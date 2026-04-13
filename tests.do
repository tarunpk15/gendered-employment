********************************************************************************
* RE-CREATING MODELS AND RUNNING DIAGNOSTICS (FIXED VERSION)
********************************************************************************

foreach m in model1 model2 model3 {
    
    display " "
    display "================================================================"
    display "DIAGNOSTICS FOR: `m'"
    display "================================================================"
    
    * 1. Run the model WITHOUT robust just for the tests
    if "`m'" == "model3" reg Employment i.Female##i.Post
    if "`m'" == "model2" reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married
    if "`m'" == "model1" reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv

    * 2. Run Heteroskedasticity Tests (These will work now)
    display "--- Breusch-Pagan Test ---"
    hettest
    
    display "--- White Test ---"
    estat imtest, white
    
    * 3. Run other diagnostics
    display "--- Specification (RESET) ---"
    estat ovtest
    
    display "--- Multicollinearity (VIF) ---"
    estat vif
    
    display "--- Information Criteria (AIC/BIC) ---"
    estat ic

    * 4. NOW re-run and store the ROBUST version for your final report
    if "`m'" == "model3" quietly reg Employment i.Female##i.Post, robust
    if "`m'" == "model2" quietly reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married, robust
    if "`m'" == "model1" quietly reg Employment i.Female##i.Post Age_c Age_c2 Edu_primary Edu_secondary Rural Married Industry_ind Industry_serv, robust
    
    estimates store `m'
    display ">>> `m' (Robust) stored successfully."
}

********************************************************************************
* FINAL COMPARISON
********************************************************************************
esttab model3 model2 model1, b(%9.4f) se(%9.4f) star(* 0.05 ** 0.01 *** 0.001) ///
    title("Final Main Models (Robust Standard Errors)")