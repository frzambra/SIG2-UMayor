#Pruebas 2
#Alonso Gaete

#2conceptos

#2.1 Describa como puede utilizar el software R como un Sistema de Información Geográfica.

R, a través de paquetes como sp, sf, raster, maptools, entre otros, permite manipular, analizar y visualizar datos geoespaciales. Con estas herramientas, puedes realizar operaciones de lectura, escritura, análisis espacial y visualización, además de integrar datos geográficos con análisis estadísticos y de aprendizaje automático. También es posible conectar R con bases de datos espaciales y construir aplicaciones web interactivas que incluyan mapas y análisis geoespaciales.

#2.2 Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

Datos Geoespaciales Vectoriales: En R, los datos geoespaciales vectoriales se representan mediante objetos de clases como SpatialPoints, SpatialLines, SpatialPolygons (del paquete sp) o sf (Simple Features), que pueden contener información sobre ubicaciones puntuales, líneas o polígonos respectivamente, con atributos asociados a cada geometría

Datos Raster: Para datos geoespaciales tipo raster (cuadriculados), se utilizan objetos de clase RasterLayer, RasterStack, RasterBrick (del paquete raster) o de clase stars (del paquete stars). Estos objetos representan datos distribuidos en una cuadrícula regular, como imágenes satelitales o mapas de cobertura.

#2.3 Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#Los tipos de geometrías que se pueden manejar con el paquete sf incluyen:
  
#Point: Puntos individuales en un espacio geográfico.

#Line: Líneas simples o compuestas que pueden representar carreteras, ríos, límites, entre otros.

#Polygon: Polígonos simples o complejos que representan áreas geográficas como países, regiones, o áreas administrativas.

#Multi-Point: Colecciones de puntos.

#Multi-Line: Colecciones de líneas.

#Multi-Polygon: Colecciones de polígonos.

#Geometry Collection: Colecciones de geometrías diversas (puntos, líneas, polígonos).

#2.4 Describa los objetos de clase sf .

#Los objetos de clase sf en R son estructuras de datos espaciales que utilizan el paquete sf para representar información geoespacial. Aquí hay algunas características clave de los objetos de clase sf:
  
#Geometría y Atributos: Los objetos sf combinan datos geométricos (puntos, líneas, polígonos, etc.) con atributos asociados a esas geometrías. Cada geometría está vinculada a un conjunto de datos que describe esa geometría (como información geográfica, demográfica, etc.).

#Datos Geoespaciales Complejos: Pueden manejar geometrías complejas, incluyendo objetos multipuntos, multilíneas y multipolígonos, así como colecciones de diferentes tipos de geometrías (Geometry Collections).

#Estructura de Datos Data Frame: Los objetos sf tienen una estructura de datos similar a un data frame de R, lo que significa que pueden contener múltiples columnas de atributos y permiten el uso de funciones de manipulación de datos de R.

#Soporte para Proyecciones: Los objetos sf pueden contener información sobre proyecciones cartográficas, lo que permite trabajar con datos en diferentes sistemas de coordenadas y realizar transformaciones según sea necesario.

#3 Vectoriales

install.packages('sf')
library(sf)


#3.1 Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol) 


#3.2 Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#a. (5pts) tipo de geometria
#b. (5pts) dimensión de los puntos
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#d. (5pts) cantidad de variables y observaciones
#e. (5pts) extensión

lagos<-st_read('data_eva2/Lagos')

#A
st_geometry_type(lagos)

#B
dim(lagos)
#tiene 2 dimensiones (x,y)

#C
st_crs(lagos)

#"EPSG",32719,PROYECTADO, datum:WGS 84, Huso:UTM zone 19s

#D
str(lagos)
#2067 obs. of  22 variables:

#E
st_bbox(lagos)

#xmin       ymin       xmax       ymax 
#16712.94 3870127.72  697838.48 8051367.40 

#3.3 Con la capa de Inventario Lagos realice lo siguiente:

#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

