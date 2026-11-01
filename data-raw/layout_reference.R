library(tidyverse)
library(readxl)
## code to prepare `layout_reference` dataset goes here

#importing the 96 well plate layout reference table
#choose the location of 'plate layout.xlsx
#   Idea: put the function in a custom package along with this table a constant for easier reference
#   This section the becomes obsolete
layout_path <- file.choose()

#importing from the spreadsheet
layout_wide <- read_excel(path = layout_path,
                          sheet = 1, range = "A1:M9",
                          col_names = F,
                          col_types = "text")
#remove header
layout_wide <- layout_wide[-1, ]

#assigning the correct row labels
names(layout_wide) <- c("Row", as.character(1:12))

#converting the grid into one row per well
layout_reference <- layout_wide |>
  mutate(Row = str_trim(Row)) |>
  pivot_longer(cols = -Row,
               names_to = "Column",
               values_to = "Additive") |>
  mutate(Column  = as.integer(Column), #this is important for later function
         Additive = str_trim(Additive)) #this removes the space before '-'

usethis::use_data(
  layout_reference,
  overwrite = TRUE,
  compress = "xz"
)


usethis::use_data(layout_reference, overwrite = TRUE)
