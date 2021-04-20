from pysolar.solar import *
import datetime

latitude = 6.90105
longitude = 79.87831

date = datetime.datetime(2020, 5, 14, 19, 45, 0, 0, tzinfo=datetime.timezone.utc) #convert into utc timezone when entering

print(date)
print('Altitude of sun',f"{get_altitude(latitude, longitude, date)}")
print(get_azimuth(latitude, longitude, date))