* Illustration of bias of sd with heteroscedasticity 
clear
set seed 1
local obs 100
local rho 1
local delta 1 
tempfile increasing decreasing

set obs `obs'
gen x = _n
gen u = rnormal()
gen e = (`delta' + `rho' * x )* u
save `increasing'

replace u = rnormal()
replace e = (`delta' + `rho' * ( `obs' + 1 - x ) )* u
save `decreasing'

use `decreasing'
replace x = x + `obs'
append using `increasing'
sort x
twoway lfitci e x, est(vce(robust))   || scatter e x , ///
	graphregion(color(white)) 	name(hetcenter, replace) ytitle(e) /// 
	title("Variability close to mean")
reg e x , robust

use `increasing' , clear
replace x = x + `obs'
append using `decreasing'
sort x
twoway lfitci e x, est(vce(robust))  || scatter e x , ///
	graphregion(color(white)) 	name(hetedges, replace) ytitle(e) /// 
	title("Variability far from mean")
reg e x , robust

graph export hetcenter.eps , name(hetcenter) replace
graph export hetedges.eps , name(hetedges) replace
