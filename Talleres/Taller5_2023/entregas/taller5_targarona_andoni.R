#TALLER 5

#INTEGRANTES: Tomás Gougain, Andoni Targarona

#1. (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longitudes 70°40’ y 69°40 Oeste. Indique:

install.packages('terra')
library(terra)

r<- rast()

r <-rast(xmin= -70.667, xmax= -69.6667, ymin= -33.5, ymax= -32.5)
r

#1.2 unidades: está en grados decimales

#1.3 resolución espacial(tamaño pixel)

res(r)

#1.3.1 función obtener los valores en los pixeles

values(r)

crs(r)

#1.4 CANTIDAD FILAS Y COLUMNAS

dim(r)
#filas, columnas y capa

#src
crs(r)


#2. (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

r <-rast(xmin= -70.667, xmax= -69.6667,
         ymin= -33.5, ymax= -32.5, 
         nrows=10, ncols=5)
dim(r) # fila, columnas y capa
res(r) #resolución espacial
ncell(r)#cantidad de celdas
ext(r)#extensión
r

#agregar valores
values(r)<- 1:50
plot(r)
text(r) #muestre valor del pixel sobre ráster

#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.

r<- rast(xmin= 350000, xmax=450000, ymin= 6400000, ymax= -6500000, 
         ncol=10, nrow= 10, crs= 'EPSG:32719')

#forma2
r<- rast(xmin= 350000, xmax=450000, ymin= 6400000, ymax= -6500000, 
         ncol=10, nrow= 10)
crs(r)<- 'EPSG:32719'

#4.- (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

#forma 1
r<- rast(ncol=3, nrow=3, nlyr=3)
r

values(r)<- 1:27
plot(r)

#segunda forma
r1<- rast(ncol=3, nrow=3)
values(r1)<- 1:9

r2<- rast(ncol=3, nrow=3)
values(r2)<- 10:18

r3<-rast(ncol=3, nrow=3)
values(r3)<- 19:27

r_f2<- c(r1, r2, r3)
plot


#5.- (20pts) Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.

#suma de las capas raster
r_sum1 <- r [[(1)]+ r[(2)]+r[(3)]]
plot(r_sum1)
text(r_sum1)

sum(1:3)

#forma 2
r_sum2<- sum(r)
plot(r_sum2)
text(r_sum2)

#6.- (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.

obj_nuevo <- sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo, digits=2)
writeRaster(obj_nuevo, 'r_sqrt.tif')


#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

#archivo isla de pascua
ipascua<- rast("capas_rasters/dem_islas/Dem Isla de pascua 4m.tif")  

#sist. coordendas
crs(ipascua)

#numero filas, columnas y capas
dim(ipascua)

#Resolución espacial
res(ipascua)

plot(ipascua)

#JFernandez
jfernandez<-rast("capas_rasters/dem_islas/Dem J Fernandez  2m.tif")

#sist. coordendas
crs(jfernandez)

#numero filas, columnas y capas
dim(jfernandez)

#Resolución espacial
res(jfernandez)
plot(jfernandez)

#archivo Santa Olga
sta_olga<-rast("capas_rasters/Santa_Olga.tif")

#sist. coordendas
crs(sta_olga)

#numero filas, columnas y capas
dim(sta_olga)

#Resolución espacial
res(sta_olga)
plotRGB(sta_olga)









