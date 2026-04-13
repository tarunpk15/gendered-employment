# 📈 Employment Impact Analysis: Difference-in-Differences and Event Study

## 📌 Research Overview
This document summarizes the empirical findings regarding the impact of COVID-19 on employment probabilities using two distinct approaches: a **Gendered Impact Study** (Relative Effect) and a **Total Population Impact Study** (Absolute Effect). The analysis compares static Difference-in-Differences (DiD) estimates with dynamic Event Study results using **2019 as the baseline year**.

---

## 1️⃣ Study A: Gendered Impact Analysis (Full Model)

### 🔬 Model Specification
This model estimates the relative shock to female employment compared to male employment, controlling for age, education, location, and industry.

**Static DiD Formula:**
$$Employment_{it} = \alpha + \beta_1 Female_i + \beta_2 Post_t + \delta (Female_i \times Post_t) + \gamma X_{it} + \epsilon_{it}$$

**Dynamic Event Study Formula:**
$$Employment_{it} = \alpha + \beta_1 Female_i + \sum_{k \neq 2019} \delta_k Year_k + \sum_{k \neq 2019} \lambda_k (Female_i \times Year_k) + \gamma X_{it} + \epsilon_{it}$$

### 📊 Results Summary

| Metric | Static DiD Estimator | Event Study (2020) | Event Study (2021) |
| :--- | :---: | :---: | :---: |
| **Coefficient** | **+0.0143*** | **-0.0097*** | **-0.0242*** |
| **P-Value** | < 0.001 | < 0.001 | < 0.001 |

#### **The DiD Decomposition (Averages & Differences)**
| Group | Pre-COVID (2018-19) | Post-COVID (2020-21) | **Difference (Time)** |
| :--- | :---: | :---: | :---: |
| **Male (Control)** | $\mu_{M, Pre}$ | $\mu_{M, Post}$ | $\Delta Male = +0.0206$ |
| **Female (Treatment)** | $\mu_{F, Pre}$ | $\mu_{F, Post}$ | $\Delta Female = +0.0349$ |
| **Difference (Gender)** | $-0.2607$ | $-0.2464$ | **DiD: +0.0143** |

### 💡 DiD vs. Event Study Comparison
* **The Static Illusion:** The static DiD (+0.0143) suggests a relative improvement for women in the post-period.
* **The Dynamic Reality:** The Event Study reveals a "Progress Interrupter" effect. While women were closing the gap rapidly in 2018 (-0.0624), the pandemic caused the gap to widen relative to 2019 in both 2020 (-0.0097) and 2021 (-0.0242).
* **Conclusion:** The Event Study proves that the pandemic halted a high-momentum convergence trend that was active in 2018-2019.

---

## 2️⃣ Study B: Total Population Impact (No Gender Constraints)

### 🔬 Model Specification
This model captures the absolute change in employment probability for the entire population, regardless of gender.

**Static DiD (Pre vs. Post) Formula:**
$$Employment_{it} = \alpha + \beta_1 Post_t + \gamma X_{it} + \epsilon_{it}$$

**Dynamic Event Study Formula:**
$$Employment_{it} = \alpha + \sum_{k \neq 2019} \delta_k Year_k + \gamma X_{it} + \epsilon_{it}$$

### 📊 Results Summary

| Metric | Static DiD Estimator | Event Study (2020) | Event Study (2021) |
| :--- | :---: | :---: | :---: |
| **Coefficient** | **+0.0262*** | **+0.0200*** | **+0.0345*** |
| **P-Value** | < 0.001 | < 0.001 | < 0.001 |

#### **The Impact Decomposition**
| Period | Adjusted Probability (Mean) | Absolute Change (Rel. to 2019) |
| :--- | :---: | :---: |
| **2018 (Pre)** | 0.1933 | +0.0023 |
| **2019 (Baseline)** | **0.1911** | **0.0000** |
| **2020 (Shock)** | 0.2111 | +0.0200 |
| **2021 (Recovery)** | 0.2256 | +0.0345 |

### 💡 DiD vs. Event Study Comparison
* **Static View:** The population-wide employment probability increased by an average of 2.6 percentage points in the post-COVID years.
* **Dynamic View:** The Event Study shows that the growth was significantly stronger in 2021 (+0.0345) than in 2020 (+0.0200).
* **Conclusion:** There was no absolute decline in total employment probability in this dataset. Instead, the pandemic acted as a "speed bump" on a long-term upward trajectory, with 2021 showing a stronger recovery than the initial shock year of 2020.

---

## 🏆 Synthesis & Final Conclusion

1.  **Absolute Growth vs. Relative Decline:** While the **Total Population Study** shows that absolute employment probability increased during the pandemic, the **Gendered Impact Study** reveals that the benefits of this growth were not shared equally.
2.  **The Trend-Break:** The Event Study is critical for this research because it exposes the **non-parallel trends**. In 2018, women were catching up to men at a rate of 6% per year. The pandemic not only stopped this catch-up but reversed it, as evidenced by the negative interactions in 2020 and 2021.
3.  **The 2021 Divergence:** Both studies show that 2021 was a year of significant change. In the total population, it was a year of rapid growth, but for women, it was the year the gap widened the most (-0.0242). This suggests that the "Recovery" phase was the period of greatest gendered divergence.

**Final Verdict:** The Event Study is the superior tool for this analysis as it successfully decomposes the "Average" DiD effect into a clear narrative of interrupted progress.