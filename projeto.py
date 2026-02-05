from flask import Flask, request
from sqlalchemy import create_engine, text

app = Flask(__name__)

url = "postgresql+psycopg2://postgres:321@localhost:5432/devschool"


@app.route("/registro", methods=["POST"])
def registro():

    nome = request.form.get("nome")
    email = request.form.get("email")
    senha = request.form.get("senha")

    engine = create_engine(url)

    with engine.connect() as conexao:

        sql = text("INSERT INTO users (nome, email, senha) VALUES (:nome, :email, :senha)")

        dados = {
            "nome": nome,
            "email": email,
            "senha": senha
        }

        conexao.execute(sql, dados)
        conexao.commit()

    return "Usuario registrado com sucesso!"


@app.route("/login", methods=["POST"])
def login():

    email = request.form.get("email")
    senha = request.form.get("senha")

    engine = create_engine(url)

    with engine.connect() as conexao:

        sql = text("SELECT * FROM users WHERE email = :email AND senha = :senha")

        dados = {
            "email": email,
            "senha": senha
        }

        result = conexao.execute(sql, dados)

        usuario = result.fetchone()

    if usuario:
        return "True"
    else:
        return "False"


if __name__ == "__main__":
    app.run(debug=True)
