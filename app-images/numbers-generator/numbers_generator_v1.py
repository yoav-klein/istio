
import random

from flask import Flask

app = Flask(__name__)

@app.route('/number')
def index():
    return f"{random.randint(1, 100)}"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
