#installing the need library
install.packages("sf")
install.packages("rgdal")
install.packages("data.table")
install.packages("leaflet")
install.packages("htmltools")

#including the library
library(sf) #to deal with simple features maps
library(rgdal) # to read the map file
library(data.table) # to read the csv file
library(leaflet) # for plotting in web form
library(htmltools) # to pares html

#reading map
dz_map <- readOGR("dzaBound/dzaBound.shp")

#reading data
dz_data <- as.data.frame(fread(file="data.csv", header=TRUE))

#matching data$Province to map$Province
dz_data <- dz_data[order(match(dz_data$Province,dz_map$nam)),]

#we creat a new row that we call total and that's what we gonna plot
dz_data$total <- c(dz_data$HVA+dz_data$HVB+dz_data$HVC) 


#cleaning map
dz_map$FIRST_f_co <- NULL
dz_map$FIRST_f__1 <- NULL
dz_map$FIRST_coc <- NULL
dz_map$FIRST_soc <- NULL

#here we want custom values so we force them manual
bins <-c(0, 56, 112,168,224,228,336,392,448,504)

#function that calculate the colors density(shades) it should be noted that we have chosen 10 values because colorBin dosn'tallow more then 11 shades 
pal = colorBin("Reds", dz_data$total, bins=bins)

#creating the label
lables <- paste("<p ><b>","Province of ",dz_data$Province,"</b> </p>",
                "<p> ","HVA cases: ",dz_data$HVA," </p>",
                "<p> ","HVB cases: ",dz_data$HVB," </p>",
                "<p> ","HVC cases: ",dz_data$HVC," </p>",
                sep = "")


#building the map thing
web_map<- leaflet() %>% #contractor (%>% is magrittr pipe operator which make your code more readable )
  addProviderTiles(providers$CartoDB.Positron) %>% #choosing the background map
  setView(5,28,5,5) %>% #this values are manual set to make dz in the middle of the scan
  addPolygons(data = dz_map,
              stroke = TRUE,
              weight = 1,
              smoothFactor = 0.5,
              color = "black",
              fillOpacity = 0.8,
              fillColor = pal(dz_data$total),
              highlight = highlightOptions(
                weight = 5,
                color="#ffff05",
                fillOpacity = 0.7,
                bringToFront  = TRUE
              ),label = lapply(lables,HTML)) %>%
  addLegend(pal = pal, values = bins, opacity = 0.7,position = "topright",title = "HV Totale caese")


web_map
