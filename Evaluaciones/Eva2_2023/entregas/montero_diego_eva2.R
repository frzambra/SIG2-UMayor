#prueba2
#Diego Montero

#CONCEPTOS

#1 Describa como puede utilizar el software R como un Sistema de InformaciónGeográfica
#existen complementos que permiten la manipulación, análisis y visualización de datos geoespaciales
#algunas caracteristicas de R aplicado a los sig son:
#clases para datos espaciales, lectura y escritura de datos espaciales, analisis de patrones de puntos, geoestadistica, regresion espacial, analisis ecologico, teledeteccion y lidar


#2 Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales
#de tipo vectoriales y rasters.
# En R hay varios paquetes que permiten trabajar con objetos geoesapciales, tanto de tipo vectorial como raster
#algunos son: sf, (simple features), 'raster', 'sp'(spatial)

#3 Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}
#pueden contener información geométrica (puntos, líneas, polígonos) y atributos asociados
#'pont', 'linestring', 'polygon'

#4 Describa los objetos de clase sf
#utiliza datos espaciales vectoriales
#representa los objetos geográficos como objetos nativos de R utilizando estructuras de datos simples (listas, matrices, vectores)
#st_read() para leer datos espaciales, st_write() para escribir datos espaciales


#VECTORIALES

#1 Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

# install.packages("sf")
library(sf)
sqrt (3)
sqrt(2)
# Define las coordenadas de los puntos A, B, C, D, E y F
A <- c(0, 0)
B <- c(4, 0)
C <- c(6, 2 * 1.732051) 
D <- c(4, 4 * 1.732051)
E <- c(0, 4 * 1.732051)
F <- c(-2, 2 * 1.414214)

pentagon_coords <- rbind(A, B, C, D, E, F, A)
pentagon_sf <- st_polygon(list(pentagon_coords))
pentagon_sf <- st_sfc(pentagon_sf)
pentagon_sf <- st_sf(geometry = pentagon_sf)

plot(pentagon_sf, main = "Pentágono")


#2 Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
shapefile <- "inventario_Lagos.shp"
capa_vectorial <- st_read(shapefile)
plot(capa_vectorial, main = "Capa Vectorial")
#a. (5pts) tipo de geometria
dim (capa_vectorial)

#b. (5pts) dimensión de los puntos
st_geometry(capa_vectorial)
st_dimension(capa_vectorial)
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(capa_vectorial)
st_crs(capa_vectorial=TRUE)
#d. (5pts) cantidad de variables y observaciones
dim(capa_vectorial)
#e. (5pts) extensión
st_bbox(capa_vectorial)

#3 Con la capa de Inventario Lagos realice lo siguiente:
capa_vectorial

#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un
#objeto lagos_stgo . ¿Cuántos son?

provincia_santiago <-"santiago"
subset(capa_vectorial,provincia_santiago ==PROVINCIA)
cat('a.cantidad de lagos en la prov de santiago:',nrow(capa_vectorial),'\n')

# b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a
#SRC EPSG 4326 y reemplázelo.

st_transform(capa_vectorial,crs = 4326)

#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable
#área (AREA_KM2)
plot(capa_vectorial['AREA_KM2'],main ='variacion de la variable area'col = capa_vectorial$AREA_KM2)

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando
#una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

primer_lago <- capa_vectorial[1,]
simplificado_lago <- st_simplify(primer_lago,dTolerance = 30)

par(mfrow = c(1,2))
plot(primer_lago,main = 'geometria original',col = 'blue',max.plot = 21)
plot(simplificado_lago, main = 'geometria simplificada', col = 'red')

#4 Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

calidad_aguas<-st_read("data/indice_calidad")


#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
romeral<-calidad_agua[calidad_agua$NOM_COM=="ROMERAL",]

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
calag_rom_buf<-st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .

calidad_5<-calag_rom_buf[1:5,]

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
calidad_agua_romeral_buffer_1000m<- st_write(calag_rom_buf,"data/calag_rom_buf.gpkg",append = TRUE)

