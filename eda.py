import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import statsmodels.api as sm
import statsmodels.formula.api as smf
from matplotlib.backends.backend_pdf import PdfPages
import re

# =================================================================
# 1. DATA PRE-PROCESSING & ERROR HANDLING
# =================================================================
def clean_and_prepare(df):
    """
    Ensures data types are correct and creates necessary interaction terms.
    """
    # Force numeric types to avoid formula errors
    numeric_cols = ['Age', 'Age_c', 'Age_c2', 'Female', 'Employment', 
                    'Rural', 'Married', 'Industry_ind', 'Industry_serv']
    for col in numeric_cols:
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors='coerce')
    
    # Ensure Year is an integer for categorical treatment
    df['Year'] = df['Year'].astype(int)
    df['Post'] = (df['Year'] >= 2020).astype(int)
    
    # Drop rows with NaNs in core variables to prevent model failure
    core_vars = ['Employment', 'Female', 'Year', 'Age_c']
    df = df.dropna(subset=core_vars)
    
    return df

# =================================================================
# 2. ROBUST COEFFICIENT EXTRACTOR (Fixes KeyError)
# =================================================================
def get_interaction_coef(model, year, target_var='Female'):
    """
    Dynamically finds interaction labels regardless of internal string ordering.
    """
    params = model.params.index.tolist()
    # Search for patterns like 'Female:C(Year)[T.2018]' or 'C(Year)[T.2018]:Female'
    pattern = rf"({target_var}.*T\.{year}|T\.{year}.*{target_var})"
    
    for p in params:
        if re.search(pattern, p):
            return p
    return None

# =================================================================
# 3. MAIN ANALYSIS PIPELINE
# =================================================================
def run_comprehensive_analysis(df, output_pdf="Labor_Market_Report.pdf"):
    df = clean_and_prepare(df)
    
    with PdfPages(output_pdf) as pdf:
        print("--- Page 1: Exploratory Data Analysis ---")
        fig1, axes = plt.subplots(2, 2, figsize=(16, 12))
        
        # A. Clustered Box Plot (High-Density handled by sampling)
        df_sample = df.sample(n=min(100000, len(df)))
        sns.boxplot(data=df_sample, x='Female', y='Age', hue='Employment', 
                    palette='vlag', ax=axes[0,0])
        axes[0,0].set_title('Age Dist. by Gender and Employment Status')
        
        # B. Correlation Heatmap
        corr_vars = ['Employment', 'Female', 'Age', 'Rural', 'Married', 'Industry_serv']
        sns.heatmap(df[corr_vars].corr(), annot=True, cmap='RdBu', center=0, ax=axes[0,1])
        axes[0,1].set_title('Correlation Matrix (Key Variables)')
        
        # C. Binned Scatter Plot (The Stata 'binscatter' equivalent)
        sns.regplot(data=df_sample[df_sample['Female']==1], x='Age', y='Employment', 
                    x_bins=20, scatter_kws={'alpha':0.3}, label='Female', color='red', ax=axes[1,0])
        sns.regplot(data=df_sample[df_sample['Female']==0], x='Age', y='Employment', 
                    x_bins=20, scatter_kws={'alpha':0.3}, label='Male', color='blue', ax=axes[1,0])
        axes[1,0].set_title('Binned Scatter: Employment Prob vs Age')
        axes[1,0].legend()

        # D. Hexbin Plot (Density Plot for quadratic Age)
        hb = axes[1,1].hexbin(df['Age_c'], df['Age_c2'], gridsize=30, cmap='YlGnBu')
        fig1.colorbar(hb, ax=axes[1,1], label='Frequency')
        axes[1,1].set_title('Density: Centered Age vs Squared Age')
        
        plt.tight_layout()
        pdf.savefig(fig1)
        plt.close(fig1)

        print("--- Page 2: Regression Results (DDD Model) ---")
        # Model 1: Triple Interaction (The "She-cession" Effect)
        # Robust SE (HC1) matches Stata's ', robust'
        formula_ddd = "Employment ~ Female * Post * Industry_serv + Age_c + Age_c2 + Edu_primary + Edu_secondary + Rural + Married + Industry_ind"
        model_ddd = smf.ols(formula_ddd, data=df).fit(cov_type='HC1')
        
        # Plotting Triple Interaction Coefficients
        fig2, ax2 = plt.subplots(figsize=(10, 6))
        # Keep only interaction terms for the plot
        keep_vars = [v for v in model_ddd.params.index if ':' in v]
        coef_df = pd.DataFrame({
            'var': keep_vars,
            'val': [model_ddd.params[v] for v in keep_vars],
            'err': [model_ddd.bse[v] for v in keep_vars]
        })
        ax2.errorbar(coef_df['val'], coef_df['var'], xerr=1.96*coef_df['err'], fmt='o', color='black')
        ax2.axvline(0, color='red', linestyle='--')
        ax2.set_title('Coefficients: Triple Interaction Model')
        
        pdf.savefig(fig2)
        plt.close(fig2)

        print("--- Page 3: Event Study Analysis ---")
        # Model 3: Dynamic Event Study (Base Year: 2019)
        formula_event = ("Employment ~ Female * C(Year) + Age_c + Age_c2 + "
                         "Edu_primary + Edu_secondary + Rural + Married + "
                         "Industry_ind + Industry_serv")
        model_event = smf.ols(formula_event, data=df).fit(cov_type='HC1')
        
        event_results = []
        for yr in [2018, 2020, 2021]:
            label = get_interaction_coef(model_event, yr)
            if label:
                event_results.append({
                    'Year': yr,
                    'Estimate': model_event.params[label],
                    'Lower': model_event.conf_int().loc[label][0],
                    'Upper': model_event.conf_int().loc[label][1]
                })
        
        # Add baseline 2019
        event_results.append({'Year': 2019, 'Estimate': 0, 'Lower': 0, 'Upper': 0})
        edf = pd.DataFrame(event_results).sort_values('Year')

        fig3 = plt.figure(figsize=(12, 6))
        plt.errorbar(edf['Year'], edf['Estimate'], 
                     yerr=[edf['Estimate'] - edf['Lower'], edf['Upper'] - edf['Estimate']],
                     fmt='-o', color='darkblue', capsize=5, lw=2)
        plt.axhline(0, color='red', linestyle='--')
        plt.title('Event Study: Dynamic Gendered Impact (Ref: 2019)')
        plt.xticks([2018, 2019, 2020, 2021])
        plt.ylabel('Relative Prob. Change (Female vs Male)')
        
        pdf.savefig(fig3)
        plt.close(fig3)

    print(f"Full analysis saved to: {output_pdf}")

# =================================================================
# EXECUTION
# =================================================================
if __name__ == "__main__":
    # Load your data here
    df = pd.read_stata("final_merged_pannel.dta")
    run_comprehensive_analysis(df)
    pass