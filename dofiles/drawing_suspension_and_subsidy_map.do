clear all
set more off
set mem 100m
set matsize 11000
set scheme burd3

** Figure A2: Suspension request and subsidy at prefecture level
use "$root/data/suspension_maps.dta", clear
// changes at the prefecture-level
preserve
collapse susp_*, by(pref)
maptile susp_april_17, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.3f) cutvalues(0.05, 0.1) fcolor(Blues)
graph export "$root/results/map_suspension_request_april17.png", replace
maptile susp_may_1, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.3f) cutvalues(0.05, 0.1) fcolor(Blues)
graph export "$root/results/map_suspension_request_may1.png", replace
maptile susp_may_15, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.3f) cutvalues(0.05, 0.1) fcolor(Blues)
graph export "$root/results/map_suspension_request_may15.png", replace
restore

preserve
collapse suspsub_*, by(pref)
maptile suspsub_april_17, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.1f) cutvalues(5, 10) fcolor(Reds)
graph export "$root/results/map_suspension_subsidy_april17.png", replace
maptile suspsub_may_1, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.1f) cutvalues(5, 10) fcolor(Reds)
graph export "$root/results/map_suspension_subsidy_may1.png", replace
maptile suspsub_may_15, geography(jpn_pref) geoid(pref) ndfcolor(gs12) legformat(%9.1f) cutvalues(5, 10) fcolor(Reds)
graph export "$root/results/map_suspension_subsidy_may15.png", replace
restore
