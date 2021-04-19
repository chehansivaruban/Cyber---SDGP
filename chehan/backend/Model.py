# def find_area(array):
#     a = 0
#     ox,oy = array[0]
#     for x,y in array[1:]:
#         a += (x*oy-y*ox)
#         ox,oy = x,y
#         print(x)
#     return a/2
#
# print(find_area([(0,-1),(0,2), (1,2),(-1,-1)]))
#
# def shoelace_formula(polygonBoundary, absoluteValue = True):
#     nbCoordinates = len(polygonBoundary)
#     nbSegment = nbCoordinates - 1
#
#     l = [(polygonBoundary[i+1][0] - polygonBoundary[i][0]) * (polygonBoundary[i+1][1] + polygonBoundary[i][1]) for i in range(nbSegment)]
#
#     if absoluteValue:
#         return abs(sum(l) / 2.)
#     else:
#         return sum(l) / 2.
#
# polygonBoundary = [(0,0),(1,0),(-1,-1),(0,-1)]
#
# print(shoelace_formula(polygonBoundary,True))
#
# co = {"type": "Polygon", "coordinates": [
#     [(6.800004117406756, 79.9212096069458),
#      (6.800083712328738, 79.92163875419665),
#      (6.799906707516743, 79.92167829696132),
#      (6.799833433069831, 79.92124317181407)]]}
# lon, lat = zip(*co['coordinates'][0])
# from pyproj import Proj
# pa = Proj("+proj=aea +lat_1=37.0 +lat_2=41.0 +lat_0=39.0 +lon_0=-106.55")
#
# x, y = pa(lon, lat)
# cop = {"type": "Polygon", "coordinates": [zip(x, y)]}
# from shapely.geometry import shape
# print(shape(cop).area)  # 268952044107.43506
# from area import area
# obj = {'type':'Polygon','coordinates':[[(6.800005649334775, 79.92121210268597),(6.800080614960197, 79.92163223160216),(6.799908210220844, 79.92167738326087),(6.799830001511999, 79.92124997977321)]]}
# print(area(obj))
#
# co = {"type": "Polygon", "coordinates": [
#     [(6.800005649334775, 79.92121210268597),(6.800080614960197, 79.92163223160216),(6.799908210220844, 79.92167738326087),(6.799830001511999, 79.92124997977321)]]}
# lon, lat = zip(*co['coordinates'][0])
# from pyproj import Proj
# pa = Proj("+proj=aea +lat_1=37.0 +lat_2=41.0 +lat_0=39.0 +lon_0=-106.55")
#
# x, y = pa(lon, lat)
# cop = {"type": "Polygon", "coordinates": [zip(x, y)]}
# from shapely.geometry import shape
# print(shape(cop).area)  # 268952044107.43506

# from pyproj import Geod
# from shapely import wkt
#
# # specify a named ellipsoid
# geod = Geod(ellps="WGS84")
#
# poly = wkt.loads('''\POLYGON ((6.8000056 79.9212121,6.8000806 79.9216322,6.7999082 79.9216773,6.7998300 79.9212499))''')
#
# area = abs(geod.geometry_area_perimeter(poly)[0])
#
# print('# Geodesic area: {:12.3f} m^2'.format(area))
# print('#                {:12.3f} km^2'.format(area/1e6))
#
# # Geodesic area:  1083466.869 m^2
# #                       1.083 km^2
# from area import area
# obj = {'type':'Polygon','coordinates':[[[6.799831913729601, 79.92124659198352],[6.800005422397082, 79.9212138571927],[6.800073823774221, 79.92164965112644],[6.799911574255945, 79.9216753754958]]]}
# print(area(obj))
#
# from shapely.geometry import Polygon
# points = [(6.800005649334775, 79.92121210268597),(6.800080614960197, 79.92163223160216),(6.799908210220844, 79.92167738326087),(6.799830001511999, 79.92124997977321)]
# polygon = Polygon(points)
# # the area in square degrees
# area_sdeg = polygon.area
# print(area_sdeg)
# from area import area
# obj = {'type':'Polygon','coordinates':[[[6247568.315999, 8970249.566879],
#         [6247594.228829, 8970184.287092],
#         [6247761.474423, 8970233.464446],
#         [6247739.404801, 8970300.256833]]]}
# print(area(obj))

import pyproj
import shapely
import shapely.ops as ops
from shapely.geometry.polygon import Polygon
from functools import partial


# geom = Polygon([(6.800005649334775, 79.92121210268597),(6.800080614960197, 79.92163223160216),(6.799908210220844, 79.92167738326087),(6.799830001511999, 79.92124997977321)])
geom = Polygon([[380789.63,79.921210],[79.92163, 751781.29],[380840.45,751761.38],[79.92124,79.92124]])
geom_area = ops.transform(
    partial(
        pyproj.transform,
        pyproj.Proj(init='EPSG:3413'),
        pyproj.Proj(
            proj='aea',
            lat1=geom.bounds[1],
            lat2=geom.bounds[3])),
    geom)

# Print the area in m^2
print(geom_area.area)
