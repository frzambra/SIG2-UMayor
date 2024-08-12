#1
install.packages("terra")
library(terra)

r <- rast()
r <- rast(xmin=-70.6667, xmax=-69.6667, 
          ymin=-33.5,ymax=-32.5)

#Cada grado esta en 60 minutos por lo cual se divide 40/60 loq nos da 0.6667 grados, desde ahi se pone del mas negativo al mas positivo, tomando desde el grado mayor al menor cambiandolo de positivo a negativo como en el ejemplo
#esta en grados decimales ya que esta en latitud y longitud

res(r)
#res es la resolucion espacial lo cual es el tamaño del pixel

values(r)
crs(r)
dim(r)
#dimension del raster

#2
r <- rast(xmin=-70.6667, xmax=-69.6667, 
          ymin=-33.5,ymax=-32.5,
          nrows=10, ncols=5)
dim(r) #fila, columnas, capas
res(r) 
ncell(r) #cantidad de celdas
ext(r)

values(r) <- 1:50
plot(r)
text(r)

#3
r <- rast(xmin=350000, xmax=450000, ymin=6400000, ymax=6500000,
          ncols = 10,nrows=10, crs="EPSG:32719")
values(r) <-100:1

plot(r)
text(r)

#4
r<- rast(ncols=3, nrows=3,nlyrs=3)
values(r) <-1:27
plot(r)

plot(r[[1]]);text(r[[1]])
plot(r[[2]]);text(r[[2]])
plot(r[[3]]);text(r[[3]])

#5
#suma de las capas el spatRaster
r_sum1 <- r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)

sum(1:3)

r_sum2 <- sum(r)
plot(r_sum2)
text(r_sum2)

#6

obj_nuevo <- sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo,digits=2)
writeRaster(obj_nuevo,"r_sqrt.tif")

#7


Isla_p4<-rast("Dem Isla de pascua 4m.tif")
Isla_p4
plot(Isla_p4)

#Sistema de Referencia de Coordenadas
crs(Isla_p4)
#Número de filas y columnas
ncol(Isla_p4)
nrow(Isla_p4)
#Resolución espacial
res(Isla_p4)
#Número de capas (layers)
nlyr(Isla_p4)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

plot(Isla_p4)
plotRGB(Isla_p4)



###ISLA DE PASCUA 2M###

Isla_p2<-rast("Dem J Fernandez  2m.tif")
Isla_p2
plot(Isla_p2)

#Sistema de Referencia de Coordenadas
crs(Isla_p2)
#Número de filas y columnas
ncol(Isla_p2)
nrow(Isla_p2)
#Resolución espacial
res(Isla_p2)
#Número de capas (layers)
nlyr(Isla_p2)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

plot(Isla_p2)
plotRGB(Isla_p2)



























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

