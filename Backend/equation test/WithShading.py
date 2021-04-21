from pysolar.solar import *
import datetime
import math

latitude = 6.90105
longitude = 79.87831

date = datetime.datetime(2021, 4, 21, 12, 49, 00, 0, tzinfo=datetime.timezone.utc) # convert into utc timezone when entering

#print(date)
print('Altitude of sun',f"{get_altitude(latitude, longitude, date)}")
#print(get_azimuth(latitude, longitude, date))

H = 0
D = 10
hLow = 10.0
hHigh = 30.0
d = 40.0

theta = get_altitude(latitude, longitude, date)
alpha = math.atan((H - hLow) / D)
beta = math.atan((H - hHigh) / D+d)
print(theta)
print(alpha)
print(beta)

if theta > beta:
    print("100%")
    percentage = 100
elif theta < alpha:
    print("0%")
    percentage = 0
else:
    percentage = (math.tan(alpha) - math.tan(theta) / math.tan(alpha) - math.tan(beta))


print("percentage", f"{percentage}%")
#coveragePercentage =  ((H - hLow - (D * math.tan(alpha))) * math.tan(beta))/ ((math.tan(alpha) + math.tan(beta)) * (hHigh - hLow))
#print(f"{coveragePercentage*100}%")


#print(H/math.tan(alpha))