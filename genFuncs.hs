f x y = x + y 

pow16 0 = 1
pow16 x = 16 * pow16 (x-1)

multiply x 1 = x
multiply x y = x + multiply x (y-1)

is_even 0 = True
is_even 1 = False
is_even n = is_even (n-2)

fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

take' 0 list = []
take' n [] = []
take' n (x:xs) = x : take' (n-1) xs

drop' 0 list = list
drop' n [] = [] -- could also be an error
drop' n (x:xs) = drop' (n-1) xs

reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

group n [] = []
group n list =
    let
        first = take n list
        rest = drop n list
    in
        first : group n rest

factorial n = if n > 1
    then n * factorial (n-1)
    else 1

elem' e [] = False
elem' e (x:xs)
    | e == x = True
    | otherwise = elem' e xs

even_sum 0 = 0
even_sum x = if x `mod` 2 == 0
    then x + even_sum (x-1)
    else even_sum (x-1)

evenSum x  -- same function but with gaurds
    | (x == 0) = 0
    | (x `mod` 2 == 0) = x + even_sum (x-1)
    | otherwise = even_sum (x-1)

join xs ys = [ x ++ " " ++ y | x <- xs, y <- ys]

primes n = [x | x <- [1..n], length (factors x) == 2]

factors n = [x | x <- [1..n], n `mod` x == 0]

length' xs = sum [1 | _ <- xs]

removeLowercase st = [ c | c <- st, c `elem` ['A'..'Z']]

heads xxs = [ [ x | x <- xs, even x ] | xs <- xxs] --input list of lists get first element from all in a new list 

letEx x y z = let
    a = x * x
    b = y * y
    cc = z * z
    in
    a * a + b * b 

mult_first_two (x:y:xs) = x * y --pattern matching example

double_second (_:y:_) = 2 * y --can use underscore (wildcard) if you dont care what the other values are

