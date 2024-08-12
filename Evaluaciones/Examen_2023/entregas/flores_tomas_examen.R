#EXAMEN TOMÁS FLORES.

library(sf)

library(terra)

library(raster)

library(tmap)


# 1. Cargue la capa correspondiente a los distritos censales y asignelo al objeto dis_cens 

setwd("C:/Users/tomas/OneDrive/Documentos/R/data")


dis_cens <- st_read("distritos_censales.gpkg")


# 2. Calcule los centroides para cada uno de los distritos censales. Haga un plot en donde se puedan visualizar los distritos censales y sus centroides.


centroides <- st_centroid(dis_cens)

plot(centroides)


# 3.Para cada uno de los centroides cree buffers de 2km. Haga un plot de la geometría de los buffers.


buf <- st_buffer(centroides, dist = 2000)

plot(buf)


# 4.De los buffer creados en la pregunta anterior, seleccione el buffer que tiene como nombre Los Tricahues . Asígnelo al objeto buffer_los_tricahues


buffer_los_tricahues <- buf[buf$nom_dis == "Los Tricahues",]

buffer_los_tricahues


# 5. Cargue los archivos correspondientes a los LAI de las seis fechas, en R en un sólo objeto. Cambie el nombre de cada capa (layer) por la fecha correspondiente. Haga un plot.


capa23 <- rast("lai_2021-01-23.tif")

capa23

capa03 <- rast("lai_2021-01-03.tif") 

capa03

capa08 <- rast("lai_2021-01-08.tif") 

capa08

capa13 <- rast("lai_2021-01-13.tif") 

capa13

capa28 <- rast("lai_2021-01-28.tif") 

capa28

capa18 <- rast("lai_2021-01-18.tif") 

capa18


capastotal <- c(capa23, capa03, capa08, capa13, capa28, capa18) 

capastotal

plot(capastotal)


names(capastotal) <- c("2021-01-23", "2021-01-03", "2021-01-08", "2021-01-13", "2021-01-28", "2021-01-18" ) 

plot(capastotal)


# 6. Calcule el promedio de LAI para las seis fechas. Asigne el resultado a lai_promedio . No considere los valores no disponibles (NA) en el promedio. Haga un plot del resultado.


lai_promedio <- mean(capastotal, na.rm = T)

lai_promedio

plot(lai_promedio)


# 7. Transforme el sistema de referencia de coordenadas del objeto lai_promedio a coordenadas geográficas, datum WGS84. Asignelo al objeto lai_promedio_geo 


lai_promedio_geo <- project(lai_promedio, "EPSG:4326")

lai_promedio_geo


# 8. Utilice el buffer del distrito “Los Tricahues” de la pregunta 4, para cortar el lai_promedio ajustado a los límites del buffer de Los Tricahues 


tricahues <- crop(lai_promedio_geo, buffer_los_tricahues)

tricahues

plot(tricahues)


# 9. Cree una mascara con los valores de lai_promedio de la pregunta anterior, en el que los pixeles con valores de LAI < 3 se hagan NA . Haga un plot del raster resultante. Ajuste el resultado de forma que se eliminen los valores NA que se encuentran en los bordes.

lai_promedio

mascara <- [lai_promedio$extention == > 3, NA]   


# 10. Cree un mapa dinámico utilizando {tmap} en el que se visualize el LAI promedio para el buffer del centroide en Los Tricahues , además de los bordes del distrito Los Tricahues


mapa <- tm_shape(tricahues) + tm_borders() + tm_fill("blue") + tm_polygons(centroides)

plot(mapa)               



