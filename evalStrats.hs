--EVALUATION STRATEGIES--

{-
Motivating example
inc x = x + 1
square x = x * x
So square (inc 2) = (2 + 1) * (2 + 1) = 9
How does Haskell evaluate this?

Strict Evaluation
In strict evaluation, we always apply the innermost functions first
square (inc 2)
→ square (3)
→ 3 * 3
→ 9
First apply inc then apply square

Lazy Evaluation
In lazy evaluation, we always apply the outermost functions first
square (inc 2)
→ inc 2 * inc 2
→ 3 * 3
→ 9
First apply square then apply inc
-}

{-
Lazy Evaluation
In the following, nothing is computed until we ask for the value of z
ghci> let x = 1 + 1
ghci> let y = x + x
ghci> let z = y / 2
ghci> z
2.0
ghci> let x = 1 + undefined
ghci> let y = x + x
ghci> let z = y / 2
ghci> z
*** Exception: Prelude.undefined

If a value is never used, it is never computed
ghci> let f x = 1
ghci> f 2
1
ghci> f 3
1
ghci> f undefined
1
-}

{-
Imperative languages
Imperative languages are always strict
I So programmers know the order of side effects
def inc(x):
print "hi from inc"
return x + 1
def square(x):
print "hi from square"
return x * x
>>> print square(inc(2))
hi from inc
hi from square
9

Functional languages
For pure functions the order of evaluation is irrelevant.
I You will always get the same answer
I No need to worry about side effects
Some functional programming languages are strict by default
I eg. ML, Ocaml
Others are lazy by default
I eg. Haskell
-}

{-
Lazy vs. Strict
If strict evaluation finds an answer, then lazy evaluation will find
the same answer
Sometimes lazy evaluation can find an answer when strict can’t
ghci> fst (1, 1 `div` 0)
1
Strict evaluation would crash on this example

Sometimes lazy evaluation can be more efficient than strict
I Particularly if some values are computed but never used
double (x, y) = (2*x, 2*y)
ghci> fst (double (3, 4))
6
Lazy evaluation produces:
fst (double (3, 4))
→ 2 * 3
→ 6


Lazy computation
Lazy evaluation only ever computes a value when it is needed
ghci> let x = 1 `div` 0
ghci> x
*** Exception: divide by zero
This can lead to big efficiency savings, eg. in
ghci> head (map (*2) [1..100])
2
Lazy evaluation just computes 2 * 1

Lazy vs. Strict summary
Strict evaluation
I Evaluate things as soon as possible
I Gives certainty over order of side effects
Lazy evaluation
I Evaluate things only when they are needed
I Potentially eliminates unneeded computation
-}

{-
Exercise
What are the outputs for the following queries?
ghci> fst (1, error "error")
1

ghci> show [10 `div` 2, 10 `div` 1, 10 `div` 0]
"[5,10,*** Exception: divide by zero
can see it started to output a string and then got an error

ghci> let x = []
ghci> let y = head x
ghci> let z = y `div` 0
ghci> z
only gives an error on evaluation when calling z and will get divide by 0 error first
-}

{-
Laziness and lists
Lists are never evaluated until they are needed
take 2 [1..100]
→ 1 : take 1 [2..100]
→ 1 : 2 : take 0 [3..100]
→ 1 : 2 : []
→ [1,2]
take 2 [1..10] is as efficient as take 2 [1..1000]
-}

{-
Infinite lists
Laziness allows for infinite lists
all_1s = 1 : all_1s
ghci> take 4 all_1s
[1,1,1,1]
all_1s is the same as [1,1..]

Laziness allows us to do infinite computations on infinite lists
all_1s = 1 : all_1s
all_2s = zipWith (+) all_1s all_1s
ghci> take 4 all_2s
[2,2,2,2]

numbers n = n : numbers (n+1)
ghci> take 10 (numbers 0)
[0,1,2,3,4,5,6,7,8,9]
even_numbers = filter even (numbers 0)
ghci> take 10 even_numbers
[0,2,4,6,8,10,12,14,16,18]

sieve (x:xs) = x : filter (\y -> y `mod` x /= 0)
(sieve xs)
primes = sieve [2..]
ghci> take 10 primes
[2,3,5,7,11,13,17,19,23,29]
ghci> primes !! 1000
7927
-}

{-
Recap: The evaluation operator
The $ operator evaluates a function
ghci> head $ [1,2,3,4]
1
ghci> tail $ [1,2,3,4]
[2,3,4]

Strict evaluation
The $! operator does strict evaluation
I For most code you won’t notice the difference
I But it can change the error outputs
func a b = if a then b else 0
ghci> func False $ (error "error")
0
ghci> func False $! (error "error")
*** Exception: error
-}