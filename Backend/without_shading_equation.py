#without shading equation
'''
x - irradiance ( W/m*m )
a - solar panel area ( m/m )
h - hours ( h )'''

x = float(600)   #just gave some nuumbers to check this
a = float(10)    # x is from data science
h = int (2)      # a and h is from front end, user inputs

units = (x * a * h) / 1000

print (units)

