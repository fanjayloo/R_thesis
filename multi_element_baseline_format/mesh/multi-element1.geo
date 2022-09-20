
//------------------------------------------------------------------------------------
//MESH SIZE
lc = 0.001 ;
lc2 = 0.3 ;
lc3 = 0.3;
lc4 = 0.01;
//-----------------------------------------------------------------------------------
//PARAMETERS
mainplane_scale = 0.51428;

f = -0.1;
hc = f*mainplane_scale; //floor distance in terms of chord length
d = 3; //wall 
ud = 1; //upperwall
ind = -1; //inlet distance
aoa = 15;
aoa_r = aoa*0.01745329252;


Include "gaw.geo";
// boundary layer 
//--------------------------------------------------------------------------------------
//rotation
Rotate {{0, 0, 1}, {0, 0, 0}, aoa_r} {
  Curve{1,2}; 
}

//-----------------------------------------------------------------------------------------
//BOUNDARYLAYER CREATION
Point(1000) = {d,ud,0,lc2};
Point(1001) = {ind,ud,0,lc2};
Point(1002) = {ind,f,0,lc3};
Point(1003) = {d,f,0,lc3};

//wall 
Line(5) = {1000,1001};
//inlet
Line(6) = {1001,1002};
//floor
Line(7) = {1002,1003};
//outlet
Line(8) = {1003,1000};


Line Loop(100) = {6,7,8,5};
Line Loop(101) = {1,2};
Plane Surface(200) = {100,101};


Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1,79};
Field[2].CurvesList = {1};
Field[2].SizeFar = 1;
Field[2].Size = 0.000344345132020296;
Field[2].Ratio = 1.2;
Field[2].Thickness = 0.00744345132020296;
Field[2].IntersectMetrics = 0;
Field[2].Quads = 1;

Field[1] = Box;
Field[1].VIn = 0.005;
Field[1].VOut = 0.2;
Field[1].XMin = -0.5;
Field[1].XMax = 5;
Field[1].YMax = 0.5;
Field[1].YMin = -1;
Field[1].Thickness = 2;

Field[4] = Box;
Field[4].VIn = 0.005;
Field[4].XMin = -2;
Field[4].XMax = 10;
Field[4].YMax = -0.05;
Field[4].YMin = -0.1;
Field[4].Thickness = 2;

Field[3] = MinAniso;
Field[3].FieldsList = {1, 2,4};
Background Field = 3;
BoundaryLayer Field = 2;


Mesh.BoundaryLayerFanElements = 30;

//+
Dilate {{0, 0, 0}, {mainplane_scale, mainplane_scale, mainplane_scale}} {
  Curve{1,2}; 
}

Extrude {0, 0, 2}{
  Surface{200};
  Layers{1};
  Recombine;
}

Physical Surface("inlet") = {211};
Physical Surface("walls") = {223};
Physical Surface("floor") = {215};
Physical Surface("outlet") = {219};
Physical Surface("airfoil") = {227,231};
Physical Surface("frontAndBack") = {200,232};
Physical Volume("volume") = {1};
