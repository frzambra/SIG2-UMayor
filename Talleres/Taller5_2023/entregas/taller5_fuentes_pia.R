#Pia Fuentes

install.packages('terra')
library(terra)

#1.  (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

#las unidades
#la resolución espacial
#cantidad de filas y columnas
#el sistema de referencia de coordenadas

#Hay que transformar las coordenadas de GM a GD. 

r <- rast(xmin = -70.6667, xmax = -69.6667,
          ymin = -33.5,  ymax = -32.5 ) #valores negativos ya que estan en el cuadrante oeste y sur, por ende, los valorws son negativos. 
r 

#Unidad: Grados decimales (GD).
#Resolución espacial: 0.002777778, 0.005555556 GD.
#Cantidad de filas y columnas: 180 filas y 360 columnas.
#SRC: WGS 84
crs(r)

plot(r)
#PREGUNTA: why no aparece la visualización del raster? Hay que agregarle valores? 
#values(r) <- 1:64800

#2. (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

r2 <- rast(xmin = -70.6667, xmax = -69.6667,
          ymin = -33.5,  ymax = -32.5,
          nrows=10, ncols=5)


r2
class(r2)

#Funciones para obtener datos especificos (algunos aparecen también al imprimir r2)
dim(r2) #dimensión (nrow, ncol, nlyr)
res(r2) #resolución espacial 
crs(r2) #SRC
ncell(r2) #10*5=50
ext(r2) #extensión, indica coordenadas.

#Asiganr valores a las celdas.
values(r2) <- 1:50
plot(r2)
text(r2)
install.packages('tmap') #Thematic Map Visualization
library(tmap)
?tmap

tm_shape(r2) + tm_raster()

#3.  Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.

r3 <- rast(xmin = 350000, xmax = 450000, ymin = 6400000, ymax = 6500000,
          ncols = 10, nrows = 10, crs= "EPSG:32719")
class(r3)
values(r3) <- 100:1
plot(r3)
text(r3)

#4. (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

#FORMA 1 --> Crear cada capa con  los valores correspondientes.
r4.1 <- rast(ncols=3,nrows=3)
values(r4.1) <- 1:9
plot(r4.1) #los valores en el gráfico van del 1 al 9

r4.2 <- rast(ncols=3,nrows=3)
values(r4.1) <- 10:18
plot(r4.1) #valores del gráfico cambian y van desde 10 al 18.

r4.3 <- rast(ncols=3,nrows=3)
values(r4.1) <- 19:27
plot(r4.1) #con la ultima capa solicitada, al plotear el raster los valored que aparecen son del 19 al 27 (valores indicados para la ultima capa)

r4_final <- rast(x=c(r4.1,r4.2,r4.3))
plot(r4_final)


#FORMA 2 --> Hacer todo junto.
r4 <- rast(ncols=3,nrows=3,nlyr=3) #indicar enseguida el numero de capas.
values(r4) <- 1:27
plot(r4) #muestra cada capa. 

#Para graficar por capa con los valores de cada celda.
plot(r4[[1]]);text(r4[[1]])
plot(r4[[2]]);text(r4[[2]])
plot(r4[[3]]);text(r4[[3]])

#5. (20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Haga un plot del raster y muestre los valores en cada celda.

r4_suma <- sum(r4)
plot(r4_suma)
text(r4_suma) #o plot(r_sum2);text(r_sum2)

#Otra forma -> indexar las capas y sumarlas.
r4_sum1 <- r4[[1]]+r4[[2]]+r4[[3]]
plot(r4_sum1)
text(r4_sum1)

#6. (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.

r4_suma_raiz <- sqrt(r4_suma)
plot(r4_suma_raiz)
text(r4_suma_raiz, digits=2)

writeRaster(r4_suma_raiz,"r_sqrt.tif")
?writeRaster

#7.  (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

#Sistema de Referencia de Coordenadas.
#Número de filas y columnas.
#Resolución espacial.
#Número de capas (layers).
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

?plotRGB

#Raster Santa_Olga
raster1 <- rast('Santa_Olga.tif')
raster1
crs(raster1) #SRC
dim(raster1) #Cantidad de filas, columnas y capas. 
res(raster1) #resolución espacial.
plot(raster1)
plotRGB(raster1)

#Respuestas para raster Santa_Olga:
#SRC: WGS84/ UTM zone 18S (EPSG:32718)
#3812 filas y 4989 columnas.
#Resolución espacial: 0.4328, 0.4328
#Numero de capas: 3

#Raster dem_isla_de_pascua
raster2 <- rast('dem_islas/Dem Isla de pascua 4m.tif')
raster2
crs(raster2) #SRC
dim(raster2) #Cnatidad de filas, columnas y capas. 
res(raster2) #resolución espacial.
plot(raster2)

#Respuestas para raster dem_isla_de_pascua:
#SRC: WGS84/ UTM zone 12S (EPSG:32712)
#3938 filas y 5542 columnas.
#Resolución espacial:  4, 4
#Numero de capas: 1

#Raster dem_j_fernandez
raster3 <- rast('dem_islas/Dem J Fernandez  2m.tif')
raster3
crs(raster3) #SRC
dim(raster3) #Cnatidad de filas, columnas y capas. 
res(raster3) #resolución espacial.
plot(raster3)

#Respuestas para raster dem_j_Fernandez:
#SRC: WGS84/ UTM zone 17S (EPSG:32717)
#4298 filas y 8263 columnas.
#Resolución espacial:  2, 2
#Numero de capas: 1
