# Taller 5
# INTEGRANTES: Matias Ubilla y Jadeline Arratia 
# Entrega: Viernes 10 de nov. 

# instala {terra}
install.packages('terra')
library(terra)
?rast()


# 1 Cree un objeto llamdo `r` de tipo `spatRaster` que tenga una extensión entre las latitudes 33°30' y 32°30' Sur; y entre las longituded 70°40' y 69°40 Oeste. Indique:

# las unidades
# la resolución espacial
#cantidad de filas y columnas
# el sistema de referencia de coordenadas


r <- rast(ymax=-69.66667,ymin=-70.66667, xmax = -32.50,xmin=-33.50)
dim(r)

# 2 Cree un objeto llamdo `r` de tipo `spatRaster` que tenga una extensión entre las latitudes 33°30' y 32°30' Sur; y entre las longituded 70°40' y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

r <- rast(xmax=-69.66667,xmin=-70.66667, ymax = -32.50,ymin=-33.50,ncol=5,nrow=10)

dim(r)
# Fila, columnas, capas 

res(r)
#resolucion 

ncell(r)
#Cantidad de celdas

ext(r)
#extencion del raster 

values(r) <- 1:50
plot(r)
text(r)


# 3 Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.

r <- rast(xmin =350000, xmax=450000,ymin=6400000,ymax=6500000,crs = "EPSG:32719",
          ncol=10,nrow=10)

#Metodo 2

r <- rast(xmin =350000, xmax=450000,ymin=6400000,ymax=6500000,
          ncol=10,nrow=10, crs= "EPSG:32719")

values(r) <- 100:1
plot(r)
text(r)

# en r recordar que el punto es el decimal 

# 4 Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

#Metodo 1
r1 <- rast(ncols=3,nrows=3)
values(r1) <- 1:9

r2 <- rast(ncols=3,nrows=3)
values(r2) <- 10:18

r3 <- rast(ncols=3,nrows=3)
values(r3) <- 19:27

r_f2 <- c(r1,r2,r3)
plot(r_f2)

#Metodo 2 
r <- rast(nrow=3,ncol=3,nlyr=3)
values(r) <- c(1:9,10:18,19:27)
plot(r)

#5 Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Haga un plot del raster y muestre los valores en cada celda.

r_sum1 <- r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)

sum (1:3)

r_sum2 <- sum(r)
plot(r_sum2)
text(r_sum2)

#6 Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (`sqrt`) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre `r_sqrt.tif`.

obj_nuevo <- sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo, digits = 2)
writeRaster(obj_nuevo, "r_sqrt.tif")


#7 De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:
  
# Sistema de Referencia de Coordenadas (crs)
# Número de filas y columnas 
# Resolución espacial (res)
# Número de capas (layers)
# Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función `plot` y `plotRGB`.

setwd("/cloud/project")
Santa_Olga <- rast("Santa_Olga.tif")
dim(Santa_Olga)
crs(Santa_Olga)
plot(Santa_Olga)
plotRGB(Santa_Olga)

setwd("/cloud/project/dem_islas")
Dem_Pascua <- rast("Dem_Pascua.tif")
dim(Dem_Pascua)
crs(Dem_Pascua)
plot(Dem_Pascua)

Dem_Fernandez <- rast("Dem_Fernandez.tif")
dim(Dem_Fernandez)
crs(Dem_Fernandez)
plot(Dem_Fernandez)