#RASTER

#1 Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud
#Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser
#coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes
#valores:


library(raster)

xmin <- -71.833333  # Longitud Oeste
xmax <- -70.25      # Longitud Oeste
ymin <- -37.5       # Latitud Sur
ymax <- -35.333333  # Latitud Sur


nrows <- 4
ncols <- 4

ext <- extent(xmin, xmax, ymin, ymax)

r <- raster(ext, nrows = nrows, ncols = ncols)

valores_filas <- list(c(9, 6, 4, 1),
                      c(10, 25, NA, 2),
                      c(5, 10, 15, 25),
                      c(100, 5, 30, 50))


for (i in 1:nrows) {r[i,] <- valores_filas[[i]]}

projection(r) <- "+proj=longlat +datum=WGS84"

plot(r, main = "Raster con Valores Especificados")

#2 Considere el siguiente raster:

library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)


crs_actual <- crs(r)

crs_nuevo <- "+proj=utm +zone=19 +south +datum=WGS84"

r_proyectado <- project(r, crs_nuevo)

plot(r_proyectado)
text(r_proyectado)

#3 Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen
#10 y se calcule la raiz cuadrada a cada pixel.
      #√pixel + 10

library(terra)

r <- rast(x=matrix(1:16*5, 4, byrow = FALSE), crs="EPSG:4326")
r_nuevo <- sqrt(r + 10)

par(mfrow = c(1, 2))
plot(r, main = "Raster Original")
text(r)

plot(r_nuevo, main = "Nuevo Raster: sqrt(pixel + 10)")
text(r_nuevo)

#4  Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le
#cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

library(terra)

r <- rast(x=matrix(1:16*5, 4, byrow = FALSE), crs="EPSG:4326")

r_nuevo <- ifel((r < 46) | (r > 54), NA, r)

par(mfrow = c(1, 2))
plot(r, main = "Raster Original")
text(r)

plot(r_nuevo, main = "Nuevo Raster (Valores Modificados)")
text(r_nuevo)

#5 Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de
#la pregunta 2. Utilice una función de {terra} .

library(terra)
r <- rast(x=matrix(1:16*5, 4, byrow = FALSE), crs="EPSG:4326")

promedio <- mean(r, na.rm = TRUE)

mediana <- median(r, na.rm = TRUE)

desviacion_estandar <- sd(r, na.rm = TRUE)

cat("Promedio:", promedio, "\n")
cat("Mediana:", mediana, "\n")
cat("Desviación Estándar:", desviacion_estandar, "\n")




#6 Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
library(raster)
dem_chile<-rast("data_eva2/dem_chile.tif")

#a. (5pts) clase del objeto
class(dem_chile)

#b. (5pts) número de columnas, filas y capas
dim(dem_chile)
#c. (5pts) resolución espacial
res(dem_chile)

#d. (5pts) sistema de referencia de coordenadas

crs(dem_chile)
crs(dem_chile,describe=TRUE)
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
#se encuentra almacenado en el disco

#e. (15pts) cuál es la elevación máxima y mínima

elevacion_maxima <- maxValue(dem)
elevacion_minima <- minValue(dem)

cat("Elevación Máxima:", elevacion_maxima, "\n")
cat("Elevación Mínima:", elevacion_minima, "\n")


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
library(raster)
imagen_copiapo <-rast("data_eva2/imagen_copiapo.tif")

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.

library(raster)

r<-rast(nrow=3,ncol=3,nlyr=4)
values(r)<-1:9
r1<-r[[1]]
r2<-r[[2]]
r3<-r[[3]]
r4<-r[[4]]
r_sum1<-r[[1]]+r[[2]]+r[[3]]+r[[4]]

imagen_suma <-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]


#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(imagen_copiapo)
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)


#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando
#las tres primeras capas.
mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)



#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre
#copiapo_capa1.tif

copiapo_capa1.tif
capa1 <- imagen_copiapo[[1]]
writeRaster(capa1,"copiapo_capa1.tif")



