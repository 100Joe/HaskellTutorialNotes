--Exercise/Examples #1 List Functions 
--Logical 'and' function  && operator
and :: [Bool] -> Bool
and []     = True 
and (b:bs) = b && and bs
--Concat function   ++ operator
concat :: [[a]] -> [a]
concat []       = [] 
concat (xs:xss) = xs ++ concat xss
--Replicate function 
replicate :: Int -> a -> [a]
replicate 0 _ =  []
replicate n x =  x : replicate (n-1) x
--Indexing function      !! operator (double band/bang bang)
(!!) :: [a] -> Int -> a
(x:_) !! 0 =  x
(_:xs) !! n = xs !! (n-1) 
--Insert function
insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys) = if x < y then x : y : ys else y : insert x ys 
--Insertion sort
isort :: [Int] -> [Int]
isort []     = []
isort (x:xs) = insert x (isort xs)

--Exercises #2 and #3  
--Merge function 
merge :: [Int] - [Int] -> [Int]
merge [] ys         = ys 
merge xs []         = xs
merge (x:xs) (y:ys) = if x < y then X : merge xs (y:ys) else y merge (x:xs) ys 
--Merge Sort Function 
msort :: [Int] -> [Int] 
msort []  = [] 
msort [X] = [X]
msort xs = merge (msort ys) (msort zs) where (ys, zs) = halve xs

