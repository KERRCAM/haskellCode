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