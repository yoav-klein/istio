import random
import os
import requests

from flask import Flask

app = Flask(__name__)

hebrew_names = ['Avi', 'Eli', 'Yoav', 'Dikla', 'Tamar']

@app.route('/name')
def index():
    return f"{hebrew_names[random.randint(0,len(hebrew_names)-1)]}"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
