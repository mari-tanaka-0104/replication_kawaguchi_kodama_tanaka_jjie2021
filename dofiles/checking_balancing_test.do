clear all
set more off
set mem 100m
set matsize 11000

use "$root/data/summary.dta", clear
cd "$root/results"
********************
* balancing tests	
********************
** Table A3: Balancing test of survey date randomization 
* (a) Characteristics of respondents in later week compared to individuals in the analysis sample
preserve
keep if keep4==1
global outlist outreg2 using "$root/results/balancingtest_earlier_vs_later.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) nocons nonotes excel bdec(2) sdec(2) 
local replace replace 

foreach var of varlist lntfirm_emp lntest_emp lntcapital lntsales tage male {
reg `var' group2
sum `var' if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') `replace'
local replace
}

* (b) Characteristics of respondents in later week compared to individuals in the analysis sample (continued) 
global outlist outreg2 using "$root/results/balancingtest_earlier_vs_later_cont.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) nocons nonotes excel bdec(2) sdec(2)
reg type_solepro group2
sum type_solepro if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') replace ctitle("self-employed")

reg lifted_May14 group2
sum lifted_May14 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("lifted, on May 14")

reg salesg1 group2
sum salesg1 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("expected, sales growth, in Jan 2020, compared to, the last year")

reg salesg2 group2
sum salesg2 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("expected, sales growth, in Feb 2020, compared to, the last year")

reg salesg3 group2
sum salesg3 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("expected, sales growth, in March 2020, compared to, the last year")

reg salesg4 group2
sum salesg4 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("expected, sales growth, in April 2020, compared to, the last year")

reg pos_inv_q1 group2
sum pos_inv_q1 if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`group2') ctitle("investment, in Q1>0")
restore
