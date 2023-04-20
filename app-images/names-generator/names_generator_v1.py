import random
import os
import requests

from flask import Flask

app = Flask(__name__)

american_names = ['John', 'Bob', 'Dylan', 'James', 'William', 'Jeremy', 'Barbara', 'Jessica']

@app.route('/name')
def index():
    return f"{american_names[random.randint(0,len(american_names)-1)]}"

if __name__ == "__main__":
    app.run(host="0.0.0.0")
