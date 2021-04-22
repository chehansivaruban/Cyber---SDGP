from pysolar.solar import *
import datetime
import math
import utm
latitude = 6.792084061630703
longitude = 79.92573035772367

date = datetime.datetime(2021, 4, 21, 4, 1, 00, 0, tzinfo=datetime.timezone.utc)  # convert into utc timezone when entering

#print(date)
#print('Altitude of sun',f"{get_altitude(latitude, longitude, date)}")
#print(get_azimuth(latitude, longitude, date))

H = 40  # height of object
D = 20   # distance between object and roof
hLow = 10.0     # short height of roof
hHigh = 30.0    # long height of roof
d = 10   # distance between long and short height of roof
W = 5   # Width of object

theta = math.radians(round(get_altitude(latitude, longitude, date), 4))

alpha = math.atan((H - hLow) / D)
d1 = H / math.tan(alpha)
# print("alpha",alpha, d1)

beta = math.atan((H - hHigh)/(D + d))
d2 = H / math.tan(beta)
# print("Beta",beta,d2)

gamma = math.atan((hHigh - hLow) / d)

deltaD = d2 - d1
k = ((H - hLow) / math.tan(beta)) - D
# print(k)

x = H / math.tan(theta)
y = (k * (x - d1)) / deltaD
z = y * math.tan(gamma) / (math.tan(theta) + math.tan(gamma))

L = round(((y - z) / math.cos(gamma)), 3)     # Shadow length
print(f"L {L}m")

LMax = d / math.cos(gamma)

if L > LMax:
    L = LMax

shadingArea = L * W
print(f"Shading Area {shadingArea}m^2")


coordinate_1 = (6.79209275297253, 79.9256652994810)
coordinate_2 = (6.79208875788135, 79.9257357074906)
coordinate_3 = (6.79197556399928, 79.9257310135914)
coordinate_4 = (6.79198688341041, 79.9256626172544)

objCordinate = (6.79205080462838, 79.9257645412383)

utm_conversion = utm.from_latlon(coordinate_1[0],coordinate_1[1])
utm_conversion2 = utm.from_latlon(coordinate_2[0],coordinate_2[1])
utm_conversion3 = utm.from_latlon(coordinate_3[0],coordinate_3[1])
utm_conversion4 = utm.from_latlon(coordinate_4[0],coordinate_4[1])
print(utm_conversion)
print(utm_conversion2)
print(utm_conversion3)
print(utm_conversion4)


midx = (utm_conversion[0]+utm_conversion2[0]+utm_conversion3[0]+utm_conversion4[0])/4
midy = (utm_conversion[1]+utm_conversion2[1]+utm_conversion3[1]+utm_conversion4[1])/4
print("mid point :(",midx,",",midy,")")
midPointLonLat=utm.to_latlon(midx,midy,44,'N')#convert to longitude lattitude

print("Lat:",midPointLonLat)
def PolygonArea(corners):
    n = len(corners) # of corners
    area = 0.0
    for i in range(n):
        j = (i + 1) % n
        area += corners[i][0] * corners[j][1]
        area -= corners[j][0] * corners[i][1]
    area = abs(area) / 2.0
    return area

# examples
corners = [(utm_conversion[0], utm_conversion[1]), (utm_conversion2[0],utm_conversion2[1]), (utm_conversion3[0], utm_conversion3[1]),(utm_conversion4[0], utm_conversion4[1])]
print(PolygonArea(corners))

# LICENSE: public domain

def calculate_initial_compass_bearing(pointA, pointB):
    """
    Calculates the bearing between two points.
    The formulae used is the following:
        θ = atan2(sin(Δlong).cos(lat2),
                  cos(lat1).sin(lat2) − sin(lat1).cos(lat2).cos(Δlong))
    :Parameters:
      - `pointA: The tuple representing the latitude/longitude for the
        first point. Latitude and longitude must be in decimal degrees
      - `pointB: The tuple representing the latitude/longitude for the
        second point. Latitude and longitude must be in decimal degrees
    :Returns:
      The bearing in degrees
    :Returns Type:
      float
    """
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("Only tuples are supported as arguments")

    lat1 =  math.radians(pointA[0])
    lat2 = math.radians(pointB[0])

    diffLong = math.radians(pointB[1] - pointA[1])

    x = math.sin(diffLong) * math.cos(lat2)
    y = math.cos(lat1) * math.sin(lat2) - (math.sin(lat1)
            * math.cos(lat2) * math.cos(diffLong))

    initial_bearing = math.atan2(x, y)

    # Now we have the initial bearing but math.atan2 return values
    # from -180° to + 180° which is not what we want for a compass bearing
    # The solution is to normalize the initial bearing as shown below
    initial_bearing = math.degrees(initial_bearing)
    compass_bearing = (initial_bearing + 360) % 360

    return compass_bearing
value = calculate_initial_compass_bearing(midPointLonLat,objCordinate)
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

# if (date.time()) < (datetime.time(6,30,00,00)) : #east objects
#     print("East")
#     if d1 > d2:
#         print("No shading")
#     else:
#         print("With shading", d2 - d1)
# else: # west objects
#     print("West")
#     if d1 > d2:
#         print("No shading")
#     else:
#         print("With shading", d2 - d1)