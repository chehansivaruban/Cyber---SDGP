from pysolar.solar import *
import datetime
import math

latitude = 6.792084061630703
longitude = 79.92573035772367

date = datetime.datetime(2021, 4, 21, 10, 00, 00, 0, tzinfo=datetime.timezone.utc) # convert into utc timezone when entering




#print(date)
#print('Altitude of sun',f"{get_altitude(latitude, longitude, date)}")
#print(get_azimuth(latitude, longitude, date))

H = 40
D = 20
hLow = 10.0
hHigh = 30.0

theta = math.radians(round(get_altitude(latitude, longitude, date), 4))
d1 = D*H / (H - hLow)
d2 = H/math.tan(theta)

if (date.time()) < (datetime.time(6,30,00,00)) : #east objects
    print("East")
    if d1 > d2:
        print("No shading")
    else:
        print("With shading", d2 - d1)
else: # west objects
    print("West")
    if d1 > d2:
        print("No shading")
    else:
        print("With shading", d2 - d1)



#alpha = math.atan((H - hLow) / D)
#beta = math.atan((H - hHigh) / D+d)


#if theta < alpha:
    #print("0%")
    #percentage = 0
#else:
    #percentage = math.tan((alpha - theta) / (alpha - beta)) * 100


#print("percentage", f"{percentage}%")
#coveragePercentage =  ((H - hLow - (D * math.tan(alpha))) * math.tan(beta))/ ((math.tan(alpha) + math.tan(beta)) * (hHigh - hLow))
#print(f"{coveragePercentage*100}%")
#print(theta)
#print(math.tan(theta))
#print(H/math.tan(theta))