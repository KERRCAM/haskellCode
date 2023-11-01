{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use concat" #-}
{-# HLINT ignore "Use and" #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Use even" #-}

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ init [] = init
foldr' f init (x:xs) = f x (foldr' f init xs)

sum'' list = foldr (\ x acc -> acc + x) 0 list

--concat' list = foldr (++) [] list

all' list = foldr (&&) True list

length' list = foldr (\_ acc -> acc + 1) 0 list

count_ones list = foldr (\ x acc -> if x == 1 then acc + 1 else acc) 0 list

--adds together each element divided by two
mystery list = foldr (\x acc -> acc+(x/2)) 0 list

--doubles each element
mystery2 list = foldr (\x acc -> x : x : acc) [] list

--adds together all even elements
mystery3 list =
    let f = (\x acc -> if x `mod` 2 == 0
                       then x+acc
                       else acc)
    in foldr f 0 list

{- 
fold type
foldr :: (a -> b -> b) -> b -> [a] -> b
Note that two type variables are used here
I The input list has type [a]
I The accumulator has type b
So a fold can output a different type to the input list
-}

sum_of_lengths list = foldr (\x acc -> acc + length x) 0 list

to_csv list = foldr (\x acc -> show x ++ "," ++ acc) "" list

--uses last element of list as accumulator
foldr1' _ [] = error "empty list"
foldr1' _ [x] = x
foldr1' f (x:xs) = f x (foldr1' f xs)
--foldr1' (+) [1,2,3,4,5] gives 15 
{- 
Note that the type of foldr1 is
foldr1' :: (a -> a -> a) -> [a] -> a
The accumulator has the same type as the list elements
- So foldr1 cannot be used to change the type of a list
-}

--foldr1 examples
sum' list = foldr1 (+) list

product' list = foldr1 (*) list

concat' list = foldr1 (++) list

maximum' list = foldr1 (\ x acc -> if x > acc then x else acc) list

{- 
Folding right
foldr processes lists from the right
foldr (+) 0 [1..4]
= 1 + (2 + (3 + (4 + 0)))
foldr (/) 1 [1..4]
= 1 / (2 / (3 / (4 / 1)))
= 0.375

Folding left
foldl processes lists from the left
foldl (+) 0 [1..4]
= ((((0 + 1) + 2) + 3) + 4)
foldl (/) 1 [1..4]
= ((((1 / 1) / 2) / 3) / 4)
= 0.0416 

The type of foldl
foldr :: (a -> b -> b) -> b -> [a] -> b
foldl :: (b -> a -> b) -> b -> [a] -> b
Observe that the function f has its type flipped
- foldr (\ x acc -> ...
- foldl (\ acc x -> ...
-}

reverse_list list = foldl (\ acc x -> x : acc) [] list

