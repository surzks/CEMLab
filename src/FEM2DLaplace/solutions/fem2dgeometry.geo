//delx = 0.01;

Point(1) = {0.5, 0, 0, delx};
Point(2) = {1, 0, 0, delx};
Point(3) = {1, 1, 0, delx};
Point(4) = {0, 1, 0, delx};
Point(5) = {0, 0.5, 0, delx};
Point(6) = {0,0,0, delx};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 5};
Circle(5) = {5, 6, 1};

Curve Loop(5) = {1, 2, 3, 4, 5};


Plane Surface(6) = {5};
Physical Surface("domain") = {6};
Physical Line("bottom", 1001) = {1};
Physical Line("right", 1002) = {2};
Physical Line("top", 1003) = {3};
Physical Line("left", 1004) = {4};
Physical Curve("circ", 1005) = {5};

