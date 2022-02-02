from flask import Flask
from ocr_runner import OcrRunner

app = Flask(__name__)

@app.route('/hello-world')
def hello_world():
    return "Hello World"

@app.route('/ocr')
def test():
    words = OcrRunner().run("./images/img_2.jpg")
    return ", ".join(words)

if __name__ == '__main__':
    app.run()
