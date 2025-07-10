***** Project_Estimates_Smetanina.do
***** estimates and figures, sleep duration
***** time use data extracted from ipums, american time use survey 2003-2023

cd "/Users/annasmetanina/Library/Mobile Documents/com~apple~CloudDocs/EconomicsMA_HunterCollege/ECO 727 Data Analytics/Project/Analysis"
capture log close AS
log using Project_Estimates_Smetanina.smcl, name(AS) replace

* loading extracted data
use "../Data/ATUS Sleep with CPI, 2003-2023.dta", clear
describe
summarize

* estimating through ols
eststo column_1: regress bls_pcare_sleep age agesq female rearnweek uhrsworkt kidund18 rspearnweek spusualhrs
eststo column_3: regress bls_pcare_sleep c.age c.agesq female c.rearnweek kidund18 c.uhrsworkt##i.female ///
    i.kidund18##i.female c.rspearnweek c.spusualhrs

* estimating through 2sls
eststo column_2: ivregress 2sls bls_pcare_sleep age agesq female (c.rearnweek=c.rspearnweek#i.female) ///
    uhrsworkt kidund18 rspearnweek spusualhrs, first
estat firststage
eststo column_4: ivregress 2sls bls_pcare_sleep c.age c.agesq female uhrsworkt kidund18 ///
	(c.rearnweek=c.rspearnweek#i.female) c.uhrsworkt##i.female i.kidund18##i.female c.rspearnweek c.spusualhrs, first
estat firststage

* displaying estimates
estimates dir

* writing estimates to log file
esttab column_1 column_2 column_3 column_4, ///
	b(3) se(3) stats(r2 N, fmt(%4.3f %9.0fc) labels("R2" "N")) ///
	nodepvars nostar obslast noomitted nobaselevels varwidth(24) alignment(r) ///
	title("OLS and 2SLS Estimates of the Effects on Sleep Duration") ///
	mtitles("OLS" "2SLS" "OLS" "2SLS") ///
	coeflabels(bls_pcare_sleep "Sleep duration" age "Age" agesq "Age squared" female "Female" ///
	rearnweek "Weekly earnings" uhrsworkt "Weekly work hours" ///
	kidund18 "Is parent" ///
	rspearnweek "Partner's weekly earnings" spusualhrs "Partner's weekly work hours" ///
	1.female#c.uhrsworkt "Female × Weekly work hours" ///
	1.kidund18#1.female "Female × Is Parent") ///
	order(age agesq female rearnweek uhrsworkt kidund18 rspearnweek spusualhrs ///
	1.female#c.uhrsworkt 1.kidund18#1.female) ///
	drop(_cons) ///
	nonotes addnotes("Notes: This table reports the results of the OLS and 2SLS regressions estimating sleep duration, measured in minutes per 24-hour period. The sample consists of 45,955 respondents. Each estimation includes controls for age, respondent's weekly earnings and weekly work hours, marital and parental status, and partner's weekly earnings and weekly work hours. The 2SLS regressions use partner's weekly earnings as an instrument for respondents' weekly earnings. The interaction terms are 'Female × Work hours' and 'Female × Is parent.' Parentheses show standard errors. All values reflect three decimal places." "Source: American Time Use Survey data, 2003-2023.")
	
* writing estimates to latex file
esttab column_1 column_2 column_3 column_4 using "Results/regressions_table.tex", ///
	b(3) se(3) stats(r2 N, fmt(%4.3f %9.0fc) labels("\$R^2\$" "\$N\$")) ///
	nodepvars nostar obslast noomitted nobaselevels varwidth(24) alignment(D{.}{.}{-1}) replace booktabs ///
	title("OLS and 2SLS Estimates of the Effects on Sleep Duration") ///
	mtitles ("OLS" "2SLS" "OLS" "2SLS") ///
	coeflabels(bls_pcare_sleep "Sleep duration" age "Age" agesq "Age squared" female "Female" ///
	rearnweek "Weekly earnings" uhrsworkt "Weekly work hours" ///
	kidund18 "Is parent" ///
	rspearnweek "Partner's weekly earnings" spusualhrs "Partner's weekly work hours" ///
	1.female#c.uhrsworkt "Female × Weekly work hours" ///
	1.kidund18#1.female "Female × Is Parent") ///
	drop(_cons) ///
	nonotes addnotes("Notes: This table reports the results of the OLS and 2SLS regressions estimating sleep duration, measured in minutes per 24-hour period. The sample consists of 45,955 respondents. Each estimation includes controls for age, respondent's weekly earnings and weekly work hours, marital and parental status, and partner's weekly earnings and weekly work hours. The 2SLS regressions use partner's weekly earnings as an instrument for respondents' weekly earnings. The interaction terms are 'Female × Work hours' and 'Female × Is parent.' Parentheses show standard errors. All values reflect three decimal places." "Source: American Time Use Survey data, 2003-2023.")
	
* saving the data
save "../Data/ATUS Sleep with CPI, 2003-2023.dta", replace
describe
summarize

* graphing the average sleep durations by gender
collapse (mean) bls_pcare_sleep, by(year female)
line bls_pcare_sleep year if female == 1 || ///
	line bls_pcare_sleep year if female == 0, ///
	xtitle(Year) xlabel(2003(2)2023) ///
	ytitle("Average Sleep Duration") ylabel(400(30)580, noticks) ///
	text(560 2021 "Women") text(515 2019 "Men") ///
	scheme(Wide727Scheme) name(fig_avgsleep, replace)
graph export "Results/fig_avgsleep.pdf", width(3.75) replace

* saving the preliminary results data
save "../Data/ATUS Sleep with CPI - Preliminary Results, 2003-2023.dta", replace
describe
summarize

log close AS
