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
#-----------------------------------------
'''cordinates = [(6.809394580706211, 79.92064782328283), (6.795789340844343, 79.94080492622855), (6.780275490642937, 79.93703636735303), (6.801908856122825, 79.91689147646231)]

for x in cordinates:
    print(x)
    lat1 = cordinates[0][0]
    lon1 = cordinates[0][1]
    #lat2 = cordinates[x][0]
    #lon2 = cordinates[x][1]

print(lat1)'''
cordinates = [(6.809394580706211, 79.92064782328283), (6.795789340844343, 79.94080492622855), (6.780275490642937, 79.93703636735303), (6.801908856122825, 79.91689147646231)]

lat1 = cordinates[0]
lat2 = cordinates[2]
lat3 = cordinates[4]
lon1 = cordinates[1]
lon2 = cordinates[3]
lon3 = cordinates[5 ]

for i in range(len(cordinates)):
    print(i)






R = float(6371e3)  #metres
a1 = lat1 * math.pi/180
a2 = lat2 * math.pi/180
dA1 = (lat2 - lat1) * math.pi/180
dB1 = (lon2 - lon1) * math.pi/180

m1 = math.sin(dA1/2) * math.sin(dA1/2) + math.cos(a1) * math.cos(a2) * math.sin(dB1/2) * math.sin(dB1/2)
n1 = 2 * math.atan2(math.sqrt(m1), math.sqrt(1-m1))

distance1 = R * n1
print (distance1)



R = float(6371e3)  #metres
a3 = lat2 * math.pi/180
a4 = lat3 * math.pi/180
dA2 = (lat3 - lat2) * math.pi/180
dB2 = (lon3 - lon2) * math.pi/180

m2 = math.sin(dA2/2) * math.sin(dA2/2) + math.cos(a3) * math.cos(a4) * math.sin(dB2/2) * math.sin(dB2/2)
n2 = 2 * math.atan2(math.sqrt(m2), math.sqrt(1-m2))

distance2 = R * n2
print (distance2)



R = float(6371e3)  #metres
a5 = lat3 * math.pi/180
a6 = lat1 * math.pi/180
dA3 = (lat1 - lat3) * math.pi/180
dB3 = (lon1 - lon3) * math.pi/180

m3 = math.sin(dA3/2) * math.sin(dA3/2) + math.cos(a5) * math.cos(a6) * math.sin(dB3/2) * math.sin(dB3/2)
n3 = 2 * math.atan2(math.sqrt(m3), math.sqrt(1-m3))

distance3 = R * n3
print(distance3)

print(distance1+distance2+distance3)

S = (distance1 + distance2 + distance3)/2

area = math.sqrt(S * (S - distance1) * (S - distance2) * (S - distance3))
print("area is ", area)
