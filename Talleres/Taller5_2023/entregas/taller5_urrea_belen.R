#####Talller 5 

install.packages('terra')
library('terra')

# Ejercicio 1 Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

#las unidades
#la resolución espacial
#cantidad de filas y columnas
#el sistema de referencia de coordenadas
r <- rast
r <- rast(xmin = -70.6667, xmax = -69.6667, ymin= -33.5, ymax= -32.5)
      
      class(r)
      res(r) 
      values(r)   #No se le ha asignado valores a los pixeles en este objeto
      crs(r)    

      
# Ejercicio 2 : Cree un objeto llamado r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ (norte a sur) y 32°30’ Sur; y entre las longituded 70°40’ (este) y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.    
#Lo que se hizo fue      
r <- rast(xmin = -70.6667, xmax = -69.6667, ymin= -33.5, ymax= -32.5, nrows = 10, ncols = 5)
r           #Al ver el objeto, se observa que no tenemos defenidas las capas. 
dim(r)      #clase,dimensiones de las filas y columnas, resolucion con respecto a las capas, extension entre x min y max, e ymin y max. Y el SRC.
res(r)      #resolucion de las capas
ncell(r)    #multiplicacion entre filas y colummas. 
ext(r)      #Para saber la extensión de mi objeto  

#agregar valores al raster del 1 al 50 
values(r) <- 1:50
#aqui solo le asigna una paleta de color, no los valores, por esa razon despues se usa la funcion text.....
plot(r)
text(r)


# Ejercicio 3 : Cree un raster que tenga una extensión entre 350.000m (oeste) y 450.000m Este y 6.400.00m (sur) y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.
#FORMA 1 
r2 <- rast(xmin=350000, xmax = 450000, ymin=6400000, ymax=6500000, ncols = 10, nrows=10, crs = "EPSG:32719")
r2

#FORMA 2 #################Revisar 
r2 <- rast(xmin = 350000 , xmax = 450000 , ymin = 6400000 , ymax = 6500000 , ncol = 10 , nrows=10)
crs(r2) <- "EPSG:32719"
r2
 
values(r2) <- 100:1
plot(r2)
text(r2)


# Ejercicio 4 Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.        
#nlyrs es el numero de capas 
r3 <- rast(ncols=3, nrows=3, nlyrs = 3)
r3
values(r3) <- 1:27
text(r3)
plot(r3)

#Otra froma de hacerlo 
r01 <- rast(ncol = 3, nrows = 3)
values(r01) <- 1:9

plot(r01)
text(r01)


r02 <- rast(ncol = 3, nrows = 3)
values(r02) <- 10:18
plot(r02)
text(r02)

r03 <- rast(ncols=3, nrows=3)
values(r03) <- 19:27
plot(r03)
text(r03)


r_f2 <- c(r01,r02,r03)
plot(r_f2)



# Ejercicio 5 Haga la suma de las tres capas de él raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Hagua un plot del raster y muestre los valores en cada celda.
#Suma de las capas spat raster

r_sum1 <- r_f2[[1]]+r_f2[[2]]+r_f2[[3]]
plot(r_sum1)
text(r_sum1)
sum(1:3)



# Ejercicio 6  Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.
objt_nuevo <- sqrt(r_sum1)
plot(objt_nuevo)
text(objt_nuevo, digits =2)   #Aqui se muestra el resultado despues de haberse aplicado la raiz
writeRaster(objt_nuevo,'r_sqrt.tif') #Aqui se quiere guardar el objeto nuevo, en el disco                               #Como sé si el objeto quedó bien guardado?


# Ejercicio 7 De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

#Sistema de Referencia de Coordenadas
#Número de filas y columnas
#Resolución espacial
#Número de capas (layers)
#Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.
#Para este enunciado, se puede hacer de dos formas, utilizando las funciones propias para lo que se pide, por ejemplo para ver la resolucion se utiiliza la funcion res(), y asi sucesivamente. Sin embargo, otra forma de tener todo lo solicitado es con class(), con esta función se logra obtener la gran mayoria de los datos, como filas, columnas, capas, src y la resolucion 
crs()
res()
dim() #numero de filas, columnas y capas

############## Cargar y abrir los archivos Santa Olga 
library(terra)
Sta_Olga <- rast("Santa_Olga.tif")

crs(Sta_Olga, describe=TRUE)
res(Sta_Olga)
dim(Sta_Olga)
plot(Sta_Olga)
plotRGB(Sta_Olga)

########## Cargar y abrir Capa isla j.fernandez 
Juan_Fer <- rast("Dem J Fernandez  2m.tif")

crs(Juan_Fer, describe = TRUE)
res(Juan_Fer)
dim(Juan_Fer)
plot(Juan_Fer)

########## Cargar archivos de la capa Isla de Pascua 
i_pascua <- rast("Dem Isla de pascua 4m.tif")

crs(i_pascua,describe=TRUE)
res(i_pascua)
dim(i_pascua)
plot(i_pascua)
