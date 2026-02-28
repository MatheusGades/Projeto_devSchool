# DevSchool API

API RESTful de CRM + ERP para gestao de leads, cursos e vendas simuladas.

## Tecnologias
- Python 3 + Flask
- PostgreSQL
- SQLAlchemy (engine + SQL puro com text())
- Deploy: Render

## Como rodar localmente

1. Clone o repositorio e entre na pasta

2. Crie o ambiente virtual:
```
python -m venv venv
venv\Scripts\activate       (Windows)
source venv/bin/activate    (Linux/Mac)
```

3. Instale as dependencias:
```
pip install -r requirements.txt
```

4. Crie um arquivo `.env` na raiz com:
```
DATABASE_URL=postgresql+psycopg2://postgres:SUASENHA@localhost:5432/devschool
```

5. Crie as tabelas acessando a rota de setup:
```
GET /setup
```

6. Rode o seeder de produtos:
```
python seeder_produtos.py
```

7. Inicie a API:
```
python app.py
```

## Rotas

| Metodo | Rota                  | Descricao               |
|--------|-----------------------|-------------------------|
| POST   | /registro             | Criar usuario           |
| POST   | /login                | Autenticar              |
| GET    | /setup                | Criar tabelas no banco  |
| POST   | /leads/cadastro       | Criar lead              |
| GET    | /leads/listar         | Listar leads            |
| GET    | /leads/buscar/<id>    | Buscar lead por id      |
| PUT    | /leads/atualizar/<id> | Atualizar lead          |
| DELETE | /leads/deletar/<id>   | Deletar lead            |
| POST   | /produtos/cadastro    | Criar produto           |
| GET    | /produtos/listar      | Listar produtos         |
| POST   | /vendas/criar         | Criar venda com produto |
| GET    | /vendas/listar        | Listar vendas           |
| GET    | /vendas/buscar/<id>   | Buscar venda por id     |
| GET    | /dashboard/metrics    | Metricas do CRM         |

## Deploy

API disponivel em: https://projeto-devschool.onrender.com