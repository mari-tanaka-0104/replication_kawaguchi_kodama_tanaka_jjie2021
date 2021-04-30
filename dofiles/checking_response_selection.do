clear all
set more off
set mem 100m
set matsize 11000

use "$root/data/summary.dta", clear
cd "$root/results"
********************
* Response selection
********************
** Table A1: Response selection check of survey date 
preserve
* (a) Characteristics of respondents compared to individuals in sampling frame
global outlist outreg2 using "$root/results/balancingtest_survey_vs_businessmonitor.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) nocons nonotes excel bdec(2) sdec(2)
local replace replace

foreach var of varlist lntfirm_emp lntest_emp lntcapital lntsales tage male {
reg `var' respondent
sum `var' if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`respondent') `replace'
local replace
}

* (b) Characteristics of individuals in the analysis sample compared to respondents
keep if keep1==1
global outlist outreg2 using "$root/results/balancingtest_satisfyingcriteria_vs_all.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) nocons nonotes excel bdec(2) sdec(2) 
local replace replace

foreach var of varlist lntfirm_emp lntest_emp lntcapital lntsales tage male {
reg `var' keep3
sum `var' if e(sample)==1 
local m = r(mean)
$outlist addstat(Mean dep var, `m') label keep(`keep3') `replace'
local replace
}
restore
