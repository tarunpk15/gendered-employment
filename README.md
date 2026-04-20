# Gendered Employment Impact Analysis

A comprehensive econometric study investigating the differential effects of COVID-19 on employment by gender, using STATA for statistical analysis and difference-in-differences methodology.
##test user
## Project Overview

This research project analyzes the "She-cession" phenomenon by examining how COVID-19 differentially impacted male and female employment patterns. Using a dataset of **1,180,999 observations**, the study employs OLS regression models with robust standard errors to disentangle the complex relationship between gender, sectoral segregation, and pandemic-induced economic shocks.

### Key Research Questions
1. **The Structural Gap:** What is the baseline employment gap between men and women, independent of the pandemic?
2. **The Sectoral Effect:** How much of female employment decline can be attributed to sectoral segregation (concentration in vulnerable industries)?
3. **The Interaction Effect:** Did the pandemic create a unique, non-linear disadvantage for women at the intersection of time and sector?

---

## Directory Structure and File Descriptions

### Core Analysis Files
- **`did2.do`** - Master do-file containing the main difference-in-differences analysis. Compares gendered impact vs. total population impact using both static DiD and dynamic event study approaches.
- **`analysis.do`** - Primary analysis script that runs three nested regression models with different control specifications and generates comparison tables.
- **`eventplots.do`** - Generates event study visualization plots for both gendered impact and total population impact analyses.

### Diagnostic and Testing Files
- **`tests.do`** - Comprehensive diagnostic testing script that runs heteroskedasticity tests (Breusch-Pagan, White), multicollinearity checks (VIF), and model specification tests (RESET) for all model specifications.

### Documentation Files
- **`models.md`** - Detailed documentation of the three nested OLS models, including theoretical framework, empirical results, and statistical comparison.
- **`did_event.md`** - Comprehensive explanation of difference-in-differences vs. event study methodologies, with results interpretation and synthesis.
- **`tests.md`** - Documentation of diagnostic test results and model validation procedures.

### Data Files
- **`final_merged_panel.dta`** - Main dataset containing 1,180,999 observations with employment, demographic, and industry variables across multiple years.

### Visualization Files
- **`event1.png`** - Event study plot showing gendered employment impact relative to 2019 baseline
- **`event2.png`** - Event study plot showing total population employment impact relative to 2019 baseline

---

## Step-by-Step STATA Instructions

### Prerequisites
1. **STATA Version**: STATA 15 or higher (for factor variable notation)
2. **Required Packages**: The analysis will automatically install needed packages:
   - `estout` (for export tables)
   - `coefplot` (for coefficient plots)

### Step 1: Setup and Package Installation
Open STATA and navigate to the project directory. Run the setup commands:
```stata
* Install required packages (only need to run once)
ssc install estout, replace
ssc install coefplot, replace
```

### Step 2: Run the Main Analysis
Execute the master analysis file:
```stata
* Run the complete difference-in-differences analysis
do "did2.do"
```

This will:
- Load the dataset
- Run gendered impact analysis (static DiD and event study)
- Run total population impact analysis
- Generate comparison tables
- Store estimates for plotting

### Step 3: Generate Visualizations
Create event study plots:
```stata
* Generate event study visualization plots
do "eventplots.do"
```

### Step 4: Run Model Diagnostics
Test model assumptions and robustness:
```stata
* Run comprehensive diagnostic tests
do "tests.do"
```

### Step 5: Alternative Analysis Path
For a simpler analysis focusing on the three nested models:
```stata
* Run basic model comparison analysis
do "analysis.do"
```

---

## Key Variables in the Dataset

### Dependent Variable
- **`Employment`** - Binary variable (1=employed, 0=unemployed)

### Independent Variables
- **`Female`** - Gender indicator (1=female, 0=male)
- **`Post`** - COVID period indicator (1=2020-2021, 0=2018-2019)
- **`Year`** - Year variable (2018, 2019, 2020, 2021)

### Control Variables
- **`Age_c`**, **`Age_c2`** - Age and age-squared (continuous)
- **`Edu_primary`**, **`Edu_secondary`** - Education dummies
- **`Rural`** - Rural residence indicator
- **`Married`** - Marital status indicator
- **`Industry_ind`**, **`Industry_serv`** - Industry sector dummies

---

## Model Specifications

### Model 3: Baseline DiD
**Mathematical Formula:**
$$Employment_{it} = \alpha + \beta_1 Female_i + \beta_2 Post_t + \delta (Female_i \times Post_t) + \epsilon_{it}$$

**STATA Command:**
```stata
reg Employment i.Female##i.Post, robust
```

### Model 2: Demographic Controls
**Mathematical Formula:**
$$Employment_{it} = \alpha + \beta_1 Female_i + \beta_2 Post_t + \delta (Female_i \times Post_t) + \gamma_1 Age_{it} + \gamma_2 Age^2_{it} + \gamma_3 Edu_{primary,it} + \gamma_4 Edu_{secondary,it} + \gamma_5 Rural_i + \gamma_6 Married_i + \epsilon_{it}$$

**STATA Command:**
```stata
reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married, robust
```

### Model 1: Full Structural Model
**Mathematical Formula:**
$$Employment_{it} = \alpha + \beta_1 Female_i + \beta_2 Post_t + \delta (Female_i \times Post_t) + \gamma_1 Age_{it} + \gamma_2 Age^2_{it} + \gamma_3 Edu_{primary,it} + \gamma_4 Edu_{secondary,it} + \gamma_5 Rural_i + \gamma_6 Married_i + \gamma_7 Industry_{ind,it} + \gamma_8 Industry_{serv,it} + \epsilon_{it}$$

**STATA Command:**
```stata
reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
```

---

## Key Findings

### Main Results
- **Baseline Gender Gap**: Women face a 26% lower employment probability even after controlling for all factors
- **Sectoral Impact**: Industry controls explain 42% of the observed gender gap
- **Model Performance**: Full model achieves R² = 0.5330, explaining 53% of employment variance
- **Event Study**: Pandemic interrupted a strong convergence trend where women were rapidly closing the employment gap

### Statistical Significance
- All coefficients significant at p < 0.001 level
- Robust standard errors used throughout
- Diagnostic tests confirm model assumptions

---

## Usage Notes

### Running Individual Analyses
- Each `.do` file can be run independently
- Results are stored as estimates for later comparison
- Graphs are automatically saved as PNG files

### Interpreting Results
- Refer to `models.md` for detailed model interpretation
- See `did_event.md` for methodology explanation
- Check `tests.md` for diagnostic test results

### Data Requirements
- The analysis expects the dataset `final_merged_panel.dta` to be in the same directory
- All variable names and coding should match the specifications in the analysis files

---

## Technical Requirements

- **Memory**: Minimum 4GB RAM (for large dataset processing)
- **Storage**: 100MB free space (for dataset and outputs)
- **Processing Time**: Approximately 2-5 minutes for complete analysis on standard hardware

---

## Contact and Support

For questions about the analysis methodology or implementation issues, refer to the documentation files or check the comments within each `.do` file for detailed explanations of each step.
