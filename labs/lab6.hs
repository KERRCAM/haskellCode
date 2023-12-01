{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Distribution.Simple.Utils (xargs)
import Data.Time.Format.ISO8601 (yearFormat)
{-# HLINT ignore "Redundant if" #-}
{-# HLINT ignore "Redundant bracket" #-}
{-# HLINT ignore "Use isNothing" #-}


--question 1
data Direction = North | East | South | West deriving (Show, Eq, Read, Ord)

isNorth :: Direction -> Bool
isNorth direction = if direction == North then True else False

dirToInt :: Direction -> Int
dirToInt direction
    | direction == North = 1
    | direction == East = 2 
    | direction == South = 3 
    | direction == West = 4


--question 2
data Point = Point Int Int deriving (Show, Eq)

same :: Int -> Point 
same x = Point x x

isZero :: Point -> Bool
isZero point = if point == Point 0 0 then True else False

multPoint :: Point -> Int 
multPoint (Point x y) = x * y

upTwo :: Point -> Point 
upTwo (Point x y) = Point x (y + 2)

addPoints :: Point -> Point -> Point 
addPoints (Point a b) (Point c d) = Point (a + c) (b + d)


--question 3 
notNothing :: Eq a => Maybe a -> Bool 
notNothing x = if x == Nothing then False else True

safeTail :: [a] -> Maybe [a] 
safeTail [] = Nothing 
safeTail (x:xs) = Just xs

multMaybe :: Maybe Int -> Maybe Int -> Maybe Int 
multMaybe Nothing (Just y) = Nothing 
multMaybe (Just x) Nothing = Nothing 
multMaybe (Just x) (Just y) = Just (x * y)


--question 4
returnTwo :: Int -> Either Bool Char 
returnTwo n = if n == 1 then Left True else Right 'a'

showRight :: Either String Int -> String 
showRight (Left x) = x
showRight (Right y) = show y 


--question 5
data List a = Cons a (List a) | Empty deriving (Show, Eq)

isEmpty :: List a -> Bool 
isEmpty Empty = True 
isEmpty _ = False

isSingle :: List a -> Bool 
isSingle (Cons _ Empty) = True
isSingle _ = False

mult :: List Int -> Int 
mult Empty = 1 -- with error of Empty list giving output as 1
mult (Cons x xs) = x * mult xs

--ourMap :: (a -> b) -> List a -> List b 
--ourMap 


--question 6