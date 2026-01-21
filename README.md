# Designing-a-Measure-of-County-Level-Nutritious-Food-Access
# Designing a Measure of County-Level Nutritious Food Access
--- 
# Research Question
**What are the determinants and their measurable effects of nutritious food attainment within county-level food systems in the United States?**

- This project shifts the focus from traditional food security measures toward **nutrition security and nutritious food access**, emphasizing quality, affordability, and structural access rather than caloric sufficiency alone.

---

## Conceptual Development 
- Developed two conceptual models to frame nutrition security at the county level.
- **Conceptual Model 1**: Detailed, domain-rich framework separating food access, affordability, nutritional adequacy, and socioeconomic context.
- **Conceptual Model 2**: Simplified, socioecological model inspired by Seligman et al. (2023) and UNICEF frameworks.
- Key design decisions:
    
    - County as the unit of analysis for policy relevance.
    - Explicit recognition of structural and institutional determinants.
    - Alignment with socioecological and food systems literature.
Status: **Conceptual framework finalized and defensible**.
---
# Data Construction and Management 

## Data Sources

- USDA Food Access Research Atlas (FARA)
- USDA Food Environment Atlas (FEA)
## Database and Cleaning

- Built SQL database combining FARA and FEA.
- Aggregated tract-level and county-level data into ~3,140 U.S. counties.
- Initial variable audit: **441 variables**.
- Theoretical and statistical reduction: **441 → 337 → 164 → final analytic set**.
- Removed variables with:
    - > 50% missingness
    - Extreme multicollinearity (|r| > 0.9)
- Missing data handled using **Multiple Imputation by Chained Equations (MICE)**.
- All variables standardized using z-scores.
Status: **Final analytic dataset complete and reproducible**.

---
# Exploratory Factor Analysis 

## Diagnostics
- Kaiser-Meyer-Olkin (KMO) tests ensure factorability (MSA ≥ 0.6).
- Correlation matrices examined within and across domains.
## Factor Selection
- Used scree plots, parallel analysis, Kaiser criterion, and Velicer’s MAP test.
- Iterative variable pruning based on:
    - Factor loadings (|λ| ≥ 0.4–0.6)
    - Communalities
    - Cross-loadings
- Switched estimator from ML to **Principal Axis Factoring**, substantially improving coherence.
## Final EFA Solution
**5 latent factors, 20 observed variables**:
1. Economic Hardship & Nutrition Assistance Reliance
2. Geographic Food Inaccessibility
3. Urban Market Access
4. Alternative & Supplemental Food Outlets
5. Retail Food Environment


---

# Confirmatory Factor Analysis 
- Estimated CFA using Maximum Likelihood.
- Model fit:
    - RMSEA ≈ 0.03
    - TLI ≈ 0.82
- Produced finalized CFA path diagram.
- Estimated county-level factor scores (F1–F5) for all counties.
- Attempted higher-order (hierarchical) models; rejected due to weak inter-factor correlations.

---
# Spatial Mapping and Rankings 
- Generated 1,000+ county-level maps of factor scores.
- Constructed county rankings for each factor.
- Aggregated county scores to states using:
	- Unweighted averages    
    - Population-weighted averages    
- Reoriented factors so higher scores represent more favorable food environments.
- Patterns align with external benchmarks (e.g., U.S. News Healthiest Communities).

---
# Health Outcome Analysis (Completed)
## Health Data
- CDC PLACES (2017–2018)
- Outcomes analyzed:
    - Heart disease
    - Stroke
    - Diabetes
    - Obesity

### Models

- Initial beta regressions (bounded outcomes)
- Final models use OLS for interpretability.
- Estimated models using raw and standardized factor scores.

### Core Findings

- **Economic Hardship**: Strong positive association with all adverse health outcomes.
- **Geographic Food Inaccessibility**: Weak or inconsistent effects.
- **Urban Market Access**: Positive association with several chronic diseases, reflecting urban disadvantage.
- **Alternative Food Outlets**: Consistently protective.
- **Retail Food Environment**: Modest but significant associations.

---
# Contributions 
- First empirically derived, county-level **multidimensional measure of nutritious food access**.
- Variable weights determined by data (factor analysis), not expert opinion.
- Demonstrates dominance of structural economic disadvantage in diet-related disease prevalence.
- Provides a flexible framework for Bayesian, spatial, or longitudinal extensions.

---
# Known Limitations
- Some factors sensitive to imputation and missing retail data.
- Cross-sectional design limits causal inference.
- Urban access factor reflects institutional overlap rather than pure availability.

---
# Remaining / Future Work

- Optional Bayesian latent trait estimation.
- Spatial spillover modeling.
- Robustness checks using alternative health outcomes or years.
- Final write-up and framing for policy audiences.
