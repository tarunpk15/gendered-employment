********************************************************************************
* PROJECT: Gendered Impact of COVID-19 on Employment
* TASK: Difference-in-Differences (DiD) and Event Study
* DATA: 2018 - 2021 | Base Year: 2019
********************************************************************************

// 1. Install necessary packages (only needs to be run once)
ssc install coefplot, replace
ssc install estout, replace

// 2. Load the dataset
// use "your_data_path.dta", clear

********************************************************************************
* PART A: STANDARD DIFFERENCE-IN-DIFFERENCES (DiD)
********************************************************************************
/* We use the 'Post' variable (1 for 2020/2021, 0 otherwise).
   The interaction '1.Female#1.Post' is the DiD estimator.
*/

reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust

// Store results for the final table
estimates store did_model

********************************************************************************
* PART B: DYNAMIC EVENT STUDY
********************************************************************************
/* We use 'ib2019.Year' to set 2019 as the excluded baseline.
   - 2018 interaction tests the Parallel Trends Assumption.
   - 2020 and 2021 interactions show the shock and recovery.
*/

reg Employment ib2019.Year##i.Female Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust

// Store results for the final table
estimates store event_study

********************************************************************************
* PART C: EVENT STUDY VISUALIZATION
********************************************************************************
/* The 'keep' and 'rename' options are specifically formatted to match 
   Stata's internal factor-variable naming convention (Year#Female).
*/

coefplot, keep(*.Year#1.Female) vertical yline(0, lcolor(red) lpattern(dash)) ///
    title("Event Study: Gendered Employment Impact") ///
    ytitle("Coefficient (Relative to 2019)") ///
    xtitle("Year") ///
    rename(2018.Year#1.Female = "2018" 2020.Year#1.Female = "2020" 2021.Year#1.Female = "2021") ///
    note("Base Year: 2019 (Omitted). All coefficients relative to 2019 baseline.")

********************************************************************************
* PART D: EXPORT COMPARISON TABLE
********************************************************************************
/* This command creates a side-by-side comparison of the Standard DiD 
   and the Event Study, including significance stars.
*/

esttab did_model event_study, b(%9.4f) se(%9.4f) star(* 0.05 ** 0.01 *** 0.001) ///
    title("Comparison: Standard DiD vs. Event Study") ///
    mtitle("Standard DiD" "Event Study") ///
    addnotes("All models include demographic and industry controls." "Robust standard errors in parentheses.")

********************************************************************************
* END OF DO-FILE
********************************************************************************