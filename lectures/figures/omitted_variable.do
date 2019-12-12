* Illustration of omitted variable bias - ok but not good
clear
local obs 500
set obs `obs'
gen i = _n
gen r = rnormal() // *20
gen e = rnormal()
gen x = ( r > 0)
gen y = x + e
reg y r x
reg y x
gen y0 = .
gen y1 = .
replace y0 = y if !x
replace y1 = y if x
label var y0 "x = 0"
label var y1 "x = 1"

* False relationship
twoway scatter y0 y1 r || lfit y r , 	///
	graphregion(color(white)) 	name(omitted, replace) ytitle(y)

	
* True relationship
twoway scatter y0 y1 x || lfit y x , 	///
	graphregion(color(white)) 	name(correct, replace)  


graph export omitted.eps , name(omitted) replace
graph export correct.eps , name(correct) replace

* Proxy var
