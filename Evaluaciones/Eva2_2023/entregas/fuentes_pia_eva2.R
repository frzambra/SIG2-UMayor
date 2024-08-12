##Pia Fuentes.

#PARTE 1: CONCEPTOS 

#1.  (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#Respuesta: Un SIG es un sistema que ayuda a la recolección, mantención, almacenamiento, análisis, salida y distrubución de datos. Con el software R se pude realizar todo esto con sus múltiples funciones, tales como, leer y guardar archivos,  manipular y resumir datos, crear mapas, entre otros. Todas estas funciones pueden ser muy útil, por ejemplo, si se desea saber la distribución de una especie, con el software R se pueden analizar los datos de donde ha sido vista la especie, utilizando las coordenadas, creando un átrea de estudio, etc. con R se pueden analizar datos tanto vectorial como raster (descargando los paquetes sf y terra, respectivamente). Ademas, es útil para el analisis de datos espaciales, de hecho, tiene una clases para datos espaciales. 

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y raster.

#Respuesta: La clase de objetos que se utiliza en R para trabajar con objetos geoespaciale depende de si son datos vectoriales o datos raster. Para datos vectoriales la clase del objeto es {sf} (al trabajar con el paquete que lleva el mismo nombre), no obstante, ha de considerarse que sf puede ser representado por 3 tipos de datos, según la información puede ser clase sf (data.frame con los atributos y geometría), sfc (es la list-column con la geometría de cada entidad) o sfg (geometría indivual de cada simple feature). Mientras que para datos raster es {SpatRaster} (utilizando el paquete "terra").

#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}

#Respuesta: Las geometrías que se pueden trabajar con el paquete sf son: point, linestring, polygon, multipoint, multilinestring y multipolygon.

#4. (10pts) Describa los objetos de clase sf

#Respuesta: sf ("Simple Feature") se utiliza para datos de tipo espacial discreto (datos vectoriales).  Tiene 3 tipos de datos utilizados para representarlos: sf, sfc y sfg. "sf" esta compuesto por el data.frame con los atributos y geometrías de la entidad, este se compone por "sfc" que es una list-column con la geometría de cada entidad. la cual esta conformada por "sfg" que es la geometría individual (tal como punto, polígono, multipunto, etc),

#PARTE 2: VECTORIALES

install.packages('sf')
library(sf)

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F.

c <- rbind(
  c(0,0),
  c(4,0),
  c(6, 2*sqrt(3)),
  c(4, 4*sqrt(3)),
  c(0, 4*sqrt(3)),
  c(-2, 2*sqrt(3)),
  c(0,0)
)
pent <-st_linestring(c)
plot(pent)

#2. . Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente:
#a. (5pts) tipo de geometria
#b. (5pts) dimensión de los puntos
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#d. (5pts) cantidad de variables y observaciones
#e. (5pts) extensión

inv_lago <-st_read("data_eva2/Lagos/Inventario_Lagos.shp")
inv_lago 
class(inv_lago)
st_geometry(inv_lago)
st_crs(inv_lago)
st_crs(inv_lago)$epsg
dim(inv_lago)

#Respuestas
#Tipo de geometría:  MULTIPOLYGON
# Dimensión de los puntos: XY
# SRC: WGS 84, proyectada, huso 19S, códgio epsg 32719
# Cant, de variables y observaciones: 2067 features and 21 fields.
# Extensión: xmin: 16712.94 ymin: 3870128 xmax: 697838.5 ymax: 8051367

#3.  Con la capa de Inventario Lagos realice lo siguiente:
# a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
# b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
# c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
# d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

#a
lagos_santiago <- inv_lago$PROVINCIA == 'Santiago'
lagos_stgo <- inv_lago[lagos_santiago,]
#Son 9 lagos en Santiago.

#debido a la condición, en vez de 

#b 
st_crs(lagos_stgo)
lagos_stgo_4326 <- st_transform(lagos_stgo, 4326)
st_crs(lagos_stgo_4326)

#c
plot(lagos_stgo_4326[,'AREA_KM2'])

#d
primero <- lagos_stgo_4326[1,]
plot(primero[, 'geometry']) #geometría original

primero_sim <- st_simplify(primero, dTolerance = 30)
plot(primero_sim$geometry)

#4.  Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
# a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
# b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
# c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
# d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

agua <- st_read("data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")


#a
r <- agua[agua$NOM_COM == 'ROMERAL', ]
dim(r) #Hay 3

#b
calag_rom_buf <- st_buffer(r, 1000)

#c
colnames(calag_rom_buf) #Los nombres de las 5 primeras variables: "OBJECTID_1" "OBJECTID"   "NOMBRE_APR" "NOMBRE_BNA" "COD_BNA"

#d
write_sf(calag_rom_buf, file.path(dir, 'calidad_agua_romeral_buffer_1000m.gpkg'))
write_sf(calag_rom_buf, 'calidad_agua_romeral_buffer_1000m.gpkg')

#PARTE 3: RASTER
install.packages('terra')
library(terra)

#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

r <- rast(xmin= -71.83333333333333, xmax= -70.25,
          ymin= -35.3333333, ymax= -37.5)

r <- rast(xmin = -71.83333333333333, xmax = -70.25,
          ymin = -37.5,  ymax = -35.3333333,
          ncol=4, nrow=4,
          )
crs(r) #SRC: WGS 84
r
values(r) <- c(
  c( 9, 6, 4, 1),
  c(10, 25, NA, 2),
  c(5, 10, 15, 25),
  c(100, 5, 30, 50)
)
plot(r)
text(r)

#2. (15pts) Considere el siguiente raster: Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#1 opcion (creo que esta mal, comparar con la de abajo)
r_32719 <- project(r, 'EPSG:32719')
crs(r_32719)
plot(r_32719);text(r_32719)
plot(r)
plot(r_32719)
text(r_32719)

#2 opcion
r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:32719")
plot(r2);text(r2)
r3 <- project(r2, 'EPSG:32719')
plot(r3);text(r3)

#3.  (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

#raster huso 19s
r_sum3 <- r2 + 10
plot(r_sum3)
text(r_sum3)
r_raiz3 <- sqrt(r_sum3)
plot(r_raiz3);text(r_raiz3, digits=2)

#raster original
r_sum2 <- r + 10
plot(r_sum2)
text(r_sum2)
r_raiz2 <- sqrt(r_sum2)
plot(r_raiz2);text(r_raiz2)

#raster huso 19s (creo que esta mal)
r_sum <- r_32719 + 10
plot(r_sum)
text(r_sum)
r_raiz <- sqrt(r_sum)

#Otra forma de hacer la misma operación
 l <-sqrt(r3+10)
plot(l); text(l, digits=2)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)


l <- (r<46) | (r>54) #devuelve la respuesta como un logico (TRUE o FALSE)
plot(l)
text(l)

r[l] <- NA 
plot(r)
text(r)

#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

global (r, 'mean')
global (r, 'median')
global(r, 'sd')

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
#a. (5pts) clase del objeto
#b. (5pts) número de columnas, filas y capas
#c. (5pts) resolución espacial
#d. (5pts) sistema de referencia de coordenadas
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.

capa <- rast("data_eva2/dem_chile.tif")

#a
class(capa)
#clase SpatRaster.

#b
dim(capa)

#c
res(capa)

#d
crs(capa)

#e

#e
xmin(capa)
capa
#min value   :        -256 
#max value   :        6414 