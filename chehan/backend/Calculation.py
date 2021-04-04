import Prediction

class Calculation:
  def __init__(self,irradiance ,lon1,lat1,lon2,lat2,lon3,lat3,lon4,lat4):

    self.irradiance = irradiance
    self.lon1 = lon1
    self.lat1 = lat1
    self.lon2 = lon2
    self.lat2 = lat2
    self.lon3 = lon3
    self.lat3 = lat3
    self.lon4 = lon4
    self.lat4 = lat4


  def getIrradiance(self,date, time):
    x = Prediction(date, time)
    x.getIrradiance()
    return x.getIrradiance()

  def getProductivity(self,irradiance,lon1,lat1,lon2,lat2,lon3,lat3,lon4,lat4):

    return x.getIrradiance()
