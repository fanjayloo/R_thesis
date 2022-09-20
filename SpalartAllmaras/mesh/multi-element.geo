lc = 0.033 ;
lc2 = 0.45 ;
lc3 = 0.033 ;

f = -10;
d = 10;
yc = 0;
aoa = 0;

Include "gaw.geo";


// boundary layer 

Point(1000) = {d,d,0,lc2};
Point(1001) = {-d,d,0,lc2};
Point(1002) = {-d,f,0,lc2};
Point(1003) = {d,f,0,lc2};

//wall 
Line(5) = {1000,1001};
//inlet
Line(6) = {1001,1002};
//floor
Line(7) = {1002,1003};
//outlet
Line(8) = {1003,1000};

Line Loop(9) = {6,7,8,5};
Line Loop(10) = {1,2,3,4};
Plane Surface(11) = {9,10};

Field[2] = BoundaryLayer;
Field[2].FanPointsList = {1};
Field[2].CurvesList = {1,2,3,4};
Field[2].SizeFar = 1.5;
Field[2].Size = 0.0018;
Field[2].Ratio = 1.2;
Field[2].Thickness = .03;
Field[2].IntersectMetrics = 1;
Field[2].Quads = 1;

Field[1] = Box;
Field[1].VIn = 0.05;
Field[1].VOut = 1;
Field[1].XMin = -2;
Field[1].XMax = 2;
Field[1].YMax = 1;
Field[1].YMin = -1;
Field[1].Thickness = 2;

Field[3] = MinAniso;
Field[3].FieldsList = {1, 2};
Background Field = 3;
BoundaryLayer Field = 2;


Mesh.BoundaryLayerFanElements = 30;

//Mesh.Algorithm = 8; // del for quads
//Mesh.RecombineAll = 1;

//translation 
Translate {0, -yc, 0} {
  Curve{1}; 
}

//rotation
Rotate {{0, 0, 1}, {0, 0, 0}, aoa} {
  Curve{1}; 
}
Extrude {0, 0, 1}{
  Surface{11};
  Layers{1};
  Recombine;
}
  
Physical Surface("inlet") = {24};
Physical Surface("walls") = {28,36};
Physical Surface("outlet") = {32};
Physical Surface("airfoil") = {40,44,48,52};
Physical Surface("frontAndBack") = {11,53};
Physical Volume("volume") = {1};