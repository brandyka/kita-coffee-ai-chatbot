# kita-coffee-ai-chatbot
AI chatbot for Kita Coffee using Ollama and RAG to answer FAQs and handle orders
verview:
This project is an AI-powered chatbot built for Kita Coffee, designed to provide accurate business information and support customer orders via natural conversation. Leveraging Ollama’s LLaMA model and the Retrieval-Augmented Generation (RAG) technique, the chatbot delivers context-aware responses based on real-time data stored in a MySQL database.

Key Features:

LLM-based chatbot using Ollama + LLaMA 3.2

RAG architecture with ChromaDB to fetch factual answers from internal data (e.g., food & drink menus, cafe info, operational hours)

Live order-taking: users can place orders directly via chat (with product details like name, price, quantity, etc.)

Structured UI for testing built with HTML + Flask

Dynamic database integration using MySQL (real-time updates supported)

Responses are tailored, interactive, and human-like to enhance customer experience

Tech Stack:

Python (Flask)

Ollama (LLaMA 3.2)

LangChain

ChromaDB (for vector store)

HuggingFace Embeddings (MiniLM-L6-v2)

MySQL

HTML/CSS for frontend interface

Status:
currently still developing

📁 Demo & Usage Instructions:
- Clone this repository
- Open file in Vscode
- active the "venv" environment
- import database into your DBMS
- connect to database.py
- run main.py