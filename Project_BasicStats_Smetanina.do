***** Project_BasicStats_Smetanina.do
***** basic stats and figures, sleep duration
***** time use data extracted from ipums, american time use survey 2003-2023

cd "/Users/annasmetanina/Library/Mobile Documents/com~apple~CloudDocs/EconomicsMA_HunterCollege/ECO 727 Data Analytics/Project/Analysis"
capture log close AS
log using Project_BasicStats_Smetanina.smcl, name(AS) replace

* loading extracted data
use "../Data/ATUS Sleep with CPI, 2003-2023.dta", clear
describe
summarize

* storing summary statistics for women
eststo women: estpost summarize ///
	bls_pcare_sleep /// dependent variable
	age /// demographics
	uhrsworkt rearnweek /// employment
	spousepart kidund18 /// household
	spusualhrs rspearnweek /// partner employment
	if female==1

* storing summary statistics for men
eststo men: estpost summarize ///
	bls_pcare_sleep /// dependent variable
	age /// demographics
	uhrsworkt rearnweek /// employment
	spousepart kidund18 /// household
	spusualhrs rspearnweek /// partner employment
	if female==0

* storing summary statistics for both
eststo both: estpost summarize ///
	bls_pcare_sleep /// dependent variable
	age /// demographics
	uhrsworkt rearnweek /// employment
	spousepart kidund18 /// household
	spusualhrs rspearnweek /// partner employment
	
* generating table for log file
esttab women men both, ///
	main(mean %9.3fc) aux(sd %9.3fc) stats(N, fmt(%9.0fc) labels("N")) ///
	label nonumbers varwidth(24) alignment(r) ///
	title("Summary Statistics") mtitles("Women" "Men" "Both Sexes") /// 
	nonotes addnotes("Notes: Respondents report sleep duration in minutes per 24-hour period. The sample consists of 183,199 respondents. The data presents weekly earnings in real US dollars, adjusted for inflation to December 2023 using the Consumer Price Index (CPI). 'Partner' includes spouses and unmarried partners. The data indicates whether respondents are parents of minors under 18 years. Parentheses show standard deviations. All values reflect three decimal places." "American Time Use Survey data, 2003-2023.")

* generating table for latex
esttab women men both using "Results/summary_statistics.tex", ///
	main(mean %9.3fc) aux(sd %9.3fc) stats(N, fmt(%9.0fc) labels("\$N\$")) ///
	label nonumbers varwidth(24) alignment(D{.}{.}{-1}) replace booktabs ///
	title("Summary Statistics") mtitles("Women" "Men" "Both Sexes") ///
	nonotes addnotes("Notes: Respondents report sleep duration in minutes per 24-hour period. The sample consists of 183,199 respondents. The data presents weekly earnings in real US dollars, adjusted for inflation to December 2023 using the Consumer Price Index (CPI). 'Partner' includes spouses and unmarried partners. The data indicates whether respondents are parents of minors under 18 years. Parentheses show standard deviations. All values reflect three decimal places." "American Time Use Survey data, 2003-2023.")
	
* saving the data
save "../Data/ATUS Sleep with CPI, 2003-2023.dta", replace
describe
summarize

log close AS
