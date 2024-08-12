install.packages("sf")
library(sf)
#1
dis_cens<-st_read("cens/distritos_censales.gpkg")

#2
plot(dis_cens)
distritos <- dis_cens[dis_cens$nom_dis== 1:174]
cent<-st_centroid(distritos)
plot(distritos)
plot(cent,col ='black', add = TRUE)

#3
cent_buff <- st_buffer(cent,2000)
plot(cent_buff)

#4
distritos_tricahues <- dis_cens[dis_cens$nom_dis=="Los Tricahues"]
buffer_los_tricahues <- cent_buff[distritos_tricahues,]

#5
install.packages("terra")
library(terra)

capa1 <-rast("cens/lai_2021-01-03.tif")
capa2 <-rast("cens/lai_2021-01-08.tif")
capa3 <-rast("cens/lai_2021-01-13.tif")
capa4 <-rast("cens/lai_2021-01-18.tif")
capa5 <-rast("cens/lai_2021-01-23.tif")
capa6 <-rast("cens/lai_2021-01-28.tif")
plot(capa1)
plot(capa2)
plot(capa3)
plot(capa4)
plot(capa5)
plot(capa6)

#6
p1 <-mean(capa1)
p2 <-mean(capa2)
p3 <-mean(capa3)
p4 <-mean(capa4)
p5 <-mean(capa5)
p6 <-mean(capa6)

lai_promedio <-c(p1,p2,p3,p4,p5,p6)
names(lai_promedio) <-c("2021-01-03","2021-01-08","2021-01-13","2021-01-18","2021-01-23","2021-01-28")
plot(lai_promedio)

#7
crs(lai_promedio)
lai_promedio_geo<- project(lai_promedio,"EPSG:4326")
crs(lai_promedio_geo)

