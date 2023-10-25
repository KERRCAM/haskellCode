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

-- :t (type inference) will always give the most general type annotation

--Num type class can be further split into integral and fractional 
--Integral represents whole numbers (contains Int and Integer)
--Fractional represents rationals (contains Float, Double, and Rational) 

--numbers like 2 defult type to Num 
--can force a more specific number type by doing 2 :: float for example 

{- 
Converting integers to numbers
Once the type has been fixed, it is fixed
I But you can convert back to a more generic type using
fromIntegral
ghci> fromIntegral (1 :: Int) / 2
0.5
ghci> :t fromIntegral (1 :: Int)
fromIntegral (1 :: Int) :: Num b => b
ghci> :t fromIntegral
fromIntegral :: (Integral a, Num b) => a -> b
-}

{-
Haskell includes many typeclasses that we won’t see on this course
length works on any data structure that is Foldable
For COMP105, if you see
- Functor
- Foldable
- Traversable
then think list
-}