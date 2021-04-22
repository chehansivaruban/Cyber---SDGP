import math

import utm

coordinate_1 = (6.799876461577403, 79.92079429796134)

coordinate_2 = (6.79987785154483, 79.9208432496612)
coordinate_3 = (6.799818120361846, 79.92085590900636)
coordinate_4 = (6.799802845588296, 79.92080696323306)

utm_conversion = utm.from_latlon(coordinate_1[0],coordinate_1[1])

utm_conversion2 = utm.from_latlon(coordinate_2[0],coordinate_2[1])
utm_conversion3 = utm.from_latlon(coordinate_3[0],coordinate_3[1])
utm_conversion4 = utm.from_latlon(coordinate_4[0],coordinate_4[1])
print(utm_conversion)

print(utm_conversion2)
print(utm_conversion3)
print(utm_conversion4)


midx = (utm_conversion[0]+utm_conversion2[0]+utm_conversion3[0]+utm_conversion4[0])/4
midy = (utm_conversion[1]+utm_conversion2[1]+utm_conversion3[1]+utm_conversion4[1])/4
print("mid point :(",midx,",",midy,")")
midPointLonLat=utm.to_latlon(midx,midy,44,'N')#convert to longitude lattitude

print("Lat:",midPointLonLat)
def PolygonArea(corners):
    n = len(corners) # of corners
    area = 0.0
    for i in range(n):
        j = (i + 1) % n
        area += corners[i][0] * corners[j][1]
        area -= corners[j][0] * corners[i][1]
    area = abs(area) / 2.0
    return area

# examples
corners = [(utm_conversion[0], utm_conversion[1]), (utm_conversion2[0],utm_conversion2[1]), (utm_conversion3[0], utm_conversion3[1]),(utm_conversion4[0], utm_conversion4[1])]
print(PolygonArea(corners))

# LICENSE: public domain

def calculate_initial_compass_bearing(pointA, pointB):
    """
    Calculates the bearing between two points.
    The formulae used is the following:
        θ = atan2(sin(Δlong).cos(lat2),
                  cos(lat1).sin(lat2) − sin(lat1).cos(lat2).cos(Δlong))
    :Parameters:
      - `pointA: The tuple representing the latitude/longitude for the
        first point. Latitude and longitude must be in decimal degrees
      - `pointB: The tuple representing the latitude/longitude for the
        second point. Latitude and longitude must be in decimal degrees
    :Returns:
      The bearing in degrees
    :Returns Type:
      float
    """
    if (type(pointA) != tuple) or (type(pointB) != tuple):
        raise TypeError("Only tuples are supported as arguments")

    lat1 =  math.radians(pointA[0])
    lat2 = math.radians(pointB[0])

    diffLong = math.radians(pointB[1] - pointA[1])

    x = math.sin(diffLong) * math.cos(lat2)
    y = math.cos(lat1) * math.sin(lat2) - (math.sin(lat1)
            * math.cos(lat2) * math.cos(diffLong))

    initial_bearing = math.atan2(x, y)

    # Now we have the initial bearing but math.atan2 return values
    # from -180° to + 180° which is not what we want for a compass bearing
    # The solution is to normalize the initial bearing as shown below
    initial_bearing = math.degrees(initial_bearing)
    compass_bearing = (initial_bearing + 360) % 360

    return compass_bearing
value = calculate_initial_compass_bearing(midPointLonLat,coordinate_1)
print(value)