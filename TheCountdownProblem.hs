{-
What is countdown? 
- A popular quiz program on British Tv 
-Basesd on a french program 
-Includes a numbers game that we will refer to as the countdown problem. 
-}

--Rules 
--All the numbers, including intermediate results, must be positive naturals.(1,2,3...) No negatives, No zeros, No fractions. 
--Each of the source numbers can be used at most once when construting the expression. 

--Example 
  1 3 5 6 10 25 50
  (25-10) * (50+1)
--There are 780 solutions for this example. Changing the target number to 831 gives an example that has no solutions. 

--Operators 
data Op = Add | Sub | Mul | Div 
--Apply an operator 
apply :: Op -> Int -> Int -> Int
apply Add x y = x + y 
apply Sub x y = x - y 
apply Mul x y = x * y
appy Div x y = x `div` y 
--Decide if the result of applying an operator to two positive natural numbers is another such. 
valid :: Op -> Int -> Int -> Bool 
valid Add _ _ = True
valid Sub x y = x > y 
valid Mul _ _ = True 
valid Div x y = x `mod` y ==0
--Expressions 
data Expr = Val Int | App Op Expr Expr
--Return the overall value of an expression, provided that it is a positive natural number. Using list comprehension. 
eval :: Expr -> [Int]
eval (Val n)  = [n | n > 0]
eval (App o l r) = [apply o x y | x <- eval l
                                , y <- eval r
                                , valid o x y]
--Either succeeds and returns a singleton list or fails and returns the empty list.  <- expression returns the left side if the right side is true in this case. 

--Formalising the Problem 
--Return a list of all possible ways of choosing zero or more elements from a list 
choices :: [a] -> [[a]]
choices [] = 
choices (x:xs) = 

--Return a list of all the values in an expression
values :: Expr -> [Int]
values (Val n) = [n]
values (App _ l r) = values l ++ values r
--decide if an expression is a solution for a given list of source numbers and a target number. 
solution :: Expr -> [Int] -> Int -> Bool
solution e ns n = elem (values e) (choice ns) && eval e == [n] 

-- Brute force solution 
--Return a list of all possible ways of splitting a list into two non-empty parts
split :: [a] -> [([a],[a])]
--Return a list of all possible expressions whose values are precisely a given list of numbers 
exprs :: [Int] -> [Expr]
exprs [] = []
exprs [n] = [Val n]
exprs ns = [e | (ls,rs) <- split ns
              , l       <- exprs ls
              , r       <- exprs rs
              , e       <- exprs l r]
--Combuine two expressions using each operator 
combine :: Expr -> Expr -> [Expr]
combine l r = 
  [App o l r | o <- [Add,Sub,Mul,Div]]
--Return a list of all possible expressions that solve an instance of the countdown problem
solutions :: [Int] -> Int -> [Expr]
solutions ns n = [e | ns' <- choices ns 
                    , e <- exprs ns' 
                    , eval e == [n]]

{-
can we do better?
- Many of the expressions that are considered will typically be invalid - fail to evaluate.
- For example, only around 5 million of the 33 million possible expressions are valid 
- Combining generation with evaluation would allow earlier rejection of invalid expressions. 
-}

--Fusing two functions 
--valid expressions and their value 
type Result = (Expr,Int)
-- define a function that fuses together the generation and avaluation of expresions
results :: [Int] -> [Result]
results ns = [(e,n) | e <- exprs ns
                    , n <- eval e]
--This behaviour is achieved by defining 
results [] = []
results [n] = [(Val n,n) | n > 0 ]
results ns = 
    [res | (ls,rs) <- split ns
        , lx <-results ls
        , ry <-results rs
        , res <- combine' lx ry]
--Combining results 
combine' (l,x) (r,y) = 
  [(App o l r, apply o x y) | o <- [Add,Sub,Mul,Div], valid o x y]
--New function that solves countdown problems 
solutions' :: [Int] -> Int -> [Expr]
solutions' ns n = [e | ns' <- choices ns, (e,m) <- results ns', m == n]

{-
Can we do better? 
- Many expressions will be essentially the same using simple arithmetic properties 
X * y = Y *x       X * 1 = X 
- expoloiting such properties would considerably reduce the search space therefore the solution space.
-}
--Strengthening the valid predicate to take account of commutativity and identity properties 
valid :: Op -> Int -> Int -> Bool 
valid Add x y = x <= y 
valid Sub x y = x > y 
valid Mul x y = x <= y && x /= 1 && y /= 1
valid Div x y = x `mod` y == 0 
