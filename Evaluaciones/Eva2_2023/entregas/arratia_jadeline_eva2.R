# Integrante. Jadeline Arratia 
# Fecha: 17 de noviembre 2023
# Prueba 2

######### Parte 1 Datos
# se deben descargar 

######### Parte 2 Conceptos 

# 1 (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

# Se puede utilizar el software R como SIG mediante datos espaciales, se puede realizar análisis espaciales, crear mapas y visualizaciones con características específicas de estos paquetes. Además, la integración con otros paquetes estadísticos de R permite un enfoque holístico para el análisis de datos geoespaciales.
# Ademas, R puede funcionar como SIG (Sistema de Información geográfica) mediante paquetes como “sf” y “raster”.
# sf: Proporciona herramientas para realizar operaciones espaciales, trabajar con SRC (sistema de referencia de coordenadas) y visualizar mapas. 
# Los raster es una representación gráfica digital que se utiliza para recopilar datos espaciales y visualizar imágenes. Algunos raster incluyen: Resolución, formatos de archivo, análisis espacial, entre otros.


# 2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

# Continuando con la pregunta anterior, ya se conoce que R ocupa paquetes “sf” y “raster”, y se describió de manera breve cada uno de estos paquetes.
#Sf: Este se utiliza para representar datos espaciales de tipo “simple Feature” (característica simple) los cuales corresponden a datos vectoriales, estos pueden tomar forma de puntos, polígonos y líneas, además cada una de estas geometrías individuales corresponde a un objeto tipo “sfg”.
#Raster: Su resolución está determinada por el número de píxeles por unidad de área. Cuanto mayor sea la resolución, más detalles se podrán mostrar en la imagen. Se pueden guardar en varios formatos de archivo como JPEG, PNG, TIFF, etc. dependiendo de la naturaleza y el propósito de la imagen. Algunos raster incluyen: 
#Análisis espacial:  Se pueden analizar para obtener información útil como  clasificación de la cobertura del suelo, cálculos de pendientes y detección de objetos.
#Manipulación:  se puede  utilizar software de edición de imágenes para cambiar el color, el tamaño, la forma y otras funciones. 
# Ambos tipos de objetos proporcionan funcionalidades específicas para el análisis espacial y la visualización en R.

# 3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .   

# Respuesta: Se puede trabajar en el paquete Sf: con Point, Multipolygon, Linestring, Polygon, Geometry Collection, Multipoint y Multilinestring 

# 4. (10pts) Describa los objetos de clase sf.

#Considerando la pregunta 1 y 2, ya se dio información respecto a los objetos de clase “sf”, en esta respuesta se va a complementar de manera más profunda el tipo de objeto Sf, está compuesto principalmente por dos partes: 
#Sfc: Corresponde a “list - column” el cual almacena las geometrías espaciales.
#Data.frame: Almacenan los atributos no espaciales asociados con las geometrías, además posee información de atributos vectoriales (T° promedio, la población de una ciudad, etc.) 



#instalar y cargar apquetes anetes de todo
install.packages("sf")
library(sf)
install.packages("terra")
library(terra)
install.packages("tibble")

######## Parte 3 Vectoriales 
# 1 (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
  
df <- data.frame(
  latitud = c(0,4,6,4,0,-2),
  longitud = c(0,0,3.464,6.928,6.928,3.464)
)


pol <- as.matrix(df)
po <- st_polygon(
  list(
    rbind(pol,pol[1,]))
)
po
plot(po)

# 2 Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
  
# a. (5pts) tipo de geometria
# b. (5pts) dimensión de los puntos
# c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso sicorresponde y código EPSG)
# d. (5pts) cantidad de variables y observaciones
# e. (5pts) extensión 

# instala {sf} 

install.packages("sf")
library(sf)
install.packages("tibble")
library("tibble")
install.packages("terra")
library("terra")


getwd()
inn <- read_sf("data_eva2/Lagos/Inventario_Lagos.shp")

#tipo de geometria
inn$geometry
st_geometry(inn)

#dimension de los puntos 
st_dimension(inn)

