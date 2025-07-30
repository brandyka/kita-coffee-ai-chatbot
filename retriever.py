from langchain_huggingface import HuggingFaceEmbeddings
from langchain_chroma import Chroma

def get_retriever():
   
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
    
    
    vectorstore = Chroma(
        persist_directory="Chromadb",         
        embedding_function=embeddings
    )
    
    # Ambil retriever dari vectorstore
    retriever = vectorstore.as_retriever(
        search_type="similarity",       
        search_kwargs={"k": 20}          
    )
    
    return retriever