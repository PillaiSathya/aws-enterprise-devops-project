from flask import Flask

app = Flask(__name__)


@app.route("/")
def home():
    return """
<!DOCTYPE html>
<html>
<head>
    <title>AWS Enterprise DevOps</title>
</head>
<body>
    <h1>AWS Enterprise DevOps Project</h1>

    <h2>Dockerized Application</h2>

    <p>Application running inside a Docker container</p>

    <p>Built with Python Flask</p>

    <p>Served using Gunicorn</p>

    <p>Created by Sathya</p>
</body>
</html>
"""


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
