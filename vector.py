from langchain_huggingface import HuggingFaceEmbeddings
from langchain_chroma import Chroma
from langchain_core.documents import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
from uuid import uuid4
from database import connect

# --- Dokumentasi dari Database ---
def food_menu_document():
    conn = connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT food_name, deksripsi, harga, category, image_filename FROM food_menu")
    rows = cursor.fetchall()
    conn.close()

    return [
        Document(
            page_content=f"[Makanan]\nnama: {row['food_name']}\nDeskripsi: {row['deksripsi']}\nHarga: {row['harga']}\nKategori: {row['category']}\nProduk: {row['image_filename']}",
            metadata={"source": "food_menu"}
        ) for row in rows
    ]

def drink_menu_document():
    conn = connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT drink_name, deksripsi, harga, category, image_filename FROM drink_menu")
    rows = cursor.fetchall()
    conn.close()

    return [
        Document(
            page_content=f"[Minuman]\nNama: {row['drink_name']}\nDeksripsi: {row['deksripsi']}\nHarga: {row['harga']}\nKategori: {row['category']}\nProduk: {row['image_filename']}",
            metadata={"source": "drink_menu"}
        ) for row in rows
    ]

def cafe_information_document():
    conn = connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT alamat, no_telp, link_gmaps FROM cafe_information")
    rows = cursor.fetchall()
    conn.close()

    return [
        Document(
            page_content=f"[Informasi]\nAlamat: {row['alamat']}\n Kontak: {row['no_telp']}\n Google Maps: {row['link_gmaps']}",
            metadata={"source": "cafe_information"}
        ) for row in rows
    ]

def jam_operasional_document():
    conn = connect()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT hari, jam_buka, jam_tutup, catatan, category FROM jam_operasional")
    rows = cursor.fetchall()
    conn.close()

    return [
        Document(
            page_content=f"[Jam Operasional]\nHari: {row['hari']}\nJam Buka: {row['jam_buka']}\nJam Tutup: {row['jam_tutup']}\n Catatan: {row['catatan']}\nKategori: {row['category']}",
            metadata={"source": "jam_operasional"}
        ) for row in rows
    ]

def all_document():
    return (
        food_menu_document() +
        drink_menu_document() +
        cafe_information_document() +
        jam_operasional_document()
    )

# --- Chunking Dokumen ---
docs = all_document()
splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
chunks = splitter.split_documents(docs)

# --- Generate UUIDs unik untuk setiap chunk ---
chunk_ids = [str(uuid4()) for _ in chunks]

# --- Embedding + Simpan ke ChromaDB dengan ID ---
embed = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
vectorstore = Chroma.from_documents(
    documents=chunks,
    embedding=embed,
    persist_directory="Chromadb",
    ids=chunk_ids  
)
vectorstore.add_documents(documents=chunks, ids=chunk_ids)

