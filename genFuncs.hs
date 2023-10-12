f x y = x + y 

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

elem' e [] = False
elem' e (x:xs)
    | e == x = True
    | otherwise = elem' e xs
