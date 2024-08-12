#1.Cargue la capa correspondiente a los distritos censales y 
#asignelo al objeto dis_cens

install.packages('sf')
library(sf) 

dis_cens<- read_sf("data/distritos_censales.gpkg") 


#2. Calcule los centroides para cada uno de los distritos censales.
#Haga un plot en donde se puedan visualizar los distritos censales
#y sus centroides
centroides<- st_centroid(dis_cens)
plot(dis_cens)
plot(centroides)

par(mfrow=c(1,2))
plot(dis_cens$geometry)
plot(centroides$geometry)


#3.Para cada uno de los centroides cree buffers de 2km. 
#Haga un plot de la geometría de losbuffers.
buff_2k<-st_buffer(centroides,2000)
plot(buff_2k)

#4.De los buffer creados en la pregunta anterior, seleccione el buffer que tiene como nombre
#Los Tricahues . Asígnelo al objeto buffer_los_tricahues 
names(buff_2k)
buffer_los_tricahues<- buff_2k["Los Tricahues"]
buffer_los_tricahues<-[buff_2k$buffer == "Los Tricahues"]

#5.Cargue los archivos correspondientes a los LAI de las seis fechas, en R en un sólo objeto.
#Cambie el nombre de cada capa (layer) por la fecha correspondiente. Haga un plot
install.packages('terra')



lai<- list.files('archivos',full.names=TRUE)
library(terra)
print(lai)

03/01/2021<-rast('archivos/lai_2021-01-03.tif')
08/01/2021<-rast('archivos/lai_2021-01-08.tif')
13/01/2021<-rast('archivos/lai_2021-01-13.tif')
18/01/2021<-rast('archivos/lai_2021-01-18.tif')
23/01/2021<-rast('archivos/lai_2021-01-23.tif')
28/01/2021<-rast('archivos/lai_2021-01-28.tif')

fechas<-c(03/01/2021,08/01/2021,13/01/2021,
          18/01/2021,23/01/2021,28/01/2021)
plot(fechas)
names(fechas)<-c('03/01/2021','08/01/2021','13/01/2021',
                 '18/01/2021','23/01/2021','28/01/2021')
plot(fechas)


#6.Calcule el promedio de LAI para las seis fechas. Asigne el resultado a lai_promedio . No
#considere los valores no disponibles (NA) en el promedio. Haga un plot del resultado
lai_promedio<- mean(lai,na.rm=TRUE)
plot(lai_promedio)


#7. Transforme el sistema de referencia de coordenadas del objeto lai_promedio a coordenadas
#geográficas, datum WGS84. Asignelo al objeto lai_promedio_geo 
lai_promedio_geo<- st_transform(lai_promedio,4326)
lai_promedio_geo<- project(lai_promedio,'EPSG:4326')

#8. Utilice el buffer del distrito “Los Tricahues” de la pregunta 4,
#para cortar el lai_promedio
#ajustado a los límites del buffer de Los Tricahues .
buffer_los_tricahues<- crop(lai_promedio)

#9.Cree una mascara con los valores de lai_promedio de la pregunta anterior, en el que los
#pixeles con valores de LAI < 3 se hagan NA . Haga un plot del raster resultante. Ajuste el resultado de
#forma que se eliminen los valores NA que se encuentran en los bordes.
lai_promedio[lai<3]<-NA
plot(lai_promedio)


#10.Cree un mapa dinámico utilizando {tmap} en el que se visualize el LAI promedio para el buffer
#del centroide en Los Tricahues , además de los bordes del distrito Los Tricahues
install.packages('tmap')
library(tmap)
tmap_mode('view')

tm_shape(lai_promedio_geo)+
  tm_borders()+
  tm_shape(buff_2k)+
  tm_dots(col ='',style='cat')
