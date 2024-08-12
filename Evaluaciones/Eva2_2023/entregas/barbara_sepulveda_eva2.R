#barbara sepulveda
#evaluacion 2
#17 de noviembre

#CONCEPTOS

#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica
#R puede funcionar como un Sistema de Información Geográfica (SIG) mediante paquetes como 'sf' y 'raster',se puede importar datos espaciales,crear mapas y visualizaciones con funciones específicas de estos paquetes. Además, la integración con otros paquetes estadísticos en R permite un enfoque completo para el análisis de datos geoespaciales.

#2.10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespacialesde tipo vectoriales y rasters.
#En R, para trabajar con datos geoespaciales vectoriales, se utilizan objetos de clase 'sf' (simple features). Estos objetos contienen información espacial, como puntos, líneas o polígonos, junto con atributos asociados. Para datos raster, se emplean objetos de clase 'Raster' del paquete 'raster', que representan conjuntos de datos en cuadrículas, como imágenes satelitales o mapas de temperatura. Ambos tipos de objetos proporcionan funcionalidades específicas para el análisis espacial y la visualización en R.

#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}
#multipoint,point,linestring,multipolygon,geometry collection,polygon,multilinestring

#4. (10pts) Describa los objetos de clase sf
#el tipo de clase sf se utiliza para representar en R los datos geoespaciales de tipo simple feature,los cuales son datos vectoriales,compuestos por data frame y sf,cada geometria individual corresponde a un objeto sfg. Puedes realizar operaciones espaciales, como unión y corte, y también generar visualizaciones cartográficas. La clase 'sf' ha simplificado la manipulación de datos espaciales en R, proporcionando una estructura coherente y herramientas eficientes para el análisis geoespacial.


#VECTORIALES

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F
#A(0,0),B(4,0),C(6,2RAIZ 3),D(4,4RAIZ 3),E(0,4RAIZ 3),F(-2,2RAIZ 3)
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



#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#a. (5pts) tipo de geometria. 
#b. (5pts)dimensión de los puntos.
#c. (10pts)sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso sicorresponde y código EPSG)
#d. (5pts) cantidad de variables y observaciones
#e. (5pts) extensión

install.packages("sf")
library(sf)
install.packages("tibble")
getwd

inventario_lagos <- read_sf("Lagos/Inventario_Lagos.shp")


#a
inventario_lagos$geometry
st_geometry(inventario_lagos)

#b
inventario_lagos

#c
st_crs(inventario_lagos)
st_crs(inventario_lagos)$epsg
#d
ncol(inventario_lagos)- 1
nrow(inventario_lagos)
#e
#xmin: 16712.94 ymin: 3870128 xmax: 697838.5 ymax: 8051367

#3.Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a unobjeto lagos_stgo . ¿Cuántos son?
#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo aSRC EPSG 4326 y reemplázelo.
#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variableárea (AREA_KM2)
#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerandouna tolerancia de 30m. Haga un plot de la geometría original y simplificada

#a
inventario_lagos$PROVINCIA
lagos_stgo <- inventario_lagos[inventario_lagos$PROVINCIA == "Santiago", ]
length(lagos_stgo)
lagos_stgo

#b

lagos_stgo <- st_transform(lagos_stgo,4326)
st_crs(lagos_stgo)

#c
plot(lagos_stgo)

#d
prlago <- lagos_stgo[1, ]
plot(prlago)

simpprlago <- st_simplify(prlago, dTolerance = 30)


#dos paneles
par(mfrow = c(1, 2))

plot(prlago, main = "Geometría Original")
plot(simpprlago, main = "Geometría Simplificada")


#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .
#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

install.packages("sf")
library(sf)
install.packages("tibble")
getwd

aguas <- read_sf("Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")
aguas
#a
romeral <- aguas[aguas$NOM_COM == "ROMERAL",]
romeral
ext(romeral)
#b
calag_rom_buf <-st_buffer(rom,1000)
plot(calag_rom_buf$geometry)

#c
#d
st_write(calag_rom_buf,"calidad_agua_romeral_buffer_1000m.gpkg",append=TRUE)

#RASTER
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe sercoordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientesvalores:

#- Fila 1: 9, 6, 4, 1- Fila 2: 10, 25, NA, 2- Fila 3: 5, 10, 15, 25- Fila 4: 100, 5, 30, 502
f1 <- c(9,6,4,1)
f2<- c(10, 25, 1, 2)
f3 <- c(5, 10, 15, 25)
f4<- c(100, 5, 30, 50)
r1 <- rast(ymax=-70.250,ymin=-71.833,xmax=-35.333,xmin= -37.500,ncols=4,nrows=4,nlyr=4)

#2 (15pts) Considere el siguiente rasteR
install.packages("terra")
library(terra)

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
r <- project(r,"EPSG:32719")
crs(r,describe=TRUE)


#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)
sqrtpixel + 10
rr <- r+10


#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .
r


# 5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.


summary(r)


#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

getwd()
x <- rast("dem_chile.tif")
x
# a. (5pts) clase del objeto
class(x)
#b. (5pts) número de columnas, filas y capas
ncol(x)
nrow(x)
nlyr(x)
#c. (5pts) resolución espacial
res(x)
#d. (5pts) sistema de referencia de coordenadas
crs(x,describe=TRUE)
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
inMemory(x) #no esta en memoria,esta en DISCO
#f. (15pts) cuál es la elevación máxima y mínima
plot(x)
minmax(x)
#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
getwd()

copiapo <- rast("imagen_copiapo.tif")
copiapo
plot(copiapo)

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
cap1 <- copiapo[[1]]
cap2 <- copiapo[[2]]
cap3 <- copiapo[[3]]
cap4 <- copiapo[[4]]


cop <- cap1+cap2+cap3+cap4
cop
plot(cop)


#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.


w <- project(cop, "EPSG:4326")
w
#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizandolas tres primeras capas.
ploot <-copiapo[[1:3]]
plotRGB(ploot)

10#15d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif
primeracapa <- copiapo[[1]]
writeRaster(primeracapa,"copiapo_capa1.tif")



