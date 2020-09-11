library(tidyverse)
library(sf)

jail <- read.csv("NYPD_Arrest_Data__Year_to_Date_.csv")

# read SHP file from folder (geo_data) containing all connected files unzipped
nyc_shp <- st_read("geo_data/ZIP_CODE_040114.shp")

# Need to set jail CRS to EPSG:4326, which is almost always what standard Lat/Long are recorded 
# as in North America
jail <- st_as_sf(x = jail, coords = c("Longitude", "Latitude"), crs = 4326)

# need to transform nyc_shp CRS from current mixture to flat EPSG:4326
# https://mgimond.github.io/Spatial/coordinate-systems-in-r.html#transforming-coordinate-systems
nyc_shp <- st_transform(nyc_shp, crs=4326)

# Perform a WITHIN join as the points in the "left" df are within the regions of the "right" df
merged_df <- st_join(jail, nyc_shp, join=st_within, left=TRUE)

# sum(is.na(test2$ZIPCODE))
#74784
#
# Warning message:
#  attribute variables are assumed to be spatially constant throughout all geometries 
#>
# 2nd comment:
#Error in st_geos_binop("contains", x, y, sparse = sparse, prepared = prepared,  : 
#st_crs(x) == st_crs(y) is not TRUE