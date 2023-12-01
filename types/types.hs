-- :t or :type ot check type of something 
-- can check types of tuples and lists 

-- tuples can have multiple types and have length encoded in their type
-- elements in a list are all of the same type 

-- functions in haskell also have types 
{-
Function types
For a one argument function, the type is written as
[input type] -> [output type]
Examples:
- Bool -> Bool
- [Char] -> Char
- (Int, Int) -> Int
-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

mystery [] = True
mystery (x:xs)
    | x `elem` ['a'..'z'] = mystery xs
    | otherwise = False
--returns true if the list is only lowercase letters else false 
-- type is [char] -> bool

mystery2 [] = ""
mystery2 ((a,b):xs)
    | b == True = a : rest
    | otherwise = rest
    where rest = mystery2 xs
-- takes input list of tuples (char, bool) and is character has true with it its kept and if it has flase with it its discarded
--type is [(char, bool)] -> [char] 

--partial application examples 
--can call function with no all arguments making new function 
func a b c = "Arguments are: " ++ [a, b, c]
func2 = func 'x'
--in this example func2 calls func but only with a value for a 
--can now call func2 with the two arguments for b and c 

joinThree x y z = x ++ [' '] ++ y ++ [' '] ++ z
f1 = joinThree
f2 = joinThree "hello"
f3 = joinThree "hello" "to"
f4 = joinThree "hello" "to" "you"

--you can partially apply prelude functions as well:
pow2 = (^) 2
--pow2 10 gives 1024

first_four = take 4
--[1,2,3,4] for list of in order ints 

prepend1 = (:) 1
--prepend1 [1,2,3] gives [1,1,2,3]

--can be done with operaters as well
divR = (/2)  
--only need left intput
divL = (2/) 
--only need right input
divN = (/)
--essentially renames the / symbol


multThree x y z = x * y * z
{-
Bracketing for function types
Function application should be thought of multiple partial applications
multThree x y z = x * y * z
ghci> ((multThree 2) 3) 4
ghci> ((multThree 2) 3) 4
24
This means that the function type brackets to the right
Int -> Int -> Int -> Int
is the same as
Int -> (Int -> (Int -> Int))
-}

multThree x y z = x * y * z
multThree' (x, y, z) = x * y * z 
{-
These both do the same thing, but the second version cannot be partially applied
- It’s best to avoid tuples unless they are necessary
-} 

mystery3 = drop 10  
--

mystery4' a b c = b ++ a ++ c
mystery4 = mystery4' " and "  
--

mystery5 = (^) ((^) 2 2) 
--4^x where you give x 

-- ^ can only do integer powers and gives integer back
-- ** can do float powers and gives float back
