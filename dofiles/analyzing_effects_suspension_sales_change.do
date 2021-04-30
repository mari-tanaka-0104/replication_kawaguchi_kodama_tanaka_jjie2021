clear all
set more off
set mem 100m
set matsize 11000
set maxvar 10000
set scheme burd3

use "$root/data/suspension_request.dta", clear
tsset sampleid month  
cd "$root/results" 

******* Table 2: Effects of the suspension requests on sales change from March to April
global outlist outreg2 using "$root/results/susp_sales34_weighted.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) ///
nor2 nonotes bdec(2) sdec(2) ctitle("Sales change") nocons ///
keep(pos_susp risk new_infection_diff school_pos_susp travel_hotel_pos_susp school travel_hotel salesg_diff_lg) 

reg salesg_diff pos_susp risk new_infection_diff [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, NO) label replace 

reg salesg_diff pos_susp i.pref risk new_infection_diff [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg school_pos_susp travel_hotel_pos_susp school travel_hotel  [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label

******* Table 3: Effects of the suspension requests on sales change from March to April: Heterogeneity by firm type
global outlist outreg2 using "$root/results/susp_sales34_weighted_heterogeneity.tex", se alpha(0.01, 0.05, 0.10) tex(fragment) ///
nor2 nonotes bdec(2) sdec(2) ctitle("Sales change") nocons ///
keep(pos_susp risk new_infection_diff other_service_pos_susp salesg_diff_lg ///
no_emp_pos_susp no_emp selfemp_pos_susp freelance_pos_susp selfemp freelance emergency_Apr7_pos_susp emergency_Apr7 pos_susp_suspsub) 

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg no_emp_pos_susp no_emp [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label replace

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg selfemp_pos_susp freelance_pos_susp selfemp freelance [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg emergency_Apr7_pos_susp emergency_Apr7 [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label

reg salesg_diff pos_susp i.pref risk new_infection_diff salesg_diff_lg pos_susp_suspsub [aweight = weight] if month == 4 & service == 1, vce(cluster pref) 
sum salesg_diff if e(sample)==1 & pos_susp==1 [aw=weight]
local m1 = r(mean) 
sum salesg_diff if e(sample)==1 & pos_susp==0  [aw=weight]
local m0 = r(mean) 
$outlist addstat(Mean (Suspension request), `m1', Mean (No suspension request), `m0') addtext(Pref FE, YES) label



