# function to find unique, same, and other mutations
find_muts <- function(x) {
  chosen <- strsplit(as.character(x[tool_name]), ",")[[1]]
  others <- unlist(strsplit(as.character(x[x != x[tool_name]]), ","))
  unique <- setdiff(chosen, others)
  if(length(unique) == 0) unique <- "XYZ"
  same <- intersect(chosen, others)
  same_all <- intersect(unlist(strsplit(as.character(x), ",")), chosen)
  other <- setdiff(unlist(strsplit(as.character(x), ",")), chosen)
  list(Sample_name = as.character(x["Sample_name"]), tool_mut = paste(unique, collapse = ","), 
       same_muts = paste(same, collapse = ","),
       same_muts_all = paste(same_all, collapse = ","), 
       other_mut = paste(unique(other), collapse = ","))
}

