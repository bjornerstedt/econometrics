clear
tempname memhold
tempfile means
postfile `memhold' s using `means' 

*set seed 333
local obs 200
local reps 10000
set obs `obs'
gen s = .

forvalues i = 1/`reps' {
quietly replace s = (rbinomial(1,.5)-0.5)*2
sum s , meanonly
post `memhold' (r(mean) )
}
postclose `memhold'

use `means' , clear
if `obs' < 200 {
hist s , bin(20)  
}
else {
hist s , bin(50)  normal 
}
