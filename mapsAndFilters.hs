--recap: transforming lists
double_list [] = []
double_list (x:xs) = 2 * x : double_list xs

square_list [] = []
square_list (x:xs) = x * x : square_list xs