#src (datum, proyectada o no proyectada, huso si corresponde y código EPSG)

#WGS 84 / UTM zone 19S

#datum, huso y codigo epsg
st_crs(inn)

#codigo epsg de manera más rápida 
st_crs(inn$epsg)
       

#cantidad de variables y observaciones 

#observaciones 
nrow(inn)

#variables
ncol(inn)

#extension 

#xmin: 16712.94 ymin: 3870128 xmax: 697838.5 ymax: 8051367


                  
# 3. Con la capa de Inventario Lagos realice lo siguiente:


# a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?

inn
lagos_stgo <- inn[inn$PROVINCIA== "Santiago", ]
lagos_stgo
#   Son 34

# b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo aSRC EPSG 4326 y reemplázelo.

inventario <- st_transform(inn, crs = "EPSG:4326")
crs(inventario, describe=TRUE)


# c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variableárea (AREA_KM2)

plot(inn$AREA_KM2, col="blue")
?plot

# d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerandouna tolerancia de 30m. Haga un plot de la geometría original y simplificada.

l1 <- lagos_stgo[1,]
l1
l1s <-st_simplify(l1,dTolerance = 50)
plot(l1$geometry)
plot(l1s$geometry)

# 4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

# a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
la <- st_read("data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")
romeral <- la[la$NOM_COM == "ROMERAL",]
romeral
ext(romeral)
# En la comuna Romeral habran 3 puntos

# b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .

calag_rom_buf <-st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

# c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .

# 1OBJECTID_1
# 2OBJECTID
# 3NOMBRE_APR
# 4NOMBRE_BNA
# 5COD_BNA

# d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombrecalidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,"calidad_agua_romeral_buffer_1000m.gpkg",append=TRUE)

####### 4 Raster 

# 1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
# - Fila 1: 9, 6, 4, 1
# - Fila 2: 10, 25, NA, 2
# - Fila 3: 5, 10, 15, 25
# - Fila 4: 100, 5, 30, 50

rr <-rast(ymax=-70.250,ymin=-71.833,xmax=-35.333,xmin= -37.500,ncols=4,nrows=4,nlyr=4)

#2. (15pts) Considere el siguiente raster:

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

# Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

r <- project(r,"EPSG:32719")
crs(r,describe=TRUE)


# 3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

o<-r+10
values(o)
x<-sqrt(o)
values(x)

# 4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA 

nu <-r
nu[nu<46|nu>54]<-NA
plot(nu)
text(nu,digits=2)
# 5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .

summary(r)

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:




#a. (5pts) clase del objeto
#b. (5pts) número de columnas, filas y capas
#c. (5pts) resolución espacial
#d. (5pts) sistema de referencia de coordenadas
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco
# e. (15pts) cuál es la elevación máxima y mínima

i<- rast("data_eva2/dem_chile.tif")
i
# a. (5pts) clase del objeto
class(i)
#b. (5pts) número de columnas, filas y capas
ncol(i)
nrow(i)
nlyr(i)
#c. (5pts) resolución espacial
res(i)
#d. (5pts) sistema de referencia de coordenadas
crs(i,describe=TRUE)
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
i
# ESTA ALMACENADO EN DISCO
#e. (15pts) cuál es la elevación máxima y mínima
plot(i)
minmax(i)

# 7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:



copiapo <- rast("data_eva2/imagen_copiapo.tif")
copiapo

plot(copiapo)


# a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.

capa1 <- copiapo[[1]]
capa2 <- copiapo [[2]]
capa3 <- copiapo[[3]]
capa4 <- copiapo [[4]]

copiapo2 <- capa1+capa2+capa3+capa4
copiapo2
plot(copp)

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

u <- project(copiapo, "EPSG:4326")
u


#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

c1 <- copiapo[[1]]
c2 <- copiapo[[2]]
c3 <- copiapo[[3]]

rgb <- c1+c2+c3
rgb
plotRGB(copp)

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

#/ eval: false
writeRaster(c1,"copiapo_capa1.tif") 



