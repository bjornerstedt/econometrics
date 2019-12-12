use "C:\Users\n13017\Dropbox\Undervisning\Econometrics\Stata_files\Table17_1.dta", clear
xtset ind time

xtline charity, overlay legend(off) ///
	graphregion(color(white))	name(charity, replace) ytitle(Charity) /// 
	title("Charity contributions over time")

graph export charity.eps , name(charity) replace
