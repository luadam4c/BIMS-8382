
# Replace the ... with the appropriate commands.

# Make vector called z containing numbers from 1 to 100.
z = seq(from = 1, to = 100)

# Make the for-loop with the range to run over in round brackets,
# the things to do each run in curly brackets,
# and an if-statement between the curly brackets.

for(i in 1:length(z))
{
    if(z[i] < 5 | z[i] > 90){
        z[i] = z[i] * 10
    }else{
        z[i] = z[i] * 0.1
    }
}
