
--scan is like fold but it outputs the accumulator at each step
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Eta reduce" #-}
scanr' :: (a -> b -> b) -> b -> [a] -> [b]
scanr' _ init [] = [init]
scanr' f init (x:xs) =
    let
        recursed = scanr' f init xs
        new = f x (head recursed)
    in
        new : recursed

{- 
There are also left to right versions of scan
ghci> scanl (+) 0 [1..10]
[0,1,3,6,10,15,21,28,36,45,55]
ghci> scanr (+) 0 [1..10]
[55,54,52,49,45,40,34,27,19,10,0]
ghci> :t scanl
scanl :: (b -> a -> b) -> b -> [a] -> [b]
-}

fib_pairs n = scanl (\ (a, b) _ -> (b, a + b)) (0, 1) [1..n]
--ghci> fib_pairs 7 gives [(0,1),(1,1),(1,2),(2,3),(3,5),(5,8),(8,13),(13,21)]

fib_to_n n = map fst (fib_pairs n)
--ghci> fib_to_n 7 gives [0,1,1,2,3,5,8,13]

--adds the elements in the list multiplied by two (displaying all updates along the way)
mystery list = scanl (\ acc x -> 2*x + acc) 0 list

--displays max value in list between the satrt of the list and current location, so last vlaue will be max value in list
mystery2 list = scanl1 (\ acc x -> max acc x) list

--puts the values in first elemnt of tuple, anything else in second element (tuple is the accumulator)
mystery3 list = foldr (\ x (a, b) ->
                        if x `elem` "aeiou"
                        then (x:a, b)
                        else (a, x:b))
                      ("", "") list

{- 
takeWhile takes from a list while a condition is true
ghci> takeWhile (<=5) [1..10]
[1,2,3,4,5]
ghci> takeWhile (/=' ') "one two three"
"one"
ghci> takeWhile (\ x -> length x <= 2)
["ab", "cd", "efg"]
["ab","cd"]
-} 

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (x:xs)
    | f x = x : takeWhile' f xs
    | otherwise = [] 

--dropWhile is same as takeWhile but obviously for drop instead of take 
dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (x:xs)
    | f x = dropWhile' f xs
    | otherwise = x:xs

split_words "" = []
split_words string =
    let
        first = takeWhile (/=' ') string
        up_to_space = dropWhile (/=' ') string
        after_space = dropWhile (==' ') up_to_space
    in
        first : split_words after_space


{- 
The split words function is called words
ghci> words " foo bar baz "
["foo","bar","baz"]
ghci> unwords ["foo","bar","baz"]
"foo bar baz"
-}

--zip recap
--ghci> zip [1,2,3,4] [5,6,7,8] gives [(1,5),(2,6),(3,7),(4,8)]
add_two_lists l1 l2 =
    let
        zipped = zip l1 l2
    in
        map (\ (x, y) -> x + y) zipped
--ghci> add_two_lists [1,2,3,4] [5,6,7,8] gives [6,8,10,12]

{- 
zipWith zips two lists together using a function
ghci> zipWith (+) [1,2,3] [4,5,6]
[5,7,9]
ghci> zipWith (++) ["big", "red"] ["dog", "car"]
["bigdog","redcar"]
ghci> zipWith (\ x y -> if x then y else -y)
[True, False, False] [1,2,3]
[1,-2,-3]
-}

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

mult_by_pos list = zipWith (*) list [0..]

interleave str1 str2 =
    let
        zipped = zipWith (\ x y -> x : y : []) str1 str2
    in
        concat zipped



--
mystery4 list = takeWhile (`elem` ['0'..'9']) list

--adds head of first string onto length of second string
mystery5 str1 str2 = [head str1] ++ show (length str2)

--gives head and length of each string in list togeth (as one list)
mystery6 list = zipWith mystery5 list list
