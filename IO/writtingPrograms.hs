{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use <$>" #-}
{-# HLINT ignore "Use print" #-}
import System.Environment

--Writing programs
--To write a program in Haskell we write a main function
--main :: IO ()
--main = putStrLn "Hello world!"
{-
main always:
- Takes no arguments
- Returns an IO type

To run the program, we first need to compile it
$ ghc hello.hs
[1 of 1] Compiling Main ( hello.hs, hello.o )
Linking hello ...
$ ./hello
Hello world!

Compiling on Windows
1. Save your code as M:\code.hs
2. Open the Command Prompt (search for cmd)
3. Switch to the M drive with "M:"
4. Compile with "ghc code.hs"
5. To run, just type "code"
You can also compile and run code in subdirectories, but you will
need to use "cd" to first switch to the right directory
-}

{-
Command line arguments
Most command line programs take arguments
▶ getArgs :: IO [String] returns those arguments
▶ This function is in System.Environment
import System.Environment
main :: IO ()
main = do
args <- getArgs
let output = "Command line arguments: " ++ show args
putStrLn output
-}

--Looping in IO code
--The only way to loop in IO code is to use recursion
printN :: String -> Int -> IO ()
printN _ 0 = return ()
printN str n =
    do
        putStrLn str
        printN str (n-1)
-- No variables!
-- No loops!

{-
Using command line arguments
main :: IO ()
main = do
    args <- getArgs
    let n = read (args !! 0) :: Int
    printN (args !! 1) n

$ ./repeat_string 3 hello
hello
hello
hello
-}

--Exercise
--What does this IO action do?
--prints ! if you got right ans and < or > correspondingly for lt, gt
mystery :: Int -> IO ()
mystery n = do
    ans <- getLine
    let parsed = read ans
    if parsed == n
        then putStrLn "!"
        else do
            if parsed > n
                then putStrLn ">"
                else putStrLn "<"
            mystery n

{-
File IO
readFile :: String -> IO String --reads the contents of a file
Suppose that example.txt contains:
line one
line two
line three
ghci> readFile "example.txt"
"line one\nline two\nline three\n"
-}

{- !!!!!!!!!!!!!!!!!!!!!!!
writeFile
writeFile writes a string to a file
▶ writeFile :: String -> String -> IO ()
▶ The file will be overwritten! --because of this very dangererous to accidently put your source file
ghci> writeFile "output.txt" "hello\nthere\n"
The file output.txt contains:
hello
there
-} 

{-
Finishing the marks.csv example
We wrote the report function in Lecture 18
Now we can turn it into a program
main :: IO ()
main = do
    args <- getArgs
    let infile = args !! 0
        outfile = args !! 1
    input <- readFile infile
    writeFile outfile (report input) -- note report func not in this file but in L18 file
-}

--Exercise
--What does this program do?
--takes 2 command line args an in file and out file and copies lines in in file with length lt or = to 5 into the out file
{-
mystery2 :: String -> String -> IO ()
mystery2 r w = do
    d <- readFile r
    let l = lines d
        p = filter (\x -> length x <= 5) l
        o = unlines p
    writeFile w o

main = do
    args <- getArgs
    mystery2 (args !! 0) (args !! 1)
-}

--Useful IO functions
--print is the same as (putStrLn . show)
print_stuff = do
    print "hi"
    print 1
    print [1,2,3]
    print False
--note tho print "hi" would output "hi" rather than putStrLn which gets rid of quotes

--putStr prints a string without a new line
print_three a b c = do
    putStr a
    putStr b
    putStr c
    putStr "\n"
--ghci> print_three "one" "two" "three"
--onetwothree

--readLn gets a line of input and then calls read
readLn' :: Read a => IO a
readLn' = do
    x <- getLine
    return (read x)

add_one :: IO ()
add_one = do
    x <- readLn
    putStrLn (show (x + 1))

{-
forever repeats an IO action forever
 It’s in the Control.Monad package
ghci> import Control.Monad
ghci> forever (putStrLn "hi")
hi
hi
hi
hi
...

Interactive code with forever
import Control.Monad
import Data.Char
process :: IO ()
process = do
putStrLn "Give me some input: "
l <- getLine
putStrLn (map toUpper l)
main = forever process
-}

{-
sequence
sequence performs a list of IO actions
ghci> sequence [getLine, getLine, getLine]
one
two
three
["one","two","three"]
The final line is the return value of sequence
sequence :: [IO a] -> IO [a]

sequence works well with map
ghci> sequence (map print [1,2,3])
1
2
3
[(),(),()]

mapM
Alternatively, you can use mapM
mapM :: (a -> IO b) -> [a] -> IO [b]
ghci> mapM print [1,2,3,4]
1
2
3
4
[(),(),(),()]
-}

{-
when
when executes an IO action if a condition is true
ghci> when True (print "hi")
"hi"
ghci> when False (print "hi")
ghci>
when :: Bool -> IO () -> IO ()

unless
unless executes an IO action if a condition is false
ghci> unless True (print "hi")
ghci> unless False (print "hi")
"hi"
unless :: Bool -> IO () -> IO ()
-}