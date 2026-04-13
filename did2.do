********************************************************************************
* MASTER DO-FILE: COVID-19 EMPLOYMENT IMPACT (N = 1,180,999)
* ANALYSIS: GENDERED IMPACT VS. TOTAL POPULATION IMPACT
* BASE YEAR: 2019
********************************************************************************

// 1. Setup
ssc install estout, replace
ssc install coefplot, replace

// 2. Ensure Post variable exists
capture gen Post = (Year >= 2020)

********************************************************************************
* SECTION 1: THE GENDERED IMPACT (Full Model with All Controls)
********************************************************************************

* A. Standard DiD
reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
estimates store gender_did

* B. Event Study (Dynamic DiD)
reg Employment ib2019.Year##i.Female Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
estimates store gender_event

********************************************************************************
* SECTION 2: THE TOTAL POPULATION IMPACT (No Gender Constraints)
********************************************************************************

* A. Standard DiD (Overall Average Shock)
reg Employment i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
estimates store total_did

* B. Event Study (Overall Dynamic Shock)
reg Employment ib2019.Year Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
estimates store total_event

********************************************************************************
* SECTION 3: COMPARISON TABLES
********************************************************************************

// TABLE 1: Gendered Impact Analysis (DiD vs. Event Study)
esttab gender_did gender_event, b(%9.4f) se(%9.4f) star(* 0.05 ** 0.01 *** 0.001) ///
    keep(1.Female 1.Post 1.Female#1.Post *.Year#1.Female) ///
    title("Table 1: Gendered Impact Comparison") ///
    mtitle("Static DiD" "Event Study") ///
    addnotes("Note: All controls included. Event Study shows year-specific gender gaps relative to 2019.")

// TABLE 2: Total Population Impact Analysis (DiD vs. Event Study)
esttab total_did total_event, b(%9.4f) se(%9.4f) star(* 0.05 ** 0.01 *** 0.001) ///
    keep(1.Post *.Year) ///
    title("Table 2: Total Population Impact Comparison") ///
    mtitle("Static DiD" "Event Study") ///
    addnotes("Note: This model removes gender interactions to show the absolute impact on the whole sample.")

********************************************************************************
* END OF DO-FILE
********************************************************************************