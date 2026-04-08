# Econometric Research Note: DiD and Event Study Analysis

## 1. Project Overview
This research employs quasi-experimental econometric techniques to isolate the causal impact of the COVID-19 pandemic on gender-based employment outcomes. Utilizing a dataset of **1,180,999 observations**, we move beyond simple correlations to test the "She-cession" hypothesis using **Difference-in-Differences (DiD)** and **Dynamic Event Study** methodologies. 

By comparing females (Treatment Group) against males (Control Group) across the 2018–2021 period, we identify not only the immediate shock of the pandemic but also the structural reversal of pre-existing progress in the labor market.

---

## 2. Problem Statement
The COVID-19 pandemic introduced an exogenous shock that disproportionately affected high-contact service sectors. This study seeks to determine:
1.  **The Counterfactual:** What would have happened to female employment if the pandemic had not occurred?
2.  **Trend Interruption:** Did the pandemic widen a stable gap, or did it halt a narrowing trend?
3.  **The Recovery Gap:** Did the gendered impact intensify during the "reopening" phase of 2021?

---

## 3. Methodology & Model Specifications

### 3.1 Standard Difference-in-Differences (DiD)
The DiD model compares the changes in outcomes over time between a group that is affected by an event and a group that is not.
* **Equation:** $$Employment_{it} = \beta_0 + \beta_1 Female_i + \beta_2 Post_t + \delta(Female_i \times Post_t) + \gamma X_{it} + \epsilon_{it}$$
* **Logic:** It collapses the timeline into "Pre" (2018-2019) and "Post" (2020-2021). The coefficient $\delta$ (`1.Female#1.Post`) provides the Average Treatment Effect on the Treated (ATT).

### 3.2 The Event Study (Dynamic DiD)
The Event Study is a granular version of the DiD that interacts the treatment group with individual years, using **2019 as the excluded baseline year**.
* **Logic:** * **2018 Interaction:** Tests the **Parallel Trends Assumption**.
    * **2020/2021 Interactions:** Captures the dynamic evolution of the shock and the "She-cession" during the recovery.

---

## 4. Empirical Results: The DiD Table

The following table summarizes the **4 Averages** (Cell Means) and the **3 Differences** calculated from the `margins` and `regression` output.

| Group | Pre-COVID (2018-19) | Post-COVID (2020-21) | **Difference (Time)** |
| :--- | :---: | :---: | :---: |
| **Male (Control)** | 0.5828 | 0.6034 | **+0.0206*** |
| **Female (Treatment)** | 0.3221 | 0.3570 | **+0.0349*** |
| **Baseline Gap (Gender)** | **-0.2607*** | **-0.2464*** | **DiD: +0.0143*** |

> **Note:** All values represent the adjusted probability of employment. * denotes statistical significance at the 0.1% level ($p < 0.001$).

---

## 5. Event Study Results (Dynamic Analysis)

While the standard DiD provides an average, the Event Study identifies the year-by-year trajectory relative to the **2019 baseline**.

* **2018 Pre-Trend (-0.0624):** The gap was significantly wider in 2018. This proves that women were already closing the gap rapidly before the pandemic started.
* **2020 Shock (-0.0097):** In the immediate first year of the pandemic, the gap widened slightly (approx. 1%) relative to the 2019 baseline.
* **2021 Divergence (-0.0242):** The gap widened significantly during the recovery phase, indicating an asymmetric return to work.

---

## 6. Detailed Inferences

### 6.1 The "Progress Interrupter" Inference
The standard DiD estimator (**+0.0143**) is positive, which might suggest a relative improvement. However, when viewed alongside the **4 Averages**, it is clear that women have a massive baseline disadvantage (32.2% vs 58.3%). 
The Event Study confirms that the positive DiD is a result of a **Trend-Break**. Women were narrowing the gap by over 6% in 2018. The pandemic successfully halted this momentum, essentially "freezing" the gap and then causing it to widen again by 2021.

### 6.2 The Asymmetric Recovery (2021 vs. 2020)
The cell means show that while women's employment probability rose to **0.3570** in the post-period, the distance between men and women increased between 2020 and 2021. This confirms that the "She-cession" is most visible not during the lockdown itself, but during the **uneven reopening**, where men re-entered the workforce at a faster rate than women.

### 6.3 Control Variable Stability
The consistency of controls confirms the robustness of the DiD results:
* **Industry Factor:** Working in the Industrial sector (**+0.5488**) remains the strongest predictor of employment.
* **Rural Advantage:** Rural residency provides a **17.09%** higher probability of employment, likely due to the "essential" nature of agricultural work.
* **Marital Premium:** Being married provides a **2.9%** boost to employment probability, likely reflecting household economic stability.

---

## 7. Conclusion
The DiD and Event Study combination proves that the COVID-19 pandemic was a "Service Sector She-cession" that primarily acted as a **Progress Interruptor**. Before the pandemic, women were on a statistically significant path toward closing the employment gap. The pandemic halted this convergence. The significant divergence in 2021 (**-0.0242**) highlights that women faced higher barriers to re-entering the labor market than men, likely due to domestic burdens and sectoral volatility.

---
*Documented for Applied Econometrics Project - April 2026*