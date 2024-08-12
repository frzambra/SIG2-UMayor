#Prueba 2 Carlo Muñoz Morán

#(2. Conceptos)

#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#R cuenta con varias librerías especializadas en manejo y análisis de datos geoespaciales, convirtiéndolo en un Sistema de Información Geográfica (SIG) poderoso, R ofrece una amplia gama de funcionalidades para leer, escribir, visualizar y analizar datos geoespaciales.
#sf y sp: Son paquetes centrales para el manejo de datos geoespaciales. Ofrecen clases y métodos para manejar datos geoespaciales, realizar operaciones espaciales, y trabajar con geometrías.
#raster: Utilizado para el manejo de datos rasterizados, tales como imágenes satelitales, modelados de superficie, entre otros. Permite operaciones complejas en datos raster.


#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#En R, se utilizan diferentes clases de objetos para trabajar con datos geoespaciales vectoriales y raster:
#Objetos geoespaciales vectoriales:
#sf (Simple Features): Es la clase principal para representar datos geoespaciales vectoriales en R. Permite manejar datos de tipo vectorial, como puntos, líneas y polígonos. 
#Objetos geoespaciales raster:
#raster: Es la clase principal para representar datos geoespaciales rasterizados en R. Permite manejar datos en formato de cuadrícula, como imágenes satelitales, modelos de elevación digital 


#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.
#Tipos de geometria que presenta el paquete sf.
#Puntos: Representa un conjunto de coordenadas (x, y) en un espacio bidimensional.
#Líneas: Conjunto de puntos conectados que forman una línea o un camino.
#Polígonos: Regiones cerradas definidas por una secuencia de puntos conectados.
#Multipuntos: Conjunto de puntos independientes.
#Multilíneas: Conjunto de líneas independientes.
#Multipolígonos: Conjunto de polígonos independientes o regiones con múltiples partes.
#Colecciones: Agrupación de geometrías de diferentes tipos en una sola entidad.



#4. (10pts) Describa los objetos de clase sf.
#Tenemos 5 tipo de objetos de clase sf 
#1.Simplificacion de geometria tipo linea: que se usa generalmente para mapas de menor escala 
#  simplificacion de geometria tipo poligono: tambien se utiliza para mapas de menor escala.
#2.Centroides esta opcion nos ayuda a identificar el centro de los objetos geograficos con la funcion de                     st_centroid 
#3. Buffers: estos son polígonos que representan el área dentro de una distancia determinada de una entidad geométrica osea zona de influencias. 
#4. recortar clippin: es un recorte espacial para la creación de subconjuntos espaciales que implica cambios en las columnas de geometría
#5.Union (clipping) que ayuda a unir geometrias 

#(3. Vectoriales)
install.packages('sf')
library(sf)
#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
#A=(0,0)
#B=(4,0)
#C=(6,2√3)
#D=(4,4√3)
#E=(0,4√3)
#F=(-2,2√3)


df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol)                  

#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

lagos <- st_read('data_eva2/Lagos')

#a. (5pts) tipo de geometria

st_geometry_type(lagos)

#b. (5pts) dimensión de los puntos

dim(lagos)
#x=2067
#y=22

#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso sicorresponde y código EPSG)

st_crs(lagos)

#"EPSG",32719,datum:WGS 84, huso: UTM zone 19S, proyectada

#d. (5pts) cantidad de variables y observaciones

str(lagos) #2067 obs y 22 variables

#e. (5pts) extensión

st_bbox(lagos) #      xmin       ymin       xmax       ymax 
#                    16712.94 3870127.72  697838.48 8051367.40 


#3. Con la capa de Inventario Lagos realice lo siguiente:

#a.(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a unobjeto lagos_stgo . ¿Cuántos son? #SON 9 LAGOS
class(lagos)

lagos_stgo <- lagos[lagos$PROVINCIA %in% c('Santiago'),]
lagos_stgo
str(lagos_stgo)

#b.(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo aSRC EPSG 4326 y reemplázelo.
st_crs(lagos_stgo)

