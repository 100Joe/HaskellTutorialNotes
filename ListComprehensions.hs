--List Comprehensions can be used to construct a new lists from old lists 
[x^2 | x <- [1..5]] 
--The second expression is called a generator. x <- [1..5]
--You can have multiple generators, seperated by commas. 
[(x,y) | x <- [1,2,3], y <-[4,5]]
--Changing the order of the generators changes the order of the elements in the final list. 
--Multiple generators are like nested loops with later generators as more deeply nested loops whose variables change value more frequently. 
--later generators can depend on the variables that are introduced by earlier generators. 
concat :: [[a]] -> [a]
concat xss = [x | xs <- xss, x <- xs]

--Guards. List comprehensions can use guards to restrict the values produced by earlier generators. 
[x | x <- [1..10], even x]
--using a guard we can deinge a function that maps a positive integer to its list of factors 
factors :: Int -> Int
factor n = 
[x | x <- [1..n], n `mod` x == 0]
--A positive integer is prime if its only factors are 1 and itself. 
prime :: Int -> Bool 
prime n = factors n == [1,n]
--using a guard we will return a list of all primes up to a given limit 
primes :: Int -> [Int]
primes n :: [x | <- [2..n], prime x]
--or 
allprimes :: [Int]
allprimes = sieve [2..]
sieve :: [Int] -> [Int]
sieve (P:xs) = p : sieve [x | x <- xs, x `mod`p /= 0]

--The Zip function. Zip maps two lists to a list of pairs of their coreesponding elements 
zip :: [a] -> [b] -> [(a,b)]
--define a function that returns the list of all pairs of adjacent elements from a list 
pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)
-- using pairs we can define a function that decides if the elements in a list are sorted
sorted :: Ord a => [a] -> Bool
sorted xs = and [x =< y | (x,y) <- pairs xs]
--defining a function that returns the list of all positions of a value in a list 
positions :: Eq a => a -> [a] -> [Int]
positions x xs = 
  [i | (x',i) <- zip xs [0..], x == x']

--String comprehensions. A string is a sequence of characters enclosed in double quotes. Internally however strings are represented as lists of characters 
"abc" :: string  
['a','b','c'] :: [Char]
-- Any polymorphic functions that operates on lists can also be applied to strings because strings a special types of lists.
{-
length
take n 
zip
-}
--List comprehensions can be used on strings as well because they are special types of lists 
count :: Char -> String -> Int
count x xs = length [x' | x' <- xs, x == x'] 

--Exercise two 
perfect :: Int -> Bool 
perfect  n = sum (init(factors n)) == n 
--or
perfect n = sum (factors n) -n == n 
perfects n = [x | x <- [1..n], perfect x]



