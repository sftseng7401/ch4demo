from flask import Flask, jsonify, request, render_template, send_file
import os

app = Flask(__name__, template_folder='templates/')


@app.route('/')
def home():
    return render_template('index.html',
                           text="Cool！")


@app.route('/download')
def download_ppt():
    return send_file('Chapter4.pptx')


@app.route('/ping')
def get_pong():
    return jsonify({'message': 'pong'})


@app.route('/pong')
def get_ping():
    return jsonify({'message': 'ping'})


# 一定要加這個，不然部署到heroku上時，他不會去抓 heroku提供的環境變數中的 port
port = int(os.environ.get('PORT', 5000))
app.run(debug=True, host='0.0.0.0', port=port)

# app.run(host='127.0.0.1', port=5000)
