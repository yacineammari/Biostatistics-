#installing the need library only do it 1 time
install.packages("sf")
install.packages("ggplot2")
install.packages("viridisLite")
install.packages("viridis")
install.packages("data.table")


#including the library
library(sf) #to deal with simple features maps
library(ggplot2) #for plotting
library(viridisLite) #needed for viridis
library(viridis) #to change ggplot2 colors and theme
library(data.table) #to read the csv file


#reading the data
the_data <- as.data.frame(fread(file="data.csv", header=TRUE))

#reading the map as table
the_map <- st_read('dzaBound/dzaBound.shp',stringsAsFactors =FALSE)

#cleaing the map tab
the_map[c("FIRST_f_co","FIRST_f__1","FIRST_coc","FIRST_soc")] <- list(NULL)

#joining the data and the map into one var for essayer use
map_and_data <- merge(the_data, the_map, by.x = 'Province',by.y = 'nam',sort=TRUE)

#adding the gray line of lon and lat and chaning the background color
theme_set( theme_bw()+ 
  theme(panel.grid.major = element_line(color = gray(0.5)
        , linetype = "dashed", size = 0.5)
        , panel.background = element_rect(fill = "#f5f5f2"))
)

#custom guide
guide <- guide_colorbar(
  direction = "horizontal",#direction
  barheight = unit(3, units = "mm"),#tol
  barwidth = unit(70, units = "mm"),#3ard
  title.position = 'top',#put tittle in top
  # some shifting around to be centerd
  title.hjust = 0.5,
  label.hjust = 0.5
)

#caption
caption <- "MAP :Algeria Political Boundaries  DATA:MS.Schehrazad Selmane  AUTHORS:Ammari Yacine AND Mlike Yanis Rekab"
#subtitle
subtitle <- "Based on the Data provide by MS.Schehrazad Selmane,2021 "
#x
x <-"Longitude"
#y
y<- "Latitude"
 
 
#HVA MAP
ggplot(map_and_data ,aes(fill = HVA))+#passing our joined variable and choosing the filling
  geom_sf(aes(geometry = geometry))+#giving the geometry form the variable
  labs(
    title= "Cases of HVA in algeria provinces"
       ,y=y
       , x = x
       ,subtitle = subtitle 
       , caption = caption
    )+ #lables
  theme(legend.position = "bottom") +#the Guide
  scale_fill_viridis(
    option = "inferno",#the color to be used 
    direction = -1,#setting the highs to have the darker color
    name = "Cases of HVA",#the name
    guide = guide
  )
    


#WE DO THE SAME THING THE HVB AND HVC

#HVB MAP
ggplot(map_and_data ,aes(fill = HVB))+#passing our joined variable and choosing the filling
  geom_sf(aes(geometry = geometry))+#giving the geometry form the variable
  labs(
    title= "Cases of HVB in algeria provinces"
    ,y=y
    , x = x
    ,subtitle = subtitle 
    , caption = caption
  )+ #lables
  theme(legend.position = "bottom") +#the Guide
  scale_fill_viridis(
    option = "inferno",#the color to be used 
    direction = -1,#setting the highs to have the darker color
    name = "Cases of HVB",#the name
    guide = guide
  )



#HVC MAP
ggplot(map_and_data ,aes(fill = HVC))+#passing our joined variable and choosing the filling
  geom_sf(aes(geometry = geometry))+#giving the geometry form the variable
  labs(
    title= "Cases of HVC in algeria provinces"
    ,y=y
    , x = x
    ,subtitle = subtitle 
    , caption = caption
  )+ #lables
  theme(legend.position = "bottom") +#the Guide
  scale_fill_viridis(
    option = "inferno",#the color to be used 
    direction = -1,#setting the highs to have the darker color
    name = "Cases of HVC",#the name
    guide = guide
  )


