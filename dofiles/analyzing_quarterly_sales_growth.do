clear all
set more off
set mem 100m
set matsize 11000

use "$root/data/quarterly_salesg.dta", clear
cd "$root/results" 
** Table 9: Difference-in-difference for quarterly sales growth: COVID-19, vaccine, and Olympics
global outlist outreg2 using did_quarterly_sales_growth, se alpha(0.01, 0.05, 0.10) tex(fragment) excel nor2 bdec(2) sdec(2) nocons nonotes

areg salesg_q zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4 i.quarter [aw=weight], a(sampleid) cluster(sampleid)
$outlist addtext(Firm FE, YES,Quarter FE, YES, Optimism proxiy, NO, Industry-Quarter FE, NO) ///
label ctitle(Sales, growth, Q1--Q4) keep(zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4) replace

areg salesg_q zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4 zerocase_med_c_aftq2 vaccine_med_c_aftq2 i.quarter [aw=weight], a(sampleid) cluster(sampleid)
$outlist addtext(Firm FE, YES,Quarter FE, YES, Optimism proxiy, YES, Industry-Quarter FE, NO) label ctitle(Sales, growth, Q1--Q4) keep(zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4)

areg salesg_q zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4  i.quarter [aw=weight] if quarter>=2, a(sampleid) cluster(sampleid)
$outlist addtext(Firm FE, YES,Quarter FE, YES, Optimism proxiy, NO, Industry-Quarter FE, NO) label ctitle(Sales, growth, Q2--Q4) keep(zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4 )

areg salesg_q zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4  i.quarter#i.tindustry [aw=weight] if quarter>=2, a(sampleid) cluster(sampleid)
$outlist addtext(Firm FE, YES,Quarter FE, NO, Optimism proxiy, NO, Industry-Quarter FE, YES) label ctitle(Sales, growth, Q2--Q4) keep(zerocase_after zerocase_after_pr vaccine_after vaccine_after_pr p_olympic_q3 p_olympic_q4 )

