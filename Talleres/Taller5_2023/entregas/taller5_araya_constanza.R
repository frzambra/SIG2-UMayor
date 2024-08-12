#taller5
#Constanza Araya
install.packages("terra")
library(terra)
install.packages("sf")
library(sf)

#1.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:
rast() #entrega algo por defecto
#pasar a grados decimales
#x=longitud, y=latitud
70+40/60
69+40/60
33+30/60
32+30/60

#oeste se toma negativa
#sur al ecuador se toma negativa
r<-rast(xmin=-70.66667,xmax=-69.66667, ymin=-33.5,ymax=-32.5)
r
#las unidades: grados decimales
#la resolución espacial
res(r)#resolucion espacial es el tamaño del pixel
values(r)#valores del raster
#cantidad de filas y columnas
dim(r) #diemnsion del raster, fila, columna y capa
#el sistema de referencia de coordenadas
crs(r)

#2.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.
#mismo raster de arriba
r<-rast(xmin=-70.66667,xmax=-69.66667, ymin=-33.5,ymax=-32.5,nrow=10,ncol=5)
dim(r)#dimension, filas columnas cpas
#aumenta la resolucion espacial porque tiene menos celdas
res(r)
#ncell= numero de celdas
ncell(r)
ext(r)#extencion del raster
#asignar numeros a las celdas del raster
values(r)<-1:50
plot(r)
text(r)

#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.
r3<-rast(xmin=350000,xmax=450000,ymin=6400000,ymax=6500000, nrow=10, ncol=10, crs="EPSG:32719")#crs=para agregar la coordenada
r3
values(r3)<-100:1
plot(r3)
text(r3)
#4.- (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.
r<-rast(ncols=3,nrows=3,nlyrs=3) #nlyrs asignar cuantas capas tiene
values(r)<-1:27
plot(r)
plot(r[[1]]);text(r[[1]]) #primera capa
plot(r[[2]]);text(r[[2]]) #segunda capa
plot(r[[3]]);text(r[[3]]) #erera capa

#segunda forma
r1<-rast(ncols=3,nrows=3)
values(r1)<-1:9
r2<-rast(ncols=3,nrows=3)
values(r2)<-10:18
r3<-rast(ncols=3,nrows=3)
values(r3)<-19:27
r_f2<-c(r1,r2,r3)
plot(r_f2)

#5.- (20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.
r_sum1<-r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)
#otra forma
r_sum2<-sum(r)
plot(r_sum2)
text(r_sum2)
#6.- (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.
obj_nuevo<-sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo, digits=2)
writeRaster(obj_nuevo,"r_sqrt.tif")

#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

santa_olga<-rast("raster/Santa_Olga.tif")
isla_pascua<-rast("raster/dem_islas/Dem Isla de pascua 4m.tif")
juan_fernandez<-rast("raster/dem_islas/Dem J Fernandez  2m.tif")

#Sistema de Referencia de Coordenadas
crs(santa_olga)
crs(isla_pascua)
crs(juan_fernandez)

#Número de filas y columnas
dim(santa_olga) #3
dim(isla_pascua) #1
dim(juan_fernandez)#1

#Resolución espacial
res(santa_olga)
res(isla_pascua)
res(juan_fernandez)

#Número de capas (layers)
dim(santa_olga) #3
dim(isla_pascua) #1
dim(juan_fernandez)#1
#otra forma



#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.
plot(santa_olga)
plotRGB(santa_olga)
plot(isla_pascua)
plot(juan_fernandez)
