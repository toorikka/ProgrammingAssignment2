## Assignment: Caching the inverse of a Matrix

## This assignment is to write a pair of functions that calculate
## the inverse of a matrix and cache the result to avoid costly 
## computing if the same matrix is inversed again.

## "makeCacheMatrix" introduces functions to be used in matrix handling.
## It creates a special "matrix" and caches it's content for
## later to speed up the inverse calculation.
## It returns a list of functions for further use.

makeCacheMatrix <- function(x = matrix()) {
  
  mcac <- NULL ##Initialize variable 'mcac' as empty
  
  ## Create a function that places a new function call value x to 'setm' ('mcac' cache empty)
  setm <- function(mvalue) {
    x <<- mvalue
    mcac <<- NULL
  }
  
  ## Create a function getm(), which handles the funtion call's matrix 
  getm <- function() x
  
  ## Create a function inve(), which gets the function call's matrix and places it into 'mcac'
  inve <- function(invm) mcac <<- invm
  
  ## Create a function getinve(), which contains the 'mcac' value from the cache (if exists)
  ## or shows NULL for empty 'mcac'
  getinve <- function() mcac  
  
  ## Return above funtions in a list for usage
  list(setm=setm, getm=getm, inve=inve, getinve=getinve)
}



## "cacheSolve" calculates the inverse of the "special matrix"
## we created in makeCacheMatrix.
## It checks if the matrix inverse is already in cache and if yes, shows it
## If not, it calculates the matrix inverse from scatch and caches it's
## value for later use

cacheSolve <- function(x=matrix(), ...) {
        ## Return a matrix that is the inverse of 'x'
  
  ## Use getinv() to set matrix value into 'inverse' (mcac->inverse)
  inverse <- x$getinve()
  
  ## Check if there already was identical data for that matrix = 'mcac' not empty
  ## If the previous step set the existing matrix into 'inverse', 
  ## we simply return that cached inversed matrix
  if(!is.null(inverse)){
    message("using cached data")
    return(inverse)
  }
  
  ## otherwise ('mcac' was null) place the new matrix into 'invm'
  invm <- x$getm()
  
  ## Load package MASS to get the ginv() function to calculate matrix inverse
  
  ## (I wanted to use some other inverse function than solve() to be
  ## able to use also other matrices than just square ones. 
  ## Hence the MASS package.)
  library(MASS)
  
  ## Calculate the inverse of matrix 'invm' now, set it into 'inverse'
  inverse <- ginv(invm) 
  
  ## Call function inve() and set 'inverse' value to 'mcac' (to be cached)
  x$inve(inverse)
  
  ## Return the new inversed value
  inverse
}

