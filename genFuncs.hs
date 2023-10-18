import Data.Char

f x y = x + y 

pow16 0 = 1
pow16 x = 16 * pow16 (x-1)

multiply x 1 = x
multiply x y = x + multiply x (y-1)

isEven 0 = True
isEven 1 = False
isEven n = isEven (n-2)

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

multFirstTwo (x:y:xs) = x * y --pattern matching example

doubleSecond (_:y:_) = 2 * y --can use underscore (wildcard) if you dont care what the other values are

removeTwos [] = [] --eliminates all 2s from the input list
removeTwos (x:xs)
    | x == 2 = rest
    | otherwise = x : rest
    where rest = removeTwos xs

initials first last = [f] ++ ". " ++ [l] ++ "."
    where (f:_) = first
          (l:_) = last

addLists _ [] = []
addLists [] _ = []
addLists (x:xs) (y:ys) = x+y : addLists xs ys

listEqual [] [] = True --checks if lists are the same (or strings)
listEqual _ [] = False
listEqual [] _ = False
listEqual (x:xs) (y:ys)
    | x == y = listEqual xs ys
    | otherwise = False

gt_10 [] = ([], []) --returns input list as a tuple. first element is list of values over 10, second elemnt is list of values under 10 (fromt he origonal list)
gt_10 (x:xs)
    | x > 10 = (x:gt, lt)
    | otherwise = (gt, x:lt)
    where (gt, lt) = gt_10 xs

zip' [] _ = [] --puts elemnts of each list togeth in a tuple (index position wise) if one list is longer it will stop at max of shorter list
zip' _ [] = [] --(is in prelude as a base fucntion)
zip' (x:xs) (y:ys) = (x, y) : zip' xs ys

listIndSplit [] = ([], []) --must have even list input or error, splits into two lists of even and odd index positions
listIndSplit [_] = error "Error"
listIndSplit (x:y:xs) = (x:first, y:second)
    where (first, second) = listIndSplit xs 


mys2 [] [] = True --second list must be frist list with each element doubled but next to each other
mys2 [] _ = False --i.e. [1,2] is [1,1,2,2]
mys2 _ [] = False
mys2 _ [_] = False
mys2 (x:xs) (y1:y2:ys)
    | x == y1 && x == y2 = mys2 xs ys
    | otherwise = False

even' 0 = True
even' n = odd' (n-1) 

odd' 0 = False
odd' n = even' (n-1)

evens [] = []
evens (x:xs) = x : odds xs 

odds [] = []
odds (x:xs) = evens xs

fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fastFibHelp 1 = [1, 0]
fastFibHelp n = x + y : (x:y:xs) 
    where (x:y:xs) = fastFibHelp (n-1)

split pivot [] = ([], [])
split pivot (x:xs)
    | x < pivot = (x : lower, upper)
    | otherwise = (lower, x : upper)  
    where (lower, upper) = split pivot xs
    

qs [] = []
qs (x:xs) = qs lower ++ [x] ++ qs upper 
    where (lower, upper) = split x xs

qs' [] = []
qs' (x:xs) = qs' lower ++ [x] ++ qs' upper
    where lower = [e | e <- xs, e < x ]
          upper = [e | e <- xs, e >= x]

char2int c = ord c - ord 'a'

int2char i = chr (i + ord 'a')

shift c offset =
    let
        converted = char2int c
        is_lower = converted >= 0 && converted < 26
    in
        if is_lower
        then int2char ((converted + offset) `mod` 26)
        else c

caesarEnc [] _ = []
caesarEnc (x:xs) offset = shift x offset
                            : caesarEnc xs offset

caesarDec (x:xs) offset = shift x (-offset)
                            : caesarDec xs offset



    
