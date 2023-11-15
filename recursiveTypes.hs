{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Redundant bracket" #-}


--In a recursive custom type, some constructors contain the type itself
--data IntList = Empty | Cons Int IntList
--                        deriving(Show)

{-
Empty -- []
Cons 1 (Empty) -- [1]
Cons 1 (Cons 2 Empty) -- [1,2]
-}

--Here is a more general list using a type variable
data List a = Empty | Cons a (List a)
                        deriving(Show)
--ghci> :t Cons 'a' (Cons 'b' Empty) -- ['a', 'b'] gives List Char
--ghci> :t Empty -- [] gives List a

{-
Two argument constructors can be made infix with backticks
ghci> 1 `Cons` (2 `Cons` Empty)
Cons 1 (Cons 2 Empty)
This just reimplements the standard Haskell syntax
ghci> 1 : (2 : [])
[1,2]
-}

--We can write functions for our custom list type
our_head :: List a -> a
our_head Empty = error "Empty list"
our_head (Cons x _) = x
--ghci> our_head (1 `Cons` (2 `Cons` Empty)) gives 1

our_tail :: List a -> List a
our_tail Empty = error "Empty list"
our_tail (Cons _ x) = x
--ghci> our_tail (1 `Cons` (2 `Cons` Empty)) gives Cons 2 Empty

--We can write recursive functions on recursive types
our_sum :: List Int -> Int
our_sum Empty = 0
our_sum (Cons x xs) = x + our_sum xs
--ghci> our_sum (1 `Cons` (2 `Cons` Empty)) gives 3

--Custom Lists
--So far we’ve just re-implemented the Haskell list type
--Here is a new list type that can contain two different types
data TwoList a b = TwoEmpty
    | ACons a (TwoList a b)
    | BCons b (TwoList a b)
               deriving (Show)
--gchi> :t 'a' `ACons` (False `BCons` TwoEmpty) gives TwoList Char Bool

--gets the length of a TwoList
mystery :: Num a1 => TwoList a2 b -> a1
mystery TwoEmpty = 0
mystery (ACons _ xs) = 1 + mystery xs
mystery (BCons _ xs) = 1 + mystery xs

--ignores all Bs in list and returns string of all As
mystery2 :: Show a => TwoList a b -> [Char]
mystery2 TwoEmpty = ""
mystery2 (ACons x xs) = (show x) ++ mystery2 xs
mystery2 (BCons _ xs) = mystery2 xs

--A tree type in Haskell
data Tree = Leaf | Branch Tree Tree deriving (Show)
--Branch Leaf (Branch Leaf Leaf)

--Recursion on trees
--We can write recursive functions that process trees
--Usually the recursive case will process both branches
size :: Tree -> Int
size (Leaf) = 1
size (Branch x y) = 1 + size x + size y
--ghci> size (Branch Leaf (Branch Leaf Leaf)) gives 5

--Trees with data
--Nodes in a tree often hold data
data DTree a = DLeaf a
    | DBranch a (DTree a) (DTree a)
                        deriving (Show)
--                        1
--                       / \
--                      7   4
--                     / \
--                    2   9
--DBranch 1 (DBranch 7 (DLeaf 2) (DLeaf 9)) (DLeaf 4)

--Recursion on trees with data
tree_sum :: Num a => DTree a -> a
tree_sum (DLeaf x) = x
tree_sum (DBranch x l r) = x + tree_sum l + tree_sum r
--ghci> tree_sum (DBranch 11 (DLeaf 2) (DLeaf 9)) gives 22

--Example: Fibonacci numbers
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib_tree :: Int -> Tree
fib_tree 0 = Leaf
fib_tree 1 = Leaf
fib_tree n = Branch (fib_tree (n-1)) (fib_tree (n-2))
--ghci> fib_tree 4 gives (on the example tree in slides)
--Branch (Branch (Branch Leaf Leaf) Leaf)
--                      (Branch Leaf Leaf)

{- 
Example: Fibonacci numbers
fib_calls n = size (fib_tree n)
ghci> fib_calls 10
177
ghci> fib_calls 20
21891
ghci> fib_calls 30
2692537
-}

{-
Example: Finding a file (IMPORTSNT)
Suppose that we have a directory structure
              home/
              /    \
          c.txt    docs/
          /    \
      a.txt   b.txt
-rite a function that, given a filename finds the path to that file
We can formulate the files as a data tree
let fs =
    DBranch "home/"
        (DBranch "docs/" (DLeaf "a.txt") (DLeaf "b.txt"))
        (DLeaf "c.txt")

Note that the file might not exist
I So we will use the maybe type
ghci> find_file "a.txt" fs
Just "home/docs/a.txt"
ghci> find_file "d.txt" fs
Nothing
-}

find_file file (DLeaf x)
    | x == file = Just file
    | otherwise = Nothing

find_file file (DBranch x l r) =
    let
        left = find_file file l
        right = find_file file r
    in
        case (left, right) of
            (Just y, _) -> Just (x ++ y)
            (_, Just y) -> Just (x ++ y)
            (_, _) -> Nothing

--
mystery3 :: (Num a, Ord a) => Tree -> a
mystery3 Leaf = 1
mystery3 (Branch l r) = 1 + max (mystery3 l) (mystery3 r)

--
mystery4 :: DTree [a] -> [a]
mystery4 (DLeaf x) = x
mystery4 (DBranch x l r) = mystery4 l ++ x ++ mystery4 r



