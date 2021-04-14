import pyproj
import shapely
import shapely.ops as ops
from shapely.geometry.polygon import Polygon
from functools import partial


geom = Polygon([(0, 0), (0, 10), (10, 10), (10, 0), (0, 0)])
geom_area = ops.transform(
    partial(
        pyproj.transform,
        pyproj.Proj(init='EPSG:4326'),
        pyproj.Proj(
            proj='aea',
            lat1=geom.bounds[1],
            lat2=geom.bounds[3])),
    geom)

# Print the area in m^2
print(geom_area.area)





#without shading equation
'''
x - irradiance ( W/m*m )
a - solar panel area ( m/m )
h - hours ( h )'''

x = float(600)   #just gave some nuumbers to check this
a = geom_area.area    # x is from data science
h = int (2)      # a and h is from front end, user inputs

units = (x * a * h) / 1000

print (units)

