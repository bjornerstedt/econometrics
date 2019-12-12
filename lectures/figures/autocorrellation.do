clear
set seed 1
local obs 100
set obs `obs'
local rho .8

gen t = _n
tsset t
gen u = rnormal()

gen e = (u + `rho' * L.u) / sqrt( 1 + abs(`rho')) 

gen ea = .
replace ea = 0 in 1
forvalues i = 2/`obs' {
	quietly replace ea = u + `rho' * L.ea in `i'
}

twoway line ea t, 	///
	graphregion(color(white)) 	name(autocorr_neg, replace) ytitle(e) /// 
	title("No autocorrellation")
sum ea e

reg e t
reg ea t
newey e t , lag(3)
newey ea t , lag(3)
	
saveold autocorr , replace
exit
graph export autocorr_none.eps , name(autocorr_neg) replace
