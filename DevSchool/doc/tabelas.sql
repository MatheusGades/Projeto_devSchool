-- Users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    nome  VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL
);

-- Leads
CREATE TABLE leads (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150),
    telefone VARCHAR(20),
    status VARCHAR(50) DEFAULT 'Inscrito',
    nivel_conhecimento VARCHAR(50),
    interesse_curso VARCHAR(100),
    score INTEGER DEFAULT 50
);

-- Produtos
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco NUMERIC(10, 2) NOT NULL DEFAULT 0,
    quantidade INTEGER DEFAULT 0
);

-- Vendas
CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER NOT NULL REFERENCES leads(id) ON DELETE CASCADE,
    total NUMERIC(10, 2) DEFAULT 0,
    data_venda DATE DEFAULT CURRENT_DATE
);

-- Venda_itens
CREATE TABLE venda_itens (
    id SERIAL PRIMARY KEY,
    venda_id INTEGER NOT NULL REFERENCES vendas(id) ON DELETE CASCADE,
    produto_id INTEGER NOT NULL REFERENCES produtos(id) ON DELETE CASCADE,
    quantidade INTEGER NOT NULL DEFAULT 1,
    preco_unitario NUMERIC(10, 2) NOT NULL
);
