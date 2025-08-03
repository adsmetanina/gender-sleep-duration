# The Effects of Gender on Sleep Duration

Final project code for ECO 727: Data Analytics & Research Methods. This repository contains a set of Stata codes used to prepare, merge, and analyze sleep data. It specifically analyzes how gender, employment, and household composition influence sleep duration among working-age adults in the US. The project constructs an analytic sample using American Time Use Survey (ATUS) data from 2003 to 2023, and estimates these effects using OLS and 2SLS regressions.

## Files

| File                                     | Description                                                              |
|------------------------------------------|--------------------------------------------------------------------------|
| `Project_DataPreparationa.do`            | Loads and cleans ATUS data and creates final analysis sample                |
| `Project_BasicStats.do`                  | Generates descriptive statistics and summary tables                      |
| `Project_Estimates.do`                   | Performs OLS and 2SLS regressions, including gender interaction effects  |
| `fig_avgsleep.pdf`                       | Visual comparison of sleep duration by gender                            |
| `summary_statistics.tex`                 | LaTeX table of summary statistics                                        |
| `regressions_table.do`                   | LaTeX table of OLS and 2SLS estimates                                    |

## Project Overview

The final paper submitted on February 25, 2025 summarizes the research findings and methodology. It includes regression results, policy impications, and literature references.

## Data Sources

- [American Time Use Survey (ATUS) (2003–2023)]

## Methodology

- **Sample:** Adults aged 18–65 (N=183,199).
- **Key Variables:**
  - Sleep duration (minutes per 24-hour period).
  - Weekly work hours.
  - Weekly earnings (CPI-adjusted).
  - Parental and partnership status.
- **Regression Models:**
  - Ordinary Least Squares (OLS).
  - Two-Stage Least Squares (2SLS) using partner’s earnings as an instrument.
  - Gender interaction terms w/ work hours and parental status.

## Results

- **Gender:** Women sleep more than men on average, but effects reverse when controlling for interactions.
- **Work Hours:** Strong negative effect on sleep for all genders.
- **Parental Status:** Reduces sleep significantly for both genders, w/ stronger (but not statistically significant) effects for women.
- **Instrument Validity:** Partner’s earnings is a valid instrument for weekly earnings in 2SLS regressions.

## References

- Arber, Sara, Marcos Bote, and Robert Meadows. 2009. “Gender and socio-economic patterning of self-reported sleep problems in Britain.” *Social Science and Medicine*, 68: 281–289.
- Asgeirsdottir, Tinna L., and Sigurdur P. Olafsson. 2015. “An empirical analysis of the demand for sleep: evidence from the American Time Use Survey.” *Economics and Human Biology*, 19: 265–274.
- Blanchflower, David G., and Alex Bryson. 2021. “Unemployment and sleep: evidence from the United States and Europe.” *Economics and Human Biology*, 43: 101042.
- Flood, Sarah M., et al. 2023. *American Time Use Survey Data Extract Builder: Version 3.2*. IPUMS.

## License

This repository is for academic use only.
