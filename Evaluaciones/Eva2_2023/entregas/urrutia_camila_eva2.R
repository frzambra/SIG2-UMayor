#camila Urrutia
#evaluacion 2

install.packages(c("sf", "sp", "raster", "leaflet", "terra", "buffer"))


#CONCEPTOS*****
#1.10pts) 10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#"R es tanto un entorno como un lenguaje de programación ampliamente empleado para el análisis estadístico y la representación visual de datos. Aunque su uso principal es en esos ámbitos, también puede desempeñar el papel de un Sistema de Información Geográfica (SIG) gracias a paquetes especializados diseñados para la manipulación y análisis de datos geoespaciales."

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#En R, existen varios paquetes especializados que permiten trabajar con datos geoespaciales, tanto vectoriales como raster. Algunos de los paquetes más comunes son: sf(vectorial), sp(cetorial), raster(raster),terra(raster).

#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.

#point, line, polygon, multipoint,Multilinestring,Multipolygon ,Geometry Collection 

#4. (10pts) Describa los objetos de clase sf.

#En R, la clase sf se utiliza para representar datos espaciales, es decir, datos que tienen una componente geoespacial, como puntos, líneas o polígonos en un espacio bidimensional o tridimensional. Entre los objetos que encontramos en sf tenemos la Geometria, Atributos, CRS, Metadatos adicionales

#VECTORIALES****
#1. Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
#A(0,0); B(4,0); C(6,2√ 3); (4,4√ 3); E(0,4√ 3); F(-2,2√ 3)

# Coordenadas del pentágono
coordenadas <- cbind(c(0, 4, 6, 4, 0, -2), c(0, 0, 2 * sqrt(3), 4 * sqrt(3), 4 * sqrt(3), 2 * sqrt(3)))

# Crear una nueva ventana de gráficos
plot(1, type = 'n', xlab = "", ylab = "", xlim = c(-3, 7), ylim = c(-1, 5), asp = 1)

# Dibujar el pentágono
polygon(coordenadas, col = "lightblue", border = "blue")

# Etiquetar los puntos A, B, C, D, E, F
text(coordenadas[,1], coordenadas[,2], labels = c("A", "B", "C", "D", "E", "F"), pos = 3, col = "red")


#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#(5pts) tipo de geometria
#(5pts) dimensión de los puntos
#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#(5pts) cantidad de variables y observaciones
#(5pts) extensión

setwd("/cloud/project/data/prueba 2")

# Instala y carga la biblioteca sf
# install.packages("sf")
library(sf)

# Establece la ruta del archivo .shp
ruta_shapefile <- '/lagos/Inventaro_Lagos.shp'

# Lee el archivo .shp
datos_spatial <- st_read('Lagos/Inventario_Lagos.shp')

# Verifica la estructura y los primeros registros del archivo
head(datos_spatial)
#(5pts) tipo de geometria: **MULTIPOLYGON**
#(5pts) dimensión de los puntos : **XY**
#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG) : **WGS 84 / UTM zone 19S**
#(5pts) cantidad de variables y observaciones : ** collection with 2067 features and 21 fields
#(5pts) extensión : **16712.9393999996, 697838.4798, 3870127.723, 8051367.3989 (xmin, xmax, ymin, ymax)**
ext(datos_spatial)

#3. Con la capa de Inventario Lagos realice lo siguiente:
#(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

# Cargar los paquetes
library(sf)
library(dplyr)
print(datos_spatial$PROVINCIA=='Santiago')
lagos_stgo <- datos_spatial$PROVINCIA %in%'Santiago'
lagos_stgo_1 <- which(lagos_stgo)[1]
print(lagos_stgo)
# 467 474 487 499 500 505 506 507 508. Son 9
intento1 <- datos_spatial == 'Santiago'

