# Import the diabetes data frame
diabetes_data <- read.csv("Diabetes.csv", na = "")

str(diabetes_data)

# Check for missing varaibles. Delete if there are any
# Examine missing data
incomplete_data <- diabetes_data[!complete.cases(diabetes_data),]
incomplete_data

# Install the mice package if not already installed
install.packages("mice")
library(mice)
md.pattern(diabetes_data)

library(VIM)
missing_values <- aggr(diabetes_data, prop = FALSE, numbers = TRUE)

# Show content of missing values
summary(missing_values)


# Create a new variable called to Date that contains the month 
# and year data
diabetes_data$Date <- paste(diabetes_data$Month, diabetes_data$Year, sep='/')
str(diabetes_data)


# Change the date variable to a Date
# Date has a particular requirement as it should contain
# day, month and year

# Here is an example of the error
converted_date <- as.Date(diabetes_data$Date, "%m/Y")
converted_date
class(converted_date)

# And this is how it is fixed
# The date whould contain dd/mm/yyyy
converted_date <- paste(diabetes_data$Month, diabetes_data$Year, sep = "/")
converted_date

# Add the day element into the variable
converted_date <- paste("01", diabetes_data$Month, diabetes_data$Year, sep = "/")
converted_date

diabetes_data$Date <- as.Date(converted_date, "%d/%m/%Y")
str(diabetes_data)

# Plot the status variable using the plot() function
# Convert to a factor first
# You could plot the summary() of the status variable data
plot(diabetes_data$Status)
diabetes_data$Status <- factor(diabetes_data$Status)
str(diabetes_data)
plot(diabetes_data$Status)
summary(diabetes_data$Status)

# Add titles to the chart that are relevant.
attach(diabetes_data)
display_settings <- par(no.readonly = TRUE)
plot(Status, main = "Number of patient recoveries", xlab = "Diabetes status", ylab = "No of patients")

# save the modified daibetes data frame
write.csv(diabetes_data, file = "diabetes-data-modified.csv")

