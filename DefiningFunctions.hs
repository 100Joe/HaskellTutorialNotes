--Conditional expresion. (abs == absolute)
abs :: Int -> Int
abs n = if n > 0 then n else -n
--Conditional Statements can be nested
signum :: Int -> Int
signum n = if n < 0 then -1 else 
              if n == 0 then 0 else 1 
--Conditional expressions must always have an else branch. Which helps avoids ambiguity problems with nested conditionals. if then else 

--Guarded equations. ( | == "such as")
abs n | n > 0  = n
      | otherwise = -n 

signum n  | n < 0  = -1
          | n == 0  = 0
          | otherwise = 1

--Pattern matching. Many functions have a particularly clear definition using pattern mathcing on their arguments
not :: Bool > Bool
not False = True
not True = False
--Pattern matching examples. Patterns are matched in order from top down and patterns can not repeat variables on the left hand side in haskell. 
(&&) :: Bool -> Bool -> Bool
True && True = True
True && False = False
False && True = False
False && False = False
--Compact version of the above 4 lines. Use the wild card which matches any arguemnt value (_) to declare the same outcome for multiple lines. 
True && True = True
_  && _  = False

--List patterns. Every non-empty list is constructed by repeated use of an operator (:) called "Cons" that adds an element to the start of a list 
[1,2,3,4] -- 1:(2:(3:(4:[])))
--functions on lists can be defined using x:xs patterns 
head :: [a] -> a
head (x:_) = x 

tail :: [a] -> [a]
tail :: (_:xs) = xs
--x:xs patterns only match non-empty lists, these patterns must be parenthesised because application has priority over (:). 

--Lambda functions. These can be used to give a formal meaning to functions defined using currying. (\ == Lambda sign)
add :: Int -> Int -> Int 
add x y = x + y 
--The below is a lambda translation of the above.
add :: Int -> (Int -> Int)
add = \x -> (\y -> x + y)
--Lambda expressions can be used to avoid naming functions that are only referenced once 
odds n = map f [0..n-1]
          where
            f x = x*2 + 1
-- Simplified with Lambda
odds n = map (\x -> x*2 +1) [0..n-1]

--Operator sections. An operator written between its two arguments can be converted into a curried function written before its two arguments be using parenthesis. 
1 + 2 == (+) 1 2 
--This is useful because you can add a parameter to the operator and make a curried function which is referred to as a section. 
(1+) 2 == (+2) 1 
--Useful compact functions "Sections" 
(1+) -- successor function
(1/) -- reciprocation function
(*2) -- doubling function
(/2) -- halving function


--Exercise one 
--A conditional expression
safetail xs = if null xs then [] else tail xs 
--A Gaurded expression 
safetailtail xs | null xs = []
                | otherwise tail xs
--pattern matching 
safetail [] = []
safetail (_:xs) = xs 

--Exercise two 
False || False = False
False || True =True
True || False = True
True || True = True
--or 
False || False = False
_ || _ = True
--or 
False || b = b
True || _ = True