#(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
crs(datos_spatial)
?st_transform
# Definir el nuevo sistema de referencia de coordenadas (EPSG en este caso)
nuevo_csr <-st_transform(
datos_spatial,csr="EPSG:4326")

#(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
AREA_km2_stgo <-  datos_spatial$AREA_KM2
area_stgo_km2 <-c(AREA_km2_stgo[467],AREA_km2_stgo[474], AREA_km2_stgo[487],AREA_km2_stgo[499],  AREA_km2_stgo[500],AREA_km2_stgo[505],AREA_km2_stgo[506],AREA_km2_stgo[507],AREA_km2_stgo[508])
area_stgo_km2
plot(area_stgo_km2,col="red")
#(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
lago_1 <- lagos_stgo
lago_sim<-st_simplify(lago_1,dTolerance = 30)
plot(lago_1)
plot(lago_sim)


# Hacer un plot de la geometría original y simplificada
par(mfrow = c(1, 2))
plot(lago_1, main = "Geometría Original", col = "blue",max.plot = 21)
plot(lago_sim, main = "Geometría Simplificada", col = "red")

#4.Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
calidad_agua<-st_read("Indice_Calidad_de_Aguas")


#(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
romeral<-calidad_agua[calidad_agua$NOM_COM=="ROMERAL",] #hay 3
romeral

# (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.
calag_rom_buf<-st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

#(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
calidad_5<-calag_rom_buf[,1:5]
calidad_5
#OBJECTID_1
#OBJECTID
#NOMBRE_APR
#NOMBRE_BNA
#COD_BNA


#(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
calidad_agua_romeral_buffer_1000m<- st_write(calag_rom_buf,"calidad_agua_romeral_buffer_1000m.gpkg",append = TRUE) 


#RASTER****
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#-Fila 1: 9, 6, 4, 1
#-Fila 2: 10, 25, NA, 2
#-Fila 3: 5, 10, 15, 25
#-Fila 4: 100, 5, 30, 50

raster_1 <- rast(nrow=5,ncol=4,nlyr=4,ymax=-35.3333333,xmin= -71.83333305555556, xmax= -70.2666663888889,ymin= -37.5166667,crs="ESPG:4326")
fila_1 <- c(9, 6, 4, 1)
fila_2 <- c(10, 25, NA, 2)
fila_3 <- c(5, 10, 15, 25)
fila_4 <-  c(100, 5, 30, 50)
values(raster_1) <-c(fila_1,fila_2,fila_3,fila_4)
plot(raster_1)
#2. (15pts) Considere el siguiente raster y Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)
crs(r)
nuevo_crs <- project(r,"WGS84")
crs(nuevo_csr)
#3. Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
#raiz(pixel+10)

# ****no se puede calcular la raiz cuadrada de los pixel, es algo general no especifico de cada pixel****

#4. Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

r4 <- na_if(r>54,r<46)
values(r4)
plot(r4)

#5. Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}

summary(r)
fun_3 <- global(r, c("sum", "mean", "sd"), na.rm=TRUE) 

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

q <- rast("dem_chile.tif")
q
# a. (5pts) clase del objeto
class(q)

#b. (5pts) número de columnas, filas y capas
ncol(q)
nrow(q)
nlyr(q)

#c. (5pts) resolución espacial
res(q)

#d. (5pts) sistema de referencia de coordenadas
crs(q,describe=TRUE)

#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
q
DISCO

#e. (15pts) cuál es la elevación máxima y mínima
plot(q)
minmax(q)


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

cop <- rast("imagen_copiapo.tif")
cop
plot(cop)

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
c1 <- cop[[1]]
c2 <- cop [[2]]
c3 <- cop[[3]]
c4 <- cop [[4]]

copp <- c1+c2+c3+c4
copp
plot(copp)

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

w <- project(cop, "EPSG:4326")
w
#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizandolas tres primeras capas.
we <- c(c1,c2,c3)
plotRGB(we)


#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif
writeRaster(c1,"copiapo_capa1.tif")