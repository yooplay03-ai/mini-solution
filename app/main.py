import os
import psycopg
from fastapi import FastAPI
from fastapi.responses import JSONResponse

app = FastAPI()
DB_URL = os.getenv("DATABASE_URL")

@app.get("/")
def root():
    return {"message": "Hello from Yuna's mini solution"}

@app.get("/health")
def health():
    try:
        with psycopg.connect(DB_URL, connect_timeout=3) as conn:
            conn.execute("SELECT 1")
        return {"status": "ok", "db": "connected"}
    except Exception as e:
        return JSONResponse(status_code=503, content={"status": "error", "db": str(e)})
