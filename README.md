# 📘 Word → PDF Converter (Flutter + Flask)

 **Word to PDF Converter App** built with **Flutter** (frontend) and **Flask + LibreOffice** (backend).  
The app allows users to upload Word documents (`.docx`, `.doc`, `.rtf`, `.odt`) and convert them to PDF instantly.

---

## 🚀 Features

- Upload Word documents from mobile (via `file_picker`)
-  Instant conversion to **PDF** using a Flask API with LibreOffice
- Preview PDF inside the app (via `pdfx`)
-  Keep **History of converted files** (stored locally)
-  Share PDF files via WhatsApp, Email, etc.
- 🌐 Backend deployed on **Railway** (works anywhere online)

---

## 🛠️ Tech Stack

### Frontend (Flutter)
- `file_picker`
- `http`
- `pdfx`
- `shared_preferences`
- `open_filex`
- `share_plus`

### Backend (Flask + Docker)
- Python 3.11 + Flask
- LibreOffice (headless conversion)
- Dockerized & deployed on [Railway](https://railway.app)

## ⚙️ Installation (Frontend)

1. Clone the repo:
   git clone https://github.com/USERNAME/word2pdf-flutter.git
   cd word2pdf-flutter


  # Installation (Backend locally with Docker): 
  git clone https://github.com/USERNAME/word2pdf-server.git
  cd word2pdf-server

  # Build image: 
  docker build -t word2pdf . 

  # Run container: 
  docker run -d -p 5000:5000 --name word2pdf word2pdf

 # Test: 
 curl http://localhost:5000/health 

 # 🌐 Online API (Deployed on Railway) : 
 Your backend is live at:
 https://word2pdf-production-5dc8.up.railway.app

Example endpoints:

GET /health → check server status

POST /convert → upload Word file and get PDF  

# License : 

This project is open-source under the MIT License. 

# Author

Developed by **Ahmed Gad Elgaml**

































   

