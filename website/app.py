from flask import Flask, render_template
import MySQLdb



app = Flask(__name__)


@app.route("/")
def index():
    return render_template("index.html")

@app.route("/game")
def game_page():
    return render_template("game.html")


@app.route("/platformer")
def platformer():
    return render_template("godot_game/VerticalPlatformer.html")



def get_db():
    return MySQLdb.connect(
        host="localhost",
        user="piuser",
        passwd="strongpassword",
        db="TermonoppgaveDB"
    )


app.run(host="0.0.0.0", port=5000)