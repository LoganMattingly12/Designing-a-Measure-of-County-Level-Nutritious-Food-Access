#testing file
df = read.csv("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\Working Data\\thesis_data_impute_z_KMO_01.csv")
#install.packages('EFA.dimensions')
library(writexl)
library(EFA.dimensions)
library(psych)
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
MAP(df,corkind = 'pearson',verbose = TRUE)

fa = fa(r = df,nfactors = 5, rotate = 'varimax')
summary(fa)

# Add variable names as a column instead of just row names
loadings_df <- as.data.frame(unclass(load))
loadings_df <- cbind(Variable = rownames(loadings_df), loadings_df)

#to excel
write_xlsx(loadings_df, "C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\Working Data\\factor_loadings.xlsx")
