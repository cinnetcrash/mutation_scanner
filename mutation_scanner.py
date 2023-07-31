import pandas as pd

# Function to find unique, same, and other mutations
def find_muts(x, tool_name):
    chosen = x[tool_name].str.split(',').explode()
    others = x.drop(columns=[tool_name]).stack().str.split(',').explode()
    unique = set(chosen) - set(others)
    if len(unique) == 0:
        unique = ["XYZ"]
    same = set(chosen) & set(others)
    same_all = set(x.stack().str.split(',').explode()) & set(chosen)
    other = set(x.stack().str.split(',').explode()) - set(chosen)
    return {
        "Sample_name": x["Sample_name"].iloc[0],
        "tool_mut": ",".join(unique),
        "same_muts": ",".join(same),
        "same_muts_all": ",".join(same_all),
        "other_mut": ",".join(other)
    }

# Read data from the Excel file
# Replace 'path_to_file.xlsx' with the actual path to your Excel file
data = pd.read_excel('hybrid_subsitutions_real.xlsx')

# Separate mutations by "," character and convert data to long format
long_data = data.melt(id_vars=["Sample_name"], var_name="Tool", value_name="Mutation")
long_data["Mutation"] = long_data["Mutation"].str.split(',')

# Find unique mutations for 'hybrid' tool
unique_mutations = long_data.groupby(["Sample_name", "Mutation"])["Tool"].nunique().reset_index()
unique_mutations = unique_mutations[unique_mutations["Tool"] == 1].drop(columns=["Tool"])

# Print unique mutations
print(unique_mutations)

# Count the mutations for each tool
mutation_counts = long_data.groupby(["Mutation", "Tool"]).size().unstack(fill_value=0)

# Count the unique mutations for 'hybrid' method
u_mutation_counts = unique_mutations.groupby("Mutation").size().reset_index(name="hybrid")
u_mutation_counts = u_mutation_counts.sort_values(by="hybrid", ascending=False)

# Print unique mutation counts
print(u_mutation_counts)

# Print mutation counts
print(mutation_counts)
