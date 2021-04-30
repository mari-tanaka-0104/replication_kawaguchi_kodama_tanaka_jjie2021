clear all 
set more off
set mem 100m
set matsize 11000

use "$root/data/surveyweek.dta", clear
cd "$root/results" 

global ctitle_lift_med_c ctitle("Most-likely, expected, duration, of emergency, declaration")
global ctitle_lift_min_c ctitle("Shortest, expected, duration, of emergency, declaration")
global ctitle_lift_max_c ctitle("Longest, expected, duration, of emergency, declaration")
global ctitle_zerocase_med_c ctitle("Most-likely, expected, duration, of COVID-19, in Japan")
global ctitle_esalesg_q2_med ctitle("Expected, sales, growth, Q2,") 
global ctitle_elempg_pc_q2 ctitle("Expected, employment, growth, Q2,")  
global ctitle_pos_einv_q2 ctitle("Expected, investment, Q2,,") 

global x_all group2 
global x_susp group2_suspend group2_nonsuspend suspend 

global outlistspec1 se alpha(0.01, 0.05, 0.10) tex(fragment) nonotes nor2 drop($cont group2_suspend_school group2_school suspend_school school group2_suspend_other_service group2_other_service suspend_other_service other_service) bdec(2) sdec(2)  
global outlistspec2 se alpha(0.01, 0.05, 0.10) tex(fragment) nonotes nor2 drop($cont group2_suspend_school group2_school suspend_school school group2_suspend_other_service group2_other_service suspend_other_service other_service) bdec(3) sdec(3)  

** Table 4: Expected duration of the emergency declaration and COVID-19 by survey week
* (a) B-to-C service industries
global outlist outreg2 using week_susp_btoc_weighted_covid, $outlistspec1
global outlist2 outreg2 using week_susp_btoc_weighted_covid, $outlistspec2

local v lift_med_c
reg `v' $x_all [aweight = weight] if dservice_bc==1, rob 
$outlist label ${ctitle_`v'} replace
reg `v' $x_susp [aweight = weight] if dservice_bc==1,  rob 
test group2_nonsuspend group2_suspend
$outlist label ${ctitle_`v'} 

local v lift_min_c
reg `v' $x_all [aweight = weight] if dservice_bc==1,  rob 
$outlist label ${ctitle_`v'} 
local v lift_min_c
reg `v' $x_susp [aweight = weight] if dservice_bc==1,   rob 
test group2_nonsuspend group2_suspend
$outlist label ${ctitle_`v'} 

local v lift_max_c
reg `v' $x_all [aweight = weight] if dservice_bc==1, rob
$outlist label ${ctitle_`v'} 
local v lift_max_c
reg `v' $x_susp [aweight = weight] if dservice_bc==1,   rob 
test group2_nonsuspend group2_suspend
$outlist label ${ctitle_`v'} 

local v zerocase_med_c
reg `v' $x_all [aweight = weight] if dservice_bc==1,   rob 
$outlist label ${ctitle_`v'} 
local v zerocase_med_c
reg `v' $x_susp [aweight = weight] if dservice_bc==1,    rob 
test group2_nonsuspend group2_suspend
$outlist label ${ctitle_`v'} sortvar(group2 group2_suspend group2_nonsuspend suspend)


* (b) Other industries (B-to-B service and non-service industries) 
global outlist outreg2 using week_susp_btob_weighted_covid, $outlistspec1
global outlist2 outreg2 using week_susp_btob_weighted_covid, $outlistspec2

local v lift_med_c
reg `v' $x_all [aweight = weight] if dservice_bc==0,  rob 
$outlist label ${ctitle_`v'} replace

local v lift_min_c
reg `v' $x_all  [aweight = weight] if dservice_bc==0,    rob 
$outlist label ${ctitle_`v'}

local v lift_max_c
reg `v' $x_all  [aweight = weight] if dservice_bc==0,    rob 
$outlist2 label ${ctitle_`v'} 

local v zerocase_med_c
reg `v' $x_all  [aweight = weight] if dservice_bc==0,    rob 
$outlist2 label ${ctitle_`v'} 


** Table 5: Expected firm performance by survey week
* (a) B-to-C service industries
global outlist outreg2 using week_susp_btoc_weighted_firm, $outlistspec1
global outlist2 outreg2 using week_susp_btoc_weighted_firm, $outlistspec2

local v esalesg_q2_med
reg `v' $x_all [aweight = weight] if dservice_bc==1,  rob 
$outlist label  ${ctitle_`v'} replace

local v esalesg_q2_med
reg `v' $x_susp [aweight = weight] if dservice_bc==1,  rob 
$outlist label ${ctitle_`v'} 

local v elempg_pc_q2
reg `v' $x_all  [aweight = weight] if dservice_bc==1,    rob 
$outlist label ${ctitle_`v'}

local v elempg_pc_q2
reg `v' $x_susp [aweight = weight] if dservice_bc==1,   rob 
$outlist label ${ctitle_`v'}

local v pos_einv_q2
reg `v' $x_all  [aweight = weight] if dservice_bc==1,    rob 
$outlist2 label ${ctitle_`v'} 

local v pos_einv_q2
reg `v' $x_susp [aweight = weight] if dservice_bc==1,    rob 
$outlist2 label ${ctitle_`v'} sortvar(group2 group2_suspend group2_nonsuspend suspend)


* (b) Other industries (B-to-B service and non-service industries) 
global outlist outreg2 using week_susp_ifbtob_weighted_firm, $outlistspec1
global outlist2 outreg2 using week_susp_ifbtob_weighted_firm, $outlistspec2

local v esalesg_q2_med
reg `v' $x_all [aweight = weight] if dservice_bc==0,  rob 
$outlist label ${ctitle_`v'} replace

local v elempg_pc_q2
reg `v' $x_all [aweight = weight] if dservice_bc==0,    rob 
$outlist label ${ctitle_`v'}

local v pos_einv_q2
reg `v' $x_all [aweight = weight] if dservice_bc==0,    rob 
$outlist2 label ${ctitle_`v'} 




