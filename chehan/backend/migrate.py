from pysolar.solar import *
import datetime

latitude = 6.90105
longitude = 79.87831

date = datetime.datetime(2030, 5, 14, 9, 45, 0, 0, tzinfo=datetime.timezone.utc) #convert into utc timezone when entering
print(get_altitude(latitude, longitude, date))
print(date)

print(get_azimuth(latitude, longitude, date))