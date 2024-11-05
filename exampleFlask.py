#!/usr/bin/env python3
from flask import Flask, render_template
from markupsafe import Markup

app = Flask(__name__)

@app.route('/')
def index():
    titleText="Hello Title"
    bodyText=Markup("Sample Flask App for IS3800 <br>") 
    return render_template('template.html', titleText=titleText, bodyText=bodyText)



if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
