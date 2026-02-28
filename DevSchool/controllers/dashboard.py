from flask import Blueprint, jsonify
from sqlalchemy import text
from conf.conexao import engine

dashboard_bp = Blueprint("dashboard", __name__, url_prefix="/dashboard")


@dashboard_bp.route("/metrics", methods=["GET"])
def metrics():

    with engine.connect() as conexao:

        res_status = conexao.execute(text("""
            SELECT status, COUNT(*) as total
            FROM leads
            GROUP BY status
            ORDER BY total DESC
        """))
        leads_por_status = {row[0]: row[1] for row in res_status.fetchall()}

        total_vendas = float(conexao.execute(
            text("SELECT COALESCE(SUM(total), 0) FROM vendas")
        ).scalar())

        qtd_vendas = conexao.execute(
            text("SELECT COUNT(*) FROM vendas")
        ).scalar()

        total_leads = conexao.execute(
            text("SELECT COUNT(*) FROM leads")
        ).scalar()

    return jsonify({
        "total_leads": total_leads,
        "leads_por_status": leads_por_status,
        "total_vendas": total_vendas,
        "qtd_vendas": qtd_vendas
    })
