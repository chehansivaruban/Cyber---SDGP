from datetime import datetime
from pysolar.solar import *
import math
import utm

import bearing


class ShadeArea:
    def __init__(self, date, time,oLat,oLon,hours,midPointLonLat,objCor):
        self.date = date
        self.time = time
        self.oLat=oLat
        self.oLon=oLon
        self.hours=hours
        self.midPointLonLat = midPointLonLat
        self.objCor = objCor



    # H = 40  # height of object
    # D = 20  # distance between object and roof
    # hLow = 10.0  # short height of roof
    # hHigh = 30.0  # long height of roof
    # d = 10  # distance between long and short height of roof
    # W = 5  # Width of object

    def calculate_initial_compass_bearing(pointA, pointB):

        if (type(pointA) != tuple) or (type(pointB) != tuple):
            raise TypeError("Only tuples are supported as arguments")

        lat1 = math.radians(pointA[0])
        lat2 = math.radians(pointB[0])
        diffLong = math.radians(pointB[1] - pointA[1])

        x = math.sin(diffLong) * math.cos(lat2)
        y = math.cos(lat1) * math.sin(lat2) - (math.sin(lat1)* math.cos(lat2) * math.cos(diffLong))
        initial_bearing = math.atan2(x, y)
        # Now we have the initial bearing but math.atan2 return values
        # from -180° to + 180° which is not what we want for a compass bearing
        # The solution is to normalize the initial bearing as shown below
        initial_bearing = math.degrees(initial_bearing)
        compass_bearing = (initial_bearing + 360) % 360
        return compass_bearing

    def getShadeArea(self,H,D,hLow,hHigh,d,W):
        from datetime import datetime
        date_time_obj = datetime.strptime(self.time, '%H:%M:%S')
        hour = date_time_obj.hour-5
        # change of timezone
        if hour<0:
            hour = 0
        date_obj = datetime.strptime(self.date, '%Y-%m-%d')
        day_of_month = date_obj.day
        month = date_obj.month
        year = date_obj.year


        import datetime
        print(self.objCor)
        print(self.midPointLonLat)
        # objCor=(6.79205080462838, 79.9257645412383)
        # point = (6.799843819858646, 79.9208251049666)
        value = bearing.calculate_initial_compass_bearing(self.midPointLonLat, self.objCor)
        date = datetime.datetime(year, month, day_of_month, hour, 00, 00, 0,
                                 tzinfo=datetime.timezone.utc)  # convert into utc timezone when entering

        theta = math.radians(round(get_altitude(self.objCor[0], self.objCor[1], date), 4))

        alpha = math.atan((H - hLow) / D)
        d1 = H / math.tan(alpha)
        # print("alpha",alpha, d1)

        beta = math.atan((H - hHigh) / (D + d))
        d2 = H / math.tan(beta)
        # print("Beta",beta,d2)

        gamma = math.atan((hHigh - hLow) / d)

        deltaD = d2 - d1
        k = ((H - hLow) / math.tan(beta)) - D
        # print(k)

        x = H / math.tan(theta)
        y = (k * (x - d1)) / deltaD
        z = y * math.tan(gamma) / (math.tan(theta) + math.tan(gamma))

        L = round(((y - z) / math.cos(gamma)), 3)  # Shadow length
        print(f"L {L}m")

        LMax = d / math.cos(gamma)

        if L > LMax:
            L = LMax

        shadingArea = L * W
        print(value)

        if value >= 45 and value <= 135:
            print("object is East")
            if (date.time()) > (datetime.time(6, 30, 00, 00)):  # east objects
                print("No effect of shading")
            else:  # west objects
                print("shade West")
                if x < d1:
                    print("No shading")
                else:
                    print("With shading - ", f"Length {L}m")
                    print("Shading Area - ", f"{shadingArea}m^2")
        elif value >= 225 and value <= 315:
            print("object is West")
            if (date.time()) > (datetime.time(6, 30, 00, 00)):  # east objects
                print("shade East")
                if x < d1:
                    print("No shading")
                else:
                    print("With shading", f"{L}m")
                    print(shadingArea)
            else:  # west objects
                print("No effect of shading")
        else:
            print("Neither east nor west No effect of shading to the roof area")

        return shadingArea


