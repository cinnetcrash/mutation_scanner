# Install and load necessary libraries
# install.packages(c("readxl", "dplyr", "tidyverse"))
library(readxl)
library(dplyr)
library(tidyverse)

long_data <- data %>% 
  pivot_longer(cols = c(ilu_ori, ilu_alt, ont_ori, ont_alt, ilu_dnv, hybrid), names_to = "Tool", values_to = "Mutation") %>% 
  separate_rows(Mutation, sep = ",")

# Count the mutations for each sample and tool
sample_mutation_counts <- long_data %>% 
  group_by(Sample_name, Tool) %>% 
  summarise(Mutation_Count = n()) %>%
  pivot_wider(names_from = Tool, values_from = Mutation_Count, values_fill = 0)

print(sample_mutation_counts)


# Get the mutation count for 'hybrid'
hybrid_counts <- sample_mutation_counts %>%
  pull(hybrid)

# Add 'hybrid' counts to the sample_mutation_counts data frame
sample_mutation_counts$hybrid_counts <- hybrid_counts

# Now perform the filtering based on the maximum count for 'hybrid'
hyb_best <- sample_mutation_counts %>%
  rowwise() %>%
  mutate(MaxCount = max(c_across(ilu_ori:hybrid_counts))) %>%
  filter(hybrid_counts == MaxCount)

# Remove the temporary columns
hyb_best$MaxCount <- NULL
hyb_best$hybrid_counts <- NULL

print(hyb_best)

# Get the mutation count for 'dnv'
dnv_counts <- sample_mutation_counts %>%
  pull(ilu_dnv)

# Add 'dnv' counts to the sample_mutation_counts data frame
sample_mutation_counts$dnv_counts <- dnv_counts

# Now perform the filtering based on the maximum count for 'dnv'
dnv_best <- sample_mutation_counts %>%
  rowwise() %>%
  mutate(MaxCount = max(c_across(ilu_ori:dnv_counts))) %>%
  filter(dnv_counts == MaxCount)

# Remove the temporary columns
dnv_best$MaxCount <- NULL
dnv_best$dnv_counts <- NULL

##SECOND PART OF THE CODE##

df <- data
df[is.na(df)] <- ""
df[df == 0] <- ""
tool_name <- "hybrid"  # replace with the tool you're interested in

# apply the function
output <- do.call(rbind, apply(df, 1, find_muts))

# print the output
print(output)
