# install.packages("devtools")
# devtools::install_github("dkahle/ggmap")
# install.packages("tidyverse")
library(tidyverse)
library(ggmap)
register_google(key=myGoogleAPIKey)
qmap(location="New York, NY", zoom=14)

nyc <- geocode("New York, NY")
nyc

whitehouse <- geocode("whitehouse")
my_map <- get_map(whitehouse,zoom=7,maptype="terrain")
ggmap(my_map)

oxford <- geocode("Oxford, UK")
uk <- geocode("UK")


placenames <- c("Oxford, UK", "Manchester, UK", "Glasgow, UK")
locations <- geocode(placenames)
# locations is a tibble (!)
# but it doesn't include placenames...
namedLocations <- tibble(name=placenames, lat=locations$lat, lon=locations$lon)
namedLocations
ggmap(get_map(uk, zoom=4, maptype="toner-background")) + 
  geom_point(mapping=aes(x=lon, y=lat), color="red", data=namedLocations) +
  geom_text(mapping=aes(x=lon, y=lat, label=name), color="red", data=namedLocations, nudge_y=1)
