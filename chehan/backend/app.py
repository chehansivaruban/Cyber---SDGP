from flask import Flask, request, jsonify
import json
from flask_restful import Resource,Api

# from resources.Hello import Hello
#
# api_bp = Blueprint('api', __name__)
# api = Api(api_bp)

# Route
# api.add_resource(Hello, '/Hello')
from Prediction import Prediction

app = Flask(__name__)
api = Api(app)

response = ''
#
# class HelloWorld(Resource):
#     def post(self):
#         request_data = request.data
#         request_data = json.loads(request_data.decode('utf-8'))
#         name = request_data['name']
#         date = request_data['date']
#         time = request_data['time']
#         response = f'HI{time}! this is python'
#         return response
#
#     def get(self):
#         return {'name': response}
#
# class Multi(Resource):
#     def get(self,num):
#         return {'result':num*10}
#
# api.add_resource(HelloWorld,'/api')
# api.add_resource(Multi,'/multi/<int:num>')
@app.route('/api', methods=['GET', 'POST'])
def hello_world():
    global response

    if request.method == 'POST':
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        date = request_data['date']
        time = request_data['time']
        # lon1 = request_data['lon1']
        # lat1 = request_data['lat1']
        # lon2 = request_data['lon2']
        # lat2 = request_data['lat2']
        # lon3 = request_data['lon3']
        # lat3 = request_data['lat3']
        # lon4 = request_data['lon1']
        # lat4 = request_data['lat4']
        print(date)
        print("The type ", type(date))

        print(time)
        print("The type ", type(time))
        p1 = Prediction(date, time)
        out = str(p1.getIrradiance())
        print(out)
        print("The type ", type(out))

        return out
    else:
        return jsonify({'name': response})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)


