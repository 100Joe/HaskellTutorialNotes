--What are recursive functions? 
  a function defined in terms of itself. 
--Why are they useful?
  recusion is the only way to really loop anything in haskell. 
--Why are they difficult at first?
  It is a different way of thinking vs the imperative approach. 

{-
1. Name the function.          sum
2. Write down its type.        sum :: [Int] -> Int
3.Enumerate the cases.         sum []     =   followed with sum (x:xs) =  
4.Define the simple/base cases.     sum [] = 0
5.List the "ingedients"(Right hand side).         
6.Define the other/recursive cases. sum (x:xs) = x + sum xs           
7.Think about the result. (Can the type be generalized?, Can it be simplified?)  
-}
--Define a function that calculates the sum of a list of numbers 
sum :: Num a => [a] -> a              sum :: [Int] -> Int    
sum = foldr (+) 0                     sum []     =  0
                                      sum (x:xs) =  x + sum xs 

--Define a function that drops a given number of elemnets from the start of a list
drop :: Int -> [a] -> [a]                           drop :: Int -> [a] -> [a]
drop 0 [] = []                                      drop 0 xs = xs
drop 0 (x:xs) = x : xs                              drop _ [] = []
drop n [] = []                                      drop n (_:xs) = drop (n-1) xs
drop n (x:xs) = drop (n-1) xs

--Define a function that removes the last element from a non-empty list.
init :: [a] -> [a]                                init :: [a] -> [a]
init (x:xs) | null xs = []                        init [_] = []
            | otherwise = x : init xs             init (x:xs) = x : init xs 
