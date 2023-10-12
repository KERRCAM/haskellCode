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

