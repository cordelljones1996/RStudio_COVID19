rm(list = ls())

# Library
library(covid19.analytics)
library(dplyr)
library(prophet)
library(lubridate)
library(ggplot2)

# Data
tsc <- covid19.data(case = 'ts-confirmed')
tsc <- tsc %>% filter(Country.Region == 'US')
tsc <- data.frame(t(tsc))
tsc <- cbind(rownames(tsc), data.frame(tsc, row.names = NULL))
colnames(tsc) <- c('Date', 'Confirmed')
tsc <- tsc[-c(1:4),]
tsc$Date <- ymd(tsc$Date)
# Take tsc data and transpose it to an excel file and import from there
xl <- read_excel("xl.xlsx", col_types = c("date", "numeric"))
xl$Date <- ymd(xl$Date)
str(tsc)
str(xl)
# Should work, but do not run this code, will jumble up data giving a plot error
tsc$Confirmed <- as.numeric(tsc$Confirmed) 

# Plot 
qplot(Date, Confirmed, data = xl,
      main = 'Covid19 Confirmed Cases in US')

ds <- xl$Date
y <- xl$Confirmed
df <- data.frame(ds, y)

# Forecasting
m <- prophet(df)

# Prediction
future <- make_future_dataframe(m, periods = 28)
forecast <- predict(m, future)

# Plot Forecast
plot(m, forecast)
dyplot.prophet(m, forecast)

# Forecast Components
prophet_plot_components(m, forecast)

# Model Performance
pred <- forecast$yhat[1:160] # df Observed
actual <- m$history$y
plot(actual, pred)
abline(lm(pred~actual), col ='red')
summary(lm(pred~actual))
