library(sf)
library(terra)
library(terra)
#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.


#En el se pueden instalar paquetes de geodatos espaciales como 'sp', 'sf', 'raster', etc. Con estos se pueden utilizar funciones de analisis espaciales como como cálculos de distancia, intersecciones, operaciones geometricas, etc.
#También podemos impirmir estos  y crear mapas interactivos que nos podrán servir para desarrollar trabajos en sistema de información geográfica.

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#para trabajar con objetos de tipo vectorial se puede trabajar con 'sp' y 'sf', en nuestro caso utilizamos sf al ser más nuevo y dejar un poco "obsoleto"a su predecesor sp

#para trabajar con objetos de tipo raster podemos ocupar "terra"y "raster" , en nuestro caso utilizamos terra 

#3 (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#-points
#-line
#-polygon
#-multipoint
#-multiline
#-multipolygon
#-geometrycollection

#4. (10pts) Describa los objetos de clase sf.

#los objetos de clase sf se utilizan para representar datos geoespaciales vectoriales, donde cada observación puede tener información geométrica asociada a puntos, líneas o polígonos y atributos adicionales almacenados en tablas de datos. Esta es una versión más reciente que tiene la finalidad de superar a su predecesora sp y ser mucho más eficiente. Sus principales componentes son Geometry y attributes.

#3 vectoriales

a= st_point(c(0,0))

b= st_point(c(4,0))

c= st_point(c(6,2*sqrt(3)))

d= st_point(c(4,4*sqrt(3)))

e= st_point(c(0,4*sqrt(3)))

f= st_point(c(-2,2*sqrt(3)))

p= st_point(c(2,2*sqrt(3)))

multip= st_multipoint(c(a,b,c,d,e,f,p))

#4.(10pts) Describa los objetos de clase sf.

inventario_lagos<- read_sf(("D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/Lagos"))



#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

inventario_lagos<- read_sf(("D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/Lagos"))

#a. (5pts) tipo de geometria
#Su geometria es un multipolygon

#b. (5pts) dimensión de los puntos
#Es de dos dimensiones X, Y

#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#datum: WGS 84
#proyectada: si
#huso: 19s
#código EPSG: No tiene


#d. (5pts) cantidad de variables y observaciones
num_variables <- ncol(inventario_lagos)
num_observaciones <- nrow(inventario_lagos)
num_variables
num_observaciones

#tiene 22 variables y 2067 observaciones

#e. (5pts) extensión

extension <- st_bbox(inventario_lagos)
extension
#xmin       ymin       xmax       ymax 
#16712.94 3870127.72  697838.48 8051367.40 


#3. Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?

lagos_stgo<- inventario_lagos[inventario_lagos$PROVINCIA== 'Santiago', ]
lagos_stgo

#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

lagos_stgo4326<- st_transform(lagos_stgo, 4326)
crs(lagos_stgo)


#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo["AREA_KM2"], col = 'red', main = "Variación de Área de Lagos en Santiago")

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

primer_lago <- lagos_stgo[1,0]
primer_lagossmp <- st_simplify(primer_lago, dTolerance = 30)

par(mfrow = c(1, 2))

plot(primer_lago$geometry, main= 'Lago original') 

plot(primer_lagossmp$geometry, main='Lago simplificado')


#4. 4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
indice_calidad_aguas <- read_sf(("D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/Indice_Calidad_de_Aguas"))

#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
romeral_agua<-indice_calidad_aguas[indice_calidad_aguas$NOM_COM=="ROMERAL",]
romeral_agua
#hay solo tres

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
aguaromeral_buf<-st_buffer(romeral_agua,1000)
plot(aguaromeral_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
calidad_5<-aguaromeral_buf[1:5,]

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
agua_romeral_buffer_1000m<- st_write(aguaromeral_buf,'D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/calag_rom_buf.gpkg',append = TRUE) 


#4 Raster

#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

r<- rast(ymax=-70.25000,ymin=-71.66667, xmax = -35.33333,xmin=-37.50000, crs='EPSG:4326', nrow=4,ncol=4)

#2.(15pts) Considere el siguiente raster:

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

raster32719 <- project(r, "EPSG:32719")

#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
raster_pregunta3 <- sqrt(r + 10)
raster_pregunta3

#4.(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

raster32719
raster_pregunta4 <- mask(raster32719, raster32719 >= 46 & raster32719 <= 54, maskvalue = NA)


#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

raster32719

# Calcular el promedio, la mediana y la desviación estándar
promedio <- mean(raster32719, na.rm = TRUE)
mediana <- median(raster32719, na.rm = TRUE)
desviacion_estandar <- sd(raster32719, na.rm = FALSE)



#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
dem_chile <- rast(('D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/dem_chile.tif'))

#(5pts) clase del objeto
class(dem_chile)
#es un spatRaster

#(5pts) número de columnas, filas y capas
dim(dem_chile)
#Tiene 4656 columnas, 1884 filas y 1 capa
#(5pts) resolución espacial
res(dem_chile)
#[1] 0.008333333 0.008333333
#(5pts) sistema de referencia de coordenadas
crs(dem_chile)
#EPSG:4326
#(5pts) el archivo se encuentra almacenado en la memoria o en el disco.
#se encuentra almacenado en disco

#f) (15pts) cuál es la elevación máxima y mínim
xmax(dem_chile)
xmin(dem_chile)
#[1] -66.3
#[1] -82
#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
copiapo <- rast(('D:/Descargas/Datos R prueba 2/data_eva2/data_eva2/imagen_copiapo.tif'))

#(15pts) cree un raster que corresponda a la suma de las cuatro capas.

suma_copiapo <- sum(copiapo)
plot(suma_copiapo)


#(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

copiapo_reproyectado <- project(copiapo, "EPSG:4326")
copiapo_reproyectado


#(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

x<-plotRGB(copiapo_reproyectado, r = 1, g = 2, b = 3, main = "Composición de Color RGB")

#(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif

writeRaster(copiapo_reproyectado[[1]], filename =  "copiapo_capa1.tif", overwrite = TRUE)





