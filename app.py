from flask import Flask, render_template, request
import os
from ocr_runner import OcrRunner

app = Flask(__name__)

@app.route('/upload')
def upload():
   return render_template('upload.html')
	
@app.route('/uploader', methods = ['GET', 'POST'])
def uploader():
    if request.method == 'POST':
        f = request.files['image']
        file_path = os.path.join('./upload', f.filename)
        f.save(file_path)
    
        words = OcrRunner().run(file_path)

        os.remove(file_path)
        return ', '.join(words)

if __name__ == '__main__':
    app.run()
