# -*- coding: utf-8 -*-
"""
Created on Fri Apr 25 19:47:24 2025

@author: ltmat
"""
# my rendition on the code from Parallel Analysis_2

import pandas as pd
from factor_analyzer import FactorAnalyzer
import numpy as np
import matplotlib.pyplot as plt

def _HornParallelAnalysis(data, K=1000, printEigenvalues=False):
    ################
    # Create a random matrix to match the dataset
    ################
    n, m = data.shape
    # Set the factor analysis parameters
    fa = FactorAnalyzer(n_factors=1, method='minres', rotation=None, use_smc=True)
    # Create arrays to store the values
    sumFactorEigens = np.empty(m)
    # Run the fit 'K' times over a random matrix
    for runNum in range(0, K):
        fa.fit(np.random.normal(size=(n, m)))
        sumFactorEigens = sumFactorEigens + fa.get_eigenvalues()[1]
    # Average over the number of runs
    avgFactorEigens = sumFactorEigens / K

    ################
    # Get the eigenvalues for the fit on supplied data
    ################
    fa.fit(data)
    dataEv = fa.get_eigenvalues()

    ################
    ### Print results
    ################
    if printEigenvalues:
        print('Average Factor eigenvalues for random matrix:\n', avgFactorEigens)
        print('Factor eigenvalues for data:\n', dataEv[1])
    
    # Find the suggested stopping points
    suggestedFactors = sum((dataEv[1] - avgFactorEigens) > 0)
 
    print('Parallel analysis suggests that the number of factors = ', suggestedFactors)
   
    ################
    ### Plot the eigenvalues against the number of variables
    ################
    plt.figure(figsize=(18,10))
    # Line for eigenvalue 1
    plt.plot([0, m+1], [1, 1], 'k--', alpha=0.5)
    # For the random data - Factors
    plt.plot(range(1, m+1), avgFactorEigens, 'r', label='FA - random', alpha=1)
    plt.scatter(range(1, m+1), avgFactorEigens, c='r', marker='o')
    # For the Data - Factors
    plt.scatter(range(1, m+1), dataEv[1], c='b', marker='o')
    plt.plot(range(1, m+1), dataEv[1], 'b', label='FA - data')
    plt.title('Parallel Analysis Scree Plots', fontsize=20)
    plt.xlabel('Factors', fontsize=15)
    plt.xticks(ticks=range(1, m+1), labels=range(1, m+1))
    plt.ylabel('Eigenvalue', fontsize=15)
    plt.legend()
    plt.show()

    ################
    ### Create and return a dataframe of the results using column names
    ################
    factor_summary = pd.DataFrame({
        'Variable': data.columns,  # <<=== here is the change!
        'Real_Eigenvalue': dataEv[1],
        'Random_Eigenvalue': avgFactorEigens,
        'Keep': (dataEv[1] - avgFactorEigens) > 0
    })

    return suggestedFactors, factor_summary

################
# Load data and run analysis
################
df = pd.read_csv("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\Working Data\\thesis_data_impute_z_KMO_01.csv") 
df_text = df[['State', 'County', 'FIPS']]
df = df.drop(columns=['State', 'County', 'FIPS'])
variables = [
    "__Population_65_years_or_older__2010",
    "__Population_under_age_18__2010",
    "Group_quarters___population_residing_in__share",
    "Urban___rate_",
    "Low_income___rate_",
    "Median_household_income__2015",
    "Adult_diabetes_rate__2013",
    "Recreation___fitness_facilities_1_000_pop__2011",
    "Population__low_access_to_store______2015",
    "SNAP_households__low_access_to_store______2015",
    "Households__no_car___low_access_to_store______2010",
    "Low_access__low_income_population_at_1_mile__share",
    "Low_access__housing_units_receiving_SNAP_benefits_at_1_mile__share"
]
#df = df[variables]

# Run updated parallel analysis
suggestedFactors, factor_info_df = _HornParallelAnalysis(df, K=10, printEigenvalues=True)

# Show the factor summary
#print(factor_info_df)