library(readxl)
library(dplyr)


factor_scores_df = read.csv("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\Working Data\\factor_scores_01.csv")
heart_d = read_excel("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\CDC Places Project\\Heart Disease.xlsx")
stroke = read_excel("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\CDC Places Project\\Stroke.xlsx")
diabetes =  read_excel("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\CDC Places Project\\Diabetes.xlsx")
obesity =  read_excel("C:\\Users\\ltm215\\OneDrive - Mississippi State University\\Thesis\\Data\\CDC Places Project\\Obesity.xlsx")

factor_scores_df_s = factor_scores_df %>% mutate_at(c('F1_hardship', 'F2_geo_inacc','F3_urban_access', 'F4_alt_outlets','F5_retail_env'), ~(scale(.) %>% as.vector))
factor_scores_df_s$F4_alt_outlets =factor_scores_df_s$F4_alt_outlets * -1

#data
d_trans = (diabetes$Data_Value) #health outcome
X = factor_scores_df_s$F5_retail_env#factor

#model
model_1 = lm(d_trans ~ X )
summary(model_1)


