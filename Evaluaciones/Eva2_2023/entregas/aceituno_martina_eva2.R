#Prueba 2 Martina Aceituno
# Instalar los paquetes necesarios
install.packages(c("tidyverse", "sf", "terra")) #El tidyverse es un conjunto de paquetes en R que contiene ggplot2, ademas hace que sea mas ordenado en la consola


# paquetes necesarios
library(tidyverse)
library(sf)
library(terra)

# CONCEPTOS

# 1.  Describa como puede utilizar el software R como un Sistema de Información Geográfica.

# R es un entorno de programación y software estadístico que también puede utilizarse
# como un Sistema de Información Geográfica (GIS).
# R tiene varios paquetes dedicados al análisis espacial, como sp, sf (simple features),
# raster, y terra para datos raster.
# Estos paquetes permiten la manipulación y análisis de datos espaciales.


# pregunta 2

# En R, para trabajar con datos geoespaciales vectoriales se utilizan
# los objetos de las clases sf (simple features),
# mientras que para los datos raster se utilizan
# objetos de las clases proporcionadas por los paquetes raster y terra,
# como RasterLayer, RasterStack, RasterBrick (en raster) y SpatRaster (en terra).


# pregunta 3

# Con el paquete {sf} se pueden trabajar los
# siguientes tipos de geometrías: punto (POINT),
# línea (LINESTRING), polígono (POLYGON), multi punto (MULTIPOINT),
# multi línea (MULTILINESTRING), multi polígono (MULTIPOLYGON) y
# colección geométrica (GEOMETRYCOLLECTION).

# pregunta 4

# Los objetos de clase sf son data frames que tienen al menos
# una lista-columna de geometrías, donde cada geometría
# contiene una o más de las geometrías simples mencionadas anteriormente.
# Cada fila del data frame sf representa una entidad geográfica con uno
# o más atributos y una geometría asociada.

#3. VECTORIALES
# Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

# definimos coordenadas de acuerdo a la imagen
x <- c(6, 4, 0, -2, 0,2,  4)
y <- c(2*sqrt(3), 4*sqrt(3), 4*sqrt(3), 2*sqrt(3), 0, 2*sqrt(3), 0)


coordenadas <- data.frame(x = x, y = y)

# grafico con ggplot2

ggplot(coordenadas, aes(x = x, y = y)) + geom_polygon(fill = "white",
                                                      col = "pink") 
#se tomo en cuenta el punto p del polygono

#3.Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente 
inven_lagos <- read_sf("data_eva2/Lagos/Inventario_Lagos.shp")

lagos_stgo <- inven_lagos[inven_lagos$PROVINCIA == "Santiago", ]

# la provincia de santiago tiene un total de 34 lagos

# reproyecte (transforme) el sistema de referencias de coordendas
# de lagos_stgo a SRC EPSG 4326

lagos_stgo <- st_transform(lagos_stgo,4326)


# haga un mapa (con plot) en donde se muestre con colores
# la variación de la variable área (AREA_KM2)

# en la provincia santiago
plot(lagos_stgo[, c(2, 22)], main = "Variación de la variable área (AREA_KM2)")

# en todo chile
plot(inven_lagos[, c(2, 22)], main = "Variación de la variable área (AREA_KM2)")


# seleccione el primer lago de lagos_stgo y simplifique su geometria,
# considerando una tolerancia de 30m.
# Haga un plot de la geometría original y simplificada.

primer_lago <- lagos_stgo[1,]

# tolerancia de 30m.
primer_lago <- st_simplify(primer_lago, dTolerance = 30)

par(mfrow = c(1,2))
plot(primer_lago$geometry, main = "Geometria simplificada tolerancia 30m")
plot(lagos_stgo[1, 22], main = "Geometria original")



#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente

calidad_agua <- read_sf("data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")

# filtrar por comuna de “Romeral”

romeral <- calidad_agua[calidad_agua$NOM_COM == "ROMERAL", ]

# se observan 3 observaciones

# cree un buffer de 1000 metros en los puntos que se encuentran en Romeral
calag_rom_buf <- st_buffer(romeral,1000)


# ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf?

colnames(calag_rom_buf)[1:5]


# guarde el objeto calag_rom_buf en formato geopackage y
# con el nombre calidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,'calidad_agua_romeral_buffer_1000m.gpkg',append = TRUE)


#4.RASTER

# Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’
# de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste.

# El sistema de referencia de coordenadas debe ser coordenadas geográficas
# y datum WGS84.

# Definir las coordenadas y el CRS
xmn <- -71.83333 # 71°50’ Oeste
xmx <- -70.25    # 70°15’ Oeste
ymn <- -37.5     # 37°30’ Sur
ymx <- -35.33333 # 35°20’ Sur
crs <- "+proj=longlat +datum=WGS84"

# Crear un objeto SpatRaster
r <- rast(ncol=4, nrow=4, xmin=xmn, xmax=xmx, ymin=ymn, ymax=ymx, crs=crs)

# Asignar los valores
values(r) <- c(9, 10, 5, 100,
               6, 25, 10, 5,
               4, NA, 15, 30,
               1, 2, 25, 50)

# Trasponer el raster para que coincida con la disposición deseada
r <- t(r)

# Mostrar el raster
plot(r);text(r)

#2.considere el mismo raster anterior

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

# Transforme el sistema de referencia de coordenadas del raster anterior
# a coordenadas UTM Huso 19 Sur datum WGS84.

# Definir el CRS a UTM Huso 19 Sur usando el código EPSG
crs_utm <- "EPSG:32719"

# Transformar el sistema de referencia de coordenadas al UTM Huso 19 Sur
r <- project(r, crs_utm)

# Cree un raster nuevo utilizando el raster de la pregunta anterior,
# en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

# Sumar 10 a cada valor de los píxeles
r_plus10 <- r + 10

# Calcular la raíz cuadrada de cada valor de los píxeles
r_sqrt <- sqrt(r_plus10)

plot(r_sqrt);text(r_sqrt)


# Cambiar los valores que son menores que 46 o mayores que 54 por NA

r_new <- ifel(r < 46 | r > 54, NA, r)

plot(r_new);text(r_new)


# Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile <- rast("data_eva2/dem_chile.tif")

# clase del objeto

class(dem_chile) # SpatRaster

#  número de columnas, filas y capas
dim(dem_chile) # 4656 1884    1

# Resolución espacial
res(dem_chile) # 0.008333333 0.008333333

# sistema de referencia de coordenadas
crs(dem_chile,describe = TRUE)

# el archivo se encuentra almacenado en la memoria o en el disco.
# Al ser un raster sin modificaciones se encuentra en el disco, y cargado en la memoria


# Cargue el archivo imagen_copiapo.tif en R

imagen <- rast("data_eva2/imagen_copiapo.tif")

# cree un raster que corresponda a la suma de las cuatro capas.

imagen_sum <- sum(imagen)

# reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

imagen <- project(imagen, "EPSG:4326")

# haga un mapa en donde se pueda visualizar la composición de color
# RGB utilizando las tres primeras capas.

plotRGB(imagen[[1:3]])


# guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
writeRaster(imagen[[1]], "copiapo_capa1.tif")







