                          #TALLER 5 

# instalar paquete {terra}
install.packages('terra')

# cargar {terra} 
library(terra)



#1.- (30pts) Cree un objeto llamdo r de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. Indique:

            #las unidades
            #la resolución espacial
            #cantidad de filas y columnas
            #el sistema de referencia de coordenadas

#Observacion: Las coordenadas se encuentran en el cuadrante Oeste y Sur. Por lo tanto, los valores son todos negativos

#NOTA: se deben transformar las coordenadas de unidad GMS a GD. El calculo fue realizado en internet

#Observación:
#x mínimo es la latitud más lejana del ecuador = -33°30’
#x máximo es la latitud más cercana del ecuador = -32°30’
#y mínimo es la longitud más lejana del meridiano de Greenwich = -70°40’
#y máximo es la longitud más cercana del meridiano de Greenwih = -69°40

#Crear objeto de clase spatRaster
(r <- rast(xmin = -70.6667, xmax = -69.6667,
          ymin = -33.5,  ymax = -32.5 ))

#Observacion: Las dimensiones de los pixeles son entregados por defecto


#RESPUESTAS:
            #Las unidades de medida son Grados Decimales (GD en adelante)
            res(r) #la resolución de cada pixel es 0.002777778, 0.005555556, medido en GD
            dim(r) #Presenta 180 filas y 360 columnas
            crs(r,describe=TRUE) #El sistema de referencia de coordenadas no está correctamente definido.
            
            


#2.- (30pts) Cree un objeto llamdo r2 de tipo spatRaster que tenga una extensión entre las latitudes 33°30’ y 32°30’ Sur; y entre las longituded 70°40’ y 69°40 Oeste. El raster debe tener 10 filas y 5 columnas; y debe tener como valores en las celdas los números del 1 al 50.

#Crear objeto spatRaster
(r2 <- rast(xmin = -70.6667, xmax = -69.6667,
               ymin = -33.5,  ymax = -32.5,
               nrows=10,ncols=5))

#Verificar el número de filas y columnas
dim(r2) #10 filas y 5 columnas

#Asignar valores del 1 al 50
values(r2) <- 1:50

#Graficar para mostrar r2 con sus respectivos valores
plot(r2);text(r2)




#3.- (30pts) Cree un raster que tenga una extensión entre 350.000m y 450.000m Este y 6.400.00m y 6.500.000m Norte (UTM EPSG:32719). Que tenga 10 filas y 10 columnas. Agregue los valores a cada celda del 100 al 1. Haga un plot del raster y muestre los valores en la celdas.

#Observación:
#x mínimo es el valor menor en Este = 350000
#x máximo es el valor mayor en Este = 450000
#y mínimo es el valor menor en Norte = 6400000
#y máximo es el valor mayor en Norte = 6500000

#Crear objeto spatRaster
(r3 <- rast(xmin=350000,xmax=450000,ymin=6400000,ymax=6500000,
          ncols=10,nrows=10,crs="EPSG:32719"))

#Otra forma
#crs(r) <- "EPSG:32719"

#Asignar valores de 100 a 1 al objeto r3
values(r3) <- 100:1

#Graficar objeto y mostrar sus valores
plot(r3);text(r3)




#4.- (30pts) Cree un raster de tres capas, que tenga 3 filas y 3 columnas. Los pixeles de la primera capa debe tener los valores 1 a 9, de la segunda de 10 a 18 y la tercera de 19 a 27.

#Forma 1

#Crear objeto spatRaster de 3 filas, 3 columnas y 3 capas
r4 <- rast(ncols=3,nrows=3,nlyr=3)

#Asignar valores de 1 a 27, que se reparten en cada capa de la forma deseada
values(r4) <- 1:27

#Graficar objeto r4 
plot(r4)

#Para graficar por capa:
plot(r4[[1]]);text(r4[[1]])
plot(r4[[2]]);text(r4[[2]])
plot(r4[[3]]);text(r4[[3]])


