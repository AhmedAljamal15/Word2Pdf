# Word to PDF Converter

A Word to PDF Converter application built with a Flutter frontend and a Flask backend that utilizes LibreOffice for conversion. This app allows users to upload Word documents (`.docx`, `.doc`, `.rtf`, `.odt`) and receive a PDF version instantly.

## Features

- **Document Upload**: Select and upload Word documents directly from your mobile device using `file_picker`.
- **Instant Conversion**: Converts documents to PDF format via a Flask API powered by LibreOffice.
- **In-App PDF Preview**: View the converted PDF files within the application using `pdfx`.
- **Conversion History**: Keeps a local history of all converted files for easy access.
- **Share & Open**: Easily share converted PDFs through various apps like WhatsApp and Email, or open them with external viewers.
- **Live Backend**: The conversion backend is deployed on Railway, making it accessible online.

## Tech Stack

### Frontend (Flutter)

- **UI & Core**: Flutter, Dart
- **File Handling**: `file_picker`, `open_filex`, `path_provider`
- **Networking**: `http`
- **PDF**: `pdfx`
- **Sharing**: `share_plus`
- **Local Storage**: `shared_preferences`
- **Animations**: `lottie`

### Backend (Flask & Docker)

- **Framework**: Python 3.11, Flask
- **Conversion Engine**: LibreOffice (headless mode)
- **Deployment**: Dockerized and deployed on [Railway](https://railway.app/)

## Installation & Setup

### Frontend (This Repository)

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/AhmedAljamal15/Word2Pdf.git
    cd Word2Pdf
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    ```sh
    flutter run
    ```
    The app is configured to use the live backend API by default.

### Backend (Local Setup - Optional)

The backend code is in a separate repository. To run the conversion server locally with Docker:

1.  **Clone the backend repository:**
    ```sh
    git clone https://github.com/AhmedAljamal15/word2pdf-server.git
    cd word2pdf-server
    ```

2.  **Build the Docker image:**
    ```sh
    docker build -t word2pdf .
    ```

3.  **Run the container:**
    ```sh
    docker run -d -p 5000:5000 --name word2pdf word2pdf
    ```

4.  **Test the local server:**
    ```sh
    curl http://localhost:5000/health
    ```

## Live API

The backend is deployed on Railway and is publicly accessible.

**API URL**: `https://word2pdf-production-5dc8.up.railway.app`

### Endpoints

-   `GET /health`: Checks the server status.
-   `POST /convert`: Upload a Word file to receive a PDF in the response.
