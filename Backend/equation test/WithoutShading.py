
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
from math import radians
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

roundedArea = round(Area, 2)
print("\nTotal area is ", roundedArea, "m^2")


areaOfOnePanel = float(40.0)    # 40.0 m^2
capacityOfOnePanel = float(400.0)  # 400W

systemCapacity = ((roundedArea / areaOfOnePanel) * capacityOfOnePanel) / 1000
roundedSystemCapacity = round(systemCapacity, 2)


#print("Total system capacity is ", roundedSystemCapacity, "kW")


clientCapacity = bool(True)
inputCapacity = 5
inputTotalArea = 40
inputOnePanelArea = 2
inputOnePanelCapacity = 250

if clientCapacity:
    capacity = inputCapacity
else:
    capacity = (inputTotalArea / inputOnePanelArea ) * inputOnePanelCapacity / 1000


irr = 1000.0
hours = 1

# Equation of solar panel efficiency vs irradiance graph is y = 11.092*ln(x) + 23.38
eff = round((11.092 * math.log(irr)) + 23.38, 2)
print('Efficiency of solar panel ', f"{eff}%")

# Energy = Capacity x hours x efficiency (kWh)
Energy = round(capacity * hours * eff / 100, 2)


print('Produced energy ', f"{Energy}kWh")









