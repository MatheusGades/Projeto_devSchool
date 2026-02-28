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

4. Configure a conexao em `conf/conexao.py` com sua URL do PostgreSQL

5. Execute o SQL para criar as tabelas:
```
psql -U postgres -d devschool -f create_tables.sql
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

API disponivel em: https://devschool.onrender.com
