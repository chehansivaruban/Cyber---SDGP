from flask import Flask, request, jsonify
import json
from flask_restful import Resource,Api

from mamamia.Prediction import Prediction
from mamamia.Productivity import Productivity

app = Flask(__name__)
api = Api(app)

class Api(Resource):
    def get(self):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        return request_data

    def post(self):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        date = request_data['date']
        time = request_data['time']
        p1 = Prediction(date, time)
        irr = p1.getIrradiance()
        e1 = Productivity(irr,1,41)
        pro = e1.getUnits()
        return pro

api.add_resource(Api,"/api")






if __name__ == "__main__":
    app.run(debug=True)