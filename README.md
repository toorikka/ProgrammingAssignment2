### Introduction

This second programming assignment will require you to write an R
function that is able to cache potentially time-consuming computations.
For example, taking the mean of a numeric vector is typically a fast
operation. However, for a very long vector, it may take too long to
compute the mean, especially if it has to be computed repeatedly (e.g.
in a loop). If the contents of a vector are not changing, it may make
sense to cache the value of the mean so that when we need it again, it
can be looked up in the cache rather than recomputed. In this
Programming Assignment you will take advantage of the scoping rules of
the R language and how they can be manipulated to preserve state inside
of an R object.

### Example: Caching the Mean of a Vector

In this example we introduce the `<<-` operator which can be used to
assign a value to an object in an environment that is different from the
current environment. Below are two functions that are used to create a
special object that stores a numeric vector and caches its mean.

The first function, `makeVector` creates a special "vector", which is
really a list containing a function to

1.  set the value of the vector
2.  get the value of the vector
3.  set the value of the mean
4.  get the value of the mean

<!-- -->

    makeVector <- function(x = numeric()) {
            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setmean <- function(mean) m <<- mean
            getmean <- function() m
            list(set = set, get = get,
                 setmean = setmean,
                 getmean = getmean)
    }

The following function calculates the mean of the special "vector"
created with the above function. However, it first checks to see if the
mean has already been calculated. If so, it `get`s the mean from the
cache and skips the computation. Otherwise, it calculates the mean of
the data and sets the value of the mean in the cache via the `setmean`
function.

    cachemean <- function(x, ...) {
            m <- x$getmean()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- mean(data, ...)
            x$setmean(m)
            m
    }

### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at
    [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
    to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can
    edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your
    solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your
    git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains
    the completed R code for the assignment.

### Grading

This assignment will be graded via peer assessment.

###Tests done in console before editing the original file:

> source("testing.R") <- this script contains the functions in makeCacheMatrix
> source("testing2.R") <- this script contains the steps for cache checking and inverse calculation/result cacheing
> a <- matrix(1:54,9,6)
> my <- makeCacheMatrix(a)
> cacheSolve(my)
             [,1]         [,2]         [,3]          [,4]          [,5]
[1,] -0.041975309 -0.031922399 -0.021869489 -0.0118165785 -0.0017636684
[2,] -0.029629630 -0.022486772 -0.015343915 -0.0082010582 -0.0010582011
[3,] -0.017283951 -0.013051146 -0.008818342 -0.0045855379 -0.0003527337
[4,] -0.004938272 -0.003615520 -0.002292769 -0.0009700176  0.0003527337
[5,]  0.007407407  0.005820106  0.004232804  0.0026455026  0.0010582011
[6,]  0.019753086  0.015255732  0.010758377  0.0062610229  0.0017636684
              [,6]         [,7]         [,8]         [,9]
[1,]  0.0082892416  0.018342152  0.028395062  0.038447972
[2,]  0.0060846561  0.013227513  0.020370370  0.027513228
[3,]  0.0038800705  0.008112875  0.012345679  0.016578483
[4,]  0.0016754850  0.002998236  0.004320988  0.005643739
[5,] -0.0005291005 -0.002116402 -0.003703704 -0.005291005
[6,] -0.0027336861 -0.007231041 -0.011728395 -0.016225750

> cacheSolve(my)
using cached data
             [,1]         [,2]         [,3]          [,4]          [,5]
[1,] -0.041975309 -0.031922399 -0.021869489 -0.0118165785 -0.0017636684
[2,] -0.029629630 -0.022486772 -0.015343915 -0.0082010582 -0.0010582011
[3,] -0.017283951 -0.013051146 -0.008818342 -0.0045855379 -0.0003527337
[4,] -0.004938272 -0.003615520 -0.002292769 -0.0009700176  0.0003527337
[5,]  0.007407407  0.005820106  0.004232804  0.0026455026  0.0010582011
[6,]  0.019753086  0.015255732  0.010758377  0.0062610229  0.0017636684
              [,6]         [,7]         [,8]         [,9]
[1,]  0.0082892416  0.018342152  0.028395062  0.038447972
[2,]  0.0060846561  0.013227513  0.020370370  0.027513228
[3,]  0.0038800705  0.008112875  0.012345679  0.016578483
[4,]  0.0016754850  0.002998236  0.004320988  0.005643739
[5,] -0.0005291005 -0.002116402 -0.003703704 -0.005291005
[6,] -0.0027336861 -0.007231041 -0.011728395 -0.016225750

and numerous others :)

> setwd("C:/Users/minna/coursera/ProgrammingAssignment2")
> source("cachematrix.R")
> b <- matrix(1:54,6,9)
> mdata <- makeCacheMatrix(b)

> cacheSolve(mdata)
              [,1]         [,2]          [,3]          [,4]
 [1,] -0.061375661 -0.037566138 -0.0137566138  0.0100529101
 [2,] -0.050000000 -0.030555556 -0.0111111111  0.0083333333
 [3,] -0.038624339 -0.023544974 -0.0084656085  0.0066137566
 [4,] -0.027248677 -0.016534392 -0.0058201058  0.0048941799
 [5,] -0.015873016 -0.009523810 -0.0031746032  0.0031746032
 [6,] -0.004497354 -0.002513228 -0.0005291005  0.0014550265
 [7,]  0.006878307  0.004497354  0.0021164021 -0.0002645503
 [8,]  0.018253968  0.011507937  0.0047619048 -0.0019841270
 [9,]  0.029629630  0.018518519  0.0074074074 -0.0037037037
              [,5]         [,6]
 [1,]  0.033862434  0.057671958
 [2,]  0.027777778  0.047222222
 [3,]  0.021693122  0.036772487
 [4,]  0.015608466  0.026322751
 [5,]  0.009523810  0.015873016
 [6,]  0.003439153  0.005423280
 [7,] -0.002645503 -0.005026455
 [8,] -0.008730159 -0.015476190
 [9,] -0.014814815 -0.025925926

> cacheSolve(mdata)
using cached data
              [,1]         [,2]          [,3]          [,4]
 [1,] -0.061375661 -0.037566138 -0.0137566138  0.0100529101
 [2,] -0.050000000 -0.030555556 -0.0111111111  0.0083333333
 [3,] -0.038624339 -0.023544974 -0.0084656085  0.0066137566
 [4,] -0.027248677 -0.016534392 -0.0058201058  0.0048941799
 [5,] -0.015873016 -0.009523810 -0.0031746032  0.0031746032
 [6,] -0.004497354 -0.002513228 -0.0005291005  0.0014550265
 [7,]  0.006878307  0.004497354  0.0021164021 -0.0002645503
 [8,]  0.018253968  0.011507937  0.0047619048 -0.0019841270
 [9,]  0.029629630  0.018518519  0.0074074074 -0.0037037037
              [,5]         [,6]
 [1,]  0.033862434  0.057671958
 [2,]  0.027777778  0.047222222
 [3,]  0.021693122  0.036772487
 [4,]  0.015608466  0.026322751
 [5,]  0.009523810  0.015873016
 [6,]  0.003439153  0.005423280
 [7,] -0.002645503 -0.005026455
 [8,] -0.008730159 -0.015476190
 [9,] -0.014814815 -0.025925926
>