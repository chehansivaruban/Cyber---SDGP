from pysolar.solar import *
import datetime
import math
import utm


class ShadeArea:
    def __init__(self, date, time,oLat,oLon):
        self.date = date
        self.time = time
        self.oLat=oLat
        self.oLon=oLon
        # self.startDateTime = datetime.datetime(, 4, 21, 4, 1, 00, 0, tzinfo=datetime.timezone.utc)  # convert into utc timezone when entering
    #
    # H = 40  # height of object
    # D = 20  # distance between object and roof
    # hLow = 10.0  # short height of roof
    # hHigh = 30.0  # long height of roof
    # d = 10  # distance between long and short height of roof
    # W = 5  # Width of object

    def getShadeArea(self,oHieght,oDistance,hLow,hHigh,d,oWidth):
        date_time_obj = datetime.strptime(self.time, '%H:%M:%S')
        hour = date_time_obj.hour
        changetime = "05:30:00"
        change_date_time_obj = datetime.strptime(changetime, '%H:%M:%S')
        hour = hour - change_date_time_obj.hour
        if hour < 0:
            hour = 0
        date_obj = datetime.strptime(self.date, '%Y-%m-%d')
        day_of_month = date_obj.day
        month = date_obj.month
        year = date_obj.year
        date = datetime.datetime(year, month, day_of_month, 00, 00, 00, 0, tzinfo=datetime.timezone.utc)
        theta = math.radians(round(get_altitude(self.oLat, self.oLon, date), 4))

        alpha = math.atan((oHieght - hLow) / oDistance)
        d1 = oHieght / math.tan(alpha)

        beta = math.atan((oHieght - hHigh) / (oDistance + d))
        d2 = oHieght / math.tan(beta)

        gamma = math.atan((hHigh - hLow) / d)
        deltaD = d2 - d1
        k = ((oHieght - hLow) / math.tan(beta)) - oDistance

        x = oHieght / math.tan(theta)
        y = (k * (x - d1)) / deltaD
        z = y * math.tan(gamma) / (math.tan(theta) + math.tan(gamma))

        L = round(((y - z) / math.cos(gamma)), 3)  # Shadow length
        print(f"L {L}m")

        LMax = d / math.cos(gamma)

        if L > LMax:
            L = LMax

        shadingArea = L * oWidth
        print(f"Shading Area {shadingArea}m^2")
        return shadingArea
