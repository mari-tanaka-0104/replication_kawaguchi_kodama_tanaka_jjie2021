clear all
set more off
set mem 100m
set matsize 11000
set scheme burd3

use "$root/data/expected_date_lifting.dta", clear 
cd "$root/results"

***************************************
* "Surveyed on May 8-9" vs. "Surveyed on May 15-16"	
// Timing of lifting emergency declaration (Q4) 
foreach var of varlist lift_med lift_min lift_max {
gen `var'_group1 = `var' if group2==0
gen `var'_group2 = `var' if group2==1

format `var'_group1 %tdDD_Mon 
format `var'_group2 %tdDD_Mon 
}

******************************************************************************
*** subsample comparison: describe the distribution
******************************************************************************
keep sampleid keep4 lift_med* lift_min* lift_max* group2
keep if keep4==1 

di mdy(7, 22, 2020) //22118
di mdy(7, 23, 2020) //22119
di mdy(1, 1, 1960) //0

******************************************************
* "Surveyed on May 8-9" vs. "Surveyed on May 15-16"	
******************************************************

** Figure 2: Expectations about when the emergency declaration would be lifted in all prefectures by survey week
foreach duration in med min max {
twoway (hist lift_`duration'_group1, frac width(7) start(22046) xlabel(22046(7)22170, angle(vertical))) (hist lift_`duration'_group2, frac fcolor(none) lcolor(black) width(7) start(22046) xlabel(22046(7)22170, angle(vertical))) if (lift_`duration'>=22046 & lift_`duration'<=22170), xtitle("Timing of lifting emergency declaration") legend(order(1 "Surveyed on May 8-9" 2 "Surveyed on May 15-16")) scheme(burd5) 
graph export expected_date_of_lifting_declaration_`duration'.png, replace 
}
