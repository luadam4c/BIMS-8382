# Essential Statistics Homework
# http://bims.fun/r-stats-homework.html

# Load libraries
library(readr)
library(dplyr)

# Read Stress Tests data
# http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/stressEcho.html
stress <- read_csv("../data/stressEcho.csv")

# Take a look
stress

# 1. What is the highest maximum heart rate double product
#       with Dobutamine (dpmaxdo)?
hw1 <- max(stress$dpmaxdo)
hw1

# 2. What is the cutoff for the 99th percentile for the
#       measurement above?
hw2 <- quantile(stress$dpmaxdo, probs = 0.99)
hw2

# 3.　Use ggplot2 to create a histogram showing the distribution
#       of the dpmaxdo values
library(ggplot2)
hw3 <- ggplot(stress, aes(dpmaxdo)) + geom_histogram()
hw3

# 4. The plot above indicates that the distribution is approximately
#       normal, with the except of a few outliers at the right tail.
#       With the normality assumption satisfied, perform a two sample
#       t-test to compare the mean double product max heart values
#       between those who did or did not experience any cardiac event
#       (any.event). Assume equal variances between these groups.
stressYesEvent <- stress %>% filter(any.event == 1)
stressNoEvent <- stress %>% filter(any.event == 0)
hw4 <- t.test(stressNoEvent$dpmaxdo, stressYesEvent$dpmaxdo,
              var.equal = TRUE)
hw4 <- t.test(dpmaxdo ~ any.event, data = stress, var.equal = TRUE)
hw4

# 5. What is the p-value for this test?
hw5 <- hw4$p.value
hw5

# 6. The smoking history column (hxofCig) is represented categorically
#       as “heavy”, “moderate” and “non-smoker”.
#       Create a margin table showing the total counts of individuals
#       in each smoking history category, for all individuals who
#       either did or did not have any cardiac event by smoking
#       status. Next, show proportions over the row margin
#       (what percentage of each category had any cardiac event?).
xt <- xtabs(~ hxofCig + any.event, data = stress)
hw6.1 <- addmargins(xt)
hw6.1
hw6.2 <- prop.table(xt, margin = 1)
hw6.2

# 7. Create a mosaic plot to explore the tabulated counts visually.
hw7 <- mosaicplot(xt)

# 8. Now use a chi-squared test for the independence of
#       smoking history and cardiac event.
hw8 <- chisq.test(xt)
hw8

# 9. Load the broom package and “tidy” the model output above.
library(broom)
hw9 <- tidy(hw8)
hw9

# Read Muscular Dystrophy Genetics data
# http://biostat.mc.vanderbilt.edu/wiki/pub/Main/DataSets/dmd.html
# https://www.ncbi.nlm.nih.gov/pubmed/7137219
dmd <- read_csv("../data/dmd.csv")

# Take a look
dmd

# 1. What is the average value for lactate dehydrogenase?
hw10 <- mean(dmd$ld, na.rm = TRUE)
hw10

# 2. The four serum markers (creatine kinase, hemopexin,
#       pyruvate kinase and lactate dehydrogenase) are all
#       predictors of interest in this case.
#       Use ggplot2 to create histograms to assess the normality
#       of the distribution for each of these variables.
library(tidyr)
dmd_tidy <-
    dmd %>%
        gather(key = "serumMarker", value = "markerValue",
               "ck":"ld")
dmd_tidy
hw11 <- ggplot(dmd_tidy, aes(markerValue)) +
        geom_histogram() +
        facet_wrap(facets = "serumMarker", scales = "free")
hw11

# 3. All of these columns have outliers and are (at least slightly)
#       skewed. But ck seems to require the most attention.
#       Try using a log transformation on that column and
#       create another histogram.
hw12 <-
    dmd %>%
    mutate(logck = log(ck)) %>%
    ggplot(aes(logck)) + geom_histogram()
hw12

# 4. Even when transformed, the cytokine kinase is a little skewed.
#       Assuming we can tolerate this, let’s try fitting a binary
#       logistic regression model that predicts the mother’s status
#       as carrier based on the values of the four blood serum
#       markers. Don’t forget to use the log version of ck,
#       and to use summary() on the model object to view the
#       coefficients.
dmd <- dmd %>% mutate(logck = log(ck))
dmd
hw13 <-
    glm(carrier ~ logck + h + pk + ld, data = dmd,
        family = "binomial") %>% summary()
hw13 <-
    glm(carrier ~ log(ck) + h + pk + ld, data = dmd,
        family = "binomial") %>% summary()
hw13

# 5. The coefficient (estimate) for each explanatory variable gives
#       us the log of the odds ratio. Exponentiate the estimates to
#       make them more interpretable (i.e. the odds ratio for each
#       1-unit increase in the predictor variable).
fit <-
    glm(carrier ~ log(ck) + h + pk + ld, data = dmd,
    family = "binomial")
hw14 <- exp(coef(fit))
hw14 <- exp(fit$coefficients)
hw14 <- round(exp(fit$coefficients), 4)
hw14


