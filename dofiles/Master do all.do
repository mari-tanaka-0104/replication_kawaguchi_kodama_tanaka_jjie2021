*Running "Master do all.do" will create all of the graphs and tables, saved in results folder.
*Before running "Master do all.do", you need to set folder-located directory as "root" using global command.  

clear all
*global root "~/replication_2021" 
cd "$root/dofiles"

***********************************************
*Summary statistics 
***********************************************
do "making_summary_statistics_table.do"
*makes tables of summary statistics: Table 1 and Table A2 

***********************************************
*Response selection
***********************************************
cd "$root/dofiles"
do "checking_response_selection.do"
*checks responce selection of survey date: Table A1

***********************************************
*Balance tests 
***********************************************
cd "$root/dofiles"
do "checking_balancing_test.do"
*runs balancing test of survey week randomization: Table A3

***********************************************
*regressions and figures
***********************************************
cd "$root/dofiles"
do "analyzing_effects_suspension_sales_change.do"
*runs regressions for estimating effects of suspension request on firms' sales change from March to April: Table 2 and Table 3 

cd "$root/dofiles"
do "analyzing_expected_declaration_by_survey_week.do"
*runs regressions for expected duration of the emergency declaration, COVID-19, and firm performance by survey week 

cd "$root/dofiles"
do "analyzing_effects_subsidy_rdd.do"
*runs regressions for estimating effects of subsidy on firms' survival probability and behaviors: Table 6, 7, 8 and Figure 1

cd "$root/dofiles"
do "describing_expected_date_lifting.do"
*makes histograms for expected lifting date: Figure 2

cd "$root/dofiles"
do "analyzing_quarterly_sales_growth.do"
*runs regressions for quarterly sales growth: Table 9


***********************************************
*maps
***********************************************
* Before running below, install spmap and maptile using ssc
*ssc install spmap
*ssc install maptile

* For using "jpn_pref", you need to install maptile
*maptile for mapping prefectures in Japan: see 
*http://www.crepe.e.u-tokyo.ac.jp/material/maptile.html
maptile_install using "http://www.crepe.e.u-tokyo.ac.jp/material/geo_jpn_pref.zip"

cd "$root/dofiles"
do "drawing_emergency_declaration_map.do"
*draws maps for emergency declaration by prefecture: Figure A1

cd "$root/dofiles"
do "drawing_suspension_and_subsidy_map.do"
*draws maps for suspension and subsidy conditions by prefecture: Figure A2



