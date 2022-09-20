#!/bin/sh

# Quit script if any step has error:
set -e
#* Clean any sets of existing data 
python3 clean.py

#* Generate specific airfoil profile
#python3 mesh/gmsh_airfoil_coordinate_converter.py

#* Generate the mesh from script (msh2 format is currently the latest gmshToFoam recognizes):
gmsh mesh/multi-element.geo -3 -format msh2 -o mesh/main.msh
#* Convert the mesh to OpenFOAM format:
gmshToFoam mesh/main.msh -case case
#* Checkmesh
checkMesh -case case
#* Adjust polyMesh/boundary:
changeDictionary -case case
#* PARALLEL
decomposePar -case case
#* run the simulation:
mpirun -np 6 simpleFoam -case case -parallel > case/log.res
# reconstruct
reconstructPar -latestTime -case case