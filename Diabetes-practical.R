# Read in the diabetes file
diabetes_data <- read.csv("diabetes-md.csv", na ="")

# What type is the data?
class(diabetes_data)
str(diabetes_data)
dim(diabetes_data)
row(diabetes_data)

# Examine missing data
diabetes_data[!complete.cases(diabetes_data),]

# Install the mice package if not already installed
install.packages("mice")
library(mice)
md.pattern(diabetes_data)

library(VIM)
missing_values <- aggr(diabetes_data, prop = FALSE, numbers = TRUE)

# Show content of missing values
summary(missing_values)










