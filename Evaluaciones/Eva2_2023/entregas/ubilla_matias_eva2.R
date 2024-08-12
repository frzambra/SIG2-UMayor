install.packages("sf")
install.packages("tibble")
install.packages("terra")
library("sf")
library("tibble")
library("terra")
#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.
El software r puede ser utilizado como un sig debido a su capacidad para leer y guardar archivos de una manera sencilla, su manipulación de datos, la capacidad de correr modelos y test estadisticos, crear graficos didacticos, facilitando bastante la compresión a partir de datos complejos.


#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
se utilizan dataframes, listas matrices o vectores


#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

hay variados tipos de geometria con los cuales se pueden trabajar en sf pero los principales son: Punto, multipunto,linea,multilinea,poligono, multipoligono y geometry collection.
#4. (10pts) Describa los objetos de clase sf .
son representaciones de objetos geograficos generadas a partir de estructuras de datos simples como listas, matrices o vectores















#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F

df <- data.frame(
  latitud = c(0,4,6,4,0,-2),
  longitud = c(0,0,3.464,6.928,6.928,3.464)
)

pol <- as.matrix(df)
po <- st_polygon(
  list(
    rbind(pol,pol[1,]))
)
po
plot(po)
#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

inventario <- st_read("data_eva2/Lagos/Inventario_Lagos.shp")

#  a. (5pts) tipo de geometria
Tiene una geometria de tipo multipoligono
st_geometry(inventario)
#b. (5pts) dimensión de los puntos
dim(inventario)
#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
crs(inventario,describe=TRUE)
LALALAL
#d. (5pts) cantidad de variables y observaciones
dim(inventario)
#e. (5pts) extensión
ext(inventario)
#3. Con la capa de Inventario Lagos realice lo siguiente:
 # a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
inventario
lagos_stgo <- inventario[inventario$PROVINCIA == "Santiago", ]
lagos_stgo
Son 34
  #b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a
#SRC EPSG 4326 y reemplázelo.
inventario <- st_transform(inventario, crs = "EPSG:4326")
crs(inventario, describe=TRUE)

  #c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(inventario$AREA_KM2, col="red")
?plot
#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
l1 <- lagos_stgo[1,]
l1
l1s <-st_simplify(l1,dTolerance = 50)
plot(l1$geometry)
plot(l1s$geometry)

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
aguas <- st_read("data_eva2/Indice_Calidad_de_Aguas")
aguas
#  a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
rom <- aguas[aguas$NOM_COM == "ROMERAL",]
rom
ext(rom)
Hay 3 puntos
 # b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.
calag_rom_buf <-st_buffer(rom,1000)
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
calag_rom_buf
1OBJECTID_1
2OBJECTID
3NOMBRE_APR 
4NOMBRE_BNA
5COD_BNA
#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf,"calidad_agua_romeral_buffer_1000m.gpkg",append=TRUE)
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes
#valores:
f1 <- c(9,6,4,1)
f2<- c(10, 25, NA, 2)
f3 <- c(5, 10, 15, 25)
f4<- c(100, 5, 30, 50)
r1 <-rast(ymax=-70.250,ymin=-71.833,xmax=-35.333,xmin= -37.500,ncols=4,nrows=4,nlyr=4)

d <- c(9,9,9,9,10,10,10,10,5,5,5,5,100,100,100,100,6,6,6,6,25,25,25,25,10,10,10,10,5,5,5,5,4,4,4,4,NA,NA,NA,NA,15,15,15,15,30,30,30,30,1,1,1,1,2,2,2,2,25,25,25,25,50,50,50,50)
values(r1) <- d


values(r1)
#2. (15pts) Considere el siguiente raster:

  
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")


plot(r);text(r)


#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
r <- project(r,"EPSG:32719")
crs(r,describe=TRUE)

#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
ee <- r+10
ee
values(r)
values(ee)
qq <- sqrt(ee)
values(qq)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .
r2 <- r<46;r>54
plot(r2);text(r2)


# 5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

summary(r)

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

q <- rast("data_eva2/dem_chile.tif")
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
cop <- rast("data_eva2/imagen_copiapo.tif")
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
                