# Read in the dataset first
brexit_data <- read.csv("data_brexit_referendum.csv", na = "")

# Examine the structure
str(brexit_data)
class(brexit_data)
head(brexit_data, 5)


# Count the number of values with "-1" in the Leave column
leave_issue <- brexit_data(brexit_data['Leave'] == "-1")

nrow(brexit_data[brexit_data$Leave == -1,])
sum(brexit_data$Leave == -1)

# Replace these with NA
brexit_data$Leave[brexit_data$Leave == -1] <- NA


# Verify that the "-1" values have been replaced
sum(brexit_data$Leave[brexit_data$Leave == -1])

# view the no of records with NA
# Could use the complete cases command
na_records <- brexit_data[!complete.cases(brexit_data),]

# count the no of NA records
nrow(na_records)


# Visualise the patterns of NA data
# using mice or VIM
library(mice)
md.pattern(brexit_data)

# VIM
library(VIM)
missing_values <- aggr(brexit_data, prop = FALSE, numbers = TRUE)
summary(missing_values)

# Looking at the proportion of voters who
# are in favour of leaving the EU
# Create a new variabl to decide whether each area (ward) decided
# to remain or leave the EU
# Examnine the proprtaion of leave and NVotes
brexit_data$Proportion <- brexit_data$Leave / brexit_data$NVotes


# Create a new variable and figure out
# whether each ward decied to leave or remain
# We'll use the rpoportion varaibe to make this decision
# If proportion < 0.5 = remain
# If proportion > 0.5 = leave
brexit_data$Vote[brexit_data$Proportion <= 0.5] <- "Remain"
brexit_data$Vote[brexit_data$Proportion > 0.5] <- "Leave"

str(brexit_data)
# Var is a character so no need to convert first
attach(brexit_data)
brexit_data$RegionName[RegionName == "London"] <- "L"
brexit_data$RegionName[RegionName == "North West"] <- "NW" 
brexit_data$RegionName[RegionName == "North East"] <- "NE" 
brexit_data$RegionName[RegionName == "South West"] <- "SW" 
brexit_data$RegionName[RegionName == "South East"] <- "SE" 
brexit_data$RegionName[RegionName == "East Midlands"] <- "EM" 
brexit_data$RegionName[RegionName == "West Midlands"] <- "WM" 
brexit_data$RegionName[RegionName == "East of England"] <- "EE" 
brexit_data$RegionName[RegionName == "Yorkshire and The Humber"] <- "Y"

summary(brexit_data)

is.numeric(Proportion)
is.numeric(RegionName)

# Use sapply90 function to examine the structure 
# of each varaible
numeric_variable_list <- sapply(brexit_data, is.numeric)
class(numeric_variable_list)
numeric_variable_list

# We can use this logic to create a subset of the data
numerical_data <- brexit_data[numeric_variable_list]
head(numerical_data, 5)

# Remove the ID field as it is of no benefit
# Remove from the numerical_variable_list
# We can assign "FALSE" to it
numeric_variable_list["ID"] <- FALSE


# We can use this logic to create a subset of the data again
# now that the ID field is removed
numerical_data <- brexit_data[numeric_variable_list]
head(numerical_data, 5)

# We can use the apply() function to retuen a list
# where each list member has a corresponding name
lapply(numerical_data, summary)

names(brexit_data)

















