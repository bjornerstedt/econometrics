* Show how variance covariance varies
* Small and large homoscedastic error
* Small and large variance in x
* Bernouilli distribution to show that errors do not have to be normal
* Monte carlo of negative correllations
clear
set seed 333
local obs 50
local offset 0
local yoffset 10
local b .1
set obs `obs'
gen i = _n
gen x1 = `obs' * runiform() 
gen x2 = `offset' +`obs' * runiform() 
gen e = rnormal()

gen y1 = `b' * x1 + e + 10
gen y2 = `b' * x2 + e + 10 + `yoffset'
label var x1 "x"
label var x2 "x"
label var y1 "y"

* Large x variance
twoway lfit y1 x1 || scatter y1 x1  || lfit y2 x2 || scatter y2 x2 , 	///
	graphregion(color(white)) 	name(randomeffects, replace) ytitle(y) /// 
	title("Correlation and fixed effects")

*graph export fixedeffects.eps , name(fixedeffects) replace
graph export randomeffects.eps , name(randomeffects) replace
exit
xscale(range(0 10))  yscale(range(0 15)) 
graph export lvar.eps , name(lvar) replace
graph export sdisp.eps , name(sdisp) replace
graph export nonnormal.eps , name(nonnormal) replace
graph export nnresid.eps , name(nnresid) replace

