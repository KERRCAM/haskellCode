-- A higher order function is a function that:
    -- Takes another function as an argument, or
    -- Returns a function


applyTwice :: (a -> a) -> a -> a
applyTwice f input = f (f input)

compose :: (b -> c) -> (a -> b) -> a -> c
compose f g input = f (g input)
--compose (+1) (*2) 4 gives 9 

{- 
In Haskell compose is implemented by the . operator
ghci> compose head head [[1,2], [3,4]]
1
ghci> (head . head) [[1,2], [3,4]]
1
ghci> :t (.)
(.) :: (b -> c) -> (a -> b) -> a -> c 

example function: 
f list = length (double (drop_evens (tail list)))
f' list = (length . double . drop_evens . tail) list
-}

-- $ operator
evaluate :: (a -> b) -> a -> b
evaluate f input = f input 

{- 
The $ operator is exactly the same as evaluate
ghci> ($) length [1,2,3]
3
ghci> length $ [1,2,3]
3
ghci> :t ($)
($) :: (a -> b) -> a -> b

The $ operator has the lowest precedence of all operators
- It is mainly used to avoid brackets
ghci> length ([1,2,3] ++ [4,5,6])
6
ghci> length $ [1,2,3] ++ [4,5,6]
6
ghci> (length . tail) [1,2,3,4]
3
ghci> length . tail $ [1,2,3,4]
3
-}

--applies f three times
mystery :: (a -> a) -> a -> a
mystery f input = (f . f . f) input

--takes same input for f and g and add outputs
mystery2 :: (a -> Int) -> (a -> Int) -> a -> Int
mystery2 f g input = f input + g input

--
mystery3 :: (a -> b -> c) -> a -> b -> c
mystery3 f in1 in2 = in1 `f` in2

{- 
Anonymous functions
Sometimes it is convenient to define a function inline
ghci> (\x -> x + 1) 2
3
ghci> :t (\x -> x+1)
(\x -> x+1) :: Num a => a -> a
ghci> apply_twice (\x -> 2 * x) 2
8
These are called anonymous functions: they have no name

The syntax for an anonymous function is:
\ [arg1] [arg2] ... -> [expression]
The \ is supposed to resemble a lambda (λ)
I Anonymous functions are sometimes called λ-functions
Examples:
\ x y -> x + y + 1
\ list -> head list + last list
-}

--Higher order functions can also return other functions
fThatAddsn :: Int -> (Int -> Int)
fThatAddsn n = (\ x -> x + n)

swap :: (a -> b -> c) -> (b -> a -> c)
swap f = \ x y -> f y x

--This is just nicer syntax for a function that returns a function (currying)
addTwo = (+2)
addTwo' = (\ x -> x + 2)
dropSix = drop 6
dropSix' = (\ x -> drop 6 x)

