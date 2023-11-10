{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Replace case with fromMaybe" #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Use lambda" #-}
import Prelude hiding (Right, Left, Nothing, Just)
{-# HLINT ignore "Use camelCase" #-}

--We can use type variables in custom types
data Point a = Point a a
--ghci> :t Point (1::Int) (2::Int) gives Point Int
--ghci> :t Point "hello" "there" gives Point [Char]

--We can use multiple variables in the same type
data Things a b c = Things a b c deriving(Show)
--ghci> Things "string" 1 True gives Things "string" 1 True
--ghci> Things [] 1.5 'a' gives Things [] 1.5 'a'

--We can write functions using these types
first_thing (Things x _ _) = x
--ghci> first_thing (Things 1 2 3) gives 1
--ghci> :t first_thing gives first_thing :: Things a b c -> a

--The Maybe type
data Maybe a = Just a | Nothing
--ghci> :t Just "hello" gives Maybe [Char]
--ghci> :t Just False gives Maybe Bool
--ghci> :t Nothing gives Maybe a

--The Maybe type is used in pure functional code that might fail
safe_head [] = Nothing
safe_head (x:_) = Just x
--ghci> safe_head [1,2,3] gives Just 1
--ghci> safe_head [] gives Nothing

--Case expressions
--case expressions can do pattern matching in functions
head_or_zero list =
    let
        h = safe_head list
    in
        case h of Just x -> x
                  Nothing -> 0
--ghci> head_or_zero [1,2,3] gives 1

{-
The syntax for a case expression is
case [expression] of [pattern 1] -> [expression]
                     [pattern 2] -> [expression]
                     ...
                     [pattern k] -> [expression]
You can use _ (the wildcard) as a catch-all
-} 

--You can write all the patterns on one line
--case h of {Just x -> x; Nothing -> 0}
--Case is an expression
--ghci> (case 1 of 1 -> 1) + (case 2 of 2 -> 1) gives 2

--Maybe example
safe_get_heads list =
    let
        mapped = map safe_head list
        filtered = filter (/=Nothing) mapped
        unjust = (\ x -> case x of Just a -> a)
    in
        map unjust filtered
--ghci> safe_get_heads [[], [1], [2,3]] gives [1,2]

--safe division function (stops divide by 0 error)
mystery x 0 = Nothing
mystery x y = Just (div x y)

--gives true if given nothing
mystery2 x = case x of Just _ -> False
                       Nothing -> True

--adds together x and y but returns nothing is either is nothing, so safe addition
mystery3 (Just x) (Just y) = Just (x+y)
mystery3 _ _ = Nothing

{-
Exceptions in Haskell
Haskell does include support for exceptions
ghci> head [] gives *** Exception: Prelude.head: empty list
Exceptions are not pure functional
- Every function returns exactly one value
- You can’t catch exceptions in pure functional code
- Exceptions are mostly used in IO code

The Maybe type provides a way to do exception-like behaviour in
pure functional code
Can this function fail for some inputs?
- use the Maybe type
Exceptions should only be used in IO code
- File not found, could not connect to server, etc.
- These are unpredictable events
-}

--The Either type
data Either' a b = Left a | Right b
--ghci> :t Left 'a' gives Either Char b
--ghci> :t Right 'b' gives Either a Char

--The either type is useful if you want to store different types in the same list
--ghci> let list = [Left "one", Right 2, Left "three", Right 4]
is_left (Left _) = True
is_left _ = False
--ghci> map is_left list gives [True,False,True,False]

get_lefts list =
    let
        filtered = filter is_left list
        unleft = (\ (Left x) -> x)
    in
        map unleft filtered
--ghci> get_lefts list gives ["one","three"]

--Example: squaring mixed number types
--ghci> let nums = [Left pi, Right (4::Int), Left 2.7182]
square (Left x) = Left (x ** 2)
square (Right x) = Right (x ^ 2)
--ghci> map square nums gives [Left 9.86,Right 16,Left 7.38]

--Meaningful error messages
--Either can be used to give detailed errors
safe_head_either [] = Right "empty list"
safe_head_either (x:_) = Left x
--ghci> safe_head_either [] gives Right "empty list"
--ghci> safe_head_either [1,2,3] gives Left 1

--Exercise
--What are the types of these functions?
is_nothing :: Main.Maybe a -> Bool
is_nothing x = case x of Just _ -> False
                         Nothing -> True
                         
second_thing :: Things a b c -> b
second_thing (Things _ y _) = y

half :: (Fractional a, Integral b) => Either' a b -> Either' a b
half (Left x) = Left (x / 2)
half (Right x) = Right (x `div` 2)

