read.csv("TRI_2016_UT.csv")
install.packages('ggmap')
library(ggmap)
qmap(location = "Salt Lake County")
mydata = read.csv("TRI_2016_UT.csv")

location_of_pollutants = data.frame(mydata$FACILITY_NAME, mydata$LATITUDE, mydata$LONGITUDE)

colnames(location_of_pollutants) = c('facility_name', 'latitude', 'longitude')

utah_center = as.numeric(geocode("UTAH"))
  
SLCountyMap = ggmap(get_googlemap(center=utah_center, scale=2, zoom=7, maptype = "roadmap", color = "bw"),
                    extent="device")

SLCountyMap +
  geom_point(aes(x=longitude, y=latitude), data=location_of_pollutants, col="orangered", alpha=.0625,
             size=location_of_pollutants$facility_name) +
  scale_size_continuous(range = range(location_of_pollutants$facility_name)) +
  labs(x = "",
       y = "") +
  theme_minimal() +
  theme(panel.grid = element_blank(),axis.ticks = element_line())


  

  