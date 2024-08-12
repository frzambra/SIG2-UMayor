library(sf)
library(terra)
library(geodata)
library(tmap)

#1. (10pts) Cargue la capa correspondiente a los distritos censales y asignelo al objeto dis_cens .

dis_cens= st_read("data/examen/distritos_censales.gpkg")

#2. (30pts) Calcule los centroides para cada uno de los distritos censales. Haga un plot en donde se puedan visualizar los distritos censales y sus centroides.

cent= st_centroid(dis_cens$geom)

plot(dis_cens$geom)
plot(cent,add=TRUE)

#3. (30pts) Para cada uno de los centroides cree buffers de 2km. Haga un plot de la geometría de los buffers

buff= st_buffer(cent,2000)

plot(buff)

#4. (30pts) De los buffer creados en la pregunta anterior, seleccione el buffer que tiene como nombre Los Tricahues. Asígnelo al objeto buffer_los_tricahues.

tricahues= dis_cens[dis_cens$nom_dis=='Los Tricahues',]

buffer_los_tricahues= st_intersection(buff,tricahues)

#5. (20pts) Cargue los archivos correspondientes a los LAI de las seis fechas, en R en un sólo objeto.Cambie el nombre de cada capa (layer) por la fecha correspondiente. Haga un plot.

files= list.files("data/examen/",pattern='tif$',full.names = TRUE)

lai= rast(files)

plot(lai)

lai1= lai[[1]] 
lai2= lai[[2]]
lai3= lai[[3]]
lai4= lai[[4]]
lai5= lai[[5]]
lai6= lai[[6]]

lai= rast(c(lai1,lai2,lai3,lai4,lai5,lai6))

names(lai)= c('2021-01-03','2021-01-08','2021-01-13','2021-01-18','2021-01-23','2021-01-28')

plot(lai)

#6. (20pts) Calcule el promedio de LAI para las seis fechas. Asigne el resultado a lai_promedio. No considere los valores no disponibles (NA) en el promedio. Haga un plot del resultado.

lai_promedio= mean(lai,na.rm= TRUE)

plot(lai_promedio)

#7. (20pts) Transforme el sistema de referencia de coordenadas del objeto lai_promedio a coordenadas geográficas, datum WGS84. Asignelo al objeto lai_promedio_geo.

crs(lai_promedio,describe=TRUE)

lai_promedio_geo= project(lai_promedio, '+proj=longlat +EPSG:32719')

#8. (20pts) Utilice el buffer del distrito “Los Tricahues” de la pregunta 4, para cortar el lai_promedio ajustado a los límites del buffer de Los Tricahues .

buff_proj= st_transform(buffer_los_tricahues,st_crs(lai_promedio))

buff1=st_as_sf(buff_proj)

mask= mask(lai_promedio,buff1)

plot(mask)

#9. (30pts) Cree una mascara con los valores de lai_promedio de la pregunta anterior, en el que los pixeles con valores de LAI < 3 se hagan NA . Haga un plot del raster resultante. Ajuste el resultado de forma que se eliminen los valores NA que se encuentran en los bordes.

mask[lai_promedio < 3 ]= NA

plot(mask)

plot(lai_promedio)

plot(lai_promedio < 3)

#10. (40pts) Cree un mapa dinámico utilizando {tmap} en el que se visualize el LAI promedio para el buffer del centroide en Los Tricahues , además de los bordes del distrito Los Tricahues.

tm_shape(tricahues$geom) +
  tm_borders(lai_promedio) +
  tm_shape(buffer_los_tricahues) 


