# Essential Statistics in R
# 2018-03-05
# Instructor: Stephen Turner
# http://bims.fun/r-stats.html

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import National Health and Nutrition Examination Survey data
#   https://www.cdc.gov/nchs/nhanes/index.htm
nh <- read_csv("../data/nhanes.csv")
nh
nh$RelationshipStatus

# Change a character data type to the "factor" data type
#   that is better for categorical variables
nh %>%
    mutate(Gender = as.factor(Gender))

# Change all character data types to the "factor" data type
#   Note: () is not needed for the function arguments
nh <- nh %>%
    mutate_if(is.character, as.factor)
nh

# Now the values do not have "" and Levels are defined
#   Note: The ordering of Levels is by default alphabetical
nh$RelationshipStatus
nh$Race

# You can retrieve the levels of a factor vector with levels()
#   This is a character vector
raceLevels <- levels(nh$Race)
raceLevels

# Take a look at the data
head(nh)
tail(nh)
# View(nh)

## Descriptive statistics
nh$Race
unique(nh$Race)
length(unique(nh$Race))

# You can use pipes too
nh$Race %>% unique() %>% length()

# Summary statistics
mean(nh$Age)
median(nh$Age)
range(nh$Age)

# You can do this with dplyr but a data frame is returned
nh %>%
    summarize(mean(Age))

# This is more useful when you are computing grouped statistics
nh %>%
    group_by(Gender, Race) %>%
    summarize(mean(Age))

# Get all summary statistics
summary(nh)

# If there is a missing value, the statistic is NA by default
mean(nh$Income)

# Remove NA values when computing statistics
mean(nh$Income, na.rm = TRUE)

# Find the number of missing (NA) values
sum(is.na(nh$Income))

# A package Steve Turner wrote himself
library(Tmisc)

# Visualize all missing data
gg_na(nh)

# Print the proportion of missing data for each column
propmiss(nh)

# Plot histograms
ggplot(nh, aes(BMI)) + geom_histogram()
ggplot(nh, aes(Weight)) + geom_histogram(bins = 100)
ggplot(nh, aes(Age)) + geom_histogram(bins = 30)

# Plot a scatter plot
ggplot(nh, aes(Height, Weight, color = Gender)) +
    geom_point()

# Plot scatter plots
nh %>%
    filter(Age >= 18) %>%
    ggplot(aes(Height, Weight, color = Gender)) +
        geom_point(alpha = .2) + geom_smooth(method = 'lm')

## Continuous data analysis
# Note: Always sample statistics in R
?sd

# Create a new table filtered for adults only
nha <- nh %>% filter(Age >= 18)
nha

# Do a t test - assumes normal distributions
# t.test(y ~ x, data = whatever)
#   Note: By default it is applying the Welch correction
#           for unequal variances (not assuming homoscedasticity)
#           https://en.wikipedia.org/wiki/Welch%27s_t-test
#         By default it's a two-sided, unpaired test
#           and returns a 95% confidence interval
# Question: Are there differences in age for males versus females?
?t.test
t.test(Age ~ Gender, data = nha)
tTestResult <-
    t.test(Age ~ Gender, data = nha, var.equal = TRUE)

# Get the structure of the hypothesis test object
tTestResultStructure <- tTestResult %>% str()

# Get a specific value from the hypothesis test object
tTestResult$p.value

# Tidy the output with the broom package
library(broom)
tTestResult <-
    t.test(Age ~ Gender, data = nha, var.equal = TRUE)

# Question: Does BMI differ between diabetics and non-diabetics?
t.test(BMI ~ Diabetes, data = nha)

# Question: Do single or married/cohabitating people drink more alcohol?
#           Is this relationship significant?
t.test(AlcoholYear ~ RelationshipStatus, data = nha)

# Two tailed
t.test(AlcoholYear ~ RelationshipStatus, data=nha)

# Difference in means is >0 (committed drink more)
t.test(AlcoholYear ~ RelationshipStatus, data=nha, alternative="greater")

# Difference in means is <0 (committed drink less)
t.test(AlcoholYear ~ RelationshipStatus, data=nha, alternative="less")

# Data that's not normally distributed
ggplot(nha, aes(AlcoholYear)) + geom_histogram()

# Apply the Wilcoxon rank-sum test (Mann-Whitney U test)
wTestResult <-
    wilcox.test(AlcoholYear ~ RelationshipStatus, data = nha)

# Test for normality: Shapiro-Wilk test
#   This is very sensitive
?shapiro.test
shapiro.test(nha$AlcoholYear)
shapiro.test(nha$Age)
shapiro.test(nha$Income)

