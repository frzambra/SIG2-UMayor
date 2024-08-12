#Camila Urrutia
#cargar {terra} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene

library(terra)


#1.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:


#las unidades: grados decimales
r <- rast()  #automaticamente me crea un archivo rast. por defecto (4326), no tiene ningun valor.
r <- rast(xmin=-70.6666667, xmax=-69.6667, ymin=-33.55, ymax=-32.50)

#la resolución espacial
res(r) #tamaño del pixel, no son sieempre cuadrados, puede tener otra forma

#cantidad de filas y columnas
dim(r) #fila, columna y capa
values(r) #funciones para obtener el valor de los pixeles

crs(r) #para ver la coordenadas
crs(r,describe=TRUE)

plot(r) # no muestra nada por que no tengo valores.
#el sistema de referencia de coordenadas


#2.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

r <- rast(xmin=-70.6666667, xmax=-69.6667, ymin=-33.55, ymax=-32.50, nrows=10,ncols=5)

res(r) #cambio la resulucion del raste, mas grandes los pixeles, porque tiene menor celdas, ya que se hicieron al reducir a 10 filas y columna
ncell(r)
r
values(r) <- 1:50 #asigando valores al raster r
plot(r) 
ncell(r) #cantidad de celdas
ext(r) #extension
text(r) #muestre sobre el raster los valores del pixel, con raster de pequña dimension.


#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.

r<-rast(xmin=350000,xmax=450000,ymin=6400000,ymax=6500000,ncols=10,nrow=10,crs="EPSG:32729") #asignar la coordenda.
values(r) <- 100:1
plot(r)
text(r)


#4.- (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.


# Crear un raster con 3 filas, 3 columnas y 3 capas
r <- rast(nrows = 3, ncols = 3, nlyrs = 3)

values(r) <- 1:27

plot(r)

#segunda forma
r1<- rast(ncols=3,nrows=3)
values(r1)<-1:9
r2<-rast(ncols=3,nrows=3)
values(r2)<-10:28
r3<-rast(ncols=3,nrows=3)
values(r3)<-19:27

r_f2 <- c(r1,r2,r3)
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
plot(objt_nuevo)

text(obj_nuevo,digits=2)

(obj_nuevo,"r_sqrt.tif")

#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:
getwd()

#######archivo isla de pascua
ipascua<- rast("capas_rasters/dem_islas/Dem Isla de pascua 4m.tif")  

#sist. coordendas
crs(ipascua)

#numero filas, columnas y capas
dim(ipascua)

#Resolución espacial
res(ipascua)

plot(ipascua)
#######archivo J Fernandez
jfernandez<-rast("capas_rasters/dem_islas/Dem J Fernandez  2m.tif")

#sist. coordendas
crs(jfernandez)

#numero filas, columnas y capas
dim(jfernandez)
#Resolución espacial
res(jfernandez)
plot(jfernandez)

########archivo Santa Olga
santaolga<-rast("capas_rasters/Santa_Olga.tif")

#sist. coordendas
crs(santaolga)

#numero filas, columnas y capas

dim(santaolga)
#Resolución espacial
res(santaolga)
plotRGB(santaolga)