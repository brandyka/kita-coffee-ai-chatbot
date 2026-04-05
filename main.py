from langchain_ollama.llms import OllamaLLM
from langchain_core.prompts import ChatPromptTemplate
from flask import Flask, request, jsonify, render_template
from difflib import get_close_matches
from database import connect
from retriever import get_retriever

app = Flask(__name__)
retriever = get_retriever()
model = OllamaLLM(model="llama3.2")

template_prompt = """
Kamu adalah seorang AI customer service yang bekerja untuk cafe bernama Kita Coffee.

Tugas utama kamu adalah menjawab semua pertanyaan user dengan ramah, santai, dan relevan hanya seputar cafe ini.

Berikut aturan menjawab:
1. Gunakan bahasa Indonesia santai tapi sopan.
2. Panggil user dengan "kak".
3. Jika user tanya soal menu, gunakan daftar menu yang tersedia.
4. Jika user tanya info (lokasi, jam buka, fasilitas), gunakan data yang relevan.
5. Hindari menjawab hal di luar konteks cafe ini.
6. Tampilkan jawaban dalam bentuk paragraf singkat.

Berikut data referensi:
{context}

Pertanyaan user:
{question}
"""

prompt = ChatPromptTemplate.from_template(template_prompt)
chain = prompt | model

CATEGORY_ALIASES = {
    "non coffee": "Non Coffee",
    "kopi": "Coffee",
    "minuman kopi": "Coffee",
    "snack": "Snack",
    "cemilan": "Snack",
    "main course": "Makanan Berat",
    "makanan utama": "Makanan Berat",
    "camilan": "Snack"
}

def get_all_menu():
    conn = connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT food_name AS name, deksripsi, harga, category, image_filename FROM food_menu")
    food = cursor.fetchall()
    cursor.execute("SELECT drink_name AS name, deksripsi, harga, category, image_filename FROM drink_menu")
    drink = cursor.fetchall()
    conn.close()
    return food + drink


def format_cards(menu_items):
    return [
        {
            "name": item['name'].strip(),
            "deksripsi": item['deksripsi'],
            "harga": item['harga'],
            "image_filename": f"/static/img/{item['image_filename']}",
            "category": item['category']
        }
        for item in menu_items
    ]

def get_menu_as_text():
    return "\n".join(
        f"{item['name']} ({item['category']}): {item['deksripsi']} - Rp{item['harga']:,}"
        for item in get_all_menu()
    )

def find_closest_menu_item(user_input, menu_items):
    user_input = user_input.lower()
    best = None
    for item in menu_items:
        name = item['name'].lower()
        if user_input in name:
            return item
        if get_close_matches(user_input, [name], n=1, cutoff=0.6):
            best = item
    return best


def find_related_menu(keyword):
    keyword = keyword.lower()
    keywords = keyword.split()
    matched = []
    for item in get_all_menu():
        if any(word in item['name'].lower() for word in keywords):
            matched.append(item)
    return format_cards(matched)


def match_category(user_input):
    user_input = user_input.lower()
    for alias, actual in CATEGORY_ALIASES.items():
        if alias in user_input:
            return actual
    return None

def find_by_category(category_name):
    return format_cards([
        item for item in get_all_menu()
        if item['category'].lower() == category_name.lower()
    ])

