library(sp)
data(meuse) # Dataset containing the positions of known zinc deposits

# Set the spatial coordinates -> it means (x, y)
coordinates(meuse) = ~x+y
# We load grid to make our predictions
data(meuse.grid)
gridded(meuse.grid) = ~x+y

# Plot our graph
bubble(meuse, "zinc",
       col=c("#00ff0080", "#00ff0080"),
       main = "zinc concentrations (ppm)")

# Variogram - Formula (2.5)
m <- vgm(.40, # Asymptotic value
         "Sph", # Model type, we can define ours
         954, # Range
         .06) # Nugget

# Universal kriging - Formula (2.6)
x <- krige(log(zinc)~x+y, # zinc prediction in function of the position (the s_i)
           meuse, # Training = meuse data
           meuse.grid, # Predicting = meuse.grid data
           model = m, # Variogram used
           block = c(40, 40)) # Size of the blocks
spplot(x["var1.pred"], main = "universal kriging predictions")
x$var1.se = sqrt(x$var1.var) # Formula (2.9)
spplot(x["var1.se"], main = "universal kriging standard errors")