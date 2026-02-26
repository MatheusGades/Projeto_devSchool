from sqlalchemy import text
from conf.conexao import engine
from faker import Faker
import random

fake = Faker("pt_BR")

def seed_produtos():
    produtos = []

    for _ in range(50):
        produtos.append({
            "nome": fake.word().capitalize(),
            "descricao": fake.sentence(nb_words=6),
            "preco": round(random.uniform(50, 500), 2),
            "quantidade": random.randint(1, 100)
        })

    with engine.connect() as conexao:
        sql = text("INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES (:nome, :descricao, :preco, :quantidade)")

        conexao.execute(sql, produtos)
        conexao.commit()

    print("50 produtos inseridos.")

if __name__ == "__main__":
    seed_produtos()