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

{- 
Exercise
Which types are returned by the following queries?
ghci> :t take
Int -> [a] -> [a]

ghci> :t (:)
a -> [a] -> [a]

ghci> :t (++)
[a] -> [a] -> [a]
-}

--char on front of string uses : 
--string onto string uses ++

{- 
Type classes
ghci> :t (+)
(+) :: Num a => a -> a -> a
ghci> :t (*)
(*) :: Num a => a -> a -> a
Num is a type class
- It restricts the type variable a to only be number types
- Int, Integer, Float, Double are all contained in Num
- Char, Bool, tuples and lists are not in Num
:info Num 
-}

--Eq type class is all types that can be equality tested (==) 

--forces a to be both equality testable and a number
equalsTwo a b = a + b == 2
-- :t equalsTwo gives equals_two :: (Eq a, Num a) => a -> a -> Bool

-- Works but too restrictive
--equalsTwo :: Int -> Int -> Bool
-- Most general
--equalsTwo :: (Eq a, Num a) => a -> a -> Bool
-- Too general (will give error)
--equalsTwo :: a -> a -> Bool

--obviously all nums are also in eq but still need to state it 
--this is becasue haskell lets you have num types not in eq