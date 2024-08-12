#Florencia Celis
#Jonatahn Hernandez

#taller 5
# instala {terra}
install.packages('terra')

# cargar {terra} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene

library(terra)
?SpatRaster
#1.Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

#las unidades: grados decimales 
#la resolución espacial
#cantidad de filas y columnas
#el sistema de referencia de coordenadas

r<- rast(xmin=-70.6667,xmax=-69.6667, ymin= -33.5, ymax= -32.5)
r
#funciones para obtener la resolucion (tamaño del pixel)
res(r)
#funcion para obtener los valores en los pixeles 
values(r)
#sistema de coordenadas 
crs(r)
dim(r)

#2.Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.
r<- rast(xmin=-70.6667,xmax=-69.6667, ymin= -33.5, ymax= -32.5, nrows=10,ncols=5)
dim(r)#filas, columnas , capas 
res(r) #resolucion espacial 
ncell(r) #cantidad de celdas 
ext(r) #extension 
values(r)<-1:50
plot(r)
text(r)

#3. Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.
r<- rast(xmin=350000,xmax=450000,ymin=64000000,ymax=65000000, nrows=10, ncols=10, crs='EPSG:32719')
#forma dos 
r<- rast(xmin=350000,xmax=450000,ymin=64000000,ymax=65000000, nrows=10, ncols=10)
crs(r)<- 'EPSG:32719'
crs(r)

values(r)<-100:1
plot(r)
text(r)
#4.

r<- rast(ncols=3,nrows=3,nlyrs=3) #lyrs numero de capas 
r
values(r)<- 1:27
plot(r)

#segunda forma 
r1<- rast(ncols=3,nrows=3)
values(r1)<- 1:9

r2<- rast(ncols=3,nrows=3)
values(r2)<- 10:18

r3<-rast(ncols=3,nrows=3)
values(r3)<- 19:27

r_f2<- c(r1,r2,r3)
plot(r_f2)

#5. 

#suma de capa del spatraster 

r_sum1 <- r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)

sum(1:3)
r_sum2<- sum(r)
plot(r_sum2)
text(r_sum2)

#6. 
obj_nuevo<- sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo,digits=2)
writeRaster(obj_nuevo,'r_sqrt.tif')

#7
getwd()
dempascua <- rast("Dem Isla de pascua 4m.tif")
demfernandez <- rast("Dem J Fernandez  2m.tif")
santaolga <- rast("Santa_Olga.tif")

#sistema referencia de coordenada

SRC_pascua <- st_crs(dempascua)
SRC_fernandez <- st_crs(demfernandez)
SRC_santaolga <- st_crs(santaolga)

#numero de filas y columnas

num_filas_pascua <- nrow(dempascua)
num_columnas_pascua <- ncol(dempascua)
num_filas_fernandez <- nrow(demfernandez)
num_columnas_fernandez <- ncol(demfernandez)
num_filas_santaolga <- nrow(santaolga)
num_columnas_santaolga <- ncol(santaolga)

#Resolucion espacial

res(dempascua)
res(demfernandez)
res(santaolga)

#Numero de capas

nlyr(dempascua)
nlyr(demfernandez)
nlyr(santaolga)

#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

plot(dempascua)

plot(demfernandez)

plot(santaolga)
plotRGB(santaolga)