# A t test with equal variance
t.test(BMI ~ RelationshipStatus,
       data = nha, var.equal = TRUE)

# Fit a linear model on a categorical variable with 2 values
#   (linear regression)
#   Note: the p value of the intercept is the same
#           as the p value when conducting the
#           equal variance t test
levels(nha$RelationshipStatus)
fit <- lm(BMI ~ RelationshipStatus, data = nha)
fit
summary(fit)
fit %>% tidy()

# P-value computed on a t-statistic with 3552 degrees of freedom
# (multiply times 2 because t-test is assuming two-tailed)
2*(1 - pt(1.532, df = 3552))

# P-value computed on an F-test with 1 and 3552 degrees of freedom
1 - pf(2.347, df1 = 1, df2 = 3552)

# Fit a linear model on a categorical variable with 3 values
#   (multiple linear regression)
#   Note: The intercept is the baseline;
#           all other variables are treated as indicator variables
#         If you have a k-level factor, R creates k−1 dummy variables,
#           or indicator variables, by default, using the
#           alphabetically first level as baseline
levels(nha$SmokingStatus)
fit <- lm(BMI ~ SmokingStatus, data = nha)
summary(fit)

# Reorder the level with a different baseline
# Look at the levels of nha$SmokingStatus
levels(nha$SmokingStatus)

# What happens if we relevel it? Let's see what that looks like.
relevel(nha$SmokingStatus, ref = "Never")

# If we're happy with that, let's change the value of nha$SmokingStatus in place
nha$SmokingStatus <- relevel(nha$SmokingStatus, ref = "Never")

# Or we could do this the dplyr way
nha <- nha %>%
    mutate(SmokingStatus=relevel(SmokingStatus, ref = "Never"))

# Re-fit the model
fit <- lm(BMI ~ SmokingStatus, data = nha)

# Show the ANOVA table
anova(fit)

# Print the full model statistics
summary(fit)

# Do a Tukey’s range test (Tukey-Kramer method) on the linear model
#   HSD = honest significant difference
#   https://en.wikipedia.org/wiki/Tukey%27s_range_test
TukeyHSD(aov(fit))

# Plot the data as a boxplot
ggplot(nha, aes(SmokingStatus, BMI)) + geom_boxplot() + theme_classic()

# Linear regression on a continuous variable
fit <- lm(Weight ~ Height, data = nha)
summary(fit)
ggplot(nha, aes(Height, Weight)) + geom_point() +
    geom_smooth(method = 'lm')

# Don't extrapolate to the mean
ggplot(nha, aes(x=Height, y=Weight)) +
    geom_point() +
    geom_smooth(method="lm", fullrange=TRUE) +
    xlim(0, NA) +
    ggtitle("Friends don't let friends extrapolate.")

# Linear regression on one categorical variable (Yes or No)
class(nha$PhysActive)
levels(nha$PhysActive)
t.test(Testosterone ~ PhysActive, data = nha, var.equal = TRUE)
summary(lm(Testosterone ~ PhysActive, data = nha))

# Multiple linear regression on
#   both categorical and continuous variables
summary(lm(Testosterone ~ PhysActive + Age, data = nha))
summary(lm(Testosterone ~ PhysActive + Age + Gender, data = nha))
summary(lm(Testosterone ~ SmokingStatus + Age + Gender, data = nha))

fit <- lm(Income ~ Work, data = nha)
fit
anova(fit)
TukeyHSD(aov(fit))
summary(fit)

# Extract coefficients of a model
coef(fit)

# Generate predicted values from the fitted values
predict.lm(fit)

# Extract fitted values of a model
fitted(fit)

# Extract model residuals
residuals(fit)

## Discrete (categorical) data analysis
# Create a contigency table
# xtabs(~ x1 + x2, data = ...)
xt <- xtabs(~ Gender + Diabetes, data = nha)
xt

# Add the margins
addmargins(xt)

# Get the proportions over all values
prop.table(xt)

# Get the proportions over the row margins
prop.table(xt, margin = 1)

# Use the Pearson's Chi-squared test with Yates' continuity correction
chisq.test(xt)

# Fisher's Exact Test for Count Data
# https://en.wikipedia.org/wiki/Fisher%27s_exact_test
fisher.test(xt)

# Plot a mosaic plot, suppress the default title
mosaicplot(xt, main = NA)

# Get the number of perople of each race getting health insurance
xt2 <- xtabs(~ Race + Insured, data = nha)
xt2

# Add marginal totals
addmargins(xt2)

# Get the proportion of each race getting health insurance
prop.table(xt2, margin = 1)

