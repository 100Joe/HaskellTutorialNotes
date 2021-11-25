
{-Standard Library functions that can be used on Lists-}
--Select first element of list 
  head [1,2,3,4,5] 
--Remove the first element of list
  tail [1,2,3,4,5]
--Select the nth element of a list. Indexing into a list that starts at 0 (!! = double bang)
  [1,2,3,4,5] !! 2
--Select the first n elements of a list
  take 3 [1,2,3,4,5] 
--Remove the first n elements of a list 
  drop 3 [1,2,3,4,5]
--Calculate the length of a list 
  length [1,2,3,4,5]
--Calculate the sum of a list of numbers
  sum [1,2,3,4,5]
--Calculate the product of a list of numbers
  product [1,2,3,4,5]
--Append to lists
  [1,2,3] ++ [4,5]
--Reverse a list
  reverse [1,2,3,4,5]

{-
Mathematics        Haskell 
f(x)               f x         
f(x,y)             f x y 
f(g(x))            f (g x)
f(x,g(y))          f x (g y)
f(x)g(y)           f x * g y
-}

--Function  
double x = x + x 
-- Recursive use of the double function 
quadruple x = double (double x)

-- Function returns the product of a list of 1-n
factorial n = product [1..n]
-- Provides the average of a list of n's
average ns = sum ns `div`length ns

{-
GHCI commands

:l load file 
:r reload file
:set editor name
:edit name
:edit
:t type expr
:? (shows all commands)
:quit
-}

{-
The Layout rule -
in a sequence of deinitions, each definition must begin in the same column. *Be careful of where you are indenting*
(This rule allows us to avoind explicit syntax.)
-}

{-
CCC is how Haskell should be written in practice - 
C = Clear
C = Concise 
C = Correct 
-}
