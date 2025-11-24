# Problems - BEM2D

## Problem 1: Meshing
Implement a function `meshstrips` that creates a line mesh for a capacitor consisting of two lines of a given length and distance. 
The function should take the length, distance, and number of elements on each line as input and return a `LineMesh` object. 

## Problem 2: BEM - Operator
Implement the 2D Greens function as a functor `Green2D` that takes two points as input and returns the value of the Green's function.

## Problem 3: BEM - Spaces
Implement two structs `PointSpace` and `ConstSpace` that represent the test points and piecewise constant function spaces on a given mesh. 
Each struct should contain the mesh.

## Problem 4: BEM - Integration
Extend the chapter NumericalIntegration by a generalized Gaussian quadrature rule that can handle logarithmic singularities.

## Problem 5: BEM - Assembly
Implement a method `assemble` that assembles the BEM system matrix for a given operator, test space, and trial space. 
The method should return the assembled matrix. 
The integration will be handled in the next problem by `integratesingular()`.

## Problem 6: BEM Singularity Treatment
The aim of this problem is to implement a simple singularity treatment for the BEM assembly for point matching.
For which combinations of test and trial functions do we have singular integrals?

*Solution: When the test point is in the integration interval.* 

Where is the singularity located and how can it be treated?

*Solution: The singularity is located at the test point. It can be treated by splitting the integral into two parts, one on each side of the singularity, and using a special gaussian quadrature rule (generalized Gaussian quadrature) that integrates functions with a logarithmic singularity exactly.*

## Problem 7: Solve a Capacitor Problem
To verify the implementation of the BEM implementation, solve a simple capacitor problem.
We consider two parallel plates of length $w=1$ separated by a distance $d=1$. The potential on the top plate is $0.5\,\text{V}$ and on the bottom plate $-0.5\,\text{V}$.
The capacitance is the sum of the charges on both plates divided by the potential difference $C = Q / U$.
The solution should be $18.7335027\, \text{pF/m}$