#Forma 2

ere1 <- rast(ncols=3,nrows=3)
values(ere1) <- 1:9

ere2 <- rast(ncols=3,nrows=3)
values(ere2) <- 10:18

ere3 <- rast(ncols=3,nrows=3)
values(ere3) <- 19:27

erre <- c(ere1,ere2,ere3)
plot(erre) #Es el mismo resultado que en la Forma 1




#5.- (20pts) Haga la suma de las tres capas de el raster de la pregunta anterior. Guarde el resultado en un nuevo raster. Haga un plot del raster y muestre los valores en cada celda.

#Sumar cada capa del objeto r4
r4_suma <- r4[[1]]+r4[[2]]+r4[[3]]

#Graficar y mostrar los valores de cada pixel
plot(r4_suma);text(r4_suma)


#Observación: Las mismas operaciones con vectores pueden usarse en raster




#6.- (30pts) Para el raster de la pregunta anterior aplique a cada celda la raiz cuadrada (sqrt) y guarde el raster en un objeto nuevo. Guarde el objeto raster en disco con el nombre r_sqrt.tif.

#Crear objeto spatRaster a partir de la raiz cuadrada de los valores del objeto r4_suma
obj <- sqrt(r4_suma)

#Graficar
plot(obj);text(obj,digits=2)

#Guardar objeto en el directorio con el nombre "r_sqrt.tif"
writeRaster(obj,"r_sqrt.tif")




#7.- (75) De los archivos raster que descargó en la sección data. Indique para cada uno de los archivos raster lo siguiente:

# Sistema de Referencia de Coordenadas
# Número de filas y columnas
# Resolución espacial
# Número de capas (layers)
# Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.


#Cargar archivo "Santa_Olga.tif"
olga <- rast("data/Santa_Olga.tif")

#Sistema de Referencia de Coordenadas (SRC en adelante)
crs(olga,describe=TRUE)
#el SRC es UTM zona 18S, a partir del datum WGS 84, cuyo código EPSG es 32718

# Número de filas y columnas
dim(olga)
#Presenta 3812 filas con 4989 columnas

# Resolución espacial
res(olga)
#La resolución de cada pixel es de 0.4328 x 0.4328, medido en metros

# Número de capas (layers)
nlyr(olga)
#Presenta 3 capas

#NOTA: los gráficos se realizan al final de este ejercicio, todos a la vez


#Cargar archivo "Dem Isla de pascua 4m.tif"
pascua <- rast("data/dem_islas/Dem Isla de pascua 4m.tif")

#Sistema de Referencia de Coordenadas
crs(pascua,describe=TRUE)
#el SRC es UTM zona 12S, a partir del datum WGS 84, cuyo código EPSG es 32712

# Número de filas y columnas
dim(pascua)
#Presenta 3938 filas con 5542 columnas

# Resolución espacial
res(pascua)
#La resolución de cada pixel es de 4 x 4, medido en metros

# Número de capas (layers)
nlyr(pascua)
#Presenta 1 capa


#Cargar archivo #Cargar archivo Dem J Fernandez  2m.tif
fernan <- rast("data/dem_islas/Dem J Fernandez  2m.tif")

#Sistema de Referencia de Coordenadas
crs(fernan,describe=TRUE)
#el SRC es UTM zona 17S, a partir del datum WGS 84, cuyo código EPSG es 32717

# Número de filas y columnas
dim(fernan)
#Presenta 4298 filas con 8263 columnas

# Resolución espacial
res(fernan)
#La resolución de cada pixel es de 2 x 2, medido en metros

# Número de capas (layers)
nlyr(fernan)
#Presenta 1 capa


# Haga un plot de cada raster. En el caso del raster de Santa Olga, utilice la función plot y plotRGB.
plot(olga)
plotRGB(olga)

plot(pascua)

plot(fernan)

