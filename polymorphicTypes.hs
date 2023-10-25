--some functions can take many types e.g. length' 
--this is called type polymorphism
length' :: [a] -> Integer --this line is a type annotation, definines intended types of functions
length' [] = 0
length' (_:xs) = 1 + length' xs

--tail function that can only take lists of ints
intTail = tail :: [int] -> [int] 

--fst takes tuple gives first element 
--snd takes tuple gives second element

--f and g both reverse the order of elements in 4 element tuple 
--however g every element must be the same type
f (a,b,c,d) = (d,c,b,a) 
g = f :: (a,a,a,a) -> (a,a,a,a)

