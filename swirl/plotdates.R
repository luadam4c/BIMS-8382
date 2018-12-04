
# Replace in this script the ... with the appropriate commands.

# Make a vector called dates with the three dates:
# today, Sinterklaas (a Dutch holiday) and your next birthday.
dates = strptime(c("20181108000000", "20181208000000", "20190413000000"), "%Y%m%d%H%M%S")

# Make a vector called presents with the three expected number of presents.
presents = c(0, 4, 1)

# Plot the dates versus the number of presents.
plot(dates, presents)

