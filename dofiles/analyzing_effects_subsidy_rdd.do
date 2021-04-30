clear all
set more off
set mem 100m
set matsize 11000
set scheme burd3

use "$root/data/rd_subsidy.dta", clear

** Figure 1: Covariate smoothness at the worst monthly sales changen of 50%
// smoothness of covariates
rdplot emp_q0 salesg_worst, c(-50) /*
	*/ graph_options(xtitle("The worst monthly sales change (%)") /*
	*/ ytitle("The number of employment at the end of 2019") /*
	*/ title("")) 
graph export "$root/results/smoothness_covariates_employment_salesg_worst.png", replace
rdplot ln_tcapital salesg_worst, c(-50) /*
	*/ graph_options(xtitle("The worst monthly sales change (%)") /*
	*/ ytitle("log of registered capital") /*
	*/ title("")) 
graph export "$root/results/smoothness_covariates_capital_salesg_worst.png", replace
rdplot ln_tsales salesg_worst, c(-50) /*
	*/ graph_options(xtitle("The worst monthly sales change (%)") /*
	*/ ytitle("log of registered sales") /*
	*/ title("")) 
graph export "$root/results/smoothness_covariates_sales_salesg_worst.png", replace


** Table 6: Effect of the probability of receiving the business continuation subsidy and short-time work compensation
* (a) Business continuation subsidy
eststo p_survive: rdrobust p_survive salesg_worst, c(-50) fuzzy(p_contsub) all
eststo elempg_q2: rdrobust elempg_q2 salesg_worst, c(-50) fuzzy(p_contsub) all
eststo pos_einv_q2: rdrobust pos_einv_q2 salesg_worst, c(-50) fuzzy(p_contsub) all
eststo pos_edisinv_q2: rdrobust pos_edisinv_q2 salesg_worst, c(-50) fuzzy(p_contsub) all
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2, label drop(Conventional Bias-corrected) star(* 0.1 ** 0.05 *** 0.01)
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_continuation_subsidy.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_continuation_subsidy.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
	
// b2c service only    (robustness check, not in print)
eststo p_survive: rdrobust p_survive salesg_worst if visits_change != ., c(-50) fuzzy(p_contsub) all
eststo elempg_q2: rdrobust elempg_q2 salesg_worst if visits_change != ., c(-50) fuzzy(p_contsub) all
eststo pos_einv_q2: rdrobust pos_einv_q2 salesg_worst if visits_change != ., c(-50) fuzzy(p_contsub) all
eststo pos_edisinv_q2: rdrobust pos_edisinv_q2 salesg_worst if visits_change != ., c(-50) fuzzy(p_contsub) all
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2, label drop(Conventional Bias-corrected)
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_continuation_subsidy_btoc.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_continuation_subsidy_btoc.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")		
	
* (b) Short-time work compensation
eststo p_survive: rdrobust p_survive salesg4 if emp_q0 > 0, c(-5) fuzzy(p_empsub) all
eststo elempg_q2: rdrobust elempg_q2 salesg4 if emp_q0 > 0, c(-5) fuzzy(p_empsub) all
eststo pos_einv_q2: rdrobust pos_einv_q2 salesg4 if emp_q0 > 0, c(-5) fuzzy(p_empsub) all
eststo pos_edisinv_q2: rdrobust pos_edisinv_q2 salesg4 if emp_q0 > 0, c(-5) fuzzy(p_empsub) all
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2, label
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_employment_subsidy.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab p_survive elempg_q2 pos_einv_q2 pos_edisinv_q2 /*
	*/ using "$root/results/rd_employment_subsidy.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")



** Table 7: Effect of the probability of receiving the business continuation subsidy on firm behaviors
forvalues i = 1/9 {
	eststo cope`i': rdrobust cope`i' salesg_worst, c(-50) fuzzy(p_contsub) all
}
* (a) Passive measures
esttab cope4 cope6 cope5 cope7 cope8 /*
	*/ using "$root/results/rd_continuation_subsidy_cope_stop.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01)  drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab cope4 cope6 cope5 cope7 cope8 /*
	*/ using "$root/results/rd_continuation_subsidy_cope_stop.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
	
* (b) Active measures	
esttab cope1 cope2 cope3 cope9 /*
	*/ using "$root/results/rd_continuation_subsidy_cope_continue.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab cope1 cope2 cope3 cope9 /*
	*/ using "$root/results/rd_continuation_subsidy_cope_continue.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")

	
** Table 8: Effect of the probability of receiving short-time work compensation on firm behaviors at the cutoff of April sales change being below -5%
forvalues i = 1/9 {
	eststo cope`i': rdrobust cope`i' salesg4 if emp_q0 > 0, c(-5) fuzzy(p_empsub) all
}
* (a) Passive measures
esttab cope4 cope6 cope5 cope7 cope8 /*
	*/ using "$root/results/rd_employment_subsidy_cope_stop.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab cope4 cope6 cope5 cope7 cope8 /*
	*/ using "$root/results/rd_employment_subsidy_cope_stop.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")

* (b) Active measures
esttab cope1 cope2 cope3 cope9 /*
	*/ using "$root/results/rd_employment_subsidy_cope_continue.tex", label replace /*
	*/ booktabs se /*
	*/ nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
esttab cope1 cope2 cope3 cope9 /*
	*/ using "$root/results/rd_employment_subsidy_cope_continue.csv", label replace /*
	*/ se nonotes star(* 0.1 ** 0.05 *** 0.01) drop(Conventional Bias-corrected) coeflabels(Robust "Subsidy probability")
	
