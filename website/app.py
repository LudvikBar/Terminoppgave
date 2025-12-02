from flask import Flask, render_template
import MySQLdb

app = Flask(__name__)


@app.route("/")
def index():
    return render_template("index.html")

@app.route("/platformer")
def platformer():
    return render_template("VerticalPlatformer.html")


def get_db():
    return MySQLdb.connect(
        host="localhost",
        user="piuser",
        passwd="strongpassword",
        db="TermonoppgaveDB"
    )

@app.route("/")
def index():
    db = get_db()
    cursor = db.cursor()
    cursor.execute("SELECT 'Hello from MariaDB!'")
    result = cursor.fetchone()
    return result[0]

app.run(host="0.0.0.0", port=5000)