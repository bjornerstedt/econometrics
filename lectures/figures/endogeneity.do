* Illustrate effects of correlation between e and x

clear
set seed 1
local obs 100
set obs `obs'
local rho 1

gen t = _n
tsset t
gen e = rnormal()*20

gen x = (t + `rho' * e)
gen x2 = (t - `rho' * e)

gen y = x + e
gen y2 = x2 + e

twoway  scatter e x, yline(0)	///
	graphregion(color(white)) 	name(errcorr, replace)  /// 
	title("Positive correlation between x and e")
	
twoway  scatter e x2, yline(0)	///
	graphregion(color(white)) 	name(errcorrneg, replace)  /// 
	title("Negative correlation between x and e")
	
twoway function x, range(-50 150)  ///
	|| lfit y x, 	|| scatter y x, 	///
	graphregion(color(white)) 	name(ovarbias, replace)  /// 
	title("Positive bias due to correlation") ///
	legend(label(1 "True relationship")) 
	
twoway function x, range(-25 125)  ///
	|| lfit y2 x2, 	|| scatter y2 x2, 	///
	graphregion(color(white)) 	name(ovarbiasneg, replace)  /// 
	title("Negative bias due to correlation") ///
	legend(label(1 "True relationship") label(3 "y")) 
	
graph export errcorr.eps , name(errcorr) replace
graph export errcorrneg.eps , name(errcorrneg) replace
graph export ovarbias.eps , name(ovarbias) replace
graph export ovarbiasneg.eps , name(ovarbiasneg) replace
