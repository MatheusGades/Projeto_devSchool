from flask import Flask
from controllers.users import users_bp
from controllers.leads import leads_bp
from controllers.produto import produtos_bp

app = Flask(__name__)

app.register_blueprint(users_bp)
app.register_blueprint(leads_bp)
app.register_blueprint(produtos_bp)

if __name__ == "__main__":
    app.run(debug=True)
