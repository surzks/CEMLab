# Julia Introduction
[Julia](https://julialang.org/) is a relatively new programming language (version 1.0 2018).
It was developed specifically for implementing numerical algorithms and is intended to combine the speed of C or Fortran with the ease of use of Python or Matlab.
This is achieved by compiling Julia just-in-time (while C or Fortran is compiled before execution, and Python and Matlab are interpreted). 

Furthermore, Julia supports metaprogramming, which is based on ideas from Lisp. In this course we will not deal with metaprogramming due to time constraints, but only with the features we need in the following practical lessons. There will be a special focus on how to actually write "good" programs.

# Julia basics
## Types
In Julia, there are all common data types.
Of particular interest to us are `Int64` (64-bit large integers) and `Float64` (64-bit large real numbers, i.e. *double precision*).
Julia also knows so-called *abstract* data types, such as `Integer`.


*Variables are always written in lower case in Julia. 
A variable name that is composed of different words is written together.
However, if the name of a variable is too long or becomes misleading, underscores can be used to separate the word components.*
### Integer
```julia
# Integer
i1 = 1
@show typeof(i1)
@show i1 isa Integer
```
Julia creates an integer in 64-bit representation by default.
To use 16- or 32-bit, the structure of the data type must be used.
```julia
i2 = 1
@show typeof(i2)
i2 = Int32(1)
@show typeof(i2)
i2 = Int16(1)
@show typeof(i2)
```
### Floating point
Floating point numbers work in the same way as integers. 
What is interesting here is the precision with which a float operation is executed.
We can display this with the `eps()` function.

```julia
# Float
f1 = 1.0
@show typeof(f1)
@show f1 isa Float64
@show eps(f1)

f1 = Float32(1.0)
@show eps(f1)

f1 = Float16(1.0)
@show eps(f1)

f1 = BigFloat(1.0)
@show eps(f1)
```

## Structs
Data structures work in Julia like in most other programming languages. 
One advantage of Julia is that the type of the individual parameters of a data structure can be defined by *parametric types*. 
The type of the parameter is not defined until the data structure is initialised.
The data type of an element does not necessarily have to be specified. 
However, this bears the risk of generating slow code, as it increases the probability that the compiler does not know which data type is present. 
Alternatively, one could specify concrete data types. 
Often, however, one does not want to do this, as one wants the freedom to choose a more precise/larger but slower data type, or a less precise/smaller but faster data type.

*Data structures are always capitalised in Julia. Individual words are "separated" by **CamelCase** notation*

```julia
struct MixedNumbers{I, F}
	i1::I
	i2::I
	f1::F
	f2::F
	f3::Float32
	f4
end
```
By using the parametric types `I` and `F` it is only determined that the variables `i1` and `i2` or `f1` and `f2` must have the same type.
```julia
mn = MixedNumbers(1, 2, 1.0, 2.0, 3.0f0, BigFloat(4.0))

@show mn.i1
@show typeof(mn.i1)
@show mn.f1
@show typeof(mn.f1)
@show typeof(mn.f3)
@show typeof(mn.f4)
@show typeof(mn)
```

## Functions
Similar to data structures, the types of the input parameters of a function can be specified by *parametric types*. 
This can be used to specify which parameters must be of the same type without specifying which type it must be.

Another useful functionality in Julia is that functions can be overloaded, which means that several functions can be defined with the same name but different input parameters.

*Function names are treated like variable names in Julia.*

*Functions that change an input parameter but do not have a return type get an exclamation mark appended.*

```julia
function pythagoras(a::F, b::F) where F <: Real
	c = sqrt(a^2 + b^2)
	return c
end
```
**Parametric types** are particularly useful for ensuring consistent data types: Usually, you want the arguments of a function to correspond to the return value. What would happen if we used `1.0` instead of `F(1.0)`?

```julia
function plusone(a::F) where F
	return a + F(1.0)
end

@show plusone(Float32(2.0))
@show eltype(plusone(Float32(2.0)))
```

Functions should always be documented. Below you will find an example.

```julia
"""
	add(a, b)

Returns the sum of the values `a` and `b`.
"""
function add(a, b)
	return a + b
end
```

## Syntax
### `if`-Statement
In Julia, `if` statement can be created with any number of queries. 
It is started with an `if` statement and all further statements are appended with `elseif`. 
An `else` statement is optional and is concluded with an `end`.

The usual logical operators are available

| Operator | Meaning |
| -------- | --------- |
| !x | Negation |
| x && y | and |
| x \|\| y | or |

and the following relational operators:

| Operator | Meaning |
| -------- | --------- |
| x == y | equality |
| x != y | inequality |
| x > y | is greater than |
| x >= y | is greater than or equal to |
| x < y| is smaller than |
| x <= y | is smaller than or equal to |

```julia
var1 = 1.0
if var1 isa Integer
    println("Integer")
elseif var1 isa Float64
    println("Float")
else
    println("No Float or Integer")
end

if (1.0 > 1.5) || (1.0 < 2.0)
    println(true)
end

# This is a neat way to make an if-statement
# in a single line: if the first statement is true
# the second statement will be executed
# There is no problem that the second statement
# is not a Boolean
3 == 3 && println("Hello World")
```

### Arrays, matrices and vectors
In Julia there are the types `Matrix{T}` and `Vector{T}`. 
Both belong to the superordinate type `Array{T}`. 
Vectors are one-dimensional arrays and matrices are two-dimensional.

*Arrays should always be pre-allocated if possible and not enlarged in a routine. *

```julia
# empty arrays
# Vector
a1 = zeros(Float64, 5)
@show typeof(a1)
# Matrix
a2 = zeros(Float64, 5, 5)
@show typeof(a2)
# Array
a3 = zeros(Float64, 5, 5, 5)
@show typeof(a3)
# Vector, but not initialized
# If entries overwritten anyhow (without read),
# then this faster than zeros()
u1 = Array{Float64}(undef, 5)
@show typeof(u1)
```

## Testing
Above you can already see the `using Test` and the use of the `@test` macro. 
What happens here is that it checks that a certain expression is `true`. 
If it is `false` instead, you will get an error. 


*In practice, tests are used to check that all functions in the code do exactly what they are supposed to do. If functions are later changed or extended, you can make sure that the previously existing functionalities have not been changed by mistake by executing all tests.*

## `for- loops
Unlike in Matlab, for example, `for` loops are often the best choice in Julia. 
In many cases, a `for` loop can be replaced by a matrix-matrix or matrix-vector product. 
In most cases, this is less readable and not necessarily the faster option in Julia.

```julia

a = [5:10]

# iterating over each element in a
for element in a
	...
end

# iterating over each index of array a
for index in eachindex(a)
	...
end
# equivalent to (can become problematic if startindex is changed)
for index = 1:length(a)
	...
end

# iterating over each element of a, retrieving index and element
for (index, element) in enumerate(a)
	...
end

#iterating over a range
for i = 1:10
	...
end
```

## Unicode support
Julia supports Unicode, all Unicode characters can be used in the code. 
For example, variable names can be Greek letters, which is very helpful when programming mathematical functions, as variables can have the same name as in the equations. 
An overview of all supported characters can be found [here](https://docs.julialang.org/en/v1/manual/unicode-input/). 

*You can enter the letters by typing a backslash and the name of the symbol, the Tab key will then convert this into the corresponding symbol.*
