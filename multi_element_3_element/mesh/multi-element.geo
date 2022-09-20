lc = 0.0015 ;
lc2 = 0.3 ;
lc3 = 0.3;

mainplane_scale = 0.3098;
flap_scale = 0.1549;
flap2_scale = 0.8;
g=0.030;
g2=0.03;
airfoil_t = 0.12;
x_max_t = 0.214*mainplane_scale;
d = 10;
yc = 0;

aoa = 0;
aoa_r = aoa*0.01745329252;

negativeAOA_correction_fac = (airfoil_t*mainplane_scale-x_max_t*Tan(aoa_r))*Cos(aoa_r);
hc_aim = 0.2;
hc = -(hc_aim + negativeAOA_correction_fac);

trpx = 0.9*mainplane_scale;
trpy = airfoil_t*mainplane_scale+g;

aoa_fl1 = 4;
aoa_fl1_r = aoa_fl1*0.01745329252;

aoa_fl2 = 0;
aoa_fl2_r = aoa_fl2*0.01745329252;

trpx2 = trpx+(flap_scale*0.9);
trpy2 = trpy + g2;

Include "gaw.geo";

Dilate {{0, 0, 0}, {flap_scale, flap_scale, flap_scale}} {
  Duplicata { Curve{1,2,3,4,6000};}
}

Dilate {{0, 0, 0}, {mainplane_scale, mainplane_scale, mainplane_scale}} {
  Curve{1,2,3,4,6000}; 
}
//rotation
Rotate {{0, 0, 1}, {0, 0, 0}, aoa_r} {
  Curve{1,2,3,4}; 
}

//flap 1
Translate {trpx, trpy, 0} {
  Curve{6001,6002,6003,6004,6005};
}
Rotate {{0, 0, 1}, {trpx, trpy, 0}, aoa_fl1_r} {
  Curve{6001,6002,6003,6004,6005}; 
}

//flap 2
Translate {flap_scale*0.9, trpy2-0.035, 0} {
  Duplicata { Curve{6001,6002,6003,6004,6005}; }
}
Rotate {{0, 0, 1}, {trpx2, trpy2, 0}, aoa_fl2_r} {
  Curve{6006,6007,6008,6009,6010}; 
}
Dilate {{trpx2, trpy2, 0}, {flap2_scale, flap2_scale, flap2_scale}} {
  Curve{6006,6007,6008,6009,6010}; 
}

// boundary layer 

Point(1000) = {d,5,0,lc2};
Point(1001) = {-2,5,0,lc2};
Point(1002) = {-2,hc,0,lc3};
Point(1003) = {d,hc,0,lc3};

//wall 
Line(5) = {1000,1001};
//inlet
Line(6) = {1001,1002};
//floor
Line(7) = {1002,1003};
//outlet
Line(8) = {1003,1000};

Line Loop(9) = {6,7,8,5};
Line Loop(10) = {1,2,3,4,6000};
Line Loop (7000) = {6001,6002,6003,6004,6005};
Line Loop (7001) = {6006,6007,6008,6009,6010};

Plane Surface(11) = {9,10,7000,7001};



Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1,79,81,168,169,256};
Field[2].CurvesList = {1,2,3,4,6000,6001,6002,6003,6004,6005,6006,6007,6008,6009,6010};
Field[2].SizeFar = 1;
Field[2].Size = 0.00037526877501841175;
Field[2].Ratio = 1.2;
Field[2].Thickness = 0.009;
Field[2].IntersectMetrics = 1;
Field[2].Quads = 1;

Field[1] = Box;
Field[1].VIn = 0.01;
Field[1].VOut = 0.2;
Field[1].XMin = -1;
Field[1].XMax = 10;
Field[1].YMax = 0.5;
Field[1].YMin = -1;
Field[1].Thickness = 2;

Field[3] = MinAniso;
Field[3].FieldsList = {1, 2};
Background Field = 3;
BoundaryLayer Field = {2,4};


Mesh.BoundaryLayerFanElements = 30;

//Mesh.Algorithm = 8; // del for quads
//Mesh.RecombineAll = 1;

Extrude {0, 0, 2}{
  Surface{11};
  Layers{1};
  Recombine;
}

Physical Surface("inlet") = {7025};
Physical Surface("walls") = {7037};
Physical Surface("floor") = {7029};
Physical Surface("outlet") = {7033};
Physical Surface("airfoil") = {7049, 7053, 7045, 7057, 7041};
Physical Surface("flap") = {7069, 7073, 7065, 7077, 7061};
Physical Surface("flap2") = {7089, 7093, 7085, 7097,7081};
Physical Surface("frontAndBack") = {11,7098};
Physical Volume("volume") = {1};





