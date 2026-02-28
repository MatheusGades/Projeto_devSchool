import os
from sqlalchemy import create_engine

URL = os.environ.get("DATABASE_URL", "postgresql+psycopg2://postgres:321@localhost:5432/devschool")

if URL.startswith("postgres://"):
    URL = URL.replace("postgres://", "postgresql+psycopg2://", 1)

engine = create_engine(URL)
