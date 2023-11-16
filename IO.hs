import Data.Char

--Called IO actions* not dunctions, functions in haskell must be pure to be considered a function
{-
getLine reads a line of input from the console
ghci> getLine
hello
"hello"
ghci> :t getLine
getLine :: IO String

The IO type marks a value as being impure
ghci> :t getLine
getLine :: IO String
ghci> :t getChar
getChar :: IO Char
If a function returns an IO type then it is impure
- It may have side effects
- It may return different values for the same inputs

The IO type marks a value as being impure
ghci> :t getLine
getLine :: IO String
ghci> :t getChar
getChar :: IO Char
If a function returns an IO type then it is impure
- It may have side effects
- It may return different values for the same inputs

Values must be unboxed before they are used in pure functions
ghci> head (getLine)
Couldn't match expected type [a]
with actual type IO String
ghci> x <- getLine
hello
ghci> head x
'h'
-}

{-
putStrLn prints a string onto the console
ghci> putStrLn "hello"
hello
ghci> :t putStrLn
putStrLn :: String -> IO ()
The return type indicates that it returns nothing useful
- It has the IO type, indicating that it has a side effect
- () is a unit which is in itself its own type which there because all haskell code must return something 
- some IO code is only called for its side effects tho and doesnt return anything interesting 
- so it just returns unit as a placeholder instead, same as a void func in C basically
-}

{-
Exercise
What do these ghci queries do?
--will get two user inputs x and y and print them with a space inbetween
ghci> x <- getLine
ghci> y <- getLine
ghci> putStrLn (x ++ " " ++ y)

--will get user input for a number convert it to an int then print that int + 1
ghci> n <- getLine
ghci> let num = (read n) :: Int
ghci> putStrLn (show (num + 1))

--type error
ghci> putStrLn (getLine)
-}

--We can write our own IO actions
print_two :: String -> String -> IO ()
print_two s1 s2 = putStrLn (s1 ++ s2)
--ghci> print_two "abc" "def" gives abcdef
--Note that the return type is IO ()

--Combining multiple IO calls
--The do syntax allows us to combine multiple IO actions
get_and_print :: IO ()
get_and_print =
    do
        x <- getLine
        y <- getLine
        putStrLn (x ++ " " ++ y)

{-
The do syntax
A do block has the following syntax
do
    v1 <- [IO action]
    v2 <- [IO action]
    ...
    vk <- [IO action]
    [IO action]
- v1 through vk unbox the results of IO actions
- The final IO action is the return value
-}

--The v <- portion can be skipped if you don’t want to unbox
echo_two :: IO ()
echo_two =
    do
        x <- getLine
        putStrLn x
        y <- getLine
        putStrLn y

--let expressions can be used inside do blocks
add_one :: IO ()
add_one =
    do
        n <- getLine
        let num = (read n) :: Int
            out = show (num + 1)
        putStrLn out
--This is useful to do pure computation between IO actions

--if expressions can be used inside do blocks
guess :: IO ()
guess = do
    x <- getLine
    if x == "42"
        then putStrLn "correct!"
        else putStrLn "try again"
--Both branches of the if must have the same type

{-
do blocks let you sequence multiple actions
- Works with IO actions
- Will not work in pure functional code
Functional programs consist of
- a small amount of IO code
- a large amount of pure functional code
Don’t try to write your entire program in IO code
-}

{-
Putting values in the IO box
Sometimes we need to put a pure value into IO
I We can use the return function to do this
ghci> :t "hello"
"hello" :: [Char]
ghci> :t return "hello"
IO [Char]
-}

--return example
print_if_short :: String -> IO ()
print_if_short str =
    if length str <= 2
        then putStrLn str
        else return ()
--Both sides of the if must have type IO ()
--So we use return () in the else part

--Note that return does not stop execution
--It just converts pure values to IO values
--It is nothing like return from imperative languages
print123 =
    do
        x <- return 1
        y <- return 2
        z <- return 3
        putStrLn (show x ++ show y ++ show z)

{-
Monads
The type of return mentions monads
ghci> :t return
return :: Monad m => a -> m a
This is because IO is a monad
- Whenever you see Monad m => substitute IO for m
- So return :: a -> IO a
You don’t need to know anything about monads for COMP105
-}

--
mystery :: IO ()
mystery =
    do
        x <- getLine
        if x == ""
        then return ()
        else do
            putStrLn (map toUpper x)
            mystery



