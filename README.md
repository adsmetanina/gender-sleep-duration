# The Effects of Gender on Sleep Duration

This project analyzes how gender, employment, and household composition influence sleep duration among working-age adults in the US. Using American Time Use Survey (ATUS) data from 2003 to 2023, the study estimates these effects using OLS and 2SLS regressions. Final project submitted on February 25, 2025 for Data Analytics & Research Methods class.

## Repository Structure

| File                                     | Description                                                              |
|------------------------------------------|--------------------------------------------------------------------------|
| `Project_DataPreparationa.do`            | Loads and cleans ATUS data; creates final analysis sample                |
| `Project_BasicStats.do`                  | Generates descriptive statistics and summary tables                      |
| `Project_Estimates.do`                   | Performs OLS and 2SLS regressions, including gender interaction effects  |

## Objective

To estimate whether and how gender influences sleep duration, accounting for employment status and household structure. The study also examines whether these relationships are mediated by labor and caregiving obligations.

## Data & Methods

- **Dataset:** American Time Use Survey (ATUS), 2003–2023.
- **Sample:** Adults aged 18–65 (N = 183,199).
- **Key Variables:**
  - Sleep duration (minutes per 24-hour period).
  - Weekly work hours.
  - Weekly earnings (CPI-adjusted).
  - Parental and partnership status.
- **Methodology:**
  - Ordinary Least Squares (OLS).
  - Two-Stage Least Squares (2SLS) using partner’s earnings as an instrument.
  - Gender interaction terms w/ work hours and parental status.

## Key Findings

- **Gender:** Women sleep more than men on average, but effects reverse when controlling for interactions.
- **Work hours:** Strong negative effect on sleep for all genders.
- **Parenting:** Reduces sleep significantly for both genders, w/ stronger (but not statistically significant) effects for women.
- **Instrument validity:** Partner’s earnings is a valid instrument for weekly earnings in 2SLS regressions.

## References

- Arber, Sara, Marcos Bote, and Robert Meadows. 2009. “Gender and socio-economic patterning of self-reported sleep problems in Britain.” *Social Science and Medicine*, 68: 281–289.
- Asgeirsdottir, Tinna L., and Sigurdur P. Olafsson. 2015. “An empirical analysis of the demand for sleep: evidence from the American Time Use Survey.” *Economics and Human Biology*, 19: 265–274.
- Blanchflower, David G., and Alex Bryson. 2021. “Unemployment and sleep: evidence from the United States and Europe.” *Economics and Human Biology*, 43: 101042.
- Flood, Sarah M., et al. 2023. *American Time Use Survey Data Extract Builder: Version 3.2*. IPUMS.

## Requirements

- Stata 15 or higher.
- Access to ATUS extracts (not included in repo).

## License

This project is for academic use only.
