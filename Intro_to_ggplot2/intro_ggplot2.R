# Introduction to ggplot2
# 2018-02-26
# Instructor: V. P. Nagraj
# http://bims.fun/r-viz-gapminder.html

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)
# library(tidyverse)

# Import gapminder data
gm <- read_csv('../data/gapminder.csv')

# Plot is a general built-in function
plot()

# Plot with ggplot
#   gg stands for "The Grammar of Graphics"
#   The following generates a canvas only
ggplot(data = gm, mapping = aes(x = gdpPercap, y  = lifeExp))

# Add a geom to plot
#   See ggplot2 cheatsheet for possible geoms
#   OR consult http://ggplot2.tidyverse.org/reference/
ggplot(data = gm, mapping = aes(x = gdpPercap, y  = lifeExp)) +
    geom_point()
?geom_point()
?geom_jitter()

# Assign the canvas to a variable
p <- ggplot(gm, aes(x = gdpPercap, y = lifeExp))

# Add a scatter plot to the canvas
p + geom_point()

# Transform x axis to log scale
p + geom_point() + scale_x_log10()

# Store log scale transformation in base canvas
p <- p + scale_x_log10()

# Regenerate plot with group coloring (by continent)
#   aes() is needed whenever talking to the data frame
p + geom_point(aes(col = continent))

# Set a color
# See color cheatsheets
p + geom_point(color = "blue")
p + geom_point(color = "violet")

# Set other attributes
# https://www.statmethods.net/advgraphs/parameters.html
p + geom_point(color = "lightblue3", pch = 4)
p + geom_point(color = "black", pch = 'O', size = 4)
p + geom_point(color = "purple", size = 4, alpha = 0.25)

# Adjust size or shape based on a data column
p + geom_point(aes(color = continent, size = lifeExp,
                   shape = continent))

# Fix size
p + geom_point(aes(color = continent), size = 3)

# Adjust size based on a range
scale_size_continuous()

# Add a best fit curve (trend line) with confidence interval
#   Default method is loess() for number of points > 1000
#       and gam() for number of points <= 1000
p + geom_point() + geom_smooth()
?geom_smooth

# Remove the confidence interval,
#   make it linear and change line width
p + geom_point() +
    geom_smooth(se = FALSE, method = 'lm', lwd = 2)

# Add the color grouping
p + geom_point(aes(color = continent)) + geom_smooth()

# Place the color grouping in the data to produce trend lines
#   for each group
ggplot(gm, aes(x = gdpPercap, y = lifeExp, color = continent)) +
    scale_x_log10() + geom_point() + geom_smooth()

# Aesthethics could also be added
p + aes(color = continent) + geom_point() + geom_smooth()

# Facets: display subsets of the data in different panels.
p + geom_point() + facet_wrap(~ continent)
p + geom_point() + facet_wrap(~ continent, ncol = 1)

# Save a plot
pfinal <- p + geom_point() + facet_wrap(~ continent, ncol = 1)
ggsave(plot = pfinal, file = 'myplot.pdf', width = 5, height = 15)

# Plot lifeExp vs continent
p1 <- ggplot(gm, aes(continent, lifeExp))
p1

# Use opacity to accomodate for overplotting
p1 + geom_point()
p1 + geom_point(alpha = 0.25)

# Use a jitter plot
p1 + geom_jitter(alpha = 0.25)

# Seed the random number generator
set.seed(123)

# Now the jitter plot looks the same every time you run it
p1 + geom_jitter(alpha = 0.25)

# A box plot
p1 + geom_boxplot(outlier.color = 'red')

# Combination of jitter and box plot
p1 + geom_boxplot(outlier.color = 'red', alpha = 0.25) +
    geom_jitter(alpha = 0.25)
p1 + geom_jitter(alpha = 0.25) +
    geom_boxplot(outlier.color = 'red', alpha = 0.25)

# A violin plot
p1 + geom_violin()

# Combination of jitter and violin plot
p1 + geom_violin() + geom_jitter(alpha = 0.5)

# Use a beeswarm plot
library(ggbeeswarm)
p1 + geom_beeswarm()

# Reorder the x axis
#   Here, reorder is taking the first variable,
#   which is some categorical variable,
#   and ordering it by the level of the mean of
#   the second variable, which is a continuous variable.
p2 <- ggplot(gm, aes(x = reorder(continent, lifeExp),
                     y = lifeExp))
p2 + geom_boxplot()

# Single continuous variable
p3 <- ggplot(gm, aes(lifeExp))

# Histogram with default binwidth 30
p3 + geom_histogram()
?geom_histogram

# Histogram with set number of bins
p3 + geom_histogram(bins = 10)
p3 + geom_histogram(bins = 1000)
p3 + geom_histogram(bins = 60)

# Plot probability density function
p3 + geom_density()

# Group by continent
p3 + geom_histogram() + facet_wrap(~ continent)

# Allow y axis limits to be different
p3 + geom_histogram() +
    facet_wrap(~ continent, scales = 'free_y')

# Color by continent (outline of bars)
p3 + geom_histogram(aes(color = continent))

# Color by continent (filled bars and stacked)
p3 + geom_histogram(aes(fill = continent))

# Color by continent (not stacked, blocked)
p3 + geom_histogram(aes(fill = continent), position = "identity")

# Color by continent (not stacked, transparent)
p3 + geom_histogram(aes(fill = continent),
                    position = "identity", alpha = 1/3)

# Color lines by continent in density plots
p3 + geom_density(aes(color = continent))

# Color fill by continent in density plots
p3 + geom_density(aes(fill = continent), alpha = 1/4)

# Back to the plot from earlier
p <- ggplot(gm, aes(x = gdpPercap, y = lifeExp))
p <- p + scale_x_log10()
p <- p + aes(col = continent) + geom_point() +
        geom_smooth(lwd = 2, se = FALSE)

# Give the plot a title and axis labels
p <- p + ggtitle("Life expectancy vs GDP by Continent")
p <- p + xlab("GDP Per Capita (USD)") +
        ylab("Life Expectancy (years)")

# By default, the 'gray' theme is the usual background
p + theme_gray()

# Use a black/white background
p + theme_bw()

# Remove the gridlines
p + theme_classic()

# Load more themes
library(ggthemes)

# Try out different themes
# https://github.com/jrnold/ggthemes
p + theme_excel()
p + theme_excel() + scale_colour_excel()
p + theme_gdocs() + scale_colour_gdocs()
p + theme_stata() + scale_colour_stata()
p + theme_wsj() + scale_colour_wsj()
p + theme_economist()
p + theme_fivethirtyeight()
p + theme_tufte()
