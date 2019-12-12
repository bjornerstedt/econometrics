* Show how variance covariance varies
* Small and large homoscedastic error
* Small and large variance in x
* Bernouilli distribution to show that errors do not have to be normal
* Monte carlo of negative correllations
clear
set seed 333
local obs 200
set obs `obs'
gen i = _n
gen r = runiform() 
gen e = rnormal()

gen x1 = 10*r
gen x2 = 4 + 2*r
gen y1 = x1 + e
label var x1 "x"
label var x2 "x"
label var y1 "y"

* Large x variance
twoway lfitci y1 x1 || scatter y1 x1 , 	///
	graphregion(color(white)) 	name(ldisp, replace) ytitle(y) /// 
	xscale(range(0 10))  yscale(range(0 15)) title("Linear regression with small uncertainty")
	
* Large variance
replace y1 = x1 + e *3
twoway lfitci y1 x1 || scatter y1 x1 , 	///
	graphregion(color(white)) 	name(lvar, replace) ytitle(y) /// 
	xscale(range(0 10))  yscale(range(0 15)) title("Large variance increases uncertainty")
	
* Small x variance
gen y2 = x2 + e
label var y2 "y"
twoway lfitci y2 x2 ,  range(0 10)  || scatter y2 x2 , 	///
	graphregion(color(white)) 	name(sdisp, replace) ytitle(y) /// 
	xscale(range(0 10))  yscale(range(0 15)) title("Small variance in x")

* Errors do not have to be normal
gen s = (rbinomial(1,.5)-0.5)*2
gen y3 = x1+s
label var y3 "y"
twoway scatter y3 x1 || lfitci y3 x1 ,  ///
	graphregion(color(white)) 	name(nonnormal, replace)  ///
	title("Error term is not normally distributed") 

reg y3 x1
predict yhat 
gen residual = y3 - yhat
hist residual , bin(40) ///
	graphregion(color(white)) 	name(nnresid, replace)  ///
	title("Residuals are not normally distributed") 



graph export ldisp.eps , name(ldisp) replace
graph export lvar.eps , name(lvar) replace
graph export sdisp.eps , name(sdisp) replace
graph export nonnormal.eps , name(nonnormal) replace
graph export nnresid.eps , name(nnresid) replace

