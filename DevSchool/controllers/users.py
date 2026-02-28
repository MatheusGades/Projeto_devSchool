from flask import Blueprint, request, jsonify
from sqlalchemy import text
from conf.conexao import engine

users_bp = Blueprint("users", __name__, url_prefix="/users")

@users_bp.route("/registro", methods=["POST"])
def registro():

    nome = request.form.get("nome")
    email = request.form.get("email")
    senha = request.form.get("senha")

    with engine.connect() as conexao:
        sql = text("INSERT INTO users (nome, email, senha) VALUES (:nome, :email, :senha)")
        conexao.execute(sql, {"nome": nome, "email": email, "senha": senha})
        conexao.commit()

    return jsonify({"mensagem": "Usuario registrado com sucesso!"})


@users_bp.route("/login", methods=["POST"])
def login():

    email = request.form.get("email")
    senha = request.form.get("senha")

    with engine.connect() as conexao:
        sql = text("SELECT * FROM users WHERE email = :email AND senha = :senha")
        usuario = conexao.execute(sql, {"email": email, "senha": senha}).fetchone()

    if usuario:
        return jsonify({"autenticado": True})

    return jsonify({"autenticado": False})
