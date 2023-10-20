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