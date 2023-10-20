mult13 0 = 0
mult13 n = 13 + mult13 (n - 1)

pow3 0 = 1
pow3 n = 3 * pow3 (n - 1)

oddSum n
    | n == 1 = 1
    | mod n 2 == 1 = n + oddSum (n - 1)
    | otherwise = oddSum (n - 1)

lucas 0 = 2
lucas 1 = 1
lucas n = lucas (n - 1) + lucas (n - 2)

halfSum [x] = x / 2
halfSum (x:xs) = x * halfSum xs

