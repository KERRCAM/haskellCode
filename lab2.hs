--q1
squareAndCube x = (x*x, x*x*x) 
addTuple (a, b) = a + b 
first (a, _) = a 
second (_, b) = b  
swap (a, b) = (b, a) 
twoToThree (a, b) c = (a, b, c) 

--q2 
headSquared (x:xs) = x*x 
headSquared2 list = (head list)^2
third list = list !! 4 
secondTail list = tail(tail list) 
thirdHead list = head(tail(tail list)) 
firstPlusLast list = (head list) + (last list) 
prependTwo list a b = a : (b : list) 

--q3 
twoLengths list1 list2 = (length list1) + (length list2) 
makePalindrome list = list ++ (reverse list) 
sumAndProduct list = ((sum list),(product list)) 
fourThroughSix list = take 3 (drop 3 list) 
bothIn list x y = ((elem x list) && (elem y list)) 

{-q4
a) [101..200] 
b) [1000, 1002..1050] 
c) [20, 19..1] 
d) [999, 1002..] --control c to stop 
-}

--q5 
--a) [2^x | x <- [1..10]]