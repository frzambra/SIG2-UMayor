#INTEGRANTES: JAVIERA CERDA Y BARBARA SEPULVEDA
#TALLER 5, datos raster con {terra}
#ENTREGA: 10 NOV 


#primero que todo, debemos instalar y cargar el paquete {terra}
#instala {terra}
install.packages("terra")

#cargar {terra}
library(terra)

#####
rast()


#1. (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

#las unidades
#la resolución espacial
#cantidad de filas y columnas
#el sistema de referencia de coordenadas

#para crear un objeto spatraster desde cero ocupamos la funcion rast,, por lo que se le asigna al objeto r.  
?rast
r <- rast()

#Al hablar de latitud y longitud hablamos de grados, cada grado esta en 60min.
#se toma desde el grado mayor al menor 
#longitud (eje x): -70.6667, -69.6667 (70°40’ y 69°40)
#Para longitud: 40/60 = 0.6666667
40/60
40/60+70
40/60+69

#latitud (eje y ): -33.5, -32.5 (33°30’ y 32°30)
#Para latitud: 30/60 = 0,5
30/60
30/60+33
30/60+32

r <- rast(xmin=-70.6667,xmax=-69.6667,
          ymin=-33.5,ymax=-32.5)

#para indicar la resolucion espacial:
res(r)

#para indicar numero de filas, columas y capas (nrow,ncol,nlyr)
dim(r)

#SRC
crs(r)


#comprobando la extension:
ext(r)
#mostar los valores de r
values(r)
r


#2.  (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

#longitud (x): 70°40’ y 69°40
40/60
70+(40/60)
69+(40/60)
#latitud (y):  33°30’ y 32°30’
30/60
33+(30/60)
32+(30/60)

r <- rast(xmin=-70.6667,xmax = -69.6667,
          ymin= -33.5,ymax= -32.5,
          nrows = 10, ncols = 5)

#para indicar numero de filas, columas y capas:
dim(r)

#para indicar la resolucion espacial:
res(r)

#para saber la cantidad de celdas: 
ncell(r)

#para indicar la extension del raster:
ext(r)


#funcion values permite obtener los valores del raster o si se le asigna valores ("debe tener como valores en las celdas los números del 1 al 50".)
values(r) <- 1:50
plot(r)
text(r)


#3. (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.


#Este (en x) : 350.000m y 450.000m 
#Norte (en y): 6.400.00m y 6.500.000m
#Forma 1 (estableciendo el SRC aparte, no dentro del rast)
r <- rast(xmin =350000, xmax=450000,
          ymin=6400000,ymax=6500000,
          ncols=10,nrows=10)
crs(r) <- "EPSG:32719"


#forma 2
r <- rast(xmin =350000, xmax=450000,
          ymin=6400000,ymax=6500000,
          ncols=10,nrows=10, crs= "EPSG:32719")
r
#comprobando que tenga 10 filas y 10 columnas 
dim(r)

#funcion values permite asignar valores al raster ("Agregue los valores a cada celda del 100 al 1")
values(r) <- 100:1
plot(r)
text(r)


#4.(30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

#metodo 1 (lyr 1, 1 y 1)
r1 <- rast(ncols=3,nrows=3)
values(r1) <- 1:9

r2 <- rast(ncols=3,nrows=3)
values(r2) <- 10:18

r3 <- rast(ncols=3,nrows=3)
values(r3) <- 19:27

r_f2 <- c(r1,r2,r3)
plot(r_f2)
r_f2

#metodo 2 (lyr 1, 2 y 3). OFICIALLL.
r <- rast(nrows=3,ncols=3,nlyr=3)
r
values(r) <- c(1:9,10:18,19:27)
plot(r)
nlyr(r)
r
#efectivamente cada capa (lyr 1, lyr.2 y lyr.3 está con sus respectivos valores)

#5.(20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.

#primero se realiza la suma de las tres capas
r_sum1 <- r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)

sum (1:3)

#se guarda la suma en un nuevo raster
r_sum2 <- sum(r)
r_sum2
plot(r_sum2)
text(r_sum2)


#6.(30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.

obj_nuevo <- sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo, digits=2)

#para escribir el archivo raster en disco:
writeRaster(obj_nuevo, "r_sqrt.tif")


#7.  (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

#Sistema de Referencia de Coordenadas
#Número de filas y columnas
#Resolución espacial
#Número de capas (layers)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

getwd()
dempascua <- rast("Dem Isla de pascua 4m.tif")
demfernandez <- rast("Dem J Fernandez  2m.tif")
santaolga <- rast("Santa_Olga.tif")
  
# Sistema de Referencia de Coordenadas (CRS)
crs(dempascua)
crs(demfernandez)
crs(santaolga)

# Número de filas y columnas
#FILAS 
nrow(dempascua)
nrow(demfernandez)
nrow(santaolga)

#COLUMNAS 
ncol(dempascua)
ncol(demfernandez)
ncol(santaolga)

#De todas maneras, la funcion dim nos entrega numero de filas, columas y capas, de una manera más rápida 
dim(dempascua)
dim(demfernandez)
dim(santaolga)

# Resolución espacial
res(dempascua)
res(demfernandez)
res(santaolga)

# Número de capas (layers)
nlyr(dempascua)
nlyr(demfernandez)
nlyr(santaolga)

#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.
plot(dempascua)
plot(demfernandez)
plot(santaolga)
plotRGB(santaolga)

