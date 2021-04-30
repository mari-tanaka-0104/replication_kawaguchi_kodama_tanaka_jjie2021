clear all
set more off
set mem 100m
set matsize 11000

cd "$root/results" 
*************************************************
* date of the state of the emergency declaration by prefecture
*************************************************
** Figure A1: Prefectures under emergency declaration by dates
import excel "$root/data/suspension_pref.xlsx", sheet("suspension") firstrow clear
foreach var of varlist April7 April16 May14 {
maptile `var', geography(jpn_pref) geoid(pref) fcolor(Blues) cutvalues(0(1.1)0.9) legformat(%2.0f)
graph export map_of_emergency_declaration_`var'.png, replace 
}




