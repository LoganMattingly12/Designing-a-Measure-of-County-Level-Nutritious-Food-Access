install.packages("semPlots")
install.packages("lavaanPlot")
library(lavaanPlot)
library(lavaan)
library(dplyr)
library(psych)      # optional, for describe and scale helpers
library(semTools)
library(semPlots)
df = read.csv("/Users/loganmattingly/Library/CloudStorage/OneDrive-MississippiStateUniversity/Thesis/Data/Working Data/thesis_data_impute_z_KMO_01.csv")
#df = read.csv("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\Working Data\\thesis_data_impute_z_KMO_01.csv")
drops = c('State','County', 'FIPS','X__Population_under_age_18__2010','Group_quarters___population_residing_in__share','Recreation___fitness_facilities_1_000_pop__2011'
          ,'Low_income_and_low_access__measured_at_1_mile_for_urban_areas_and_10_miles_for_rural_areas__rate_','Low_access__using_vehicle_access_and_at_20_miles_in_rural_areas__rate_'
          ,'Berry_acres_1_000_pop__2012','Orchard_acres_1_000_pop__2012','Small_slaughterhouse_facilities__2012','Vegetable_acres_harvested_1_000_pop__2012','FDPIR_Sites__2015'
          ,'Students_eligible_for_reduced_price_lunch______2015','Summer_Food_Service_Program_participants____children___2017_','WIC_redemptions_WIC_authorized_stores__2016'
          ,'General_food_sales_tax__retail_stores__2014_','Soda_sales_tax__retail_stores__2014_','Convenience_stores_1_000_pop__2016','Farmers__markets_1_000_pop__2018'
          ,'Food_Banks__2018','Specialized_food_stores_1_000_pop__2016','Supercenters___club_stores_1_000_pop__2016','Fast_food_restaurants_1_000_pop__2016','Direct_farm_sales_per_capita__2012'
          ,'Direct_farm_sales__2012','Expenditures_per_capita__fast_food__2012_','Adult_diabetes_rate__2013','SNAP_households__low_access_to_store______2015'
          ,'Low_access__low_income_population_at_1_mile__share','Low_access_housing_units_receiving_SNAP_benefits_at_10_miles__share'
          ,'Expenditures_per_capita__restaurants__2012_','Farms_with_direct_sales______2012','SNAP_authorized_stores_1_000_pop__2017')
df = df[ , !(names(df) %in% drops)]

df_clean <- df %>%
  rename(
    # Factor 1
    low_income_rate        = Low_income___rate_,
    median_income          = Median_household_income__2015,
    no_car_low_access      = Households__no_car___low_access_to_store______2010,
    snap_hu_1mi            = Low_access__housing_units_receiving_SNAP_benefits_at_1_mile__share,
    snap_benefits_pc       = SNAP_benefits_per_capita__2017,
    free_lunch             = Students_eligible_for_free_lunch______2015,
    
    # Factor 2
    pop_low_access         = Population__low_access_to_store______2015,
    pop_low_access_10mi    = Low_access__population_at_10_miles__share,
    pop_lowinc_10mi        = Low_access__low_income_population_at_10_miles__share,
    low_access_urban_rural = Low_access__at_1_mile_for_urban_areas_and_10_miles_for_rural_areas__rate_,
    
    # Factor 3
    pop_65plus             = X__Population_65_years_or_older__2010,
    urban_rate             = Urban___rate_,
    snap_redemptions       = SNAP_redemptions_SNAP_authorized_stores__2017,
    
    # Factor 4
    fm_accept_snap         = Farmers__markets_that_report_accepting_SNAP______2018,
    fm_accept_wic          = Farmers__markets_that_report_accepting_WIC______2018,
    fm_accept_wiccash      = Farmers__markets_that_report_accepting_WIC_Cash______2018,
    fm_sell_animal         = Farmers__markets_that_report_selling_animal_products______2018,
    
    # Factor 5
    grocery_stores_pc      = Grocery_stores_1_000_pop__2016,
    wic_stores_pc          = WIC_authorized_stores_1_000_pop__2016,
    fullservice_restaurants_pc = Full_service_restaurants_1_000_pop__2016
)

model <- '
    # Factor 1: Economic Hardship and Nutrition Assistance Reliance
    F1_hardship =~ low_income_rate
                 + median_income
                 + no_car_low_access
                 + snap_hu_1mi
                 + snap_benefits_pc
                 + free_lunch

    # Factor 2: Geographic Food Inaccessibility
    F2_geo_inacc =~ pop_low_access
                  + pop_low_access_10mi
                  + pop_lowinc_10mi
                  + low_access_urban_rural

    # Factor 3: Urban Market Access
    F3_urban_access =~ pop_65plus
                     + urban_rate
                     + snap_redemptions

    # Factor 4: Alternative and Supplemental Food Outlets
    F4_alt_outlets =~ fm_accept_snap
                    + fm_accept_wic
                    + fm_accept_wiccash
                    + fm_sell_animal

    # Factor 5: Retail Food Environment
    F5_retail_env =~ grocery_stores_pc
                   + wic_stores_pc
                   + fullservice_restaurants_pc
                   
    Healthy_food_access =~ F1_hardship
                          + F2_geo_inacc
                          + F3_urban_access
                          + F4_alt_outlets
                          + F5_retail_env
                   

'
fit <- cfa(model, data = df_clean, estimator = "ML", std.lv = TRUE)
summary(fit, fit.measures = TRUE, standardized = TRUE)

inspect(fit,'cor.lv')




lavaanPlot(model = fit, 
           coefs = TRUE, 
           stand = TRUE, 
           covs = TRUE, 
           stars = "all")
