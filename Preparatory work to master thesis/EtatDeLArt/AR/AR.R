library(tseries)
data(AirPassengers) # Dataset number of passengers per year

plot(AirPassengers) # We plot our data
abline(reg = lm(AirPassengers ~ time(AirPassengers))) # We perform a linear regression

# Diff to remove the linear trend
adf.test(diff(log(AirPassengers)), alternative = "stationary", k = 0) # p-value = 0.01

acf(diff(log(AirPassengers)), main = "Auto-Correlation Function (ACF)")
pacf(diff(log(AirPassengers)), main = "Partial Auto-Correlation Function (PACF)")

fit <- arima(log(AirPassengers),
             c(0, 1, 1), # AR(0) - Formula (2.16), I(1), MA(1) - Formula (2.17)
             seasonal = list(order = c(0, 1, 1), period = 12)) # Yearly seasonal effects
pred <- predict(fit, n.ahead = 10 * 12) # 10 years later
ts.plot(AirPassengers,
        exp(1)^pred$pred, # Predictions
        log = "y", # Log scale for Y
        lty = c(1,3), # Plot solid, then dashed
        ylab = "AirPassengers")