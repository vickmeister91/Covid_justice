jail<-read.csv("NYPD_Arrest_Data__Year_to_Date_.csv")
nyc_shp<-st_read("ZIP_CODE_040114.shp")
test<-st_as_sf(x = jail, coords = c("Longitude", "Latitude"), crs = st_crs(nyc_shp))
test2<-st_join(test, nyc_shp, join=st_contains, left=TRUE)
sum(is.na(test2$ZIPCODE))
#74784
#
# Warning message:
#  attribute variables are assumed to be spatially constant throughout all geometries 
#>
# 2nd comment:
#Error in st_geos_binop("contains", x, y, sparse = sparse, prepared = prepared,  : 
#st_crs(x) == st_crs(y) is not TRUE