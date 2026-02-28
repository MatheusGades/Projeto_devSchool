from flask import Blueprint, request, jsonify
from sqlalchemy import text
from conf.conexao import engine

leads_bp = Blueprint("leads", __name__, url_prefix="/leads")

def calcular_score(email, telefone):
    if email and telefone:
        return 100
    else:
        return 50


@leads_bp.route("/cadastro", methods=["POST"])
def criar_lead():

    nome = request.form.get("nome")
    email = request.form.get("email")
    telefone = request.form.get("telefone")
    status = request.form.get("status") or "Inscrito"
    nivel_conhecimento = request.form.get("nivel_conhecimento")
    interesse_curso = request.form.get("interesse_curso")

    if not nome or not nome.strip():
        return jsonify({"erro": "Nome e obrigatorio"}), 400

    score = calcular_score(email, telefone)

    with engine.connect() as conexao:
        sql = text("INSERT INTO leads (nome, email, telefone, status, nivel_conhecimento, interesse_curso, score)VALUES (:nome, :email, :telefone, :status, :nivel_conhecimento, :interesse_curso, :score)")

        conexao.execute(sql, {
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "status": status,
            "nivel_conhecimento": nivel_conhecimento,
            "interesse_curso": interesse_curso,
            "score": score
        })
        conexao.commit()

    return jsonify({"mensagem": "Criado com sucesso!"})


@leads_bp.route("/listar", methods=["GET"])
def listar_leads():

    with engine.connect() as conexao:
        result = conexao.execute(text("SELECT * FROM leads"))
        colunas = result.keys()
        leads = [dict(zip(colunas, row)) for row in result.fetchall()]

    return jsonify(leads)


@leads_bp.route("/buscar/<int:id>", methods=["GET"])
def buscar_lead(id):

    with engine.connect() as conexao:
        result = conexao.execute(text("SELECT * FROM leads WHERE id = :id"), {"id": id})
        row = result.fetchone()

    if not row:
        return jsonify({"erro": "Lead nao encontrado"}), 404

    return jsonify(dict(zip(result.keys(), row)))


@leads_bp.route("/atualizar/<int:id>", methods=["PUT"])
def atualizar_lead(id):

    nome = request.form.get("nome")
    email = request.form.get("email")
    telefone = request.form.get("telefone")
    status = request.form.get("status")
    nivel_conhecimento = request.form.get("nivel_conhecimento")
    interesse_curso = request.form.get("interesse_curso")

    with engine.connect() as conexao:

        atual = conexao.execute(
            text("SELECT email, telefone FROM leads WHERE id = :id"), {"id": id}).fetchone()

        if not atual:
            return jsonify({"erro": "Lead nao encontrado"}), 404

        email_final = email if email else atual[0]
        telefone_final = telefone if telefone else atual[1]
        score = calcular_score(email_final, telefone_final)

        if status == "Matriculado":
            score = 100

        sql = text("""
            UPDATE leads
            SET nome = COALESCE(:nome, nome),
                email = COALESCE(:email, email),
                telefone = COALESCE(:telefone, telefone),
                status = COALESCE(:status, status),
                nivel_conhecimento = COALESCE(:nivel_conhecimento, nivel_conhecimento),
                interesse_curso = COALESCE(:interesse_curso, interesse_curso),
                score = :score
            WHERE id = :id
        """)

        conexao.execute(sql, {
            "id": id,
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "status": status,
            "nivel_conhecimento": nivel_conhecimento,
            "interesse_curso": interesse_curso,
            "score": score
        })
        conexao.commit()

    return jsonify({"mensagem": "Atualizado com sucesso!"})


@leads_bp.route("/deletar/<int:id>", methods=["DELETE"])
def deletar_lead(id):

    with engine.connect() as conexao:
        conexao.execute(text("DELETE FROM leads WHERE id = :id"), {"id": id})
        conexao.commit()

    return jsonify({"mensagem": "Deletado com sucesso!"})
