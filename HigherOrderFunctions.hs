--A Higher-order function takes a functions as an argument or returns a function as a result. 
twice :: (a -> a) -> a -> a 
twice f x = f (f x)

{-
Why are Higher-order functions useful?
-Common programming idioms can be encoded as functions within the language itself.
-Domain specific languages can be defined as collections of higher-order functions.
-Algebraic properties of higher-order functions can be used to reason about programs. 
-}

--Map function. The higher-order library function called map applies a function to every element of a list. 
map :: (a -> b) -> [a] -> [b]
map f xs = [f x | x <- xs]
--Recursive map function
map f []     = []
map f (x:xs) = f x : map f xs

--Filter function. This higher-order function selects every element from a list that satisfies a predicate.(Predicate = Property/True||False)
filter :: (a -> Bool) -> [a] -> [a]
filter p xs = [x | x <- xs, p x]
--Recursive filter function
filter p [] = []
filter p (x:xs)
  | p x       = x : filter p xs
  | otherwise = filter p xs 

-- Foldr(Foldright) function. a number of functions on lists can be defined using the following simple pattern of recursion. 
f [] = v
f (x:xs) = x (infix) f xs
--examples 
sum = foldr (+) 0
product = foldr (*) 1
or = foldr (||) False
and = foldr (||) True
--Recursive foldr function. 
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f v [] = v
foldr f v (x:xs) = f x (foldr f v xs)
--foldr encapsulates a simple pattern of recursion, it can be used to define many more functions. 
length :: [a]  -> Int
length [] = 0
length (_:xs) = 1 + length xs 
--reverse functions 
reverse [] = []
reverse (x:xs) = reverse xs ++ [x] 
--append functions is particularly compact definition using foldr
(++ ys) = foldr (:) ys 

{-
Why is foldr useful?
-Some recursive functions on lists, such as sum, are simpler to define using foldr.
-Properties of functions defined using foldr can be proved using algebraic properties of foldr, such as fusion and the banana split rule.
-Advanced program optimisations can be simpler if foldr is used in place of explicit recursion. 
-}

--Other Library functions 
-- (.) returns the composition of two functions as a single function
(.) ::: (b -> c) -> (a -> b) -> (a -> c)
f . g = \Lx -> f (g x)
--example
odd :: Int -> Bool 
odd = not . even 

-- all function decided if every element of a list satisfies a given predicate(Predicate = Property/True||False)
all :: (a -> Bool) -> [a] -> Bool
all p xs = and [p x | x <- xs]

-- any function decided if at least one element of a list satisfies a given predicate(Predicate = Property/True||False)
any :: (a -> Bool) -> [a] -> Bool
any p xs = or  [p x | x <- xs]

--takeWhile function selects elements from a list while a predicate holds of all the elements 
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p [] = []
takewhile p (x:xs)
    |p x       = x : takeWhile p xs
    |otherwise = []

--dropWhile function removes elements from a list while a predicate holds of all the elements
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile p [] = []
dropwhile p (x:xs)
    |p x       = dropWhile p xs
    |otherwise = x:xs

--Exercises 
--What are higher order functions that return functions as results better known as? (Curried functions)
take :: Int -> ([a] -> [a]) --With curried functions the arrows means brackets to starting from the right.

--Express [f x | x <- xs, p x] using map and filter 
map f (filter p xs)