# Do a chi-squared test
#   Note: the p-value here is rounded off
chisq.test(xt2)

# Get the actual p value
chisq.test(xt2)$p.value

# Get the expected counts under the null hypothesis (independence)
chisq.test(xt2)$expected

# Make a mosaic plot
mosaicplot(xt, main = NA)

# Logistic regression
#   Note: This is a type of generalized linear model (GLM)
#   Typical use:
#       mod <- glm(y ~ x, data = yourdata, family = 'binomial')
#       summary(mod)

# Look at Race. The default ordering is alphabetical
levels(nha$Race)

# Let's relevel that where the group with the highest rate of insurance is "baseline"
relevel(nha$Race, ref = "White")

# If we're happy with that result, permanently change it
nha$Race <- relevel(nha$Race, ref = "White")

# Or do it the dplyr way
nha <- nha %>%
    mutate(Race = relevel(Race, ref = "White"))

# Fit a logistic regression model
fit <- glm(Insured ~ Race, data = nha, family = "binomial")
summary(fit)

# Add potential confounding variables like Age, Income, SleepHrsNight
fit <- glm(Insured ~ Age + Income + SleepHrsNight + Race,
           data = nha, family = "binomial")
summary(fit)

# Power calculations

# If we have 20 samples in each of two groups
  #   (e.g., control versus treatment),
#   and the standard deviation for whatever we’re measuring is 2.3,
#   and we’re expecting a true difference in means
#   between the groups of 2, what’s the power to detect this effect?
power.t.test(n = 20, delta = 2, sd = 2.3)
power.t.test(n = 20, delta = 2, sd = 2.3)$power

# What’s the sample size we’d need to detect a difference of 0.8
#   given a standard deviation of 1.5, assuming we want 80% power?
power.t.test(power = 0.8, delta = 0.8, sd = 1.5)$n

# What’s the difference we can detect if we have 6 samples,
#   90% power and a standard deviation of 2.3?
power.t.test(power = 0.9, n = 6, sd = 2.3)$delta

# Two-sample proportion test (e.g., chi-square test):
#   If we have two groups (control and treatment),
#   and we’re measuring some outcome (e.g., infected yes/no),
#   and we know that the proportion of infected controls is 80%
#   but 20% in treated, what’s the power to detect this effect
#   in 5 samples per group?
power.prop.test(n = 5, p1 = 0.8, p2 = 0.2)

# How many samples would we need for 90% power?
power.prop.test(power = 0.9, p1 = 0.8, p2 = 0.2)
power.prop.test(power = 0.9, p1 = 0.8, p2 = 0.2)$n

## Tidy models

# Try modeling Testosterone against Physical Activity, Age, and Gender.
fit <- lm(Testosterone ~ PhysActive + Age + Gender, data = nha)

# See what that model looks like:
summary(fit)

# Pull out the coefficient for Age
fit$coefficients["Age"]

# Get all the coefficients as a matrix
coef(summary(fit))

# Pull out the coefficient for Age (another way)
coef(summary(fit))["Age", "Estimate"]

# Pull out the p-value for PhysActive
coef(summary(fit))["PhysActiveYes", "Pr(>|t|)"]

# Use the tidy function from the broom package
#   to get all the coefficients as a data frame
library(broom)
tidy(fit) %>%
    filter(term != "(Intercept)") %>%
    select(term, p.value) %>%
    arrange(p.value)

# Augment the original data with fitted values and residuals, etc.
#   Note: New columns begins with a . to avoid overwriting any
#           of the original columns
augment(fit) %>% head

# Plot residuals vs fitted values for males,
#   colored by Physical Activity, size scaled by age
augment(fit) %>%
    filter(Gender == "male") %>%
    ggplot(aes(.fitted, .resid, col = PhysActive, size = Age)) +
            geom_point()

# Compute summary statistics of the model
glance(fit)

# You can pipe onto broom functions
t.test(AlcoholYear ~ RelationshipStatus, data = nha) %>% tidy()
wilcox.test(AlcoholYear ~ RelationshipStatus, data = nha) %>% tidy()
xtabs(~ Gender + Diabetes, data = nha) %>% fisher.test() %>% tidy()
glm(Insured ~ Race, data = nha, family = binomial) %>% tidy()


glm(Insured ~ Race, data = nha, family = binomial) %>%
    tidy() %>%
    filter(term != "(Intercept)") %>%
    mutate(logp = -1 * log10(p.value)) %>%
    ggplot(aes(term, logp)) + geom_bar(stat = "identity") +
        coord_flip()
