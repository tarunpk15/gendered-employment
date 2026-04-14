# 📊 Descriptive Statistics: PLFS Dataset (2018–2021)

## 📌 Overview
This document provides a comprehensive summary of the variables used in the econometric analysis of female employment during the COVID-19 pandemic. The dataset consists of **1,180,999 observations**, providing high statistical power for the Difference-in-Differences (DiD) and Event Study frameworks.

---

## 📋 Summary Statistics Table

| Variable | Obs | Mean | Std. Dev. | Min | Max |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **Female** | 1,180,999 | 0.4945 | 0.5000 | 0 | 1 |
| **Employment** | 1,180,999 | 0.4677 | 0.4990 | 0 | 1 |
| **Age** | 1,180,999 | 35.2162 | 13.6299 | 15 | 64 |
| **Edu_primary** | 1,180,999 | 0.0458 | 0.2091 | 0 | 1 |
| **Edu_secondary** | 1,180,999 | 0.5028 | 0.5000 | 0 | 1 |
| **Edu_higher** | 1,180,999 | 0.2876 | 0.4527 | 0 | 1 |
| **Rural** | 1,180,999 | 0.5644 | 0.4958 | 0 | 1 |
| **Married** | 1,180,999 | 0.6509 | 0.4767 | 0 | 1 |
| **Industry_agri** | 1,180,999 | 0.1720 | 0.3773 | 0 | 1 |
| **Industry_ind** | 1,180,999 | 0.0625 | 0.2421 | 0 | 1 |
| **Industry_serv** | 1,180,999 | 0.2596 | 0.4384 | 0 | 1 |
| **Year** | 1,180,999 | 2019.502 | 1.1212 | 2018 | 2021 |
| **Age_c (Centered)** | 1,180,999 | 1.61e-06 | 13.6287 | -20.4471 | 29.0347 |
| **Age_c2 (Squared)** | 1,180,999 | 185.7418 | 184.5972 | 0.0012 | 843.0139 |
| **Post (2020-21)** | 1,180,999 | 0.5006 | 0.5000 | 0 | 1 |

---

## 🔍 Data Insights & Structure

### 1. Demographic Composition
* **Gender Balance:** The sample is nearly evenly split, with females comprising **49.45%** of the observations.
* **Marital Status:** A significant majority (**65.1%**) of the individuals in the sample are married, which is a critical control for the "Domestic Burden" hypothesis.
* **Regional Split:** The dataset leans towards rural areas (**56.4%**), which aligns with the sectoral dominance of agriculture and essential services during the lockdowns.

### 2. Labor Force Characteristics
* **Aggregate Employment:** The mean employment rate across the entire four-year period is **46.8%**. 
* **Sectoral Distribution:** * **Services:** 26% of the sample.
    * **Agriculture:** 17.2% of the sample.
    * **Industry:** 6.2% of the sample.
* **Note:** The remaining percentage likely represents individuals not in the labor force (NILF) or those in unclassified informal sectors.

### 3. Education Levels
* The workforce is characterized by a high proportion of individuals with at least a **secondary education (50.3%)**, while **28.8%** have attained higher education. Only a small fraction (**4.6%**) is limited to primary education.

### 4. Time & Treatment Structure
* **Post-Shock Balance:** The `Post` variable mean of **0.5006** indicates an almost perfect 50/50 split between the Pre-COVID (2018-19) and Post-COVID (2020-21) periods, ensuring a balanced comparison for the DiD estimator.
* **Age Distribution:** With a mean age of **35.2 years**, the sample captures a prime-working-age population. The centering of age (`Age_c`) and its square (`Age_c2`) are correctly implemented to control for the non-linear relationship between age and employment probability.

---