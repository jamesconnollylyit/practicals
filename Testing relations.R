# Refer to the "Analysing beaver data" lab practical for 
# further information

# Use statistical methods to examine
# the relationships between our vars of interest

# beavers dataset
# contains the body temp of 4 beavers captured every 10 mins
# over a day
# We want to examine difference in average body temp
# to evaluate whether body temp is affected by activity

# Q1
# Hypothesis test
# h0: beaver body temperature is not affected by activity
# h1: beaver body temperature is affected by activity

?beavers
str(beaver2)

# Copy the data into a data frame
beavers_data <- beaver2
str(beavers_data)
head(beavers_data)

# Convert the activ variable to
# a categorical dichotomous variable
beavers_data$activ <- factor(beavers_data$activ, labels = c("No", "Yes"))
str(beavers_data)

install.packages("psych")
library(psych)

pairs.panels(beavers_data, 
             smooth = TRUE, # If TRUE, draws loess smooths  
             scale = FALSE, # If TRUE, scales the correlation text font  
             density = TRUE, # If TRUE, adds density plots and histograms  
             ellipses = TRUE, # If TRUE, draws ellipses   
             method = "spearman",# Correlation method (also "pearson" or "kendall") 
             pch = 21, # pch symbol   
             lm = FALSE, # If TRUE, plots linear fit rather than the LOESS (smoothed) fit 
             cor = TRUE, # If TRUE, reports correlations
             jiggle = FALSE, # If TRUE, data points are jittered  
             factor = 2, # Jittering factor  
             hist.col = 4, # Histograms color   
             stars = TRUE,
             ci = TRUE) # If TRUE, adds confidence intervals 
             
# Q2
attach(beavers_data)
plot(activ, temp, pch = 9, col = "lightblue")

# We can split the dicotomous var into 2
# and then examine the data
library("lattice")

# 
histogram(~temp | activ, 
          data = beavers_data, 
          main = "Distribution of beaver activity data", 
          xlab = "Temperature (degrees)", ylab = "Activity")

# Visual analysis seems to indicate that the data is normally distributed
# summarise the 
tapply(temp, activ, median)

# Quantile-quantile plot (Q-Q plot) allows us to check
# if the data is normally distributed or not

# Is temp normally distributed?
qqnorm(temp)
# Add line that represents normal distribution
qqline(temp, col = "red")

# Temp appears not to be normally distributed

with(beavers_data, 
     qqplot(temp[activ == "Yes"], 
            temp[activ == "No"], 
            main = "Comapring 2 samples of cativity data", 
            xlab = "Acitive temp = Yes", 
            ylab = "Active temp = No"))

# We can add normality line to the plot
# to help evaluate normality 
with(beavers_data, {
  qqnorm(temp[activ == "No"], 
         main = "Inactive data")
  qqline(temp[activ == "No"])
})

with(beavers_data, {
  qqnorm(temp[activ == "Yes"], 
         main = "Acive data")
  qqline(temp[activ == "Yes"])
})

# Formal test of normality
# Shapiro-Wilks test
# p-value tells us the chances that the sample
# comes form a normal distribution
# If p> 0.05 = normally distributed
normality_test <- shapiro.test(beavers_data$temp)
normality_test$p.value
# p-value = 7.763623e-05

# This test does not work on a dicotomus variable
with(beavers_data, tapply(temp, activ, shapiro.test))

# Results show:
# No = p-value = 0.1231 - normally distributed
# Yes = p-value = 0.5583 - normally distributed
# temp = not normally distributed

# After consulting the chart, I am amining
# a dependent variable (temp)
# with an independent categorical var (activ)
# format wilcox.test(dependent ~ independent)
wilcox.test(temp~activ)
# cut-off = 0.05
# p-value = < 2.2e-16 (2.2 power -16) = 0.00000000000000022
# p-value < 0.05 = we reject the H0

# p-value < 0.05 so this indicates the Null (H0) hypothesis
# is rejected. Therefore this indicates that beaver body
# temperature is affected by activity (p = 2.2e-16)






















