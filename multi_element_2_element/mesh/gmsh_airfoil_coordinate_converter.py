# author: Fan Jay Loo
# purpose: convert airfoil coordinates to gmsh version
airfoil_name = 'gaw'


#* read the coordinates to two lists
mainCoords = []
# flapCoords = []
with open('{}.txt'.format(airfoil_name)) as fin:
    fin.readline() # skip header
    fin.readline() # skip header
    for l in fin:
        coords =list(map(float,l.split()))
        mainCoords.append(coords[:2])
#       if len(coords) > 2:
#            flapCoords.append(coords[2:])

# create a GMSH file and write the points in GMSH format
with open('{}.geo'.format(airfoil_name),'w') as fout:
    for i, c in enumerate(mainCoords):
        fout.write('Point (%i) = {%f, %f, 0, lc};\n'%(i+1,c[0],c[1]))

#* for flaps 
 #   for i, c in enumerate(flapCoords):
 #       fout.write('Point (%i) = {%f, %f, 0, 1};\n'%(i+len(mainCoords)+1,c[0],c[1]))

#* Create splines
    fout.write('Spline (1) = {%s,1};\n' % ','.join(map(str,range(1,len(mainCoords)+1))))
#    fout.write('Spline (2) = {%s};\n' % ','.join(map(str,range(len(mainCoords)+1,len(mainCoords)+len(flapCoords)+1)))) #* forflaps
