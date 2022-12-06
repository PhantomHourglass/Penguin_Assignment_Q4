setwd("~/Documents/Year 3/penguin_assessment_Q4") 

source("functions/libraries.R") #loading in required libraries
source("functions/functions.R") #loading in functions
source("functions/plotting.R") #loading in functions related to plotting

write.csv(penguins_raw, "data_raw/penguins_raw.csv") #preserving a read only version of the raw data

penguin_data_clean <- data_cleaning(penguins_raw) #cleaning data
names(penguin_data_clean) #checking result of cleaning
head(penguin_data_clean)

write.csv(penguin_data_clean, "data_clean/penguin_data_clean.csv") #preserving copy of clean data

#removing N/A bodymass values
removed_empty_bodymass <- remove_empty_bodymass(penguin_data_clean)

#removing adelie species from dataset
gentoo_and_chinstrap <- remove_adelie(removed_empty_bodymass)
print(gentoo_and_chinstrap, n = 300)

#shapiro-wilk test to test normality of gentoo bodymass data
shapiro_wilk_gentoo <- with(gentoo_and_chinstrap, shapiro.test(body_mass_g[species == "gentoo"]))
shapiro_wilk_gentoo#p = 0.2336 therefore accept H0, data is normally distributed

#shapiro-wilk test to test normality of chinstrap bodymass data
shapiro_wilk_chinstrap <- with(gentoo_and_chinstrap, shapiro.test(body_mass_g[species == "chinstrap"])) #p = 0.5605
shapiro_wilk_chinstrap #p = 0.5605 therefore accept H0, data is normally distributed

var.test(body_mass_g ~ species, data = gentoo_and_chinstrap) #p = 0.01559 there is a significant difference 
#between the variances of the 2 species' bodymass therefore use Welch's t test

welch_t_test <- t.test(body_mass_g ~ species, data = gentoo_and_chinstrap, var.equal = FALSE)
welch_t_test #p = 2.2e-16


#plotting overlapping histogram
save_bodymass_plot_png(gentoo_and_chinstrap)

save_bodymass_plot_svg(gentoo_and_chinstrap)
