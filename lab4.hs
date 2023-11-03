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
tripleList list = map (*3) list

listToStr list = map show list

secondChar list = map (!!1) list

addPairs list = map (\ (x,y) -> x+y) list 

tripleListList list = map (map (*3)) list

--question 4 
onlyOdds list = filter odd list

vowles list = filter (`elem` "aeiou") list 

between a b list = filter (\ x -> x < a && x > b) list