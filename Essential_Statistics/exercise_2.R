# Exercise 2

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import National Health and Nutrition Examination Survey data
#   https://www.cdc.gov/nchs/nhanes/index.htm
nh <- read_csv("../data/nhanes.csv")

# Get the data from adults only
nha <- nh %>% filter(Age >= 18)

# 1. Is the average BMI different in single people versus those in a
#   committed relationship? Perform a t-test.
t.test(BMI ~ RelationshipStatus, data = nha)

# 2. The Work variable is coded “Looking” (n=159),
#       “NotWorking” (n=1317), and “Working” (n=2230).
# 2.1 Fit a linear model of Income against Work.
#       Assign this to an object called fit.
fit <- lm(Income ~ Work, data = nha)

# 2.2 What does the fit object tell you when you display it directly?
fit

# 2.3 Run an anova() to get the ANOVA table.
#       Is the model significant?
anova(fit)

# 2.4 Run a Tukey test to get the pairwise contrasts.
#       (Hint: TukeyHSD() on aov() on the fit).
#       What do you conclude?
TukeyHSD(aov(fit))

# 2.5 Instead of thinking of this as ANOVA,
#       think of it as a linear model.
#       After you’ve thought about it,
#       get some summary() statistics on the fit.
#       Do these results jive with the ANOVA model?
summary(fit)

# 3. Examine the relationship between HDL cholesterol levels (HDLChol)
#       and whether someone has diabetes or not (Diabetes).
# 3.1 Is there a difference in means between diabetics and nondiabetics?
#       Perform a t-test without a Welch correction
#       (that is, assuming equal variances – see ?t.test for help).
fit <- lm(HDLChol ~ Diabetes, data = nha)

# 3.2 Do the same analysis in a linear modeling framework.
t.test(HDLChol ~ Diabetes, data = nha, var.equal = TRUE)

# 3.3 Does the relationship hold when adjusting for Weight?
summary(lm(HDLChol ~ Diabetes + Weight, data = nha))

# 3.4 What about when adjusting for Weight, Age, Gender, PhysActive
#       (whether someone participates in moderate or
#       vigorous-intensity sports, fitness or recreational activities,
#       coded as yes/no).
#       What is the effect of each of these explanatory variables?
summary(lm(HDLChol ~ Diabetes + Weight +
                    Age + Gender + PhysActive, data = nha))

