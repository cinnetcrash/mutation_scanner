## R Functions README

This README provides an overview of three R functions along with additional code snippets for mutation data analysis. The functions and code snippets are designed to process mutation data, calculate mutation counts, and identify unique mutations for specific tools.

### 1. `sample_mutation_counts` Function

#### Function Description

The `sample_mutation_counts` function processes mutation data in a long format and calculates the mutation counts for each sample and tool. It performs the following steps:

1. Reads data from an Excel file specified by the file path.
2. Separates mutations by the "," character and converts the data to a long format using `pivot_longer` and `separate_rows`.
3. Finds unique mutations for the 'hybrid' tool by grouping the data and filtering mutations with only 'hybrid' occurrences and no occurrences with other tools.
4. Prints the resulting data frame containing the unique mutations for the 'hybrid' tool.
5. Counts the mutations for each tool using `count` and transforms the data to a wide format using `pivot_wider`.
6. Prints the resulting data frame containing mutation counts for each tool.

#### Example Usage

```R
# Ensure that the required libraries are installed and loaded
# install.packages(c("readxl", "dplyr", "tidyverse"))
library(readxl)
library(dplyr)
library(tidyverse)

# Read data from the Excel file, replace 'path_to_file.xlsx' with the actual path to your Excel file
data <- read_excel('hybrid_subsitutions_real.xlsx')

# Applying the sample_mutation_counts function
result_unique_mutations <- sample_mutation_counts(data)

# Printing the unique mutations for 'hybrid' tool
print(result_unique_mutations)

# Printing the mutation counts for each tool
print(result_mutation_counts)

Feel free to use these R functions and code snippets in your projects and customize them to suit your specific needs. The sample_mutation_counts function will help you obtain mutation counts for each sample and tool, while the find_muts function can be utilized to extract unique, same, and other mutations for a given tool. Additionally, the provided code snippets demonstrate how to calculate mutation counts for each tool and identify unique mutation counts for the 'hybrid' method.

Author: Ege Dedeoğlu, Gültekin Ünal

License: MIT License, 2023
