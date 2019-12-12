* Bias from measurement error
clear
set seed 1
local obs 30
set obs `obs'

gen xs = _n

gen e = rnormal()*1
gen u = rnormal()*10

gen x = (xs - u)

gen y = xs + e

twoway lfit y xs || lfit y x || scatter y xs || scatter y x , 	///
	graphregion(color(white)) 	name(measurement, replace)  /// 
	title("Bias measurement error") ///
	 legend(label(3 "Without errors") label(4 "With errors") ///
	 label(1 "True relationship") label(2 "Estimated relationship")) 
	
graph export measurement.eps , name(measurement) replace
