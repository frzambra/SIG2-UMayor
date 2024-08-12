#Examen Valentina Court 


install.packages(c("raster","terra","sf"))
library(raster)
library(terra)
library(sf)


#1. (10pts) Cargue la capa correspondiente a los distritos censales y asignelo al objeto dis_cens .

dis_cens<-read_sf("/cloud/project/data/Examen/distritos_censales.gpkg")


#2. (30pts) Calcule los centroides para cada uno de los distritos censales. Haga un plot en donde se puedan visualizar los distritos censales y sus centroides.

centroid_dis_cens<-st_centroid(dis_cens$geom)
plot(centroid_dis_cens,add=TRUE)

plot(dis_cens$geom)

#3. (30pts) Para cada uno de los centroides cree buffers de 2km. Haga un plot de la geometría de los buffers.

buff_cent<-st_buffer(centroid_dis_cens,dist = 2000)
plot(buff_cent)

#4. (30pts) De los buffer creados en la pregunta anterior, seleccione el buffer que tiene como nombre Los Tricahues . Asígnelo al objeto buffer_los_tricahues .

buffer_los_tricahues<-buff_cent$"Los Tricahues"

#5. (20pts) Cargue los archivos correspondientes a los LAI de las seis fechas, en R en un sólo objeto.
#Cambie el nombre de cada capa (layer) por la fecha correspondiente. Haga un plot.

LAI<-list.files("/cloud/project/data/Examen/LAI",pattern='tif$',full.names = TRUE)

rast_LAI<-rast(LAI)


names(rast_LAI)=c("2021-01-03","2021-01-08","2021-01-13","2021-01-18","2021-01-23","2021-01-28")

plot(rast_LAI)

#6. (20pts) Calcule el promedio de LAI para las seis fechas. Asigne el resultado a lai_promedio . No considere los valores no disponibles (NA) en el promedio. Haga un plot del resultado.



lai_promedio<-mean(rast_LAI,na.rm=TRUE)
plot(lai_promedio)




#7. (20pts) Transforme el sistema de referencia de coordenadas del objeto lai_promedio a coordenadas geográficas, datum WGS84. Asignelo al objeto lai_promedio_geo .




crs(lai_promedio)

lai_promedio_geo<-project(lai_promedio,"EPSG:32719")
crs(lai_promedio_geo) ==crs(lai_promedio)






#8. (20pts) Utilice el buffer del distrito “Los Tricahues” de la pregunta 4, para cortar el lai_promedio ajustado a los límites del buffer de Los Tricahues .


#9. (30pts) Cree una mascara con los valores de lai_promedio de la pregunta anterior, en el que los pixeles con valores de LAI < 3 se hagan NA . Haga un plot del raster resultante. Ajuste el resultado de forma que se eliminen los valores NA que se encuentran en los bordes.



#10. (40pts) Cree un mapa dinámico utilizando {tmap} en el que se visualize el LAI promedio para el buffer del centroide en Los Tricahues , además de los bordes del distrito Los Tricahues.



