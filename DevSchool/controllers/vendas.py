from flask import Blueprint, request, jsonify
from sqlalchemy import text
from conf.conexao import engine

vendas_bp = Blueprint("vendas", __name__, url_prefix="/vendas")


@vendas_bp.route("/criar", methods=["POST"])
def criar_venda():

    lead_id = request.form.get("lead_id")
    produto_id = request.form.get("produto_id")
    quantidade = request.form.get("quantidade") or 1

    if not lead_id:
        return jsonify({"erro": "lead_id e obrigatorio"}), 400

    if not produto_id:
        return jsonify({"erro": "produto_id e obrigatorio"}), 400

    with engine.connect() as conexao:

        res = conexao.execute(
            text("SELECT preco FROM produtos WHERE id = :id"), {"id": produto_id}
        ).fetchone()

        if not res:
            return jsonify({"erro": "Produto nao encontrado"}), 404

        preco = float(res[0])
        quantidade = int(quantidade)
        total = preco * quantidade

        venda_id = conexao.execute(
            text("INSERT INTO vendas (lead_id, total, data_venda) VALUES (:lead_id, :total, CURRENT_DATE) RETURNING id"),
            {"lead_id": lead_id, "total": total}
        ).scalar()

        conexao.execute(
            text("INSERT INTO venda_itens (venda_id, produto_id, quantidade, preco_unitario) VALUES (:venda_id, :produto_id, :quantidade, :preco_unitario)"),
            {"venda_id": venda_id, "produto_id": produto_id, "quantidade": quantidade, "preco_unitario": preco}
        )

        conexao.commit()

    return jsonify({"mensagem": "Venda criada com sucesso!", "venda_id": venda_id, "total": total})


@vendas_bp.route("/listar", methods=["GET"])
def listar_vendas():

    with engine.connect() as conexao:
        result = conexao.execute(text("SELECT * FROM vendas"))
        colunas = result.keys()
        vendas = [dict(zip(colunas, row)) for row in result.fetchall()]

    return jsonify(vendas)


@vendas_bp.route("/buscar/<int:id>", methods=["GET"])
def buscar_venda(id):

    with engine.connect() as conexao:

        res_venda = conexao.execute(text("SELECT * FROM vendas WHERE id = :id"), {"id": id})
        row_venda = res_venda.fetchone()

        if not row_venda:
            return jsonify({"erro": "Venda nao encontrada"}), 404

        venda = dict(zip(res_venda.keys(), row_venda))

        res_itens = conexao.execute(text("SELECT * FROM venda_itens WHERE venda_id = :id"), {"id": id})
        itens = [dict(zip(res_itens.keys(), row)) for row in res_itens.fetchall()]

    venda["itens"] = itens
    return jsonify(venda)


@vendas_bp.route("/deletar/<int:id>", methods=["DELETE"])
def deletar_venda(id):

    with engine.connect() as conexao:
        conexao.execute(text("DELETE FROM venda_itens WHERE venda_id = :id"), {"id": id})
        conexao.execute(text("DELETE FROM vendas WHERE id = :id"), {"id": id})
        conexao.commit()

    return jsonify({"mensagem": "Deletado com sucesso!"})
