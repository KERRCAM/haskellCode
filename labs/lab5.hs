{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Avoid lambda" #-}
{-# HLINT ignore "Use or" #-}
{-# HLINT ignore "Use even" #-}
{-# HLINT ignore "Use infix" #-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# HLINT ignore "Use span" #-}

--question 1
listProduct list = foldr (\x acc -> acc * x) 1 list

listAny list = foldr (||) False list

productOfEvens list = foldr(\x acc -> if mod x 2 == 0 then acc * x else acc) 1 list

lt10 list = foldr(\x acc -> if x < 10 then acc + 1 else acc) 0 list

smalls string = foldr(\x acc -> if elem x ['a','b'..'z'] then x : acc else acc) "" string

sumEvensOdds list = foldr(\x (a,b) -> if mod x 2 == 0 then (a+x,b) else (a,b+x)) (0,0) list 

listProductS list = scanl (\acc x -> acc * x) 1 list

listAnyS list = scanl (||) False list

productOfEvensS list = scanl(\acc x -> if mod x 2 == 0 then acc * x else acc) 1 list

lt10S list = scanl(\acc x -> if x < 10 then acc + 1 else acc) 0 list

smallsS string = scanl(\acc x -> if elem x ['a','b'..'z'] then x : acc else acc) "" string

sumEvensOddsS list = scanl(\(a,b) x -> if mod x 2 == 0 then (a+x,b) else (a,b+x)) (0,0) list  

--question 2 
leadingCaps string = takeWhile (`elem` ['A'..'Z']) string

dropCaps string = dropWhile (`elem` ['A'..'Z']) string

--splitOn c string = (takeWhile (`elem` c) string, dropWhile (`elem` c) string)
--var not in scope error
