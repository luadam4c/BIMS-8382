# Advanced Data Visualization Homework
# http://bims.fun/r-viz-homework.html

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import dataset from
#   Brauer et al. Coordination of Growth Rate, Cell Cycle,
#   Stress Response, and Metabolic Activity in Yeast (2008)
#   Mol Biol Cell 19:352-367
yDat <- read_csv('../data/brauer2007_tidy.csv')

# 1. Plot a histogram of the expression variable,
#       and set the bin number equal to 100.
p1 <- ggplot(yDat, aes(expression))
hw1 <- p1 + geom_histogram(bins = 100)
hw1

# 2. Check the distribution of each nutrient in the data set
#       by adjusting the fill aesthetic.
#       Use the same bin number for this histogram..
hw2 <- p1 + geom_histogram(bins = 100, aes(fill = nutrient))
hw2

# 3. Now split off the same histogram into a faceted display
#       with 3 columns.
hw3 <- p1 + geom_histogram(bins = 100, aes(fill = nutrient)) +
        facet_wrap(~ nutrient, ncol = 3)
hw3

# 4. The gene with the highest mean expression is HXT3,
#       while the gene with the lowest mean expression is HXT6.
#       Subset the data to only include these genes,
#       and create a stripplot that has expression values
#       as “jittered” points on the y-axis and
#       the gene symbols the x-axis.
HXTDat <- filter(yDat, symbol == "HXT3" | symbol == "HXT6")
p2 <- ggplot(HXTDat, aes(x = symbol, y = expression))
hw4 <- p2 + geom_jitter(width = 0.1)
hw4

# 5. Now map each observation to its nutrient by color and
#       adjust the size of the points to be 2.
hw5 <- p2 + geom_jitter(aes(color = nutrient), width = 0.1, size = 2)
hw5

# 6. Using dplyr logic, create a data frame that has
#       the mean expression values for all combinations of rate
#       and nutrient (hint: use group_by() and summarize()).
#       Create a plot of this data with rate on the x-axis and
#       mean expression on the y-axis and lines colored by nutrient.
mean_expression <-
    yDat %>%
        group_by(rate, nutrient) %>%
        summarize(meanexp = mean(expression))
mean_expression
p3 <- ggplot(mean_expression, aes(x = rate, y = meanexp))
hw6 <- p3 + geom_line(aes(color = nutrient))
hw6

# 7. Add black dotted line (lty = 3) that represents
#       the smoothed mean of expression across all combinations of
#       nutrients and rates.
hw7 <- hw6 + geom_smooth(se = FALSE, color = 'black', lty = 3)
hw7

# 8. Change the scale to include breaks for all of the rates.
hw8 <- hw7 + scale_x_continuous(breaks = seq(0.05, 0.3, 0.05))
hw8
hw8 <- hw7 + scale_x_continuous(breaks = mean_expression$rate)
hw8
hw8 <- hw7 + scale_x_continuous(breaks = unique(mean_expression$rate))
hw8
# The provided solution seems to be replotting the breaks many times

# 9. By default ggplot() will name the x and y axes with names of
#       their respective variables. You might want to apply more
#       meaningful labels. Change the name of the x-axis to “Rate”,
#       the name of the y-axis to “Mean Expression” and
#       the plot title to “Mean Expression By Rate (Brauer)”
hw9 <- hw8 + xlab("Rate") + ylab("Mean Expression") +
        ggtitle("Mean Expression By Rate (Brauer)")
hw9

# 10. Add a theme from the ggthemes package.
#       The plot below is based on Edward Tufte’s book
#       The Visual Display of Quantitative Information.
#       Choose a theme that you like, but choose wisely –
#       some of these themes will override other adjustments
#       you’ve made to your plot above, including axis labels.
library(ggthemes)
hw10 <- hw9 + theme_tufte()
hw10

# 11. The last step is to save the plot you’ve created.
#       Write your plot to a 10 X 6 PDF using a ggplot2 function.
ggsave("hw_plot.pdf", plot = hw10, width = 10, height = 6)

