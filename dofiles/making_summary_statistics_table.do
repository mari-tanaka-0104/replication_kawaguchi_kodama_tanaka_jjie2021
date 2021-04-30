clear all
set more off
set mem 100m
set matsize 11000

use "$root/data/summary.dta", clear
cd "$root/results"

********************
* summary statistics	
********************

keep if keep4==1

** Table A2: Summary statistics (without weight)
xi: estpost summ emp_q1 num_employee_cat0 num_employee_cat1 num_employee_cat2 num_employee_cat3 num_employee_cat4 num_employee_cat5 ind_cat1 ind_cat2 ind_cat3 tage D20s D30s D40s D50s D60s D70s male salesg1 salesg2 salesg3 salesg4 salesg_q1 esalesg_q2_med esalesg_q3_med esalesg_q4_med pos_inv_q1 pos_disinv_q1 pos_einv_q2 pos_edisinv_q2 p_survive p_contsub p_empsub p_suspsub p_olympic
esttab ., cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) booktabs
esttab . using "$root/results/summary_stat.csv", replace cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) 
esttab . using "$root/results/summary_stat.tex", replace cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) booktabs 

** Table 1: Summary statistics
xi: estpost summ emp_q1 num_employee_cat0 num_employee_cat1 num_employee_cat2 num_employee_cat3 num_employee_cat4 num_employee_cat5 ind_cat1 ind_cat2 ind_cat3 tage D20s D30s D40s D50s D60s D70s male salesg1 salesg2 salesg3 salesg4 salesg_q1 esalesg_q2_med esalesg_q3_med esalesg_q4_med pos_inv_q1 pos_disinv_q1 pos_einv_q2 pos_edisinv_q2 p_survive p_contsub p_empsub p_suspsub p_olympic [aw=weight]
esttab ., cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) booktabs
esttab . using "$root/results/summary_stat_weighted.csv", replace cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) 
esttab . using "$root/results/summary_stat_weighted.tex", replace cell("mean(fmt(%9.2f)) sd(fmt(%9.2f)) min(fmt(%9.0f)) max(fmt(%9.0f))") nomtitle nonumber label varwidth(40) booktabs 