lagos4326 <- st_transform(lagos_stgo,4326)
st_crs(lagos4326)

#c.(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variableárea (AREA_KM2)

plot(lagos_stgo$AREA_KM2,col ='green', add = TRUE)


#d.(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerandouna tolerancia de 30m. Haga un plot de la geometría original y simplificada}

lagos_stgo<-st_transform(lagos_stgo,32719)
st_crs(lagos_stgo)

simp<-st_simplify(lagos_stgo[,1],dTolerance =30)

par(mfrow = c(1,2))
plot(simp$geometry)
plot(lagos_stgo[,1]$geometry)

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

ica <- st_read("data_eva2/Indice_Calidad_de_Aguas")
ica

#a.(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

romeral <- ica[ica$NOM_COM %in% c("ROMERAL"),]
romeral
str(romeral)
#3 obs

#b.(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .

calag_rom_buf <- st_buffer(romeral,1000)
calag_rom_buf
plot(calag_rom_buf$geometry)

#c.(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .

names(calag_rom_buf)[1:5]


#d.(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombrecalidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")

#(4.Raster)
#4.1. 
#(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste.

#El sistema de referencia de coordenadas debe sercoordenadas geográficas y datum WGS84. 

#En cada fila el raster debe tener los siguientesvalores:

#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

install.packages('terra')
library(terra)

r <- rast(ymax=-35.333333,ymin=-37.5, xmax =-70.25,xmin=-71.833333,ncol=4,nrow=4,crs="EPSG:4326")
r 
values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)
plot(r)
text(r)

#4.2. 
#(15pts) Considere el siguiente raster

r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

plot(r2);text(r2)
crs(r2)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84

crs(r2) <- "EPSG:32719"
crs(r2)
cat(crs(r2))

#4.3. 
#(20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen10 y se calcule la raiz cuadrada a cada pixel.

nuevox <- sqrt(r2+10)
nuevox
plot(nuevox)
text(nuevox,digits=2)

#4.4 
#(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se lecambie los valores que son menores que 46 y mayores que 54, por el valor NA 

nuevox2 <- r2
nuevox2[nuevor2 < 46 | nuevox2 > 54] <- NA
plot(nuevox2)

#4.5. 
#(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster dela pregunta 2. Utilice una función de {terra} 

?global
#forma1
op <- global(r2, c("sum", "mean", "sd"), na.rm=TRUE) 
op
#forma2
op2 <- summary(r2, na.rm = TRUE)
op2
#      sum    mean       sd
#lyr. 1 680   42.5  23.80476

#4.6.
#Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile <- rast("data_eva2/dem_chile.tif")
dem_chile

#a. (5pts) clase del objeto

class(dem_chile)

#b. (5pts) número de columnas, filas y capas

#                   4656        1884    1
dim(dem_chile)

#c. (5pts) resolución espacial

#0.008333333 0.008333333
res(dem_chile)

#d. (5pts) sistema de referencia de coordenadas

# ID["EPSG",4326]]
cat(crs(dem_chile))

#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco

inMemory(dem_chile)
#EN EL DISCO

#f. (15pts) cuál es la elevación máxima y mínima

elevacion <- range(values(dem_chile), na.rm = TRUE)
print(paste("Elevación Máxima:", max(elevacion))) #6414
print(paste("Elevación Mínima:", min(elevacion))) #-256


#4.7. 
#Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente

imagen_copiapo <- rast("data_eva2/imagen_copiapo.tif")
dim(imagen_copiapo)

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.

sumac <- sum(imagen_copiapo,na.rm=TRUE)
sumac

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(imagen_copiapo) <-  "EPSG:4326"
cat(crs(imagen_copiapo))

#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizandolas tres primeras capas.

plotRGB(imagen_copiapo[[1:3]])


#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

capa1_copiapo<-imagen_copiapo[[1]]
dim(capa1_copiapo)

writeRaster(capa1_copiapo,'copiapo_capa1.tif')