#a 
lagos_stgo<-lagos[lagos$PROVINCIA%in%c("Santiago"),]
str(lagos_stgo)


#b
st_crs(lagos_stgo)
lagos_stgo4326<-st_transform(lagos_stgo,4326)
st_crs(lagos_stgo4326)

#c

plot(lagos_stgo$AREA_KM2,col='blue') 

#d

lagos_stgo<-st_transform(lagos_stgo,32719)
st_crs(lagos_stgo)

lago_simplificado<-st_simplify(lagos_stgo[,1],dTolerance =30)

par(mfrow = c(1,2))
plot(lago_simplificado$geometry)
plot(lagos_stgo[,1]$geometry)



#4 Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m


Indice_calidad_de_Aguas<-st_read("data_eva2/Indice_Calidad_de_Aguas")


#a

Indice_Romeral<-Indice_calidad_de_Aguas[Indice_calidad_de_Aguas$NOM_COM %in% c("ROMERAL"),]
Indice_Romeral

str(Indice_Romeral)
# 3 observaciones

#b

calag_rom_buf<-st_buffer(Indice_Romeral,1000)
plot(calag_rom_buf$geometry)

#c

names(calag_rom_buf)[1:5]
# OBJECTID_1    OBJECTID  NOMBRE_APR  NOMBRE_BNA    COD_BNA



#d

st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")


#4 RASTER

install.packages('terra')
library('terra')

#1 Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:

#-Fila 1: 9, 6, 4, 1
#-Fila 2: 10, 25, NA, 2
#-Fila 3: 5, 10, 15, 25
#-Fila 4: 100, 5, 30, 50

r<-rast(xmin=-71.83,xmax=-70.25,
        ymin=-37.5,ymax=-35.33,
        ncol=4, nrow=4,
        crs="EPSG:4326")

values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)

plot(r)
text(r)


#2 Considere el siguiente raster:

r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r2);text(r2)


#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

crs(r2)<-'EPSG:32719'
crs(r2)

#3 Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

# √pixel + 10

r2_raiz<-sqrt(r2+10)
plot(r2_raiz)
text(r2_raiz,digits=2)

#4 Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

r3<-rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r3);text(r3)



l<-r3<46|r3>54
plot(l);text(l)

r3[l]<-NA
plot(r3);text(r3)

#5 Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .

r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r2);text(r2)

global(r2,mean)
global(r2,sd)
global(r2,median)

#media= 42.5, desviacion estanda=23.80476, mediana=42.5

#6 Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
#a. (5pts) clase del objeto
#b. (5pts) número de columnas, filas y capas
#c. (5pts) resolución espacial
#d. (5pts) sistema de referencia de coordenadas
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.

dem_chile<-rast("data_eva2/dem_chile.tif")

#a
class(dem_chile)
#"SpatRaster"

#b
dim(dem_chile)
#4656 1884    1

#c
res(dem_chile)
#0.008333333 0.008333333

#d
cat(crs(dem_chile))

#"EPSG",4326

#e
inMemory(dem_chile)
# se almacena en disco

#7 cuál es la elevación máxima y mínima

extension<-ext(dem_chile)

dem_chilerecorte<-crop(dem_chile,extension)


elevacion_maxima<-max(dem_chilerecorte)
elevacion_minima<-min(dem_chilerecorte)

elevacion_maxima
elevacion_minima

#min=-256, max=6414

#8 . Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando
#las tres primeras capas.
#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif


copiapo<-rast("data_eva2/imagen_copiapo.tif")

#a

capa1<-copiapo[[1]]
capa2<-copiapo[[2]]
capa3<-copiapo[[3]]
capa4<-copiapo[[4]]

sumacapa<-sum(capa1,capa2,capa3,capa4,na.rm=TRUE)



#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(copiapo)<-"EPSG:4326"
crs(copiapo)

#C

plotRGB(copiapo[[1:3]])

#d

capa1_copiapo<-copiapo[[1]]
dim(capa1_copiapo)

writeRaster(capa1_copiapo,'copiapo_capa1.tif')




