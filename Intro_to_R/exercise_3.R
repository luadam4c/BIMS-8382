# Exercise 3

# Read in data
gdat <- read_csv(file = '../data/gapminder.csv')

# Compute the standard deviation of the life expectancy
?sd
lifeExpStd <- sd(gdat$lifeExp)

# Compute the mean population size in millions
meanPop <- mean(gdat$pop)/1e6

# Get the range of years represented in the data
yearsRange <- range(gdat$year)

# Print all results
print(sprintf('Standard deviation of the life expectancy = %g',        
              lifeExpStd))
print(sprintf('Mean population size = %g millions',        
              meanPop))
print(sprintf('Range of years = %d - %d',        
              yearsRange[1], yearsRange[2]))
