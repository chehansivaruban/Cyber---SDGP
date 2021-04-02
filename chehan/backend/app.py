from flask import Flask, request, jsonify
import json
# from flask import Blueprint
# from flask_restful import Api
# from resources.Hello import Hello
#
# api_bp = Blueprint('api', __name__)
# api = Api(api_bp)

# Route
# api.add_resource(Hello, '/Hello')
#
# app = Flask(__name__)

response = ''

@app.route('/api',methods=['GET','POST'])
def hello_world():
    global response

    if (request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        name = request_data['name']
        response = f'HI{name}! this is python'
        return " "
    else:
        return jsonify({'name':response})

if __name__ == '__main__':
    app.run()
