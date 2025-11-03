# Meshing
This section covers the basics of meshing in 1D and 2D, which is essential for implementing numerical methods like the Finite Element Method (FEM) and Boundary Element Method (BEM). We will define simple data structures to represent meshes and provide functions to create common mesh types.

## Line Mesh
A line mesh consists of a set of nodes and elements (line segments) connecting these nodes.
These meshes are used to solve 1D problems (FEM) or to represent boundaries in 2D problems (BEM).

## Surface Mesh
A surface mesh consists of a set of nodes and elements (triangles or quadrilaterals) connecting these nodes.
These meshes are used to solve 2D problems (FEM) or to represent surfaces in 3D problems (BEM).

## Volume Mesh
A volume mesh consists of a set of nodes and elements (tetrahedra or hexahedra) connecting these nodes.
These meshes are used to solve 3D problems (FEM) or Volume Integral Equations (BEM).