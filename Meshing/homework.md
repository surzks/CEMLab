# Homework - Mesh

## Homework 1: Curved Line Mesh
Create a function that creates a line mesh for a curved line segment defined by a curvature parameter (e.g., radius of curvature). The function should take the length of the line segment, number of elements, and curvature parameter as input. The function should return a `LineMesh` object representing the curved line segment in a two-dimensional space.

## Homework 2: SurfaceMesh Struct
Create a concrete subtype `SurfaceMesh` that represents a 2D mesh consisting of triangular elements. The struct should store the coordinates of the nodes and triples of indices describing each triangle.

## Homework 3: SurfaceMesh - Mesh Generation
Implement a function `meshrectangle` that generates a surface mesh for a square domain with given side length and number of elements along each side. The function should return a `SurfaceMesh` object in a three-dimensional space.

## Homework 4: SurfaceMesh - Translation
Adapt the `translate!` method to work with the `SurfaceMesh` type. The method should modify the coordinates of all nodes in the surface mesh.

## Homework 5: SurfaceMesh - Welding
Adapt the `weld` method to merge two `SurfaceMesh` objects into one.

## Homework 6: SurfaceMesh - Visualization
Implement a method `plot` that visualizes the surface mesh using the `Plots` package.