import logging
from flask import Flask

logging.basicConfig(level=logging.DEBUG)
app = Flask(__name__)

@app.route("/")
def hello_world():
    app.logger.info('------ got request ------')
    return "<p>Hello, World</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

