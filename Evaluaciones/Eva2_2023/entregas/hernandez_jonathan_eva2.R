#prueba 2 JONATHAN HERNANDEZ
#CONCEPTOS
#1-Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#R:Puede ser  utilizado como un sig através de instalar paquetes como sp,sf,raster, terra, etc. Estos permiten manipular, vizualizarr y analisar datos geoespaciales.

#2-Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#En los objetos de tipo vectoriales, especificamente es sf, se pueden encontrar los siguientes objetos: puntos, lineas, multipuntos, multilineas, poligono, multipolino, geometrycollection, entre otras. Cabe destacar que estos cuentan con atritubotos asociados a cada geometria. Por el contrario en los objetos de tipo raster, especificamnete en terra, la clase de objetos que se encuentran es Spatraster.

#3- Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .
#Los tipos de geometrías que se pueden manejar con el paquete sf incluyen:
# Puntos 
#Líneas 
#Polígonos
#Colecciones de geometrías

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

puntos_pentagono<-data.frame(
  x=c(0,4,6,4,0,-2),
  y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
puntos_pentagono

puntos_en_conjunto<-as.matrix(puntos)
puntos_en_conjunto

pentagono<-st_polygon(list(
  rbind(puntos_matriz,puntos_matriz[1,])))
pentagono
plot(pentagono)


#2-. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

Lagos<-st_read("data_eva2/Lagos")
#a. (5pts) tipo de geometria
st_geometry_type(Lagos)
#b. (5pts) dimensión de los puntos
#Las dimensiones son XY
dim(Lagos)

#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(Lagos)
#R:/"EPSG",32719,datum:WGS 84, huso: UTM zone 19S, proyectada

#d. (5pts) cantidad de variables y observaciones
str(Lagos)
#R:/2067 obs. Y  22 variables

#e. (5pts) extensión
st_bbox(Lagos)
#xmin       ymin       xmax       ymax 
#16712.94 3870127.72  697838.48 8051367.40 

#3.Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
#R:/son 9 lagos
Lagos_stgo<-Lagos[Lagos$PROVINCIA%in%c("Santiago"),]
str(Lagos_stgo)

#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
Lagos_stgo_4326<-st_transform(Lagos_stgo,4326)
st_crs(Lagos_stgo_4326)

#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(Lagos_stgo$AREA_KM2,col="red")

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

Lagos_stgo_32719<-st_transform(lagos_stgo,32719)
st_crs(Lagos_stgo32719)

Lago_Simplificado<-st_simplify(Lagos_stgo[,1],dTolerance =30)

par(mfrow = c(1,2))
plot(Lago_Simplificado$geometry)
plot(Lagos_stgo[,1]$geometry)

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
Indice_Calidad_Aguas<-st_read("data_eva2/Indice_Calidad_de_Aguas")

#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

Indice_Romeral<-Indice_Calidad_Aguas[Indice_Calidad_Aguas$NOM_COM %in% c("ROMERAL"),]
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

raster_1<-rast(xmin=-71.833,xmax=-70.25,
        ymin=-37.5,ymax=-35.333,
        nrows=4,ncol=4,
        crs="EPSG:4326")

values(raster_1)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)

plot(raster_1)
text(raster_1)

#2. (15pts) Considere el siguiente raster
raster_2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

plot(raster_2);text(raster_2)
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84
crs(raster_2) <- "EPSG:32719"
crs(raster_2)

#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.


raster2_raiz<-sqrt(r2+10)
plot(raster2_raiz)
text(raster2_raiz,digits=2)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

l<-r2<46|r2>54

raster_2[l]<-NA

plot(raster_2)
text(raster_2)

#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .
?global
?mean

raster_2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

plot(raster_2);text(r2)

global(raster_2,mean)
global(raster_2,median)
global(raster_2,sd)


#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

Dem_Chile<-rast("data_eva2/dem_chile.tif")


#a. (5pts) clase del objeto
class(Dem_Chile)

#b. (5pts) número de columnas, filas y capas
dim(Dem_Chile)
#R:/ filas:4656  columnas:1884    capas:1

#c. (5pts) resolución espacial
res(Dem_Chile)

#d. (5pts) sistema de referencia de coordenadas
cat(crs(Dem_Chile))

#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
inMemory(Dem_Chile)
#R:/Esta almacenado en el disco

#f. (15pts) cuál es la elevación máxima y mínima
Elevacion <- range(values(Dem_Chile), na.rm = TRUE)
max(Elevacion)
min(Elevacion)
#R:/La max elevacion es de 6414 y la min es de -256


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
Imagen_Cop-rast("data_eva2/imagen_copiapo.tif")

Imagen_Cop_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(Imagen_Cop)<-"EPSG:4326"
crs(Imagen_Cop)

#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
plotRGB(Imagen_Cop[[1:3]])

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

Capa1_Cop<-Imagen_Cop[[1]]
dim(Capa1_Cop)

writeRaster(Capa1_Cop,'copiapo_capa1.tif')