
clear
set seed 453

local obs 1000
set obs `obs'
gen x = _n
gen r = rnormal()*20
gen vf = (x-`obs'/2)^2/`obs'-93
gen e = vf+r
replace e = e+ 200 if x > 240 & x<260
replace e = e+ 200 if x > 740 & x<760
replace e = e+ 100 if x > 495 & x<505
reg e x
corr e x
gen e2 = r*vf/`obs'

* Histogram of residuals
hist e , freq ///
	graphregion(color(white)) 	name(error, replace)  ///
	title("Distribution of residuals")

* Scatterplot of residuals
twoway scatter e x || lfit e x , 	///
	graphregion(color(white)) 	name(smiley, replace) ///
	title("Plot residuals")

* Scatterplot of relationship
gen y = x+e
twoway scatter y x || lfit y x ,  ///
	graphregion(color(white)) 	name(fform, replace)  ///
	title("Non-linear relationship with outliers")
	
*exit

keep x y
saveold correllations , replace
graph export smiley.eps , name(smiley) replace
graph export fform.eps , name(fform) replace
graph export error.eps , name(error) replace
