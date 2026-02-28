from flask import Flask
from sqlalchemy import text
from conf.conexao import engine
from controllers.users import users_bp
from controllers.leads import leads_bp
from controllers.produto import produtos_bp
from controllers.vendas import vendas_bp
from controllers.dashboard import dashboard_bp

app = Flask(__name__)

app.register_blueprint(users_bp)
app.register_blueprint(leads_bp)
app.register_blueprint(produtos_bp)
app.register_blueprint(vendas_bp)
app.register_blueprint(dashboard_bp)



@app.route("/setup", methods=["GET"])
def setup():
    sql = """
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        nome VARCHAR(150) NOT NULL,
        email VARCHAR(150) UNIQUE NOT NULL,
        senha VARCHAR(255) NOT NULL
    );
    CREATE TABLE IF NOT EXISTS leads (
        id SERIAL PRIMARY KEY,
        nome VARCHAR(150) NOT NULL,
        email VARCHAR(150),
        telefone VARCHAR(20),
        status VARCHAR(50) DEFAULT 'Inscrito',
        nivel_conhecimento VARCHAR(50),
        interesse_curso VARCHAR(100),
        score INTEGER DEFAULT 50
    );
    CREATE TABLE IF NOT EXISTS produtos (
        id SERIAL PRIMARY KEY,
        nome VARCHAR(150) NOT NULL,
        descricao TEXT,
        preco NUMERIC(10, 2) NOT NULL DEFAULT 0,
        quantidade INTEGER DEFAULT 0
    );
    CREATE TABLE IF NOT EXISTS vendas (
        id SERIAL PRIMARY KEY,
        lead_id INTEGER NOT NULL REFERENCES leads(id) ON DELETE CASCADE,
        total NUMERIC(10, 2) DEFAULT 0,
        data_venda DATE DEFAULT CURRENT_DATE
    );
    CREATE TABLE IF NOT EXISTS venda_itens (
        id SERIAL PRIMARY KEY,
        venda_id INTEGER NOT NULL REFERENCES vendas(id) ON DELETE CASCADE,
        produto_id INTEGER NOT NULL REFERENCES produtos(id) ON DELETE CASCADE,
        quantidade INTEGER NOT NULL DEFAULT 1,
        preco_unitario NUMERIC(10, 2) NOT NULL
    );
    """
    with engine.connect() as conn:
        conn.execute(text(sql))
        conn.commit()
    return "Tabelas criadas com sucesso!"

if __name__ == "__main__":
    app.run(debug=True)
