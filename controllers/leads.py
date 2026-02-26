from flask import Blueprint, request
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

    if not nome or not nome.strip():
        return "Nome é obrigatório"

    score = calcular_score(email, telefone)

    with engine.connect() as conexao:
        sql = text("INSERT INTO leads (nome, email, telefone, status, score) VALUES (:nome, :email, :telefone, :status, :score)")

        conexao.execute(sql, {
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "status": status,
            "score": score
        })
        conexao.commit()

    return "Criado com sucesso!"


@leads_bp.route("/listar", methods=["GET"])
def listar_leads():

    with engine.connect() as conexao:
        sql = text("SELECT * FROM leads")
        result = conexao.execute(sql)
        leads = result.fetchall()

    return str(leads)


@leads_bp.route("/buscar/<int:id>", methods=["GET"])
def buscar_lead(id):

    with engine.connect() as conexao:
        sql = text("SELECT * FROM leads WHERE id = :id")
        result = conexao.execute(sql, {"id": id})
        lead = result.fetchone()

    if not lead:
        return "Lead não encontrado"

    return str(lead)

@leads_bp.route("/atualizar/<int:id>", methods=["PUT"])
def atualizar_lead(id):

    nome = request.form.get("nome")
    email = request.form.get("email")
    telefone = request.form.get("telefone")
    status = request.form.get("status")

    with engine.connect() as conexao:

        sql_busca = text("SELECT email, telefone FROM leads WHERE id = :id")
        atual = conexao.execute(sql_busca, {"id": id}).fetchone()

        if not atual:
            return "Lead não encontrado"

        email_final = email if email else atual[0]
        telefone_final = telefone if telefone else atual[1]
        score = calcular_score(email_final, telefone_final)

        sql_update = text("UPDATE leads SET nome = COALESCE(:nome, nome), email = COALESCE(:email, email), telefone = COALESCE(:telefone, telefone), status = COALESCE(:status, status), score = :score WHERE id = :id")

        conexao.execute(sql_update, {
            "id": id,
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "status": status,
            "score": score
        })

        conexao.commit()

    return "Atualizado com sucesso!"


@leads_bp.route("/deletar/<int:id>", methods=["DELETE"])
def deletar_lead(id):

    with engine.connect() as conexao:
        sql = text("DELETE FROM leads WHERE id = :id")
        conexao.execute(sql, {"id": id})
        conexao.commit()

    return "Deletado com sucesso!"