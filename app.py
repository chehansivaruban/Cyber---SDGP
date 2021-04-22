from datetime import datetime

from flask import Flask
from flask import Flask, request, jsonify
import json
from flask_restful import Resource,Api

import Area
import Prediction
import ShadeArea
import Wshade

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
        roofMarkerHW = request_data['roofMarkerHW']
        sLonArray = []
        m = 0
        for doc in request_data['roofMarkerHW']:
            sLon = doc['lngS']
            sLonArray.insert(m, sLon)
            m = m + 1

        sLatArray = []
        n = 0
        for doc in request_data['roofMarkerHW']:
            sLat = doc['latS']
            sLatArray.insert(n, sLat)
            n = n + 1
        p1 = Prediction(date, startTime,endTime)
        irr = p1.getIrradiance()
        area= Area(sLatArray,sLonArray)
        theArea = area.getArea()
        pro = Wshade(irr, capacity, capacity, theArea, 0, 0)
        productivity = pro.getUnits()

        print("Productivity : ",productivity)
        return round(productivity,2)
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
            roofMarkerHW = request_data['roofMarkerHW']
            heightArray=[]
            oLenArray=[]
            i=0
            for doc in request_data['shadingMarkerHW']:
                height = doc['height']
                heightArray.insert(i,height)
                oLenArray.insert(i,3)
                i=i+1

            widthArray = []
            j = 0
            for doc in request_data['shadingMarkerHW']:
                width = doc['width']
                widthArray.insert(j, width)
                j = j + 1

            oLatArray = []
            k = 0
            for doc in request_data['shadingMarkerHW']:
                oLat = doc['lat']
                oLatArray.insert(k, oLat)
                k = k + 1

            oLanArray = []
            l = 0
            for doc in request_data['shadingMarkerHW']:
                oLan = doc['lng']
                oLanArray.insert(l, oLan)
                l = l + 1

            sLonArray = []
            m = 0
            for doc in request_data['roofMarkerHW']:
                sLon = doc['lngS']
                sLonArray.insert(m, sLon)
                m = m + 1

            sLatArray = []
            n = 0
            for doc in request_data['roofMarkerHW']:
                sLat = doc['latS']
                sLatArray.insert(n, sLat)
                n = n + 1

            # process data into needed format for the data science component
            date_time_obj = datetime.strptime(startTime, '%H:%M:%S')
            hour = date_time_obj.hour
            # change of timezone
            changetime = "05:30:00"
            change_date_time_obj = datetime.strptime(changetime, '%H:%M:%S')
            hour = hour - change_date_time_obj.hour
            if hour < 0:
                hour = 0
            end_date_time_obj = datetime.strptime(endTime, '%H:%M:%S')
            endHour = end_date_time_obj.hour
            change_date_time_obj = datetime.strptime(changetime, '%H:%M:%S')
            endHour = endHour - change_date_time_obj.hour
            if endHour < 0:
                endHour = 0
            date_obj = datetime.strptime(date, '%Y-%m-%d')
            numHour = endHour - hour

            totalShading=[]
            for a in range(len(oLatArray)):
                shadeArea = ShadeArea(date,startTime,oLatArray[a],oLanArray[a],numHour)
                shadingFromObject=shadeArea.getShadeArea(heightArray[a],oLenArray[a],hLow,hHigh,d,oWidth)
                totalShading.insert(a,shadingFromObject)

            p2 = Prediction(date, startTime, endTime)
            irr = p2.getIrradiance()
            area = Area(sLatArray, sLonArray)
            theArea = area.getArea()
            pro = Wshade(irr, capacity, capacity, theArea, 0, 0)
            productivity = pro.getUnits(totalShading)


            return productivity
        except:
            return "error : Not found"

api.add_resource(Api2,"/shade")


if __name__ == "__main__":
    app.run(debug=True)
