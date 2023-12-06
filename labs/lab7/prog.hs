{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use print" #-}
{-# HLINT ignore "Use unless" #-}

--different process on mac which is as follows:
{-
The default interactive shell is now zsh.
To update your account to use zsh, please run `chsh -s /bin/zsh`.
For more details, please visit https://support.apple.com/kb/HT208050.
Kerrs-MacBook-Pro:haskellCode kerrcameron$ pwd
/Users/kerrcameron/Documents/haskellCode
Kerrs-MacBook-Pro:haskellCode kerrcameron$ cd labs/lab7
Kerrs-MacBook-Pro:lab7 kerrcameron$ ghc prog.hs 
[1 of 2] Compiling Main             ( prog.hs, prog.o )
[2 of 2] Linking prog
Kerrs-MacBook-Pro:lab7 kerrcameron$ ./prog 
Hello world!
Kerrs-MacBook-Pro:lab7 kerrcameron$ 
-}

main = putStrLn "Hello world!"


echo :: IO ()
echo = do 
    str <- getLine 
    putStrLn str 


doubleEcho = do 
    str <- getLine 
    putStrLn str 
    putStrLn str


putTwoStrs = do 
    str1 <- getLine 
    str2 <- getLine 
    putStrLn str1 
    putStrLn str2


plusOne :: IO () 
plusOne = do 
    str <- getLine 
    let n = read str :: Int 
        out = n + 1 
    putStrLn (show out)


timesTwo = do 
    str <- getLine 
    let n = read str :: Int 
        out = n * 2 
    putStrLn (show out) 


add = do 
    str1 <- getLine 
    let n1 = read str1 :: Int 
    str2 <- getLine 
    let n2 = read str2 :: Int 
        out = n1 + n2 
    putStrLn (show out) 


reverseIO = do 
    str <- getLine 
    let reversed = reverse str 
    print reversed


guess42 = do 
    str <- getLine 
    let n = read str :: Int 
    if n == 42 then putStrLn "Correct" else putStrLn "Wrong"


getInt :: IO Int 
getInt = do 
    str <- getLine 
    let n = read str :: Int 
    return n 


getBool = do 
    str <- getLine 
    let n = read str :: Bool 
    return n 


gt10 = do 
    str <- getLine
    let n = read str :: Int 
    if n > 10 then return True else return False


getTwoStrings = do 
    str1 <- getLine
    str2 <- getLine
    return (str1,str2) 


echoForever :: IO () 
echoForever = do 
    str <- getLine 
    putStrLn str 
    echoForever


addOneForever = do 
    str <- getLine 
    let n = read str :: Int 
        out = n + 1 
    putStrLn (show out) 
    addOneForever 


echoUntilQuit = do 
    str <- getLine 
    putStrLn str 
    if str == "quit" then return () else echoUntilQuit


{-
printNumbersBetween a b 
    |
-}

