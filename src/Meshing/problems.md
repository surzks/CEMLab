# Problems - Mesh

## Problem 1: Mesh Struct
Create an abstract type `Mesh` and a concrete subtype `LineMesh` that represents a 1D mesh consisting of line segments. The struct should store the coordinates of the nodes and tuples of indices describing each line segment.

## Problem 2: Mesh - Translation
Implement a method `translate!` that translates the entire mesh by a given vector. The method should modify the coordinates of all nodes in the mesh.

## Problem 3: Mesh - Welding
Implement a method `weld` that merges two meshes into one.

## Problem 4: Mesh - Mesh Generation
Implement a function `meshline` that generates a line mesh for a given a start point, end point, and the number of elements. The function should return a `LineMesh` object in the same dimensional space as the input points.

## Problem 5: Mesh - Visualization
Implement a method `plot` that visualizes the line mesh using the `Plots` package.