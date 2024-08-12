install.packages("terra")
library(terra)



#1.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:
r<-rast(xmin=-70.6667,xmax=-69.666,
        ymin=-33.5,ymax=-32.5)

#las unidades
##R: Al utilizar latitud y longitud, las unidades son grados decimales.

#la resolución espacial
res(r)
#cantidad de filas y columnas
ncol(r)
nrow(r)

#el sistema de referencia de coordenadas
crs(r)

#2.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

r<-rast(xmin=-70.6667,xmax=-69.666,
        ymin=-33.5,ymax=-32.5,
        nrows=10,ncol=5)
r

values(r)<-1:50 #agrega valores al raster
plot(r)
text(r)#muestre sobre el pixel, su valor

#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.
r<-rast(xmin=350000,xmax=450000,
        ymin=6400000,ymax=6500000,
        ncol=10,nrows=10,
        crs="EPSG:32719")

values(r)<-100:1
plot(r)
text(r)


#4.- (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

r<-rast(ncols=3,nrows=3,nlyrs=3)
r
values(r)<-1:27

plot(r[[1]]);text(r[[1]])
plot(r[[2]]);text(r[[2]])
plot(r[[3]]);text(r[[3]])


#hacer la de la capa por separado

#5.- (20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.

r_sum1<-r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)


#6.- (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.
obj_nuevo<-sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo,digits=2)
writeRaster(obj_nuevo,'r_sqrt.tif')


#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

santa_olga_leido<-rast("Santa_Olga.tif")
santa_olga_leido
plot(santa_olga_leido)

#Sistema de Referencia de Coordenadas
crs(santa_olga_leido)
#Número de filas y columnas
ncol(santa_olga_leido)
nrow(santa_olga_leido)
#Resolución espacial
res(santa_olga_leido)
#Número de capas (layers)
nlyr(santa_olga_leido)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

plot(santa_olga_leido)
plotRGB(santa_olga_leido)

