from flask import Blueprint, request, jsonify
from sqlalchemy import text
from conf.conexao import engine

produtos_bp = Blueprint("produtos", __name__, url_prefix="/produtos")


@produtos_bp.route("/cadastro", methods=["POST"])
def cadastrar_produto():

    nome = request.form.get("nome")
    descricao = request.form.get("descricao")
    preco = request.form.get("preco")
    quantidade = request.form.get("quantidade")

    if not nome:
        return jsonify({"erro": "Nome e obrigatorio"}), 400

    with engine.connect() as conexao:
        sql = text("INSERT INTO produtos (nome, descricao, preco, quantidade) VALUES (:nome, :descricao, :preco, :quantidade)")
        conexao.execute(sql, {"nome": nome, "descricao": descricao, "preco": preco, "quantidade": quantidade})
        conexao.commit()

    return jsonify({"mensagem": "Produto cadastrado com sucesso!"})


@produtos_bp.route("/listar", methods=["GET"])
def listar_produtos():

    with engine.connect() as conexao:
        result = conexao.execute(text("SELECT * FROM produtos"))
        colunas = result.keys()
        produtos = [dict(zip(colunas, row)) for row in result.fetchall()]

    return jsonify(produtos)


@produtos_bp.route("/buscar/<int:id>", methods=["GET"])
def buscar_produto(id):

    with engine.connect() as conexao:
        result = conexao.execute(text("SELECT * FROM produtos WHERE id = :id"), {"id": id})
        row = result.fetchone()

    if not row:
        return jsonify({"erro": "Produto nao encontrado"}), 404

    return jsonify(dict(zip(result.keys(), row)))


@produtos_bp.route("/atualizar/<int:id>", methods=["PUT"])
def atualizar_produto(id):

    nome = request.form.get("nome")
    descricao = request.form.get("descricao")
    preco = request.form.get("preco")
    quantidade = request.form.get("quantidade")

    with engine.connect() as conexao:
        sql = text("""
            UPDATE produtos
            SET nome = COALESCE(:nome, nome),
                descricao = COALESCE(:descricao, descricao),
                preco = COALESCE(:preco, preco),
                quantidade = COALESCE(:quantidade, quantidade)
            WHERE id = :id
        """)
        conexao.execute(sql, {"id": id, "nome": nome, "descricao": descricao, "preco": preco, "quantidade": quantidade})
        conexao.commit()

    return jsonify({"mensagem": "Produto atualizado com sucesso!"})


@produtos_bp.route("/deletar/<int:id>", methods=["DELETE"])
def deletar_produto(id):

    with engine.connect() as conexao:
        conexao.execute(text("DELETE FROM produtos WHERE id = :id"), {"id": id})
        conexao.commit()

    return jsonify({"mensagem": "Produto deletado com sucesso!"})
