-- type declarations. a new name for an existing type can be defined using a type declaration. 
type String = [Char]
--Type declarations can be used to make other types more readable
type Pos = (Int, Int)
origin :: Pos                     left :: Pos -> Pos
origin = (0,0)                    left (x,y) = (x-1,y)
--Type declarations can also have parameters. 
type Pair a = (a,a)
mult :: Pair Int -> Int           copy :: a -> Pair a 
mult (m,n) = m * n                copy x = (x,x)
--Type declarations can be nested however they can not be used in a recursive manner. 
type Pos = (Int, Int)
type Trans = Pos -> Pos
type Tree = (Int, [Tree]) --This does not work and the compiler will throw an error. 

-- Data declarations. a completely new type can be defined by specifying its values using a data declaration.
data Bool = False | True --Bool is a new type and has 2 constructors False | True

{-
-The two values False and True are called the constructors for the type Bool. 
-Type and constructor names must always begin with an upper-case letter.
-Data declarations are similar to context free grammars. The former specifies the values of a type, the latter the sentences of a language. 
-}

--Values of new types can be used in the same ways as those of built in types. 
data Answer = Yes | No | Unknown 
--we can define 
answers :: [Answer]
answers = [Yes,No,Unknown]
flip :: Answer -> Answer
flip Yes = No 
flip No = Yes 
flip Unknown = Unknown
--The constructors in a data declaration can also have parameters. 
data shape = Circle Float
            | Rect Float Float 
square :: Float -> Shape 
square n = Rect n n 
area :: Shape -> Float
area (Circle r) = pi & r^2
area (Rect x y) = x * y 
{-
Shape has values of the form Circle r where r is a float, and Rect x y where x and y are floats 
Circle and Rect can be viewed as functions that construct values of type shape: 
Circle :: Float -> Shape       Rect :: Float -> Float -> Shape 
-}
--data declarations themselves can also have parameters 
data Maybe a = Nothing | Just a 
safediv :: Int -> Int -> Maybe Int 
safediv _ 0 = Nothing 
safediv m n = Just (m `div` n)
safehead :: [a] -> Maybe a 
safehead [] = Nothing
safehead xs = Just (head xs)

--Recursive Types. New types can be decared in terms of themselves.
data Nat = Zero | Succ Nat 
{-
-A value of type Nat is either Zero, or of the form Succ n where n :: Nat. That is, Nat contains the following infinite sequence of values
Zero
Succ Zero 
Succ (Succ Zero)
-We can think of values of type Nat as natural numbers, where Zero represents 0, and Succ represents the successor function 1+. 
Succ(Succ(Succ Zero)) == 1 + (1 + (1 + 0))
-}
--Using recursion it is easy to define functions that convert between values of type Nat and Int 
nat2int :: Nat -> Int 
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n
int2nat :: Int -> Nat 
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))
--Two naturals can be added by converting them to integers adding and then converting back
add :: Nat -> Nat -> Nat 
add m n = int2nat (nat2int m + nat2int n)
--however we can do this recursively without doing the conversions 
add Zero  n = n 
add (Succ m) n = Succ (add m n) 
--Example 
add (Succ (Succ Zero)) (Succ Zero) 
= 
  Succ (add (Succ Zero) (Succ Zero))
=
  Succ (Succ (add Zero (Succ Zero)))
=
  Succ (Succ (Succ Zero))

--Arithmetic Expressions. Consider a simple form of expressions built up from integers usding addition and multiplication. 
{-  +
  1   *
    2  3 
-}
--using recursion, a suitable new trpe to represent such expressions can be defined by 
data Expr = Val Int 
          | Add Expr Expr
          | Mul Expr Expr
add (Val 1) (Mul (Val 2) (Val 3)) 
--examples 
size :: Expr -> Int
size (Val n)  = 1 
size (Add x y) = size x + size y
size (Mul x y) = size x * size y
eval :: Expr -> Int
eval (Val n) = n
eval (Add x y) = eval x + eval y
eval (Mul x y) = eval x * eval y

Val :: Int -> Expr
Add :: Expr -> Expr -> Expr
Mul :: Expr -> Expr -> Expr

--Many functions on expression can be defined by replacing the constructors by other functions using a suitable fold function 
eval = folde id (+) (*)

--Excersises 
mult :: Nat -> Nat -> Nat 
mult Zero m = Zero
mult (Succ n) m = add (mult n m) m  

data Tree a = Leaf a 
            | Node (Tree a) (Tree a)
