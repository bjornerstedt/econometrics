clear
set seed 1
local obs 50
set obs `obs'

gen i = _n
local rho 0
matrix m = (2 , 2)
matrix v = (1 , `rho' \ `rho' ,1)

forvalues i = 1/1 {

drawnorm x y , means(m) cov(v) clear

* Large x variance
twoway lfitci y x || scatter y x , 	///
	graphregion(color(white)) 	name(corr, replace) ytitle(y) /// 
	title("Corr")
	
display "Press any key to continue " _request(yval)
}

if i == 1 {
graph export corr.eps , name(corr) replace
}
