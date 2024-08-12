#Taller 5 Valentina Court 

install.packages("terra")
library("terra")
#1.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

#las unidades
#la resolución espacial
#cantidad de filas y columnas
#el sistema de referencia de coordenadas
r <- rast()
r <-rast(xmin=-70.6667,xmax=-69.6667,ymin=-33.5,ymax=-32.5)
r
#resolucion
res(r)
#valorpixeles
values(r)


#2.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50 
r <-rast(xmin=-70.6667,xmax=-69.6667,ymin=-33.5,ymax=-32.5,nrows=10,ncols=5)
dim(r)
res(r)
r
ncell(r)
ext(r)
values(r)<-1:50
values(r)
plot(r)
text(r)


#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.
e <-rast(xmin=350000,xmax=450000,ymin=6400000,ymax=6500000,ncols=10,nrows=10,crs="EPSG:32719")
e
values(e)<-100:1
plot(e)
text(e)


#4. (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.
f <-rast(ncols=3,nrows=3,nlyrs=3)
f
values(f) <- 1:27
plot(f)
plot(f[[1]]);text(f[[1]])
plot(f[[2]]);text(f[[2]])
plot(f[[3]]);text(f[[3]])


#5. (20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.
f_sum1 <- f[[1]]+f[[2]]+f[[3]]
f_sum1
plot(f_sum1)
text(f_sum1)


#6. (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.
jj <-sqrt(f_sum1)
plot(jj)
text(jj)
#guardar raster

writeRaster(jj,"r_sqrt.tif")

#7. (75pts) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

#Sistema de Referencia de Coordenadas
#Número de filas y columnas
#Resolución espacial
#Número de capas (layers)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.