user_session = {}

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/ask", methods=["POST"])
def ask():
    data = request.get_json()
    question = data.get("question", "")
    q = question.lower()
    user_id = "default_user"
    session = user_session.get(user_id, {"step": 0})

    if "order_item" in data:
        session.update({
            "item_name": data["order_item"],
            "harga": int(data["harga"]),
            "category": data["category"],
            "step": 1
        })
        user_session[user_id] = session
        return jsonify({"answer": f"Baik Kak, Untuk pesanan {data['order_item']}, atas nama siapa kak ?", "menu": []})

    if session.get("step") == 1:
        session["customer"] = question
        session["step"] = 2
        user_session[user_id] = session
        return jsonify({"answer": "Untuk alamat pengiriman kak ?", "menu": []})

    if session.get("step") == 2:
        session["address"] = question
        session["step"] = 3
        user_session[user_id] = session
        return jsonify({"answer": "Jumlah pesanannya berapa kak ?", "menu": []})

    if session.get("step") == 3:
        try:
            qty = int(q)
            session["quantity"] = qty
            session["total"] = qty * session["harga"]
            session["step"] = 4
            user_session[user_id] = session
            return jsonify({"answer": (
                f"Oke kak berikut pesanannya:\n"
                f"- Item: {session['item_name']}\n"
                f"- Jumlah: {qty}\n"
                f"- Total: Rp{session['total']:,}\n"
                f"Konfirmasi pesanan ini? (ya/tidak)"
            ), "menu": []})
        except ValueError:
            return jsonify({"answer": "Jumlah pesanannya harus berupa angka ya kak", "menu": []})

    if session.get("step") == 4:
        if "ya" in q:
            conn = connect()
            cursor = conn.cursor()
            cursor.execute("""
                INSERT INTO orders(customer, address, item_name, quantity, category, harga)
                VALUES(%s, %s, %s, %s, %s, %s)
            """, (
                session["customer"],
                session["address"],
                session["item_name"],
                session["quantity"],
                session["category"],
                session["harga"]
            ))
            conn.commit()
            conn.close()
            user_session.pop(user_id)
            return jsonify({"answer": "Order berhasil dibuat kak! Silakan lanjut ke pembayaran 🙌", "menu": []})
        else:
            user_session.pop(user_id)
            return jsonify({"answer": "Pesanan dibatalkan ya kak. Kalau mau pesan lagi tinggal klik menu 😁", "menu": []})

    matched_cat = match_category(q)
    if matched_cat:
        menu_cards = find_by_category(matched_cat)
        context = get_menu_as_text()
        response_text = chain.invoke({"context": context, "question": question})
        return jsonify({"answer": response_text, "menu": menu_cards})

    if any(k in q for k in ["menu", "daftar", "makanan", "minuman", "list", "order", "pesan", "lihat menu", "punya apa aja"]):
        cards = format_cards(get_all_menu())
        return jsonify({"answer": "Berikut menu Kita Coffee ya kak 🍽️", "menu": cards})

    all_menu = get_all_menu()
    matched = find_closest_menu_item(q, all_menu)
    matched_card = []
    if matched:
        matched_card = [{
            "name": matched['name'],
            "deksripsi": matched['deksripsi'],
            "harga": matched['harga'],
            "image_filename": f"/static/img/{matched['image_filename']}",
            "category": matched['category']
        }]


    non_menu_keywords = ["jam", "lokasi", "alamat", "buka", "tutup", "dimana", "kapan"]
    if matched_card or matched_cat or "menu" in q:
        context = get_menu_as_text()
        show_carousel = True
    else:
        docs = retriever.invoke(question)
        context = "\n".join([doc.page_content for doc in docs])
        show_carousel = not any(k in q for k in non_menu_keywords)

    response_text = chain.invoke({"context": context, "question": question})
    related_cards = find_related_menu(q) if show_carousel and not matched_card else []

    return jsonify({
        "answer": response_text,
        "menu": matched_card + related_cards if matched_card else related_cards
    })

@app.route("/order", methods=["POST"])
def order():
    data = request.get_json()
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO orders(customer, address, item_name, quantity, category, harga)
        VALUES(%s, %s, %s, %s, %s, %s)
    """, (
        data['customer'], data['address'], data['item_name'],
        data['quantity'], data['category'], data['harga']
    ))
    conn.commit()
    conn.close()
    return jsonify({"status": "success", "message": "Order berhasil dibuat"})

@app.route("/pay_order", methods=["POST"])
def pay_order():
    order_id = request.json.get("id")
    conn = connect()
    cursor = conn.cursor()
    cursor.execute("UPDATE orders SET status = 'paid' WHERE id = %s", (order_id,))
    conn.commit()
    conn.close()
    return jsonify({"status": "success", "message": "Pembayaran berhasil"})

if __name__ == "__main__":
    app.run(debug=True, port=8000)
