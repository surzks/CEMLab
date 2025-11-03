# Homework - Julia Introduction
## H1: Initialization of arrays
Create a two-dimensional square array with 10,000 entries, where each element value corresponds to the sum of the column and row index. 
Load the `Test` package and use the `@test`-macro to test the result.

## H2: Iterative updating
Create a vector with 100 entries, with all values set to zero.
Set two random values to the value one.
Now write a function `propagate!()` that receives a vector as an input parameter. The function should update the vector iteratively. In each update, each neighboring element of a one should also be set to the value 1. 
If all elements of the vector are one, the function should return the number of iterations required.

## H3: Pythagorean Triples
The numbers $a=3$, $b=4$ and $c=5$ form a Pythagorean triple, which means that $a^2+b^2=c^2$, where $a$, $b$ and $c$ are integers. There is such a triple where the sum of $a$, $b$ and $c$ is 1000. This is the one we want to find. Where possible, try to use the concepts introduced so far (for example, use a struct to store your triples).