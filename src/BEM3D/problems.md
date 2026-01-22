# Problems
## Problem 1: EFIE
Use a sphere of radius 1m centered at the origin as geometry and implement the Electric Field Integral Equation (EFIE) for a plane wave incident field.
The examples in the BEAST documentation can be helpful for this task.

## Problem 2: Conditioning of the EFIE
Look at the conditioning of the EFIE system matrix for different frequencies, what can you observe?
Build a Calderon preconditioner for the EFIE and look at the conditioning again.

## Problem 3: Manufactured Solution
For the scattering of a plane wave at a sphere, analytical solutions are known (Mie series).
Sadly you do not have such a implementation available.
How can you verify that your EFIE implementation is correct?

## Problem 4: MFIE
Implement the Magnetic Field Integral Equation (MFIE) for the scattering of a plane wave at a perfectly conducting sphere.
How does the conditioning of the MFIE system matrix compare to the EFIE?

