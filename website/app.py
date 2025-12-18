from flask import Flask, render_template
import pymysql


app = Flask(__name__)



@app.route("/")
def index():
   items = get_all_items()
   return render_template("index.html", items=items)

@app.route("/game")
def game_page():
    return render_template("game.html")


@app.route("/platformer")
def platformer():
    return render_template("godot_game/VerticalPlatformer.html")


def get_db():
    return pymysql.connect(
        host="localhost",
        user="nettbutikk",
        password="termin",
        database="gamebutikk"
    )

def get_all_items():
    db = get_db()
    cursor = db.cursor()
    cursor.execute("SELECT id, name, price FROM items")
    items = cursor.fetchall()
    cursor.close()
    db.close()
    return items



app.run(host="0.0.0.0", port=5000, ssl_context=('domain.crt', 'domain.key'))
