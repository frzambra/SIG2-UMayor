#2 CONCEPTOS

#1 Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#1 En primer lugar instalando y cargando paquetes de datos como sf, terra y tmap dependiendo de lo que necesites hacer sirviendo sf para representar, análizar y operar objetos geoespaciales vectoriales, terra para objetos raster y tmap para la creación y el diseño de mapas. También podrás subir a r archivos con los que podrás trabajar como datos.  Una vez instalado y cargado el paquete tendrás que escribir códigos utilizando funciones propias de los paquetes o generales, creando variables en donde guardarás lo realizado para seguir operándolo o mostrarlo. 

#2Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#2 Para trabajar con datos raster, la clase definida por terra es SpatRaster, en el caso de los objetos de tipo vectorial la geometría tiene clase list-column y los atributos data.frame

#3 Liste los tipos de geometrias que se pueden trabajar con el paquete sf
#3 Se puede trabajar las geometrías: point, multipoint, linestring, multilinestring, polygon, multipolygon


#4 Describa los objetos de clase sf (describir el objeto sf)
#4 un objeto sf cuenta con el simple feature individual, los atributos más la geometría 


#3 VECTORIALES

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

install.packages("sf")
library (sf)

df_pol = data.frame (c(0,4,6,4,0,-2),c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
dpol = as.matrix(df_pol)
de = st_polygon(list(rbind(dpol[1:6,],dpol[1,])))
plot(de)

#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#a. (5pts) tipo de geometria
#b. (5pts) dimensión de los puntos
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)#d. (5pts) cantidad de variables y observaciones
#e. (5pts) extensión


#4 RASTER
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud
#Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser
#coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes
#valores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

install.packages("terra")
library(terra)

i= rast(nrow=4, ncol= 4, xmin=35.20, xmax=37.30, ymin=70.15, ymax=71.50)

#2. (15pts) Considere el siguiente raster. Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)








