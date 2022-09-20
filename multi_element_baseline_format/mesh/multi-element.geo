
//------------------------------------------------------------------------------------
//MESH SIZE
lc = 0.001 ;
lc2 = 0.3 ;
lc3 = 0.3;
lc4 = 0.01;
//-----------------------------------------------------------------------------------
//PARAMETERS
mainplane_scale = 0.4425;
flap_scale = 0.4425;

airfoil_t = 0.12*mainplane_scale;
x_max_t = 0.214*mainplane_scale;

g = 0.05;
trpx = 0.9*mainplane_scale;
trpy = airfoil_t+g;
aoa = 0;
aoa_r = aoa*0.01745329252;

aoa_fl = 0;
aoa_fl_r = aoa_fl*0.01745329252;

negativeAOA_correction_fac = (airfoil_t-x_max_t*Tan(aoa_r))*Cos(aoa_r);
hc_aim = 0.2;
hc = -(hc_aim + negativeAOA_correction_fac);
//hc = hc_aim+positiveAOA_correction_fac;

//hc = f*mainplane_scale; //floor distance in terms of chord length

Include "gaw.geo";
//rotation
Rotate {{0, 0, 1}, {0, 0, 0}, aoa_r} {
  Curve{1,2}; 
}

//+
Point(80) = {-0.3, 0.8, 0, 0.3};
//+
Point(81) = {3, 0.8, 0, 0.3};
//+
Point(82) = {3, hc, 0, 0.3};
//+
Point(83) = {-0.3, hc, 0, 0.3};
//+

//+

//+
Point(86) = {3, 3, 0, 0.3};
//+

//+

//+
Point(89) = {-0.3, 3, 0, 0.3};
//+

//+
Point(91) = {-4, hc, 0, 0.3};
//+
Point(92) = {-4, 0.8, 0, 0.3};
//+
Point(93) = {5, 0.8, 0, 0.3};
//+

//+
Point(95) = {5, hc, 0, 0.3};
//+
Line(3) = {80, 92};
//+
Line(4) = {91, 83};
//+
Line(5) = {80, 83};
//+
Line(6) = {81, 80};
//+

//+
Line(10) = {82, 83};
//+
Line(11) = {81, 82};
//+
Line(12) = {80, 89};
//+
Line(13) = {86, 81};
//+
Line(14) = {82, 95};
//+
Line(15) = {93, 81};
//+

//+

//+

//+

//+
Point(96) = {-4, 3, -0, 0.3};
//+
Point(97) = {5, 3, 0, 0.3};
//+
Line(20) = {96, 92};
//+
Line(21) = {91, 92};
//+

//+
Line(23) = {96, 89};
//+
Line(24) = {89, 86};
//+
Line(25) = {97, 86};
//+
Line(26) = {97, 93};
//+
Line(27) = {95, 93};
//+


Translate {trpx, trpy, 0} {
  Duplicata { Curve{1}; Curve{2}; }
}


Line Loop(1000) = {1,2};

//+
Curve Loop(1002) = {5, -10, -11, 6};

Line Loop(2000) = {29,28};

Plane Surface(200) = {1000,1002,2000};

//+
Curve Loop(1003) = {20, -3, 12, -23};
//+
Plane Surface(201) = {1003};
//+
Curve Loop(1004) = {24, 13, 6, 12};
//+
Plane Surface(202) = {1004};
//+
Curve Loop(1005) = {25, 13, -15, -26};
//+
Plane Surface(203) = {1005};
//+
Curve Loop(1006) = {11, 14, 27, 15};
//+
Plane Surface(204) = {1006};
//+
Curve Loop(1007) = {21, -3, 5, -4};
//+
Plane Surface(205) = {1007};

MeshSize {80,92,91} = 0.025;
MeshSize {89,86} = 0.055;
MeshSize {80,81,82,83} = 0.025;
MeshSize {93,95} = 0.055;
MeshSize {96,97} = 0.075;

Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1,79};
Field[2].CurvesList = {1,28};
Field[2].SizeFar = 1;
Field[2].Size = 0.0008787354597783271;
Field[2].Ratio = 1.2;
Field[2].Thickness = 0.009787354597783271;
Field[2].IntersectMetrics = 0;
Field[2].Quads = 1;

Field[3] = MinAniso;
Field[3].FieldsList = {2};
Background Field = 3;
BoundaryLayer Field = 2;

//+
Dilate {{0, 0, 0}, {mainplane_scale, mainplane_scale, mainplane_scale}} {
  Curve{1,2}; 
}
Dilate {{trpx, trpy, 0}, {flap_scale,flap_scale,flap_scale}} {
  Curve{29,28}; 
}
Rotate {{0, 0, 1}, {trpx, trpy, 0}, aoa_fl_r} {
  Curve{29,28}; 
}

Extrude {0, 0, 2}{
  Surface{200,201,202,203,204,205};
  Layers{1};
  Recombine;
}


//+
Physical Surface("inlet", 2153) = {2139, 2051};
//+
Physical Surface("floor", 2154) = {2151, 2029, 2121};
//+
Physical Surface("outlet", 2155) = {2125, 2107};
//+
Physical Surface("walls", 2156) = {2063, 2073, 2095};
//+
Physical Surface("frontAndBack", 2157) = {2152, 2064, 2042, 2086, 2130, 2108, 205, 200, 204, 203, 202, 201};
//+
Physical Surface("airfoil", 2158) = {2013, 2017};
//+
Physical Surface("flap", 2159) = {2037, 2041};
//+
Physical Volume("volume", 2160) = {2, 6, 1, 3, 4, 5};
