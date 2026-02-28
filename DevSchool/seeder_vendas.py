from sqlalchemy import text
from conf.conexao import engine
from datetime import datetime, timedelta
import random

def seed_vendas():

    with engine.connect() as conexao:

        leads = [r[0] for r in conexao.execute(text("SELECT id FROM leads")).fetchall()]
        produtos = conexao.execute(text("SELECT id, preco FROM produtos")).fetchall()

        if not leads or not produtos:
            print("Cadastre leads e produtos antes de rodar o seeder!")
            return

        for _ in range(30):
            lead_id = random.choice(leads)
            dias_atras = random.randint(0, 60)
            data = (datetime.now() - timedelta(days=dias_atras)).date()

            venda_id = conexao.execute(
                text("INSERT INTO vendas (lead_id, total, data_venda) VALUES (:lead_id, 0, :data) RETURNING id"),
                {"lead_id": lead_id, "data": data}
            ).scalar()

            itens = random.sample(list(produtos), k=random.randint(1, 3))
            total_val = 0

            for prod in itens:
                prod_id, preco = prod[0], float(prod[1])
                qtd = random.randint(1, 2)
                subtotal = preco * qtd
                total_val += subtotal

                conexao.execute(
                    text("INSERT INTO venda_itens (venda_id, produto_id, quantidade, preco_unitario) VALUES (:venda_id, :produto_id, :quantidade, :preco_unitario)"),
                    {"venda_id": venda_id, "produto_id": prod_id, "quantidade": qtd, "preco_unitario": preco}
                )

            conexao.execute(
                text("UPDATE vendas SET total = :total WHERE id = :id"),
                {"total": total_val, "id": venda_id}
            )

        conexao.commit()

    print("30 vendas com itens inseridas com sucesso!")

if __name__ == "__main__":
    seed_vendas()
