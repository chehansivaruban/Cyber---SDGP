from flask import Flask
from flask import Flask, request, jsonify
import json
from flask_restful import Resource,Api

from Prerdiction import Prediction
from Productivity import Productivity

app = Flask(__name__)
api = Api(app)

class Api(Resource):
    #get request to call the json objects sent to the backend
    def get(self):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        return request_data
    #post request to get the data from front end to do processing
    def post(self):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        date = request_data['date']
        startTime = request_data['startTime']
        endTime = request_data['endTime']
        capacity = request_data['capacity']
        p1 = Prediction(date, startTime,endTime)
        irr = p1.getIrradiance()
        e1 = Productivity(irr,1,capacity)
        pro = e1.getUnits()
        print("Productivity : ",pro)
        return round(pro,2)
api.add_resource(Api,"/wshade")

class Api2(Resource):
    def post(self):
        try:
            request_data = request.data
            request_data = json.loads(request_data.decode('utf-8'))
            date = request_data['date']
            startTime = request_data['startTime']
            endTime = request_data['endTime']
            capacity = request_data['capacity']
            shadingMarkerHW = request_data['shadingMarkerHW']
            return date,startTime,endTime,capacity,shadingMarkerHW
        except:
            return "error"




api.add_resource(Api2,"/shade")


if __name__ == "__main__":
    app.run(debug=True)
