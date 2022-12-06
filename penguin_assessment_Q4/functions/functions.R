
#creation of data cleaning function
data_cleaning <- function(data_raw){
  data_raw %>%
    clean_names() %>%
    remove_empty(c("rows", "cols")) %>%
    select(-starts_with("delta")) %>%
    select(-comments)
}


#removes rows containing N/A in bodymass, selects species and bodymass columns
remove_empty_bodymass <- function(penguin_data_clean){
  penguin_data_clean %>%
    filter(!is.na(flipper_length_mm)) %>%
    select(species, body_mass_g)
}


#removes adelie species from dataset and renames gentoo and chinstrap
remove_adelie <- function(removed_empty_bodymass){
    subset(removed_empty_bodymass, species != "Adelie Penguin (Pygoscelis adeliae)") 
}








