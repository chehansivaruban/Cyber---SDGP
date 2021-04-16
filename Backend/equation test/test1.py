'''import kwargs as kwargs
import pyproj
import shapely
import shapely.ops as ops
from shapely.geometry.polygon import Polygon
from functools import partial

from pyproj import CRS
crs = CRS.from_epsg(4326)
crs.to_epsg()
4326
crs.to_authority()
('EPSG', '4326')
crs = CRS.from_string("epsg:4326")
crs = CRS.from_proj4("+proj=latlon")
#crs = CRS.from_user_input(4326)


geom = Polygon([(0, 0), (0, 10), (10, 10), (10, 0), (0, 0)])
geom_area = ops.transform(
    partial(
        pyproj.transform,
        pyproj.Proj(init='EPSG:4326'),
        pyproj.Proj(
            proj='aea',
            lat1=geom.bounds[1],
            lat2=geom.bounds[3])),
    geom)

# Print the area in m^2
print(geom_area.area)


'''
from math import tan

cordinates = [(0, 0), (1, 0), (1, 1), (0, 1)]

for i in cordinates:
    
    (x1,y2) = i
    (x2,y2) = i
    print(x1 , x2)

#without shading equation
'''
x - irradiance ( W/m*m )
a - solar panel area ( m/m )
h - hours ( h )'''

x = float(600)   #just gave some nuumbers to check this
#a = geom_area.area    # x is from data science
h = int (2)      # a and h is from front end, user inputs

#units = (x * a * h) / 1000

#print (units)
'''
h = float(20.0)
h1 = float(8.0)
h2 = float(10.0)
d = float(10.0)
angle1 = float(42.785383168773286)
angle2 = float(10.0)

a1 = tan(angle1)
a2 = 0.1763

percentage = ( (h - h1 - (d * a1) ) * a2 ) / ( (a1 + a2) * ( h2 - h1) )

print(percentage, "%")'''
import math
from math import sin, cos, sqrt, atan2, radians
#-----------------------------------------
'''cordinates = [(6.809394580706211, 79.92064782328283), (6.795789340844343, 79.94080492622855), (6.780275490642937, 79.93703636735303), (6.801908856122825, 79.91689147646231)]

for x in cordinates:
    print(x)
    lat1 = cordinates[0][0]
    lon1 = cordinates[0][1]
    #lat2 = cordinates[x][0]
    #lon2 = cordinates[x][1]

print(lat1)'''
cordinates = [(6.799827088087496, 79.9212470788844), (6.7999039652508015, 79.92168303605159), (6.800083997285784, 79.92164192800433), (6.800005279767673, 79.92120649445515)]

lat1 = radians(abs(cordinates[0][0]))
lat2 = radians(abs(cordinates[1][0]))
lat3 = radians(abs(cordinates[2][0]))
lat4 = radians(abs(cordinates[3][0]))
lon1 = radians(abs(cordinates[0][1]))
lon2 = radians(abs(cordinates[1][1]))
lon3 = radians(abs(cordinates[2][1]))
lon4 = radians(abs(cordinates[3][1]))

lat = [lat1, lat2, lat3,lat4]
lon = [lon1, lon2, lon3,lon4]

Area = float(0)

for i in range(len(cordinates)-2):
    print(i+1)
    R = float(6371e3)  # metres
    a1 = lat[0]
    a2 = lat[i+1]
    dA1 = lat[i+1] - lat[0]
    dB1 = lon[i+1] - lon[0]

    m1 = math.sin(dA1 / 2) * math.sin(dA1 / 2) + math.cos(a1) * math.cos(a2) * math.sin(dB1 / 2) * math.sin(dB1 / 2)
    n1 = 2 * math.atan2(math.sqrt(m1), math.sqrt(1 - m1))

    distance1 = R * n1
    print("Distance 1 is ", distance1)


    a3 = lat[i+1]
    a4 = lat[i+2]
    dA2 = lat[i+2] - lat[i+1]
    dB2 = lon[i+2] - lon[i+1]

    m2 = math.sin(dA2 / 2) * math.sin(dA2 / 2) + math.cos(a3) * math.cos(a4) * math.sin(dB2 / 2) * math.sin(dB2 / 2)
    n2 = 2 * math.atan2(math.sqrt(m2), math.sqrt(1 - m2))

    distance2 = R * n2
    print("Distance 2 is ", distance2)


    a5 = lat[i+2]
    a6 = lat[0]
    dA3 = lat[0] - lat[i+2]
    dB3 = lon[0] - lon[i+2]

    m3 = math.sin(dA3 / 2) * math.sin(dA3 / 2) + math.cos(a5) * math.cos(a6) * math.sin(dB3 / 2) * math.sin(dB3 / 2)
    n3 = 2 * math.atan2(math.sqrt(m3), math.sqrt(1 - m3))

    distance3 = R * n3
    print("Distance 3 is ", distance3)

    print(distance1 + distance2 + distance3)

    S = (distance1 + distance2 + distance3) / 2

    area = math.sqrt((S * (S - distance1) * (S - distance2) * (S - distance3)))
    print("area of ", i+1, "is ", area)
    Area = Area + area

print("\nTotal area is ", Area)







