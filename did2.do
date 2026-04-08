********************************************************************************
* PROJECT: Gendered Impact of COVID-19 (Female Subsample Analysis)
* TASK: Absolute Impact Trend and Sectoral DiD (Services vs. Others)
* BASE YEAR: 2019 | DATA: Females Only
********************************************************************************

// 1. Setup
ssc install coefplot, replace
ssc install estout, replace

// 2. Filter data for Females Only
// preserve // Optional: use preserve/restore if you want to keep the full dataset in memory
keep if Female == 1

********************************************************************************
* PART A: ABSOLUTE EVENT STUDY (Interrupted Time Series)
********************************************************************************
/* This measures the absolute change in employment probability for women 
   in each year relative to the 2019 baseline. 
*/

reg Employment ib2019.Year Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
estimates store absolute_event_study

// Visualization of the Absolute Trend
coefplot, keep(*.Year) vertical yline(0, lcolor(red) lpattern(dash)) ///
    title("Absolute Impact on Female Employment (Base Year: 2019)") ///
    ytitle("Change in Probability") xtitle("Year") ///
    rename(2018.Year = "2018" 2020.Year = "2020" 2021.Year = "2021") ///
    note("Reference Year: 2019. This shows the absolute trend for the female population.")

********************************************************************************
* PART B: SECTORAL DiD (Service Sector Women vs. Other Women)
********************************************************************************
/* Since you want a 'DiD' for females, we use Industry_serv as the treatment.
   Treatment: Women in Services | Control: Women in Industry/Agri
*/

reg Employment i.Industry_serv##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind, robust
estimates store sectoral_did_fem

********************************************************************************
* PART C: SECTORAL EVENT STUDY (Dynamic Sectoral Impact)
********************************************************************************
/* This determines if service-sector women fell behind other women specifically 
   in 2020 and 2021.
*/

reg Employment ib2019.Year##i.Industry_serv Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind, robust
estimates store sectoral_event_fem

// Visualization of Sectoral Divergence
coefplot, keep(*.Year#1.Industry_serv) vertical yline(0, lcolor(red) lpattern(dash)) ///
    title("Sectoral Divergence within Females (Services vs. Others)") ///
    ytitle("Coefficient (Relative to Non-Service Women & 2019)") ///
    xtitle("Year") ///
    rename(2018.Year#1.Industry_serv = "2018" 2020.Year#1.Industry_serv = "2020" 2021.Year#1.Industry_serv = "2021")

********************************************************************************
* PART D: COMPARISON TABLE
********************************************************************************

esttab absolute_event_study sectoral_did_fem sectoral_event_fem, b(%9.4f) se(%9.4f) ///
    star(* 0.05 ** 0.01 *** 0.001) ///
    title("Absolute Female Employment Analysis") ///
    mtitle("Absolute Trend" "Sectoral DiD" "Sectoral Event") ///
    addnotes("All models restricted to Female observations only." "Sectoral models use Industry_serv as the treatment group.")

// restore // Restore full dataset if preserve was used