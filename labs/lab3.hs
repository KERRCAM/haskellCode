mult13 0 = 0
mult13 n = 13 + mult13 (n - 1)

pow3 0 = 1
pow3 n = 3 * pow3 (n - 1)

oddSum n
    | n == 1 = 1
    | mod n 2 == 1 = n + oddSum (n - 1)
    | otherwise = oddSum (n - 1)

lucas 0 = 2
lucas 1 = 1
lucas n = lucas (n - 1) + lucas (n - 2)

halfSum [x] = x / 2
halfSum (x:xs) = x * halfSum xs

mult [] = [] 
mult (x:xs) = (x * 2) : mult xs

dropEvens [] = [] 
dropEvens (x:xs) 
    | mod x 2 == 0 = loop 
    | otherwise = x : loop  
    where loop = dropEvens xs 

triple [] = [] 
triple (x:xs) = x : x : x : triple xs 

multiAdjacent [] = [] 
multiAdjacent [_] = error "called on list with odd length"
multiAdjacent (x:y:xs) = (x * y) : multiAdjacent xs

getEle i [] = error "list is too short"
getEle 0 (x:_) = x 
getEle i (x:xs) = getEle (i - 1) xs

dropEle i [] = error "list is too short"
dropEle 0 (_:xs) = xs
dropEle i (x:xs) = x : dropEle (i - 1) xs

divList [] [] = [] 
divList [] _ = error "lists are different length"
divList _ [] = error "lists are different length"
divList (x:xs) (y:ys) = x / y : divList xs ys

longer [] _ = False 
longer [] [] = False 
longer _ [] = True 
longer (_:xs) (_:ys) = longer xs ys

div3Anot [] = ([], [])
div3Anot (x:xs)
    | mod x 3 == 0 = (x:first, second)
    | otherwise = (first, x:second)
    where (first, second) = div3Anot xs

vowlesAcons [] = ([], [])
vowlesAcons (x:xs) 
    | elem x "aeiou" = (x:vow, cons)
    | otherwise = (vow, x:cons)
    where (vow, cons) = vowlesAcons xs

fastLucasHelp 1 = [1,2]
fastLucasHelp n = x + y : (x:y:rest)
    where (x:y:rest) = fastLucasHelp (n - 1)

fastLucas n = head (fastLucasHelp n)

multPairs [] = [] 
multPairs ((x, y):xs) = x * y : multPairs xs

multByPos list = multPairs (zip list [0..])



-- Returns the length of the collatz sequence starting at n
collatz 1 = 1
collatz n
    | n `mod` 2 == 0 = 1 + collatz (div n 2)
    | otherwise = 1 + collatz (3*n + 1)
-- Returns (starting_number, sequence_length) for the longest sequence less than n
longest_collatz_helper 1 = (1,1)
longest_collatz_helper n =
    let
        (start, length) = longest_collatz_helper (n-1)
        our_length = collatz n
    in
        if our_length > length
        then (n, our_length)
        else (start, length)
longest_collatz n = start
    where (start, _) = longest_collatz_helper n

