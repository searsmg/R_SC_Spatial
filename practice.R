#day one software carpentry workshop
#2022-02-09

library(sf)
library(raster)
library(dplyr)
library(tmap)

#imagery
images <- list.files(path = "intermediateGeospatialR/data/nightLights",
                     pattern = ".tif", 
                     full.names = TRUE)

#we only want the counts data
counts <- images[grepl(pattern = "_counts", x = images)]

#radians values not counts
images <- images[!grepl(pattern = "_counts", x = images)]

#county locations
counties <- sf::st_read(dsn = "intermediateGeospatialR/data/counties/countyTex.shp",quiet =TRUE)

#census data
censusT <- sf::st_read(dsn = "intermediateGeospatialR/data/census/ageAndPoverty.shp", quiet =TRUE)
# head(censusT)

#look at map
tmap::tmap_mode("view") # sets up the interactive map 
# we need to read the raster in to visualize 
tmap::qtm(raster::raster(images[1]))

#look at the data from image 1
View(data.frame(unique(values(raster::raster(images[1])))))

#look at the 3 counties in Texas
tmap::qtm(counties)

#structure of dataset
str(censusT)

#look at the data
glimpse(censusT)

#use a sequence to only look at a few
tmap::qtm(censusT[seq(from = 3, to = 19, by = 2),])

#projection
temp <- raster::raster(images[1])
temp

censusT
counties

counties <- sf::st_transform(x = counties, crs = temp@crs)
censusT <- sf::st_transform(x = censusT, crs = temp@crs)

raster::compareCRS(temp, counties)

rm(temp)
