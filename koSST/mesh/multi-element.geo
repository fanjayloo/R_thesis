
//------------------------------------------------------------------------------------
//MESH SIZE
lc = 0.001 ;
lc2 = 0.3 ;
lc3 = 0.3;
lc4 = 0.01;
//-----------------------------------------------------------------------------------
//PARAMETERS
mainplane_scale = 1;
airfoil_t = 0.12*mainplane_scale;
x_max_t = 0.214*mainplane_scale;

aoa = 0;
aoa_r = aoa*0.01745329252;

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
Point(80) = {-0.2, 0.8, 0, 0.3};
//+
Point(81) = {1.5, 0.8, 0, 0.3};
//+
Point(82) = {1.5, hc, 0, 0.3};
//+
Point(83) = {-0.2, hc, 0, 0.3};
//+

//+

//+
Point(86) = {1.5, 3, 0, 0.3};
//+

//+

//+
Point(89) = {-0.2, 3, 0, 0.3};
//+

//+
Point(91) = {-2, hc, 0, 0.3};
//+
Point(92) = {-2, 0.8, 0, 0.3};
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
Point(96) = {-2, 3, -0, 0.3};
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


Line Loop(1000) = {1,2};

//+
Curve Loop(1002) = {5, -10, -11, 6};

Plane Surface(200) = {1000,1002};



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
MeshSize {80,81,82,83} = 0.005;
MeshSize {93,95} = 0.055;
MeshSize {96,97} = 0.075;

Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1,79};
Field[2].CurvesList = {1};
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

Extrude {0, 0, 0.0001}{
  Surface{200,201,202,203,204,205};
  Layers{1};
  Recombine;
}


//+
Physical Surface("inlet", 1150) = {1048, 1136};
//+
Physical Surface("walls", 1151) = {1060, 1070, 1092};
//+
Physical Surface("outlet", 1152) = {1104, 1122};
//+
Physical Surface("floor", 1153) = {1118, 1034, 1148};
//+
Physical Surface("frontAndBack", 1154) = {1061, 201, 1149, 205, 202, 1083, 1039, 200, 1105, 203, 204, 1127};
//+
Physical Surface("airfoil", 1155) = {1018, 1022};
//+
Physical Volume("volume", 1156) = {2, 6, 1, 3, 4, 5};
//+
Transfinite Curve {1009} = 50 Using Progression 1;
