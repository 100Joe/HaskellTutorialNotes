--Expressions are evaluated by a stepwise process of applying functions to their arguments 
fac 4
=
product [1..4]
=
product [1,2,3,4]
=
24

--Recursive functions. Functions can also be defined in terms of themselves. Such functions are called recursive.  
fac 0 = 1
fac n = n * fac (n-1)

fac 3 
=
  3 * fac 2
=
  3 * (2 * fac 1)
=
  3 * (2* (1 * fac 0))
=
  3 * (2 * (1 * 1))
= 
  3 * (2*1)
=
  6


--why is recursion useful? 
--Some functions, such as factorial, are sumpler to define in terms of other functions. 
--As we shall see, however, many functions can naturally be defined in terms of themselves.
--Properties of functions defined using recursion can be proved using the simple but powerful mathematical technique of induction. 

--Recursion on lists. Recursion is not restricted to numbers, but can also be used to define functions on lists. All recursive functions have a base case for empty lists.
product :: Num a => [a] -> a
product [] = 1
product (n:ns) = n * product ns

product [2,3,4]
=
2 * product [3,4]
=
2 * (3 * product [4])
=
2 * (3 * (4 * product []))
=
2 * (3 * (4 * 1))
=
24

--Using the same pattern of recursion as in product we can define the length function on lists
length :: [a] -> Int 
length [] = 0
length (_:xs) = 1 + length xs

length [1,2,3]
=
1 + length [2,3]
=
1 + (1 + length [3])
=
1 + (1 + (1 + length []))
=
1 + (1 + (1 + 0))
=
3

--We can also define the recursive case for reverse function 
reverse :: [a] -> [a]
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]

reverse [1,2,3]
=
reverse [2,3] ++ [1]
=
(reverse [3] ++ [2]) ++ [1]
=
((reverse [] ++ [3]) ++ [2]) ++ [1]
=
(([] ++[3]) ++ [2]) ++[1]
=
[3,2,1]

--Multiple arguements. Functions with more than one argument can also be defined using recursion
zip :: [a] -> [b] -> [(a,b)]
zip []      _        = []
zip _       []       = []
zip (x:xs) (y:ys)    = (x,y) : zip xs ys 
--Remove the first n elements from a list 
drop :: Int -> [a] -> [a]
drop 0 xs = xs 
drop _ [] = []
drop n (_:xs) = drop (n-1) xs
--Appending two lists
(++) :: [a] -> [a] -> [a]
[]      ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)


--Quicksort algorithm from the start of the course. 2 rules to follow 
-- The empty list is already sorted;
--Non-empty lists can be sorted by sorting the tail values < the head, sorting the tail values > the head, and then appending the resulting lists on either side of the head value. 

qsort :: Ord a => [a] -> [a]
qsort []    = []
qsort (x:xs) = 
  qsort smaller ++ [x] ++ qsort larger
  where 
    smaller = [a | a <-xs, a < x]
    larger = [b | b <- xs, b > x]
    