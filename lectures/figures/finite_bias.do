* Biased estimation with uncorrelated but not mean independent errors
clear
set seed 453

local obs 10000
local sampobs 5 // Increase to 500 to get close to unbiased estimate

set obs `obs'
gen x = .
gen r = .
gen e = .

replace x = rnormal(0,2)
replace r = rnormal()*2
replace e = x^3-12*x + r

* Scatterplot of residuals
twoway scatter e x || lfit e x , 	///
	graphregion(color(white)) 	name(crooked, replace) ///
	title("Biased estimation as not mean independent")
	
* Variables x and e are uncorrelated
corr x e

tempname memhold
tempfile results

postfile `memhold' b using `results'

forvalues i=1/1000 {
quietly {
preserve
sample `sampobs' , count
reg e x , nocons
di _b[x]
post `memhold' (_b[x])
restore
}
}
postclose `memhold'
use `results' , clear

* The estimate is biased
sum b

* Histogram of residuals
hist b , freq ///
	graphregion(color(white)) 	name(bdist, replace)  ///
	title("Distribution of estimates")

* Scatterplot of residuals
	
exit

keep x y
saveold correllations , replace
graph export crooked.eps , name(crooked) replace
