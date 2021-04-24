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
        oneCapacity = request_data['oneCapacity']
        onepanelArea = request_data['onepanelArea']
        cordinate = request_data['solarPanel']
        print(cordinate)
        sLonArray = [] #Array with solar panel longitudes
        # m = 0
        # for doc in request_data['solarPanel']: #insert longitudes to array
        #     sLon = doc['lngS']
        #     sLonArray.insert(m, sLon)
        #     m = m + 1

        sLatArray = []
        index1=0
        identify = 1 #1=lat
        for i in cordinate:
            print(i)
            identify = 1
            for j in i:
                print(j)
                if identify==1:
                    sLatArray.insert(index1,j)
                else:
                    sLonArray.insert(index1,j)
                identify = 0
            index1 = index1+1

        print("sLatArray",sLatArray)
        print("sLonArray:",sLonArray)
        print("clientcap",capacity)
        if capacity == "":
            capacity = 0
            clientCapacity = False
        else:
            onepanelArea = 0
            oneCapacity = 0
            clientCapacity = True
        print("client:", clientCapacity)





        # n = 0
        # for doc in request_data['solarPanel']:#insert lattitudes to array
        #     sLat = doc['latS']
        #     sLatArray.insert(n, sLat)
        #     n = n + 1
        p1 = Prediction(date, startTime,endTime)# make an object of prediction
        irr = p1.getIrradiance() #get predicted irradiance
        print('app',irr)
        area= Area(sLatArray,sLonArray) #make an area object
        thatArea = area.getArea()
        pro = Wshade(irr, clientCapacity, capacity, thatArea, onepanelArea,oneCapacity)
        productivity = pro.getUnits() # produce the productivity

        print("Productivity : ",productivity)
        return round(productivity,2)
api.add_resource(Api,"/wshade")

class Api2(Resource):
    def post(self):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        date = request_data['date']
        startTime = request_data['startTime']
        endTime = request_data['endTime']
        capacity = request_data['capacity']
        hLow = request_data['hLow']
        hHigh = request_data['hHigh']
        d = request_data['d']
        oneCapacity = request_data['oCapacity']
        onepanelArea = request_data['oArea']
        cordinate = request_data['solarPanelMarker']
        shadingMarkerHW = request_data['shadingMarkerHW']
        objectHw = request_data['objectHw']

        if capacity == "":
            capacity = 0
            oneCapacity = float(oneCapacity)
            onepanelArea = float(onepanelArea)
            clientCapacity = False
        else:
            onepanelArea = 0
            oneCapacity = 0
            capacity = float(capacity)
            clientCapacity = True
        print("client:", clientCapacity)

        sLonArray = []  # Array with solar panel longitudes
        sLatArray = []
        index1 = 0
        identify = 1  # 1=lat
        for i in cordinate:
            print(i)
            identify = 1
            for j in i:
                print(j)
                if identify == 1:
                    sLatArray.insert(index1, j)
                else:
                    sLonArray.insert(index1, j)
                identify = 0
            index1 = index1 + 1

        oLonArray = []  # Array with solar panel longitudes
        oLatArray = []
        oLenArray = []
        index1 = 0
        identify = 1  # 1=lat
        z = 0
        for i in shadingMarkerHW:
            print(i)
            identify = 1
            for j in i:
                print(j)
                if identify == 1:
                    oLatArray.insert(index1, j)
                else:
                    oLonArray.insert(index1, j)
                identify = 0
            index1 = index1 + 1
            oLenArray.insert(z, 7)
            z = z + 1
        print('olen :',oLenArray)


        heightArray=[] #hieght of objects
        widthArray = []#width of objects
        for i in objectHw:
            print(i)
            identify = 1
            for j in i:
                print(j)
                if identify == 1:
                    heightArray.insert(index1, j)
                else:
                    widthArray.insert(index1, j)
                identify = 0
            index1 = index1 + 1
        print("ola :",oLatArray)
        print("olo :",oLonArray)
        print("ole :",oLenArray)
        print("h :",heightArray)
        print("w :",widthArray)

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
        hLow = float(hLow)
        hHigh = float(hHigh)



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
        pro = Wshade(irr, capacity, capacity, theArea, oneCapacity, onepanelArea)
        productivity = pro.getUnitsShade(totalShading,len(totalShading))


        return productivity


api.add_resource(Api2,"/shade")


if __name__ == "__main__":
    app.run(debug=True)
