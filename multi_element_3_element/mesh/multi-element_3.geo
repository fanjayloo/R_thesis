lc = 0.001 ;
lc2 = 0.3 ;
lc3 = 0.003;

f = -0.06;
d = 10;
yc = 0;
aoa = 0;

aoa_r = aoa*0.01745329252;

sc_fl1 = 0.6;
sc_fl2 = 0.4;

trpx = 0.9;
trpy = 0.1;

aoa_fl1 = 40;
aoa_fl1_r = aoa_fl1*0.01745329252;
aoa_fl1_red = aoa_fl1 + 10;
aoa_fl1_red_r = aoa_fl1_red*0.01745329252;

aoa_fl2 = 50;
aoa_fl2_r = aoa_fl2*0.01745329252;

aoa_ftot = -30;
aoa_ftot_r = aoa_ftot*0.01745329252;

Include "gaw.geo";


// boundary layer 

Point(1000) = {d,5,0,lc2};
Point(1001) = {-2,5,0,lc2};
Point(1002) = {-2,f,0,lc3};
Point(1003) = {d,f,0,lc3};

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

//translation 
Translate {0, -yc, 0} {
  Curve{1}; 
}

//rotation
Rotate {{0, 0, 1}, {0, 0, 0}, aoa_r} {
  Curve{1,2,3,4}; 
}

//flap 1
Translate {trpx, trpy, 0} {
  Duplicata { Curve{1,2,3,4,6000};}
}
Rotate {{0, 0, 1}, {trpx, trpy, 0}, aoa_fl1_r} {
  Curve{6001,6002,6003,6004,6005}; 
}
Dilate {{trpx, trpy, 0}, {sc_fl2, sc_fl2, sc_fl2}} {
  Duplicata{Curve{6001,6002,6003,6004,6005};} 
}
Dilate {{trpx, trpy, 0}, {sc_fl1, sc_fl1, sc_fl1}} {
 Curve{6001,6002,6003,6004,6005}; 
}
Translate {Cos(aoa_fl1_red_r)*sc_fl1, Sin(aoa_fl1_r)*sc_fl1, 0} {
  Curve{6006,6007,6008,6009,6010}; 
}
Rotate {{0, 0, 1}, {1.2,0.559, 0}, aoa_fl2_r} {
  Curve{6006,6007,6008,6009,6010}; 
}
Rotate {{0, 0, 1}, {trpx,trpy, 0}, aoa_ftot_r} {
  Curve{6001,6002,6003,6004,6005,6006,6007,6008,6009,6010}; 
}
Line Loop (7000) = {6001,6002,6003,6004,6005};
Line Loop (7001) = {6006,6007,6008,6009,6010};
Plane Surface(11) = {9,10,7000,7001};


Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1};
Field[2].CurvesList = {1,2,3,4,6001,6002,6003,6004,6006,6007,6008,6009,6005};
Field[2].SizeFar = 1;
Field[2].Size = 0.000344345132020296;
Field[2].Ratio = 1.2;
Field[2].Thickness = 0.00744345132020296;
Field[2].IntersectMetrics = 1;
Field[2].Quads = 1;

Field[1] = Box;
Field[1].VIn = 0.1;
Field[1].VOut = 1;
Field[1].XMin = -2;
Field[1].XMax = 10;
Field[1].YMax = 1;
Field[1].YMin = -1;
Field[1].Thickness = 2;

Field[3] = MinAniso;
Field[3].FieldsList = {1, 2};
Background Field = 3;
BoundaryLayer Field = {2,4};


Mesh.BoundaryLayerFanElements = 30;

//Mesh.Algorithm = 8; // del for quads
//Mesh.RecombineAll = 1;

//+
Dilate {{0, 0, 0}, {0.3, 0.3, 0.3}} {
  Curve{1,2,3,4,6000,6001,6002,6003,6004,6005,6006,6007,6008,6009,6010}; 
}
Extrude {0, 0, 0.0001}{
  Surface{11};
  Layers{1};
  Recombine;
}
  




Physical Surface("inlet") = {7025};
Physical Surface("walls") = {7037};
Physical Surface("floor") = {7029};
Physical Surface("outlet") = {7033};
Physical Surface("airfoil") = {7041,7045,7049,7053,7057,7061,7065,7069,7073,7077,7081,7085,7089,7093,7097};
Physical Surface("frontAndBack") = {11,7098};
Physical Volume("volume") = {1};







