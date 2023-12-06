{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Evaluate" #-}
{-# HLINT ignore "Use uncurry" #-}

--question 1
plusTen = (10 +) 

isTwenty = (20 ==)

powerThree = (3^)

concatThree x y z = x ++ y ++ z 
concatThreeP y z = (concatThree "Answer: ") y z 
piIs z = ((concatThree (show pi)) " is ") z 

--question 2 
{- 
a) 
ghci> (\ x -> x - 1) 10
9
b) 
ghci> (\ x y -> x + y) 10 12
22
c) 
ghci> (\ x y -> show x ++ show y) 10 12
"1012"
d) 
ghci> (\ (x,y) -> (y,x)) (10,12)
(12,10)
e)
ghci> (\ (x:xs) -> head (tail(x:xs))) [10,12,14]
12
-}

--question 3
tripleList :: Num b => [b] -> [b]
tripleList list = map (*3) list

listToStr :: Show a => [a] -> [String]
listToStr list = map show list

secondChar :: [[b]] -> [b]
secondChar list = map (!!1) list

addPairs :: Num b => [(b, b)] -> [b]
addPairs list = map (\ (x,y) -> x+y) list 

tripleListList :: Num b => [[b]] -> [[b]]
tripleListList list = map (map (*3)) list

--question 4 
onlyOdds :: Integral a => [a] -> [a]
onlyOdds list = filter odd list

vowles :: [Char] -> [Char]
vowles list = filter (`elem` "aeiou") list 

between :: Ord a => a -> a -> [a] -> [a]
between a b list = filter (\ x -> x > a && x < b) list 

order :: Ord a => [(a, a)] -> [(a, a)]
order list = filter (\(x,y) -> x > y) list

singletons :: Foldable t => [t a] -> [t a]
singletons list = filter (\x -> length x == 1) list

onlyOddsList :: Integral a => [[a]] -> [[a]]
onlyOddsList list = map (filter odd) list

--quetion 5 
{- rewrittng with . operator
a) head (head [[1]])
(head . head) [[1]]

b)(+1) ((*2) 4)
((+1) . (*2()) 4

c)sum (tail (tail [1,2,3,4])) 
(sum . tail . tail) [1,2,3,4]

d)filter (>10) (map (*2) [1..10]) 
((filter >10) . (map (*2))) [1..10]
-}