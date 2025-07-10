***** Project_DataPreperation_Smetanina.do
***** data preperation, sleep duration
***** time use data extracted from ipums, american time use survey, 2003-2023

cd "/Users/annasmetanina/Library/Mobile Documents/com~apple~CloudDocs/EconomicsMA_HunterCollege/ECO 727 Data Analytics/Project/Analysis"
capture log close AS
log using Project_DataPreparation_Smetanina.smcl, name(AS) replace
global tcscale=1.5

* loading extracted data
use ../Data/atus_00004.dta, clear
describe
summarize

* dropping unnecessary variables
drop caseid serial strata pernum lineno ///
race hispan asian region marst occ uhrswork1 uhrswork2 ///
educ empstat famincome spempstat multjobs clwkr fullpart hourwage ///
rested age_cps8 sex_cps8 empstat_cps8 multjobs_cps8 clwkr_cps8 occ_cps8 fullpart_cps8 ///
uhrsworkt_cps8 uhrswork1_cps8 uhrswork2_cps8 earnweek_cps8 hourwage_cps8 bls_carehh bls_comm bls_educ ///
bls_hhact bls_leis bls_other bls_pcare bls_social bls_work wt03 wt04 wt06 wt20

* keeping respondents aged 18-65
drop if age<18|age>65
label variable age "Age"
generate agesq=age*age
label variable agesq "Age squared"

* recoding missing values
replace month=. if month==999
replace sex=. if sex==99
replace age=. if inlist(age, 996, 997, 998)
replace uhrsworkt=. if inlist(uhrsworkt, 9995, 9999)
replace earnweek=. if earnweek==99999.99
replace spousepres=. if spousepres==99
replace spusualhrs=. if inlist(spusualhrs, 995, 999)
replace spearnweek=. if spearnweek>=99999.98
replace kidund18=. if kidund18==99
replace dataqual=. if inlist(dataqual, 9998, 9999)
replace outcome=. if outcome==9999
replace outcome_alt=. if outcome_alt==9999

* checking for bad quality data
tabulate outcome
tabulate outcome_alt
tabulate dataqual

* analyzing any differences between outcome and outcome_alt
generate outcome_diff=(outcome!=outcome_alt)
tabulate outcome_diff
drop outcome_diff

* removing bad quality data and unnecessary quality variables
keep if dataqual==0200
keep if outcome==0100
drop outcome_alt

* creating dummy variable "female"
generate female=0 if sex==01
replace female=1 if sex==02
label variable female "Female"
drop sex

* recoding "earnweek" and "spearnweek"
generate topcode=1 if earnweek==2884.61
replace earnweek=$tcscale*earnweek if topcode==1
generate sptopcode=1 if spearnweek==2884.61
replace spearnweek=$tcscale*earnweek if sptopcode==1
label variable topcode "Weekly wages topcode"
label variable sptopcode "Partner's weekly wages topcode"

* converting "spousepres" to dummy variables
generate spousepart=(spousepres==1|spousepres==2)
label variable spousepart "Is married or partnered"
drop spousepres

* converting "kidund18" to dummy variables
replace kidund18=0 if kidund18==00
replace kidund18=1 if kidund18==01
label variable kidund18 "Is parent"

* labelling remaining variables
label variable uhrsworkt "Weekly work hours"
label variable earnweek "Weekly earnings"
label variable spusualhrs "Partner's weekly work hours"
label variable spearnweek "Partner's weekly earnings"
label variable bls_pcare_sleep "Sleep duration" /// dependent variable

* ordering variables
order year month /// survey information
age agesq female /// demographics
uhrsworkt earnweek /// employment
spousepart spusualhrs spearnweek kidund18 /// household
dataqual outcome /// data quality
bls_pcare_sleep /// dependent variable

* saving the data
save "../Data/ATUS Sleep, 2003-2023.dta", replace
describe
summarize

* merging cpi data
use "../Data/ATUS Sleep, 2003-2023.dta", clear
merge m:1 year month using "../../Data/CPI-U", keep(match)
summarize cpi if year==2023 & month==12, meanonly
display r(mean)
scalar cpi_dec_2023=r(mean)
generate rearnweek=earnweek*(cpi_dec_2023/cpi)
generate rspearnweek=spearnweek*(cpi_dec_2023/cpi)
label variable rearnweek "Real weekly wages"
label variable rspearnweek "Partner's real weekly wages"

* relabelling variables for consistent formatting
label variable year "Survey year"
label variable month "Month of ATUS interview"
label variable dataqual "Interview should not be used"
label variable outcome "Final interview outcome code"
label variable cpi "Consumer Price Index"

* ordering variables
order year month /// survey information
age agesq female /// demographics
uhrsworkt rearnweek earnweek /// employment
spousepart spusualhrs rspearnweek spearnweek kidund18 /// household
dataqual outcome /// data quality
cpi _merge /// merge data

* saving the data
save "../Data/ATUS Sleep with CPI, 2003-2023.dta", replace
describe
summarize

log close AS
