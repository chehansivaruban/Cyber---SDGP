from pysolar.solar import *
import datetime

latitude = 6.90901
longitude = 79.89480

date = datetime.datetime(2021, 4, 20, 7, 30, 0, 0, tzinfo=datetime.timezone.utc) #convert into utc timezone when entering
print(get_altitude(latitude, longitude, date))
print(date)

print(get_azimuth(latitude, longitude, date))