
import os
import requests

from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    generator_host=os.getenv('GENERATOR_HOST')
    generator_port=os.getenv('GENERATOR_PORT')
    resp = requests.get(f"http://{generator_host}:{generator_port}").text
    return f"Your luckey number is.. {resp}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
