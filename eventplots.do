estimates restore gender_event

coefplot, keep(*.Year#1.Female) vertical yline(0, lcolor(red) lpattern(dash)) ///
    title("Event Study: Gendered Employment Impact (Base: 2019)") ///
    ytitle("Coefficient (Gender Gap Change)") ///
    xtitle("Year") ///
    rename(2018.Year#1.Female = "2018" 2020.Year#1.Female = "2020" 2021.Year#1.Female = "2021") ///
    note("Base Year: 2019 (Omitted). Negative values indicate a widening gap relative to 2019.")

estimates restore total_event

coefplot, keep(2018.Year 2020.Year 2021.Year) vertical yline(0, lcolor(red) lpattern(dash)) ///
    title("Event Study: Total Employment Impact (Base: 2019)") ///
    ytitle("Change in Employment Probability") ///
    xtitle("Year") ///
    rename(2018.Year = "2018" 2020.Year = "2020" 2021.Year = "2021") ///
    note("Base Year: 2019 (Omitted). All coefficients show absolute probability shift for the whole sample.")