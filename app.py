from datetime import datetime

import utm
from flask import Flask
from flask import Flask, request, jsonify
import json
from flask_restful import Resource,Api

import bearing
from Area import Area
from Prediction import Prediction
from ShadeArea import ShadeArea
from Wshade import Wshade

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
        sLonArray = [] #Array with solar panel longitudes
        m = 0
        for doc in request_data['solarPanel']: #insert longitudes to array
            sLon = doc['lngS']
            sLonArray.insert(m, sLon)
            m = m + 1

        sLatArray = [] #Array with solar panel latitudes
        n = 0
        for doc in request_data['solarPanel']:#insert lattitudes to array
            sLat = doc['latS']
            sLatArray.insert(n, sLat)
            n = n + 1
        p1 = Prediction(date, startTime,endTime)# make an object of prediction
        irr = p1.getIrradiance() #get predicted irradiance
        area= Area(sLatArray,sLonArray) #make an area object
        theArea = area.getArea() #calculate area of the solar module
        pro = Wshade(irr, True, capacity, theArea, 0,0)
        productivity = pro.getUnits() # produce the productivity

        print("Productivity : ",productivity)
        return round(productivity,2)
api.add_resource(Api,"/wshade")

class Api2(Resource):
    def post(self):
        request_data1 = request.data
        request_data = json.loads(request_data1.decode('utf-8'))
        date = request_data['date']
        startTime = request_data['startTime']
        endTime = request_data['endTime']
        capacity = request_data['capacity']
        hLow = request_data['hLow']
        hHigh = request_data['hHigh']


        heightArray=[] #hieght of objects
        oLenArray=[]
        i=0
        for doc in request_data['shadingMarkerHW']:
            height = doc['height']
            heightArray.insert(i,height)
            oLenArray.insert(i,7)
            i=i+1

        widthArray = []#width of objects
        j = 0
        for doc in request_data['shadingMarkerHW']:
            width = doc['width']
            widthArray.insert(j, width)
            j = j + 1

        oLatArray = []#object latitude
        k = 0
        for doc in request_data['shadingMarkerHW']:
            oLat = doc['lat']
            oLatArray.insert(k, oLat)
            k = k + 1

        oLonArray = [] #objects logitude
        l = 0
        for doc in request_data['shadingMarkerHW']:
            oLon = doc['lng']
            oLonArray.insert(l, oLon)
            l = l + 1

        sLonArray = [] #Array with solar panel longitudes
        m = 0
        for doc in request_data['solarPanel']:
            sLon = doc['lngS']
            sLonArray.insert(m, sLon)
            m = m + 1

        sLatArray = [] #Array with solar panel latitudes
        n = 0
        for doc in request_data['solarPanel']:
            sLat = doc['latS']
            sLatArray.insert(n, sLat)
            n = n + 1


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
        numHour = endHour - hour

        utm_conversion = utm.from_latlon(round(sLatArray[0],15), round(sLatArray[0],15))
        utm_conversion2 = utm.from_latlon(sLatArray[1], round(sLatArray[1],15))
        utm_conversion3 = utm.from_latlon(sLatArray[2], round(sLatArray[2],15))
        utm_conversion4 = utm.from_latlon(sLatArray[3], round(sLatArray[3],15))
        midx = (utm_conversion[0] + utm_conversion2[0] + utm_conversion3[0] + utm_conversion4[0]) / 4
        midy = (utm_conversion[1] + utm_conversion2[1] + utm_conversion3[1] + utm_conversion4[1]) / 4
        midPointLonLat = utm.to_latlon(midx, midy, 44, 'N')  # convert to longitude lattitude


        totalShading=[]
        for a in range(len(oLatArray)-1):

            objCor = (oLatArray[a],oLonArray[a])
            d = bearing.getDistance(objCor,midPointLonLat)
            shadeArea = ShadeArea(date,startTime,oLatArray[a],oLonArray[a],numHour,midPointLonLat,objCor)
            shadingFromObject=shadeArea.getShadeArea(heightArray[a],oLenArray[a],hLow,hHigh,d,widthArray[a])
            totalShading.insert(a,shadingFromObject)

        p2 = Prediction(date, startTime, endTime)
        irr = p2.getIrradiance()
        area = Area(sLatArray, sLonArray)
        theArea = area.getArea()
        numObjs = len(oLatArray)
        pro = Wshade(irr, capacity, capacity, theArea, 0, 0)
        productivity = pro.getUnitsShade(totalShading,len(totalShading))


        return productivity


api.add_resource(Api2,"/shade")


if __name__ == "__main__":
    app.run(debug=True)
