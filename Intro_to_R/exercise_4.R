# Exercise 4

# load the gapminder demographics data
gm <- read_csv('../data/gapminder.csv')

# Load the dplyr package
library(dplyr)

# Find the rows with life expectancies of more than 80 years
?dplyr::filter
filter(gm, lifeExp > 80)

# Find corresponding countries and years 
gm$country[gm$lifeExp > 80]
gm$year[gm$lifeExp > 80]

# Find the countries with a low GDP per capita < 500 in 2007
filter(gm, gdpPercap < 500 & gm$year == 2007)
gm$country[gm$gdpPercap < 500 & gm$year == 2007]

