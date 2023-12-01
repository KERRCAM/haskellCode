import Data.List

{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Redundant lambda" #-}
{-# HLINT ignore "Eta reduce" #-}

{- 
We can read a file using readFile
I This is an IO function
I We will study this in more detail later on
ghci> readFile "marks.csv"
"aaaa 70 65 67 60\nbbbb 55 60 55...
The '\n' character is the newline character

lines
The function lines gives us a list of lines
ghci> lines "line 1\nline 2\nline 3\n"
["line 1","line 2","line 3"]
ghci> file <- readFile "marks.csv"
ghci> lines file
["aaaa 70 65 67 60",
"bbbb 55 60 55 65", ...

unlines
The unlines function does the opposite
ghci> unlines ["line 1", "line 2", "line 3"]
"line 1\nline 2\nline 3\n"
ghci> unlines . lines $ file
"aaaa 70 65 67 60\nbbbb 55 60 55 65

unlines
The unlines function does the opposite
ghci> unlines ["line 1", "line 2", "line 3"]
"line 1\nline 2\nline 3\n"
ghci> unlines . lines $ file
"aaaa 70 65 67 60\nbbbb 55 60 55 65

Getting the averages
average :: [String] -> Float
average [student, a1, a2, a3, ct] =
(read a1 + read a2 + read a3 + read ct) / 4
ghci> let averages = map average parsed
ghci> averages
[65.5,58.75,40.0,68.75,25.0]

Getting the student names
name :: [String] -> String
name [student, _, _, _, _] = student
ghci> let names = map name parsed
ghci> names
["aaaa","bbbb","cccc","dddd","cccc"]
-}

average :: [String] -> Float --only accepts lists length 5
average [student, a1, a2, a3, ct] = (read a1 + read a2 + read a3 + read ct) / 4

name :: [String] -> String
name [student, _, _, _, _] = student

report_line :: String -> Float -> String
report_line student average = student ++ " " ++ show average

--ghci> unlines zipped
--"aaaa 65.5\nbbbb 58.75\ncccc 40.0\n..."
--ghci> writeFile "report.csv" (unlines zipped)

--All in one function
report file =
    let
        parsed = map words . lines $ file
        students = map name parsed
        averages = map average parsed
        zipped = zipWith report_line students averages
    in
        unlines zipped


--vote system
--First we need to figure out who the candidates are
uniq [] = []
uniq (x:xs) = x : uniq (filter (/=x) xs)

--This function counts the number of votes for a particular candidate
count x list = length (filter (==x) list)

--Vote totals
totals votes =
    let
        candidates = uniq votes
        f = (\ c -> (count c votes, c))
    in
        map f candidates

--Finding the winner
--Recall: tuples are ordered lexicographically
winner votes = (snd . maximum . totals) votes

{- 
Alternative vote
In the alternative vote system, voters rank the candidates
- In each round, the candidate with the least number of first
preference votes is eliminated
- The winner is the last candidate left once all others have been
eliminated
-}

--Getting the first choice votes
first_choice votes = map head votes

--Ranking the candidates
rank_candidates votes = sort . totals . first_choice $ votes

--Removing a losing candidate
remove_cand c votes =
    let
        rm_votes = map (filter (/=c)) votes
        rm_empty = filter (/=[]) rm_votes
    in
        rm_empty


--Putting it all together
{-
av_winner votes =
    let
        ranked = rank_candidates votes
        first = head ranked
    in
        if length ranked == 1
        then first
        else av_winner (remove_cand first votes)
-}
