# EVALUACIÓN 2 TOMÁS FLORES.

# CONCEPTOS.

#Describa como puede utilizar el sofware R como un SIG.

# Mediante bibliotecas de datos y paquetes se puede manipular y analizar datos geo espaciales. 

# Describa que clase de objetos se utilizan en R para trabajar con objetos geoespacialesde tipo vectoriales y rasters.

# PUNTOS, LINEAS, POLIGONOS Y GEOMETRIAS

#  Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#point, linestring, polygon.

#describa objetos de clase sf

#Estructuras de datos, crs y operaciones espaciales.



# VECTORIALES 

#PENTAGONO

# Coordenadas 
coordenadas <- matrix(c(
  0, 0,   # A
  4, 0,   # B
  6, 2 sqrt(3),   # C
  4, 4 sqrt(3), # D
  0.4, sqrt(3), # E
  -2,2sqrt(3)
), ncol = 2, byrow = TRUE)

# objeto sf con las coordenadas
pentagono <- st_polygon(list(coordenadas))
pentagono_sf <- st_sfc(pentagono, crs = st_crs("epsg:4326"))

# pentágono
plot(pentagono_sf, main = "Pentágono")
, # D
  0, 0.5  # E
), ncol = 2, byrow = TRUE)



#CARGAR LIBRERIAS
library(sf)
library(terra)
library(raster)

# 2 Cargue la capa vectorial "lagos" e indique:

#cargar lagos
setwd("C:/Users/tomas/OneDrive/Documentos/R/data/data_eva2/data_eva2")
lagos <- st_read("Lagos")
# A. tipo de geometría
st_geometry(lagos)
# B. dimension de los puntos
dim(lagos)
# C. sistema de referencia de coordenadas
st_crs(lagos)
# D. cantidad de variables y observaciones   ####REVISAR ANTES DE ENVIAR######
ncol(lagos)
nrow(lagos)
# E. extension                            ######REVISAR ANTES DE ENVIAR######
extension <- tools::file_ext(lagos)
extension 

# 3 CON LA CAPA DE INVENTARIO LAGOS REALICE LO SIGUIENTE:

# A. Seleccionar los lagos que pertenecen a la provincia de santiago
setwd("C:/Users/tomas/OneDrive/Documentos/R/data/data_eva2/data_eva2/Lagos")
lagos2 <- st_read("inventario_lagos.shp")
lagos_stgo <- lagos2[lagos2$PROVINCIA == "Santiago", ]
lagos_stgo
#Cuantos lagos son
nrow(lagos_stgo)

# B. Proyectar el sistema de referencia de coordenadas de lagos_stgo a SRC EPSG 4326 Y REEMPLAZAR
lagos_stgo2 <- st_transform(lagos_stgo, crs = st_crs("epsg:4326"))
lagos_stgo2

# C. Haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
 
###############

# 4. . Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/data_eva2/data_eva2")
st_read("Indice_Calidad_de_Aguas")

# A. Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
setwd("C:/Users/tomas/OneDrive/Documentos/R/data/data_eva2/data_eva2/Indice_Calidad_de_Aguas")
agua <- st_read("ICA_Indice_Calidad_Aguas.shp")
rom<- agua[agua$NOM_COM== "ROMERAL", ]
rom
#Cantidad de puntos
nrow(rom)

# B. Cree un buffer de 100 metros en los puntos que se encuentran en Romeral y asignelo al objeto Calag_rom_buf
calag_rom_buf <- st_buffer(rom, dist = 1000)
calag_rom_buf

# ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
nom <- names(calag_rom_buf)[1:5]
nom

# Guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf, "calidad_agua_romeral_buffer_1000m.gpkg", append = F)


# 4. RASTER

# 1. Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe sercoordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores

#Coordenadas
latitudes <- seq(-37.5, -35.333) 
latitudes
longitudes <- seq(-71.833, -70.25) 
longitudes
#Matriz
matriz <- matrix(c(9, 6, 4, 1,
                     10, 25, NA, 2,
                     5, 10, 15, 25,
                     100, 5, 30, 50), nrow = 4, byrow = TRUE)

#Raster #####REVISARRRRRRR######
objrast <- raster(values_R, xmn = min(longitudes), xmx = max(longitudes), ymn = min(latitudes), ymx = max(latitudes), crs = 'epsg:4326')
objrast

# 2. CONSIDERE EL SIGUIENTE RASTER

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

# Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84.
rtransformado <- project(r, "EPSG:32719")
rtransformado

# 3. Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel

# Raster
r <- rast(x = matrix(1:16 * 5, 4, byrow = FALSE),crs = "EPSG:4326")
r
# Sumar 10 y calcular la raíz cuadrada
r2 <- sqrt(r + 10)
r2

# 4. Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA . 


#####REVISAAAAAARRRR########

r
r_nuevo <- ifel(r < 46 | r > 54, NA, r)
r_nuevo
plot(r_nuevo)

# 5.  Calcule el promedio, la mediana y desviación estandar de todos los valores del raster dela pregunta 2. Utilice una función de {terra}  ######REVISSSAAAAAAAARRRR#####

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
r
plot(r);text(r)

prom <- mean(r)
plot(prom)
median(r)

# Imprimir los resultados
cat("Promedio:", prom, "\n")
cat("Mediana:", mediana, "\n")
cat("Desviación estándar:", desviacion_estandar, "\n")

# 6. CARGUE EL ARCHIVO DEM_CHILE.TIF E INDIQUE:

setwd("~/R/data/data_eva2/data_eva2")
dem<- rast("dem_chile.tif") 
dem
# A. Clase de objeto
class(dem)

# B. filas, columnas y capas
dim(dem)

# C. Resolución espacial
res(dem)

# D. sist. referencia coordenadas
crs(dem)

# E. Almacenamiento en memoria o disco 
inMemory(dem)
# E. Elevacion min y max.
min(dem)
max(dem)

#7. CARGUE EL ARHIVO IMAGEN COPIAPO Y: 
cop<-rast("imagen_copiapo.tif")
cop
# A. cree un raster que corresponda a la suma de las cuatro capas

cop2 <- sum(cop)
cop2

# B. Reproyectar el sist referencia coordenadas.
cop3 <- project(cop2, "EPSG 4326")
cop3

# C. mapa
mapa <- cop[[1:3]]
plotRGB(mapa, r = 1, g = 2, b = 3, stretch = "lin", main = "Composición RGB")

# d. Guardar (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
writeRaster(raster_copiapo[[1]], "copiapo_capa1.tif", format = "GTiff", overwrite = TRUE)












