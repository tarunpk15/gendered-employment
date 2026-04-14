********************************************************************************
* TASK: COMPREHENSIVE DATA VISUALIZATION AND MODEL DIAGNOSTICS
* OUTPUT: Research_Full_Visual_Report.pdf
********************************************************************************

// 1. Initialize PDF
capture putpdf save "Research_Full_Visual_Report.pdf", replace
putpdf begin
putpdf paragraph, halign(center)
putpdf text ("Data Structure & Econometric Analysis"), bold font("Arial", 16)

********************************************************************************
* SECTION 0: DATA EXPLORATION (Visualizing the Raw Structure)
********************************************************************************
putpdf paragraph
putpdf text ("Part 1: Data Exploration"), bold font("Arial", 14)

* A. Box Plot: Employment by Gender and Period
graph box Employment, over(Female) over(Post) ///
    title("Employment Distribution by Gender & Period") ///
    ytitle("Employment Status (Binary)") name(box_data, replace)
graph export "box_data.png", replace

* B. Binned Scatter: Employment vs Age (Visualizing the Concave Relationship)
binscatter Employment Age_c, line(connect) ///
    title("Employment Probability by Age") ///
    xtitle("Age (Centered)") ytitle("Mean Employment") name(bin_age, replace)
graph export "bin_age.png", replace

putpdf paragraph, halign(center)
putpdf image "box_data.png", width(3)
putpdf image "bin_age.png", width(3)

********************************************************************************
* SECTION 1: MODEL DIAGNOSTICS (Fixed "varlist required")
********************************************************************************
foreach m in model1 model2 model3 {
    
    estimates restore `m'
    putpdf page
    putpdf paragraph, halign(center)
    putpdf text ("Detailed Dashboard: `m'"), bold font("Arial", 14)

    // 1. Predict residuals for this specific model to fix the error
    capture drop temp_res
    predict temp_res, residuals
    
    // 2. Coefficient Plot
    coefplot `m', drop(_cons) vertical title("Coefficients") name(coef_`m', replace)
    
    // 3. Residuals vs Fitted (Checks for Heteroskedasticity)
    quietly rvfplot, title("Residuals vs Fitted") name(rvf_`m', replace)
    
    // 4. Q-Q Plot (The Fix: Added 'temp_res' variable here)
    quietly qnorm temp_res, title("Q-Q Plot (Normality of Residuals)") name(qq_`m', replace)
    
    // Combine and Export
    graph combine coef_`m' rvf_`m' qq_`m', cols(1) xsize(7) ysize(10) name(dash_`m', replace)
    graph export "dash_`m'.png", replace
    
    putpdf paragraph, halign(center)
    putpdf image "dash_`m'.png", width(4.5)
    
    drop temp_res // Clean up for next loop iteration
}

********************************************************************************
* FINALIZE
********************************************************************************
putpdf save "Research_Full_Visual_Report.pdf", replace
display "SUCCESS: PDF generated with fixed diagnostics and data plots."