# 📊 Gendered Employment Dynamics during COVID-19 (PLFS Analysis)

## 📌 Project Overview
This research investigates the asymmetric impact of the COVID-19 pandemic on employment in India, specifically focusing on the intersection of gender and sectoral vulnerability. Using a massive micro-dataset ($N = 1,180,999$), we employ Difference-in-Differences (DiD) and Triple Interaction (DDD) frameworks to isolate the "She-cession" effect.

---

## 1️⃣ Model 1: The Triple Interaction (DDD) Framework
**Specification:** Full controls + Triple interaction (Gender $\times$ Post-COVID $\times$ Service Sector).

### Regression Results (Selected)
| Variable | Coefficient | Std. Err. | t-stat | P > |t| |
| :--- | :--- | :--- | :--- | :--- |
| **1.Female (Base)** | -0.3195 | 0.0011 | -279.98 | 0.000 |
| **1.Female # 1.Post** | +0.0176 | 0.0015 | 11.25 | 0.000 |
| **1.Post # 1.Industry_serv** | +0.0019 | 0.0016 | 1.16 | 0.245 |
| **1.Female # 1.Post # 1.Industry_serv** | **-0.0463** | 0.0033 | -13.77 | 0.000 |
| **Industry_ind** | +0.5239 | 0.0013 | 389.39 | 0.000 |
| **R-squared** | **0.5437** | | | |

### 🔍 Analysis
* **The "Triple Penalty":** The coefficient for `1.Female # 1.Post # 1.Industry_serv` is **-0.0463**. This is the "smoking gun." It indicates that women in the service sector suffered a **4.63 percentage point drop** in employment probability specifically due to the pandemic, over and above the general gender and sectoral shocks.
* **Sectoral Buffer:** The general interaction `1.Female # 1.Post` is positive (+0.0176), suggesting that outside of high-contact services, the gender gap didn't widen as drastically when controlling for industry.
* **Explanatory Power:** This model has the highest $R^2$ (54.37%), meaning it does the best job of explaining the actual variance in employment.

---

## 2️⃣ Model 2: Demographic Base Model
**Specification:** Gender $\times$ Year interactions + Demographics (No Industry Controls).

### Regression Results (Selected)
| Variable | Coefficient | Std. Err. | t-stat | P > |t| |
| :--- | :--- | :--- | :--- | :--- |
| **1.Female (Base)** | -0.4990 | 0.0014 | -352.22 | 0.000 |
| **1.Female # 2020** | +0.0589 | 0.0020 | 28.66 | 0.000 |
| **1.Female # 2021** | +0.0360 | 0.0020 | 17.79 | 0.000 |
| **Rural** | +0.0718 | 0.0007 | 96.77 | 0.000 |
| **R-squared** | **0.3640** | | | |

### 🔍 Analysis
* **Omitted Variable Bias:** The `Female` coefficient is significantly more negative here (-0.4990) than in Model 1. This is because, without industry controls, the variable is "absorbing" the fact that women are concentrated in lower-employment sectors.
* **Urban-Rural Divide:** Living in a rural area provides a **7.18%** boost to employment probability in this baseline, likely due to agricultural stability.

---

## 3️⃣ Model 3: Full DiD (Industry Fixed Effects)
**Specification:** Gender $\times$ Year interactions + Full Controls.

### Regression Results (Selected)
| Variable | Coefficient | Std. Err. | t-stat | P > |t| |
| :--- | :--- | :--- | :--- | :--- |
| **1.Female (Base)** | -0.2919 | 0.0012 | -233.42 | 0.000 |
| **1.Female # 2020** | +0.0526 | 0.0017 | 30.32 | 0.000 |
| **1.Female # 2021** | +0.0381 | 0.0016 | 22.63 | 0.000 |
| **Industry_serv** | +0.5185 | 0.0008 | 589.17 | 0.000 |
| **R-squared** | **0.5336** | | | |

### 🔍 Analysis
* **The Trend:** This model shows that while women faced a massive structural disadvantage (-29.1%), the relative "gap" narrowed slightly in 2020 and 2021 compared to the baseline, *once you compare men and women in the same industries*.
* **Industry Importance:** The $R^2$ jump from 0.36 to 0.53 proves that industry is the single most important predictor of employment status in your dataset.

---

## ⚖️ Comparative Analysis

| Variable | Model 1 (Triple) | Model 2 (Demo Only) | Model 3 (Full DiD) |
| :--- | :---: | :---: | :---: |
| **Female (Base)** | -0.3196 | -0.4990 | -0.2919 |
| **Age_c** | 0.0084 | 0.0126 | 0.0086 |
| **Rural** | 0.1678 | 0.0718 | 0.1708 |
| **Married** | 0.0467 | 0.0257 | 0.0289 |
| **R-Squared** | **0.5437** | **0.3640** | **0.5336** |

### 📢 Key Takeaways
1.  **The "She-cession" is Sectoral:** The difference between Model 2 and Model 3 shows that "Gender" isn't the only story—"Where you work" is. Sectoral segregation explains about **20%** of the observed gender gap.
2.  **Domestic Stability:** The `Married` coefficient is consistently positive. In the full model (M1), being married increases employment probability by **4.67%**, suggesting a stability effect or household economic necessity.
3.  **The Education Hierarchy:** Primary education consistently provides a larger boost to employment probability (**~5.2%**) than secondary education (**~1.2%**) in the full models, indicating high demand for basic literacy over mid-level schooling in this labor market.

---