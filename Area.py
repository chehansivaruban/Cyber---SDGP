import math
from math import radians

class Area:
    def __init__(self, cordinates):
        self.cordinates=cordinates

    def getArea(self):
        lat1 = radians(abs(self.cordinates[0][0]))
        lat2 = radians(abs(self.cordinates[1][0]))
        lat3 = radians(abs(self.cordinates[2][0]))
        lat4 = radians(abs(self.cordinates[3][0]))
        lon1 = radians(abs(self.cordinates[0][1]))
        lon2 = radians(abs(self.cordinates[1][1]))
        lon3 = radians(abs(self.cordinates[2][1]))
        lon4 = radians(abs(self.cordinates[3][1]))

        lat = [lat1, lat2, lat3, lat4]
        lon = [lon1, lon2, lon3, lon4]

        Area = float(0)

        for i in range(len(self.cordinates) - 2):
            print(i + 1)
            R = float(6371e3)  # metres
            a1 = lat[0]
            a2 = lat[i + 1]
            dA1 = lat[i + 1] - lat[0]
            dB1 = lon[i + 1] - lon[0]

            m1 = math.sin(dA1 / 2) * math.sin(dA1 / 2) + math.cos(a1) * math.cos(a2) * math.sin(dB1 / 2) * math.sin(
                dB1 / 2)
            n1 = 2 * math.atan2(math.sqrt(m1), math.sqrt(1 - m1))

            distance1 = R * n1
            print("Distance 1 is ", distance1)

            a3 = lat[i + 1]
            a4 = lat[i + 2]
            dA2 = lat[i + 2] - lat[i + 1]
            dB2 = lon[i + 2] - lon[i + 1]

            m2 = math.sin(dA2 / 2) * math.sin(dA2 / 2) + math.cos(a3) * math.cos(a4) * math.sin(dB2 / 2) * math.sin(
                dB2 / 2)
            n2 = 2 * math.atan2(math.sqrt(m2), math.sqrt(1 - m2))

            distance2 = R * n2
            print("Distance 2 is ", distance2)

            a5 = lat[i + 2]
            a6 = lat[0]
            dA3 = lat[0] - lat[i + 2]
            dB3 = lon[0] - lon[i + 2]

            m3 = math.sin(dA3 / 2) * math.sin(dA3 / 2) + math.cos(a5) * math.cos(a6) * math.sin(dB3 / 2) * math.sin(
                dB3 / 2)
            n3 = 2 * math.atan2(math.sqrt(m3), math.sqrt(1 - m3))

            distance3 = R * n3
            print("Distance 3 is ", distance3)

            print(distance1 + distance2 + distance3)

            S = (distance1 + distance2 + distance3) / 2

            area = math.sqrt((S * (S - distance1) * (S - distance2) * (S - distance3)))
            print("area of ", i + 1, "is ", area)
            Area = Area + area

        roundedArea = round(Area, 2)
        print("\nTotal area is ", roundedArea, "m^2")
        return roundedArea