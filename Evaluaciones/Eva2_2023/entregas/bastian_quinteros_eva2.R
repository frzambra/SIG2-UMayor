#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#R puede utilizarse como un Sistema de informacion greografica, a traves de la implementacion de paquetes diseñados para el manejo y analisis de datos geoespaciales, en el cual usamos sp y sf


#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#Se utilizan dos tipos de objetos para trabajar con datos geoespaciales, vectores (sf); el cual presenta datos geoespaciales vectoriales el cual se maneja a traves del paquete sf
#Por ultimo raster; este representa datos geoespaciales raster el cual maneja con paquete raster o terra


#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#El paquete sf tiene distintas geometrias para los datos vectoriales, las cuales son:
#Lineas (linestring), Puntos (Point), Poligonos (Polygon), Colecciones de geometrias (Multipoint, Multilinestring, Multipolygon, Geometry Colecction), Geometrias geometrias (Geometry)
#El paquete sf admite varias geometrías para datos vectoriales, entre las que se incluyen:


#4. (10pts) Describa los objetos de clase sf 

# Geometria('geometry'), atributos ('data'), Sistema de referencia de Coordenadas ('crs')



#1.(20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

# Instalar y cargar el paquete 'sf'
install.packages("sf")
library(sf)

# Coordenadas de los puntos A, B, C, D, E, F
coords <- matrix(c(0, 4, 6, 4, 0, -2, 0,
                   0, 0, 2 * sqrt(3), 4 * sqrt(3), 4 * sqrt(3), 2 * sqrt(3), 0),
                 ncol = 2, byrow = TRUE)
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol) 


#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

lagos<-st_read("data_eva2/Lagos")
#a. (5pts) tipo de geometria
st_geometry_type(lagos)
#b. (5pts) dimensión de los puntos
dim(lagos)
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(lagos)
#R:"EPSG", 32719, datum:WGS84, huso:UTM zone 19s, proyectada

#d. (5pts) cantidad de variables y observaciones str(lagos)
#R: Tiene 2067 observaciones y 22 variables

#e. (5pts) extensión
st_bbox(lagos)



#3.Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?

lagos_stgo<-lagos[lagos$PROVINCIA%in%c("Santiago"),]
str(lagos_stgo)
#R: tiene 9 lagos en total


#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
lagos_stgo<-st_transform(lagos_stgo,4326)
st_crs(lagos_stgo)

lagos_stgo<-st_transform(lagos_stgo,32719)
st_crs(lagos_stgo)

lago_simplificado<-st_simplify(lagos_stgo[,1],dTolerance =30)

par(mfrow = c(1,2))
plot(lago_simplificado$geometry)
plot(lagos_stgo[,1]$geometry)


#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:


ica <- st_read("data_eva2/Indice_Calidad_de_Aguas")
ica

#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?


#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

romeral <- ica[ica$NOM_COM %in% c("ROMERAL"),]
romeral
str(romeral)
#3 obs

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .

calag_rom_buf <- st_buffer(romeral,1000)
calag_rom_buf
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .

names(calag_rom_buf)[1:5]


#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombrecalidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")





#1.(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud
Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser
coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes
valores:
  - Fila 1: 9, 6, 4, 1
- Fila 2: 10, 25, NA, 2
- Fila 3: 5, 10, 15, 25
- Fila 4: 100, 5, 30, 50

#LONGITUDES EN X, LATITUDES EN Y AL DIVIDIR POR 60.
#- Fila 1: 9, 6, 4, 1- Fila 2: 10, 25, NA, 2- Fila 3: 5, 10, 15, 25- Fila 4: 100, 5, 30, 50

install.packages('terra')
library(terra)

r<-rast(xmin=-71.833,xmax=-70.25,
        ymin=-37.5,ymax=-35.333,
        nrows=4,ncol=4,
        crs="EPSG:4326")

values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)



#2. (15pts) Considere el siguiente raster:4 Raster
library(terra)

#este es el entregado
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84

r <- raster(matrix(1:16*5, 4, byrow = FALSE))
crs(r) <- "+proj=longlat +datum=WGS84"

r_nuevo <- projectRaster(r, crs="+proj=utm +zone=19 +south +datum=WGS84")

st_crs(r_nuevo)



#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
nuevor <- sqrt(r2+10)
nuevor
plot(nuevor)
text(nuevor,digits=2)



#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

nuevor <- r2
nuevor[nuevor < 46 | nuevor > 54] <- NA

# Mostrar el nuevo raster
plot(nuevor)
text(nuevor, digits = 2)



#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .

op <- global(r2, c("sum", "mean", "sd"), na.rm=TRUE) 
op2 <- summary(r2, na.rm = TRUE)



#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile <- raster("/cloud/project/data_eva2/dem_chile.tif")

# a. Clase del objeto
clase_objeto <- class(dem_chile)
#R: raster

# b. Número de columnas, filas y capas
num_columnas <- ncol(dem_chile)
num_filas <- nrow(dem_chile)
num_capas <- nlayers(dem_chile)
#R: Tiene 1884 columnas, 4656 filas, y 1 capa


# c. Resolución espacial
resolucion_espacial <- res(dem_chile)
#R:0.008333333 0.008333333

# d. Sistema de referencia de coordenadas
sistema_referencia <- crs(dem_chile)
print(paste("d. Sistema de referencia de coordenadas:", proj4string(sistema_referencia)))
#R: "EPSG",4326

# e. Almacenamiento en memoria o en disco
inMemory(dem_chile)
#R: Se almacena en disco


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
imagen_copiapo<-rast("data_eva2/imagen_copiapo.tif")
imagen_copiapo_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]
#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)
#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

capa1_copiapo<-imagen_copiapo[[1]]
dim(capa1_copiapo)
writeRaster(capa1_copiapo,'copiapo_capa1.tif')    

