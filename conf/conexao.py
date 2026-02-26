from sqlalchemy import create_engine

URL = "postgresql+psycopg2://postgres:321@localhost:5432/devschool"

engine = create_engine(URL)
