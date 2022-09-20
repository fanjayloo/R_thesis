#!/bin/bash

airfoil_no="S1223"

mainplaneAOA=10

for i in $(seq 0 1 90)
do
echo "starting simulation with aoa $i" > case/log.mesh

sed -i "8s/.*/aoa = $mainplaneAOA;/" mesh/multi-element.geo

sed -i "17s/.*/aoa_fl1 = $i;/" mesh/multi-element.geo

./run.sh

cp case/log.res /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection/$airfoil_no/results/yc_$g/log_res_$i.txt

cp mesh/multi-element.geo /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection/$airfoil_no/results/yc_$g/multi-element_$i.geo

cp case/postProcessing/forceCoeffs1/0/coefficient.dat /mnt/d/Personal\ Projects/Racing\ Car\ Front\ Wing\ Project/CFD\ Results/Airfoil\ Selection/$airfoil_no/results/yc_$g/coefficient_$i.dat 


done
    

    