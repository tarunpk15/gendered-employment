# 📊 Impact of COVID-19 on Female Employment (PLFS Data)

## 📌 Overview
This project analyzes the differential impact of COVID-19 on female employment in India using PLFS data (2018–2021). A Difference-in-Differences (DiD) framework is used to estimate causal effects.

---

## 🧪 Diagnostic Tests

To ensure robustness and validity of results, several econometric diagnostic tests were performed.

---

### 1️⃣ Model Specification & Correctness

#### Linktest
- Command: linktest
- Purpose: Detects model misspecification.
- Interpretation:
  - _hat should be significant
  - _hatsq should NOT be significant

#### Ramsey RESET Test
- Command: estat ovtest
- Purpose: Tests for omitted variables or incorrect functional form.
- Interpretation:
  - p > 0.05 → Model correctly specified
  - p < 0.05 → Possible misspecification

---

### 2️⃣ Model Selection (AIC & BIC)

- Command: estat ic
- Purpose: Compare models based on fit and complexity.
- Interpretation:
  - Lower AIC → Better fit
  - Lower BIC → More parsimonious model

---

### 3️⃣ Heteroskedasticity

#### Breusch-Pagan Test
- Command: hettest
- Null Hypothesis: Constant variance

#### White Test
- Command: estat imtest, white
- More general test for heteroskedasticity

📌 Result:
Heteroskedasticity was detected; hence robust standard errors were used.

---

### 4️⃣ Multicollinearity

#### Variance Inflation Factor (VIF)
- Command: estat vif

- Interpretation:
  - VIF < 5 → Safe
  - VIF > 10 → Problematic

📌 Note:
Higher VIFs in interaction terms are expected and not problematic.

---

### 5️⃣ Serial / Cluster Correlation

#### Durbin-Watson Test
- Command: estat dwatson
- Limited applicability for pooled cross-sections

#### Clustered Standard Errors
- Recommended approach:
```stata
vce(cluster Year)
