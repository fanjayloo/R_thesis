#!/bin/bash

airfoil_no="NACA6412"

flag=0.4

for g in 0.2
do 
  
    
    for i in $(seq -10 1 0)
    do
    echo "starting simulation with aoa $i" > case/log.mesh

    sed -i "14s/.*/aoa = $i;/" mesh/multi-element.geo

    sed -i "19s/.*/hc_aim = $g;/" mesh/multi-element.geo

    ./run.sh

    cp case/log.res /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection2/$airfoil_no/results/yc_$g/log_res_$i.txt

    cp mesh/multi-element.geo /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection2/$airfoil_no/results/yc_$g/multi-element_$i.geo

    cp case/postProcessing/forceCoeffs1/0/coefficient.dat /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection2/$airfoil_no/results/yc_$g/coefficient_$i.dat 
        
    cp case/postProcessing/solverInfo/0/solverInfo.dat /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection2/$airfoil_no/results/yc_$g/solverInfo_$i.dat

    cp case/postProcessing/yPlus/0/yPlus.dat /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection2/$airfoil_no/results/yc_$g/yplus_$i.dat
        
    done


done
    

    