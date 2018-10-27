# Exercise 2

# Import libraries
library(readr)
library(dplyr)
library(ggplot2)

# Import gapminder data
gm <- read_csv('../data/gapminder.csv')

# Make a scatter plot of lifeExp on the y-axis against year on the x
p <- ggplot(gm, aes(x = year, y = lifeExp))
p + geom_point()

# Make a series of small multiples faceting on continent
p + geom_point() + facet_wrap(~ continent, ncol = 1)

# Add a fitted curve, smooth or lm, with and without facets
p + geom_point() + geom_smooth()
p + geom_point() + geom_smooth(method = 'lm')
p + geom_point() + geom_smooth() +
    facet_wrap(~ continent, ncol = 1)
p + geom_point() + geom_smooth(method = 'lm') +
    facet_wrap(~ continent, ncol = 1)

# Using geom_line() and aesthetic mapping country to group=,
#   make a "spaghetti plot," showing semitransparent lines
#   connected for each country, faceted by continent.
#   Reduce the opacity (alpha=)
#   of the individual black lines. Don' show Oceania countries
p2 <- ggplot(gm %>% filter(continent != "Oceania"),
                aes(x = year, y = lifeExp))
p2 + geom_line(aes(group = country), color = 'black',
               alpha = 0.5) + facet_wrap(~ continent)

#   Add a smoothed loess curve with a thick (lwd=3) line
#   with no standard error stripe.
p2 + geom_line(aes(group = country), color = 'black',
               alpha = 0.5) +
    facet_wrap(~ continent) +
    geom_smooth(se = FALSE, lwd = 3)
