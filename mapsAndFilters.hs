--recap: transforming lists
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use zipWith" #-}
{-# HLINT ignore "Use uncurry" #-}
{-# HLINT ignore "Use const" #-}
{-# HLINT ignore "Use map" #-}
{-# HLINT ignore "Use camelCase" #-}
double_list [] = []
double_list (x:xs) = 2 * x : double_list xs

square_list [] = []
square_list (x:xs) = x * x : square_list xs

-- map (a function) (a list) 
--appllies the function to every element in the list 
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

{- 
square x = x * x
ghci> map square [1..5]
[1,4,9,16,25]
ghci> map reverse ["the", "quick", "brown", "fox"]
["eht","kciuq","nworb","xof"]
ghci> map fst [(1,2),(3,5),(6,3),(2,6),(2,5)]
[1,3,6,2,2]

It is common to use curried functions with map
ghci> map (*2) [1..5]
[2,4,6,8,10]
ghci> map (2^) [1..5]
[2,4,8,16,32]
ghci> map (drop 2) ["the", "quick", "brown"]
["e","ick","own"]

It is common to use an anonymous function with map
ghci> map (\x -> x*x) [1..5]
[1,4,9,16,25]
ghci> map (\(x, y) -> x + y) [(1,1), (2,2), (3,3)]
[2,4,6]
ghci> map (\(_:y:_) -> y) ["the", "quick", "brown"]
"hur"

Nested maps
When working with nested lists, it is common to use nested maps
ghci> map (map (*2)) [[1,2,3], [4,5,6], [7,8]]
[[2,4,6],[8,10,12],[14,16]]
import Data.Char
ghci> map (map toUpper) ["the", "quick", "brown"]
["THE","QUICK","BROWN"]
Note the use of currying for the inner map
-}

--applies mod 2 to every element of the list
mystery list = map (`mod` 2) list

--males every element to a 1 and takes sum of list essentially giving the list length
mystery2 list = sum (map (\_ -> 1) list)

--inputs list of ints and returns corresponding character in the alphabet 
mystery3 list = map (\x -> ['a'..'z'] !! x) list 

--Filter keeps only the elements for which f returns True
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x = x : rest
    | otherwise = rest
    where rest = filter' f xs
--ghci> filter' even [1..10] gives [2,4,6,8,10] 


--rearranges list to be all the even elements then all the odd elements
mystery4 list = filter even list ++ filter odd list

--multiplies each number in the list by its index position in the list
mystery5 list = map (\(x, y) -> x * y) (zip list [0..]) 
--power isntead of multiplication
mystery05 list = map (\(x, y) -> x ^ y) (zip list [0..])

--takes numbers in first list and reassigns them to corresponding positions in second list 
--can go over the length of second list though unlike mystery3
mystery6 list1 list2 =
    let
        filtered = filter (< length list2) list1
    in
        map (\x -> list2 !! x) filtered

{- 
Higher order programming
map and filter are examples of higher order programming
This style
- de-emphasises recursion
- focuses on applying functions to lists
- is available in imperative languages (python, C++)
There is a whole family of higher order programming functions
available in Haskell
-}
