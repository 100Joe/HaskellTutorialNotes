{-
{-
Basic types 

Bool - Logical Values  True || False
Char - single characters  (Single quotes '')
String - strings of characters (double quotes "")
Int - integer numbers (whole numbers)
Float - floating-point numbers (decimals)
-}

--lists are a sequence of values of the same type 
[False, True, False] :: Bool
['a','b', 'c'] :: Char
--We can use nested lists 
[['a'], ['b','c']] :: [[Char]]


--Tuples are a sequence of values of different types. Tuples encodes its length/size
(False, True) :: (Bool,Bool)
(False, 'a', True) :: (Bool, Char, Bool)
--We can nest touples as well
('a',(False,'b')) :: (Char,(Bool,Char))

--Funtions are a mapping from values of one type to values of another type
not :: Bool -> Bool
even :: Int -> Bool
--This Function takes two arguements at the same time.
add :: (Int, Int) -> Int
add (x,y) = x+y
--Int into list of Int
zeroto :: Int -> [Int]
zeroto n = [0..n]
--Curried functions are functions with multiple arguements used one at a time are also possible by returning functions as results
add' :: Int -> (Int -> Int)
add' x y = x+y
--Functions with more than two arguements can be curried by returning nested functions
mult :: Int -> (Int-> (Int -> Int))
mult x y z = x*y*z 
--Curried functions are more flexible than functions on tuples, because useful functions can often be made by partially applying a curried function
add' 1 :: Int -> Int
take 5 :: [Int] -> [Int]
drop 5 :: [Int] -> [Int]
{-To avoid exess parentheses when using curried functions, two simple conventions are adopted

the arrow -> associates to the right.
Int -> Int -> Int -> Int == Int ->(Int->(Int -> Int))

function application associates to the left 
mult x y z == ((mult x)y)z
-}

--Functions are considered POLYMORPHIC if it's type contains one or more type variables(Which must be lower-Case). For any type a this function will return an Int.
  length :: [a] -> Int
  length [False, True]  == a = Bool
  length [1,2,3,4] == a = Int
--Many of the functions defined in the standard prelude library are polymorphic. Few examples below
fst :: (a,b) -> a 
head :: [a] -> a 
take :: Int -> [a] -> [a]
zip :: [a] -> [b] -> [(a,b)]
id :: a -> a 
{-
Polymorphic functions can be call overloaded if its type contains one or more class contraints 
  Num - Numeric types    (+) :: Num a => a -> a -> a
  Eq - Equality types    (==) :: Eq a => a -> a -> Bool
  Ord - Ordered types    (<) :: Ord a => a -> a -> Bool 
  -}

{-
Tips for functions
It is useful to begin by writing down its type.
it is good practice to state the type of every new function defined 
Take care to include the necessary class constraintes to polymorphic functions that use Numbers, equality, or orderings. 
-}

--Exercise 1 

['a','b','c']               :: [Char]
('a','b','c')               :: (Char,Char,Char)
[(False, '0'), (True, '1')] :: [(Bool, Char)]
([False, True], ['0', '1']) :: ([Bool], [Char])
[tail, init, reverse]       :: [[a] -> [a]]


--Exercise 2 
second xs = head (tail xs) == second :: [Int] -> Int or as a polymorphic function second :: [a] -> a 
swap (x,y) = (y,x) == swap :: (a,b) -> (b,a) 
pair x y = (x,y) == pair :: a -> b -> (a,b)  --This is a curried function which is also polymorphic 
double x = x*2 == double :: Num a => a -> a
palindrome xs = reverse xs == xs   palindrome :: Eq a => [a] -> Bool
twice f x = f (f x) == twice :: (t -> t) -> t -> t
-}
