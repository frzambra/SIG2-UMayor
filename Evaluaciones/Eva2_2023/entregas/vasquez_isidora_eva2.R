#Evualuacion2
#Isidora Vásquez


#CONCEPTOS
#1-Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#R:/El sofware R puede se puede utilizar como un sistema de información geografica através de instalar paquetes como sp,sf,raster, terra, etc. Estos permiten manipular, vizualizarr y analisar datos geoespaciales.

#2-Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#EN los objetos de tipo vectoriales, especificamente es sf, la clase de objetos que se pueden encontrar son: puntos, lineas, multipuntos, multilineas, poligono, multipolino, geometrycollection, entre otras. Cabe destacar que estos cuentan con atritubotos asociados a cada geometria. Por el contrario en los objetos de tipo raster, especificamnete en terra, la clase de objetos que se encuentran es Spatraster.

#3- Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .
#Los tipos de geometrías que se pueden manejar con el paquete sf incluyen:
# Puntos (POINT)
#Líneas (LINESTRING)
#Polígonos (POLYGON)
#Colecciones de geometrías (MULTIPOINT, MULTILINESTRING, MULTIPOLYGON,GEOMETRY COLLECTION)

#4 Describa los objetos de clase sf .
#Point: Puntos individuales en un espacio geográfico.
#Line: Líneas simples o compuestas que pueden representar carreteras, ríos, límites, entre otros.
#Polygon: Polígonos simples o complejos que representan áreas geográficas como países, regiones, o áreas      administrativas.
#Multi-Point: Colecciones de puntos.
#Multi-Line: Colecciones de líneas.
#Multi-Polygon: Colecciones de polígonos.
#Geometry Collection: Colecciones de geometrías diversas (puntos, líneas, polígonos).


#VECTORIALES
#1-Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
install.packages('sf')
library(sf)

puntos<-data.frame(
  x=c(0,4,6,4,0,-2),
  y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
puntos 

puntos_matriz<-as.matrix(puntos)
puntos_matriz

pentagono<-st_polygon(list(
  rbind(puntos_matriz,puntos_matriz[1,])))
pentagono
plot(pentagono)


#2-. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

lagos<-st_read("data_eva2/Lagos")
#a. (5pts) tipo de geometria
st_geometry_type(lagos)
#b. (5pts) dimensión de los puntos
#Las dimensiones son XY
dim(lagos)

#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(lagos)
#R:/"EPSG",32719,datum:WGS 84, huso: UTM zone 19S, proyectada

#d. (5pts) cantidad de variables y observaciones
str(lagos)
#R:/2067 obs. Y  22 variables

#e. (5pts) extensión
st_bbox(lagos)

#xmin       ymin       xmax       ymax 
#16712.94 3870127.72  697838.48 8051367.40 

#3.Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
#R:/son 9 lagos
lagos_stgo<-lagos[lagos$PROVINCIA%in%c("Santiago"),]
str(lagos_stgo)

#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
lagos_stgo<-st_transform(lagos_stgo,4326)
st_crs(lagos_stgo)

#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo$AREA_KM2,col="red")

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

lagos_stgo<-st_transform(lagos_stgo,32719)
st_crs(lagos_stgo)

lago_simplificado<-st_simplify(lagos_stgo[,1],dTolerance =30)

par(mfrow = c(1,2))
plot(lago_simplificado$geometry)
plot(lagos_stgo[,1]$geometry)

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
Indice_calidad_de_Aguas<-st_read("data_eva2/Indice_Calidad_de_Aguas")

#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

Indice_Romeral<-Indice_calidad_de_Aguas[Indice_calidad_de_Aguas$NOM_COM %in% c("ROMERAL"),]
Indice_Romeral

str(Indice_Romeral)
#R:/Hay 3 observaciones

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf

calag_rom_buf<-st_buffer(Indice_Romeral,1000)

plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf
#R:/OBJECTID_1 OBJECTID            NOMBRE_APR                       NOMBRE_BNA    COD_BNA
names(calag_rom_buf)[1:5]

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")

#RASTER
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

install.packages('terra')
library(terra)

r<-rast(xmin=-71.833,xmax=-70.25,
        ymin=-37.5,ymax=-35.333,
        nrows=4,ncol=4,
        crs="EPSG:4326")

values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)

plot(r)
text(r)

#2. (15pts) Considere el siguiente raster
r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

plot(r2);text(r2)
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84
crs(r2) <- "EPSG:32719"
crs(r2)

#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel

r2_raiz<-sqrt(r2+10)
plot(r2_raiz)
text(r2_raiz,digits=2)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

l<-r2<46|r2>54

r2[l]<-NA

plot(r2)
text(r2)

#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .
r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

plot(r2);text(r2)

global(r2,mean)
global(r2,median)
global(r2,sd)
#R:/ El promedio es 42.5, la mediana es 42.5y la desviacion estandar es 23.80476

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile<-rast("data_eva2/dem_chile.tif")


#a. (5pts) clase del objeto
class(dem_chile)

#b. (5pts) número de columnas, filas y capas
dim(dem_chile)
#R:/ filas:4656  columnas:1884    capas:1

#c. (5pts) resolución espacial
res(dem_chile)

#d. (5pts) sistema de referencia de coordenadas
cat(crs(dem_chile))

#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
inMemory(dem_chile)
#R:/Esta almacenado en el disco

#f. (15pts) cuál es la elevación máxima y mínima
elevacion <- range(values(dem_chile), na.rm = TRUE)
max(elevacion)
min(elevacion)
#R:/La max elevacion es de 6414 y la min es de -256


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
imagen_copiapo<-rast("data_eva2/imagen_copiapo.tif")

Capa1<-imagen_copiapo[[1]]
Capa2<-imagen_copiapo[[2]]
Capa3<-imagen_copiapo[[3]]
Capa4<-imagen_copiapo[[4]]

sumas_capas<-sum(Capa1,Capa2,Capa3,Capa4,na.rm =TRUE)

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)

#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
plotRGB(imagen_copiapo[[1:3]])

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

capa1_copiapo<-imagen_copiapo[[1]]
dim(capa1_copiapo)

writeRaster(capa1_copiapo,'copiapo_capa1.tif')
