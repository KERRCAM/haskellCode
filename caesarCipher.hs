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
--getFreqs not 100% s it gets scewed by any non low case letters, would fix this by changing above to be total length of letters not list

getFreqs _ 26 = []
getFreqs string c = freq (int2char c) string
                    : getFreqs string (c + 1)

chiSquared [] [] = 0 --will break on lists of different lengths
chiSquared (x:xs) (y:ys) =
    (x - y)**2/y + chiSquared xs ys

engFreqs = [0.0855, 0.0160, 0.0316, 0.0387, 0.1210,
            0.0218, 0.0209, 0.0496, 0.0733, 0.0022,
            0.0081, 0.0421, 0.0253, 0.0717, 0.0747,
            0.0207, 0.0010, 0.0633, 0.0673, 0.0894,
            0.0268, 0.0106, 0.0183, 0.0019, 0.0172,
            0.0011] 

chiSquaredString string =
    let
        string_freqs = getFreqs string 0
    in
        chiSquared string_freqs engFreqs



chiSquaredList _ 26 = []
chiSquaredList string i =
    let
        decoded = caesarDec string i
        score = chiSquaredString decoded
    in
        (score, decoded) : chiSquaredList string (i+1)

getBest [(score, string)] = (score, string)
getBest ((score, string):xs) =
    let
        (tail_score, tail_string) = getBest xs
    in
        if score < tail_score
        then (score, string)
        else (tail_score, tail_string)

caesarCrack string =
    let
        scores = chiSquaredList string 0
        (score, best) = getBest scores
    in
        best

