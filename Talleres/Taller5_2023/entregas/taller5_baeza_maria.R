#taller 5 nombres:Martina aceituno y maria esperanza Baeza
#1.-
install.packages('terra')
library(terra)
?rast
r<-rast()
r<- rast(xmin=-70.6667, xmax=-69.6667,
         ymin=-33.5, ymax=-32.5)
r
#la unidades del raster esta en grados decimales
res(r) #resolución espacial, que el tamaño en pixeles

#funcion para obtener los valores en los pixeles
values(r)
crs(r)
dim(r)
#2.
r<-rast(xmin=-70.6667,xmax=-69.6667,
        ymin=-33.5,ymax=-32.5,nrows=10,ncols=5)
dim(r)#dimension, filas y colmunas
res(r)#resolución espacial
ncell(r)#cantidad de celdas
ext(r)#entrega individualmente la extension

values(r)<-1:50
plot(r)
text(r)#para que muestre sobre el raster de cada pixel, el valor del pixel

#3.
#forma1
r<-rast(xmin=350000,xmax=4500000,ymin=6400000,ymax=6500000,
        ncols=10,nrows=10,crs="EPSG:32719")
#forma 2
r<-rast(xmin=350000,xmax=4500000,ymin=6400000,ymax=6500000,
        ncols=10,nrows=10,)
crs(r)<-'EPSG:32719'
values(r)<-100:1
plot(r)
text(r)

#4.
#1 forma
r<-rast(ncols=3,nrows=3,nlyrs=3)
r
values(r)<-1:27
plot(r)
#2 forma
r1<-rast(ncols=3,nrows=3)
values(r1)<-1:9

r2<-rast(ncols=3,nrows=3)
values(r2)<-10:18

r3<-rast(ncols=3,nrows=3)
values(r3)<-19:27

r_f2<-c(r1,r2,r3)
plot

#5.suma de las capas del spatRaster

r_sum1<-r[[1]]+r[[2]]+r[[3]]
plot(r_sum1)
text(r_sum1)

sum(1:3)

r_sum2<-sum(r)
plot(r_sum2)
text(r_sum2)

6.
obj_nuevo<-sqrt(r_sum1)
plot(obj_nuevo)
text(obj_nuevo,digits=2)
writeRaster(obj_nuevo,'r_sqrt.tif',overwrite=TRUE)
print(obj_nuevo)
#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:
  
# Sistema de Referencia de Coordenadas
#Número de filas y columnas
#Resolución espacial
#Número de capas (layers)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.

# Instala y carga el paquete raster si no lo has hecho
install.packages("raster")
library(raster)

# Ruta al archivo raster
ruta_raster <- "dem_islas/Dem Isla de pascua 4m.tif"

# Carga el raster
raster_obj <- raster(ruta_raster)

# Imprime el sistema de referencia de coordenadas (CRS)
print(crs(raster_obj))

# Imprime el número de filas y columnas
print(dim(raster_obj))

# Imprime la resolución espacial
print(res(raster_obj))

# Imprime el número de capas (layers)
print(nlayers(raster_obj))

# Hace un plot del raster
plot(raster_obj)

# Ruta al archivo raster
ruta_raster2 <- ("/cloud/project/dem_islas/Dem J Fernandez 2m.tif")
raster_obj2 <- raster(ruta_raster2)
print(crs(raster_obj2))
print(dim(raster_obj2))
print(res(raster_obj2))
print(nlayers(raster_obj2))
plot(raster_obj2)

# Ruta al archivo raster 
ruta_raster3 <- "Santa_Olga.tif"
raster_obj3 <- raster(ruta_raster3)
print(crs(raster_obj3))
print(dim(raster_obj3))
print(res(raster_obj3))
print(nlayers(raster_obj3))
plot(raster_obj3)
plotRGB(raster_obj3, r = "red", g = "green", b = "blue")

