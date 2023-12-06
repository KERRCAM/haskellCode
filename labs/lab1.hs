
plusOne x = x + 1 

fiveSum x y = (x + y) * 5 

minusOne x = x - 1 

quadPow x = 4^x 

addThree x y z = x + y + z 

circleArea r = pi * (r^2) 

modThree x = mod x 3 

mod3Or5 x = ((mod x 3) == 0) || ((mod x 5) == 0) 

minMax a b c d = (min a b) ++ (max c d) 

--quadratic a b c = (-b + sqrt ((b^2) - (4*a*c)))0 / (2*a) need to fix
{- 
10: 
a) yes 
b) no 
c) yes 
-} 

gt100 x = if x > 100 then 1 else 0 

switch x y c = if c == 1 then x else y  

myMax x y = if x > y then x else y 

fizzbuzz x = if (mod3Or5 x) == True then "fizzbuzz" else "nope" 


q1 x = 
    let a = x*x in 
    2 * a 


q2 x = 
    let a = x + 1       
        b = a*a 
        c = 2^b  
    in   
        a + b - c


boundedSquare x = 
    let a = x*x in 
        if a < 100 then a else 100
                  
