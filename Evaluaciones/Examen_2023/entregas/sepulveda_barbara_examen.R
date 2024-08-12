#Barbara sepulveda
#15 de diciembre 2023
#examen

#1. (10pts) Cargue la capa correspondiente a los distritos censales y asignelo al objeto dis_cens .
install.packages("sf")
library(sf)

getwd

dis_cens<-st_read("data/distritos_censales.gpkg")

#2. (30pts) Calcule los centroides para cada uno de los distritos censales. Haga un plot en donde se puedan visualizar los distritos censales y sus centroides
plot(dis_cens)
distritos <- dis_cens[dis_cens$nom_dis== 1:174]
cent<-st_centroid(distritos)
plot(distritos)
plot(cent,col ='black', add = TRUE)




#3. (30pts) Para cada uno de los centroides cree buffers de 2km. Haga un plot de la geometría de losbuffer
st_buffer
seine_buff_2km = st_buffer(seine, dist = 2000)

#4. (30pts) De los buffer creados en la pregunta anterior, seleccione el buffer que tiene como nombre Los Tricahues . Asígnelo al objeto buffer_los_tricahues .
distritos_tricahues <- dis_cens[dis_cens$nom_dis== "Los Tricahues",]
buffer_los_tricahues<- cent_buff[distritos_tricahues,] 

install.packages("terra")
library(terra)

#5. (20pts) Cargue los archivos correspondientes a los LAI de las seis fechas, en R en un sólo objeto.Cambie el nombre de cada capa (layer) por la fecha correspondiente. Haga un plot

cap1<-rast("data/lai_2021-01-03.tif")
plot(cap1)
cap2<-rast("data/lai_2021-01-08.tif")
cap3<-rast("data/lai_2021-01-13.tif")
cap4<-rast("data/lai_2021-01-18.tif")
cap5<-rast("data/lai_2021-01-23.tif")
cap6<-rast("data/lai_2021-01-28.tif")
layer<- c(cap1,cap2,cap3,cap4,cap5,cap6)
names(layer)<-c("2021-01-03","2021-01-08","2021-01-13","2021-01-18","2021-03-23","2021-01-28")



#6. (20pts) Calcule el promedio de LAI para las seis fechas. Asigne el resultado a lai_promedio . Noconsidere los valores no disponibles (NA) en el promedio. Haga un plot del resultado.
pro1<-mean(cap1)
pro2<-mean(cap2)
pro3<-mean(cap3)
pro4<-mean(cap4)
pro5<-mean(cap5)
pro6<-mean(cap6)

lai_promedio <- c(pro1,pro2,pro3,pro4,pro5,pro6)
names(lai_promedio)<-c("2021-01-03","2021-01-08","2021-01-13","2021-01-18","2021-03-23","2021-01-28")
plot(lai_promedio)


#7. (20pts) Transforme el sistema de referencia de coordenadas del objeto lai_promedio a coordenadas geográficas, datum WGS84. Asignelo al objeto lai_promedio_geo .

lai_promedio <- (lai_promedio_geo,coords = c('longitud','latitud'),crs =4326)


#8. (20pts) Utilice el buffer del distrito “Los Tricahues” de la pregunta 4, para cortar el lai_promedio ajustado a los límites del buffer de Los Tricahue
crs(lai_promedio)
lai_promedio_geo <- project(lai_promedio,"EPSG:4326")
crs(lai_promedio_geo)

#9. (30pts) Cree una mascara con los valores de lai_promedio de la pregunta anterior, en el que lospixeles con valores de LAI < 3 se hagan NA . Haga un plot del raster resultante. Ajuste el resultado deforma que se eliminen los valores NA que se encuentran en los bordes.
#10. (40pts) Cree un mapa dinámico utilizando {tmap} en el que se visualize el LAI promedio para el buffer del centroide en Los Tricahues , además de los bordes del distrito Los Tricahues.
library(tmap)
