* Load merged dataset
//use "final_merged_panel.dta", clear

* Run main regression (with industry)
reg Employment i.Female##i.Year Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust

estimates store model3

* Run regression without industry
reg Employment i.Female##i.Year Age_c Age_c2  Edu_primary Edu_secondary  Rural Married, robust
 
estimates store model2

* Run regression with industry and service and post interaction terms
reg Employment i.Female##i.Post##i.Industry_serv Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind, robust
 
estimates store model1
 
 
 *compare model1 , model2
estimates table model1 model2 model3, b se
 
 * Plot event study
coefplot, keep(1.Female#2018.Year 1.Female#2019.Year 1.Female#2020.Year 1.Female#2021.Year) ///
    vertical yline(0) title("Event Study: Female Employment Effect") ///
    xtitle("Year") ytitle("Effect on Employment") ///
    rename(1.Female#2018.Year="2018" 1.Female#2019.Year="2019" 1.Female#2020.Year="2020" 1.Female#2021.Year="2021")
 