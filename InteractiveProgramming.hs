--To date we have seen is how haskell can be used to write batch programs that take all their inputs at the start and give all their outputs at the end 
inputs => Batch program => outputs   Example: a Compiler 

--However we would also like to use haskell to write interactive programs that read from the keyboard and write to the screen as they are running. 
      keyboard
inputs => Batch program => outputs   
      screen

-- Haskell programs are pure mathematical functions. Haskell programs have no side effects 
--However reading from the keyboard and writing to the screen are side effects. Interactive programs have side effects. 

--Interactive programs can be written in haskell by using types to distinguish pure expressions from impure actions that may involve side effects. 
IO a  --The type of actions that return a value of type a 
IO Char -- The type of actions that return a character.
IO () -- The type of purely side effecting actions that return no result value. () is the type of tuples with no components 

--The standard library provides a number of actions including the following three primitives 
--The action getChar reads a character from the keyboards  exhoes it to the screen and returns the character as its result value 
getChar :: IO Char 
--The action putChar c writes the character c to the screen and returns no result value 
putChar :: Char -> IO ()
--The action return v simply retuns the value v, without performing any interaction 
return :: a -> IO a 

--Sequencing 
--A sequence of actions can be combined as a single composite action using the keyword do 
  act :: IO (Char, Char)
  act = do x <- getChar
          getChar
          y <- getChar
          return (x,y)
--Derived Primitives. Reading a string from the keyboard 
getLine :: IO String 
getLine = do x <- getChar 
            if x == '\n' then 
              return []
            else 
              do xs <- getLine 
                return (x:xs)

putStr :: String -> IO ()
putStr [] = return ()
putStr (x:xs) = do  putChar x
                    putChar xs

putStrLn :: String -> IO ()
putStrLn xs = do putStr xs 
                putChar '\n'
--Example of defining an action that prompts for a string to be entered and displays its length 
strlen :: IO ()
strlen = do put "Enter a string: "
            xs <- getLine
            putStr "The string has "
            putStr (show (length xs))
            putStrLn " characters"

--Hangman 
{-
Consider the following version of hangman: 
-One player secretly types in a word 
-The other player tries to deduce the word by entering a sequence of guesses
-for each guess the computer indicates which letters in the secret word occur in the guess.  
-The game ends when the guess is correct 
-}
--Top down approach 
hangman :: IO ()
hangman = do putStrLn "Think of a word: "
            word <- sgetLine
            putStrLn "Try to guess it:"
            play word

sgetLine :: IO String
sgetLine = do x <- getCh
              if x == '\n then
                do putChar x 
                  return []
              else 
                do putChar '-'
                xs <- sgetLine
                return (x:xs)

import System.IO

getCh :: IO Char 
getCh = do hSetEcho stdin False
          x <- getChar
          hSetEcho stdin True 
          return x 

-- The function play is the main loop which requests and processes guesses until the game ends 
play :: String -> IO ()
play word = 
    do putStr "? "
      guess <- getLine
      if guess === word then 
        putStrLn "You got it!"
      else
        do putStrLn (match word guess)
        play word 

--The function match indicates which characters in one string occur in a second string 
match :: String -> String -> String 
match xs ys  = [if elem x ys then x else '-' | x <- xs]
