# Install and load necessary libraries
# install.packages(c("readxl", "dplyr", "tidyverse"))
library(readxl)
library(dplyr)
library(tidyverse)

# Read data from the Excel file
# Replace 'path_to_file.xlsx' with the actual path to your Excel file
data <- read_excel('hybrid_subsitutions_real.xlsx')

# Separate mutations by "," character and convert data to long format
long_data <- data %>% 
  pivot_longer(cols = c(ilu_ori, ilu_alt, ont_ori, ont_alt, ilu_dnv, hybrid), names_to = "Tool", values_to = "Mutation") %>% 
  separate_rows(Mutation, sep = ",")

# Find unique mutations for 'hybrid'
unique_mutations <- long_data %>%
  group_by(Sample_name, Mutation) %>%
  summarise(hybrid = sum(Tool == "hybrid"), other = sum(Tool != "hybrid")) %>%
  filter(hybrid >= 1, other == 0) %>%
  select(Sample_name, Mutation)

# Print unique mutations
print(unique_mutations)

# Count the mutations for each tool
mutation_counts <- long_data %>% 
  count(Mutation, Tool) %>% 
  pivot_wider(names_from = Tool, values_from = n, values_fill = 0)

# Count the unique mutations for 'hybrid' method
u_mutation_counts <- unique_mutations %>%
  group_by(Mutation) %>%
  summarise(hybrid = n())

u_mutation_counts <- u_mutation_counts %>% 
  arrange(desc(hybrid))

# Print unique mutation counts
print(u_mutation_counts)


# Print mutation counts
print(mutation_counts)
