{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

--The type keyword gives a new name to an existing type
--All types must start with capital letters
type String' = [Char]
exclaim :: String' -> String'
exclaim str = str ++ "!"
--ghci> exclaim "hello" gives "hello!"
--type is useful when you want to give a meaningful name to a complex type
type VoteResults = [(Int, String)]
results :: VoteResults
results = [(2, "red"), (1, "blue"), (1, "green")]
--ghci> head results gives (2,"red")

--The data keyword is used to create an entirely new type
data Bool' = True | False
-- | should be read as “or”
-- each of the values is a constructor

data Direction = North | South | East | West
rotate North = East
rotate East = South
rotate South = West
rotate West = North
--ghci> :t rotate gives rotate :: Direction -> Direction

{-
By default, a new data type is not part of any type class
ghci> rotate North gives No instance for (Show Direction) arising from ...
We can use the deriving keyword to fix this
data Direction = North | South | East | West deriving (Show, .., ..)
ghci> rotate North
East
Haskell automatically writes the show function for us
You can override this if you want 

Haskell can automatically implement the following type classes
- Show – will print out the type as it is in the code
- Read – will parse the type as it is in the code
- Eq – the natural definition of equality
- Ord – constructors that come first are smaller
-}

--when deriving ord the order is the order in the constructer i.e West > South would be True if given ord typeclass 

--Exercise 
data Colour = Red | Blue | Green deriving (Show, Read, Eq, Ord)
{- 
What are the results of the following queries?
1. show Red ++ show Blue ++ show Green
"RedBlueGreen"
2. Red == Red && Red /= Green
True
3. Red < Blue && Green < Blue
False
4. read "red" :: Colour
parse error
-}

--can define operators too 
(***) x y = x + y + 2 
--1 *** 2 gives 5

--More complex constructors can contain other types
data Point = Point Int Int deriving (Show, Read, Eq)
--need to give ints for it to make into valid new type

--It is common to use pattern matching to work with complex constructors
shift_up (Point x y) = Point x (y+1)
--ghci> shift_up (Point 1 1) gives Point 1 2
--ghci> :t shift_up gives shift_up :: Point -> Point

--example
move :: Point -> Direction -> Point
move (Point x y) North = Point x (y+1)
move (Point x y) South = Point x (y-1)
move (Point x y) East = Point (x+1) y
move (Point x y) West = Point (x-1) y
--ghci> move (Point 0 0) North gives Point 0 1

--Types can have multiple constructors each of which can have their own types
data Shape = Circle Float | Rect Float Float deriving (Show)
--ghci :t Circle 2.0 gives Circle 2.0 :: Shape
--ghci> :t Rect 3.0 4.0 gives Rect 3.0 4.0 :: Shape

--Example
area :: Shape -> Float
area (Circle radius) = pi * radius**2
area (Rect x y) = x * y
--ghci> area (Circle 2.0) gives 12.566371
--ghci> area (Rect 3.0 4.0) gives 12.0

--You can use data types to build custom records
data Person = Person String String Int String
get_first_name (Person x _ _ _) = x
get_second_name (Person _ x _ _) = x
get_age (Person _ _ x _) = x
get_nationality (Person _ _ _ x) = x
--ghci> get_age (Person "joe" "bloggs" 25 "UK") gives 25

{-
To make things easier, Haskell provides a record syntax
data Person = Person { firstName :: String,
                       secondName :: String,
                       age :: Int,
                       nationality :: String}
                                        deriving(Show)
ghci> Person "joe" "bloggs" 25 "UK" gives Person {firstName = "joe", secondName = "bloggs", age = 25, nationality = "UK"} 

When you use the record syntax, Haskell automatically creates
getter functions for each parameter
gchi let joe = Person "joe" "bloggs" 25 "UK"
gchi> firstName joe
"joe"
ghci> secondName joe
"bloggs"
-}

--Records can be created out of order (normal data types cannot)
data Example = Example { a :: String, b :: Int} deriving (Show)
--ghci> Example "one" 2 gives Example {a = "one", b = 2}
--ghci> Example {b = 3, a = "zero"} gives Example {a = "zero", b = 3}

--Example
data AdvShape = AdvCircle Point Float
    | AdvRect Point Point
                        deriving (Show)

area' (AdvCircle _ radius) = pi * radius**2
area' (AdvRect (Point x1 y1) (Point x2 y2)) =
    let
        w = abs (x1 - x2)
        h = abs (y1 - y2)
    in
        fromIntegral (w * h)
        --from intergral ints -> floats
--end of example





