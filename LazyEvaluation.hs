--Expressions in Haskell are evaluated using a simple technique calle lazy evaluation
{-
-Avoids doing unnecessary evaluation
-Ensures termination whenever possible 
-Supports programming with infinite lists
-Allows programs to be more modular 
-}

--Evaluating expression 
square n = n * n 
--example 
  square (1+2)
  square 3 
  3*3 
  9 
--Any way of evaluating the same expression will give the same result, provided it terminates. 

--There are two main strategies for deciding which reducible expression (redex) to consider next 
{-
-Choose a redex that in innermost in the sense that does not contain another redex
-Choose a redex that is outermost in the sense that is not contained in another redex 
-}
--termination 
--Innermost
infinity = 1 + infinity
fst (0, infinity)
fst (0, 1 + (1+ infinity))
--Outermost 
fst (0, infinity)
0 
{-
-Outermost evaluation may give a result when innermost evaluation fails to terminate 
- if any evaluation sequence termninates then so does outermost with the same result. 
-duplication may cause the outermost evaluation to take more steps to evaluate. 
-}

--lazy evaluation  = outermost evaluation + sharing of arguments 

--Infinite list 
ones = 1 : ones 
1 : ones 
1 : (1 : ones)

{-
-In the lazy case only the first element of ones is produced as the rest are not required 
-In general with lazy evaluation expressions are only evaluated as much as required by the context in which they are used.
- hence ones is really a potential infinite list  
-}

--Modular Programming 
--Lazy evaluation allows us to make programs more modular by separating control from data 
take 5 ones == [1,1,1,1,1] --the data part ones is only evaluated as much as required by the control part take 5
--without using lazy evaluation the control and data parts would need to be combined into one 
replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n x = x : replicate (n-1) x

--Generating primes 
{-
To generate the infinite sequence of primes:
1. Write down the infinite sequence 2,3,4,...;
2. Mark the first number p as being prime;
3. Delete all multiples of p from the sequence;
4 Return to the second step
-}

primes = sieve [2..]
sieve (p:xs) = p : sieve [x | x <-xs, mod x p /= 0]

