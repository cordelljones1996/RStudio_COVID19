# Library
library(covid19.analytics)

# Data
ag <- covid19.data(case = 'aggregated')
tsc <- covid19.data(case = 'ts-confirmed')
tsa <- covid19.data(case = 'ts-ALL')

# Summary 
report.summary(Nentries = 10,
               graphical.output = T)

# Totals per location
tots.per.location(tsc, geo.loc = c('US', 'Brazil'))

# Growth rate
growth.rate(tsc, geo.loc = 'US')

# Totals plot
totals.plt(tsa, c('US'))

# World Map
live.map(tsc)

# SIR Model
generate.SIR.model(tsc, 'US', tot.population = 328200000)
