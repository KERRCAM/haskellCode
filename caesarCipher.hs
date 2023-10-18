import Data.Char

char2int c = ord c - ord 'a'

int2char i = chr (i + ord 'a')

shift c offset =
    let
        converted = char2int c
        is_lower = converted >= 0 && converted < 26
    in
        if is_lower
        then int2char ((converted + offset) `mod` 26)
        else c

caesarEnc [] _ = []
caesarEnc (x:xs) offset = shift x offset
                            : caesarEnc xs offset

caesarDec :: [Char] -> Int -> [Char]
caesarDec (x:xs) offset = shift x (-offset)
                            : caesarDec xs offset

count _ [] = 0
count c (x:xs)
    | c == x = 1 + rest
    | otherwise = rest
    where rest = count c xs

freq c list = fromIntegral (count c list) / fromIntegral (length list)