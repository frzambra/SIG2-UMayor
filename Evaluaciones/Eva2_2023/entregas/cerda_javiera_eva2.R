#EVALUACION 2.
#JAVIERA CERDA 
#FECHA: 17/11


#CONCEPTOS 

#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#R sive como un sistema de informacion geografica para diversas funciones, como; transformar el sistema de referencia de coordenadas, asignarle un CRS y consultar/inspeccionar el SRC, además, nos entrega todo lo que compone el SRC: datum, huso, codigo epsg. mostrandonos coordenadas geograficas (latitud longitu, esfericas) y coordenadas proyectadas (metros, conica, cilindrica y planas)
#R nos permite tener tres formatos para manejar los CRS: proj 4, EPSG y wkt (el cual describe la caracteristica completa del SRC)
#Cabe destacar, que además, al momento de trasnformar el SRC se recomienda realizarlo de vectorial a raster, y R nospermite realizar esto, lo cual es fundamental en el mundo de los datos geoespaciales para poder manejar los datos tanto vectoriales como raster. 


#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#para trabajar con objetos geoespaciales de tipo vectorial se utiliza la clase de objetos sf (simple feature). En este tipo de clase,los archivos vectorias quedan almacenados como objeto sf, en donde se debe instalar y cargar primero que todo el paquete (install.packages("sf") y cargar (library(sf))). 

#para trabajar con objetos geoespaciales de tipo raster se utiliza la clase de objetos SpatRaster. En este tipo de clase, los archivos quedan almacenados como objeto SpatRaster, para esto, se debe instalar y cargar el paquete, el cual corresponde a terra (install.packages("terra) y library(terra)) ya que la clase definida por {terra} es SpatRaster. 


#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#los tipos de geoemtrias que se pueden trabajar con el paquete {sf} son: 
#1.Point 
#2.Linestring 
#3.Polygon 
#4. multipoint
#5. multilinestring 
#6. multipolygon
#7. geometrycollection 

#4. (10pts) Describa los objetos de clase sf .

#el tipo de objeto de clase sf, sirve para representar los datos geoespaciales de tipo {sf} (simple feature), este tipo de clase indica que representara a datos vectoriales. 
#Para mayor entendimiento, sf esta formado por un sfc y los sfc estan formados por sfg, sf es quien almacena las simple feature y tenemos tres tipos de datos utilizados para representarlos (sf,sfc y sfg)
#Adicional a esto, los objetos sf estan formados por un data frame + columna de un objeto sfc y cada geometria del objeto sfc corresponde a un obejto sfg. 
#las geometrias, se guardan en la list colum, y cada gometria individual se guarda en un objeto sfg 
#sfg guarda la geometria de una entidad individual y esta implementada en tipos de datos: numerico, matrix y list, considerando que un point es un vectior numerico, un grupo de puntos e suna matrix y dada fila de la matrix es un point y que cualquier otro grupo es una list 


#3. VECTORIALES

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

#a(0,0)
#b(4,0)
#c(6, 2√3)
#d(4, 4√3)
#e(0,4√3)
#f(-2,2√3)
#st_polygon es una funcion que permite realizar el poligono

df <- data.frame(latitud = c(0,4,6,4,0,-2),
  longitud = c(0,0,3.464,6.928,6.928,3.464))
pentagono <- as.matrix(df)
pentagono_of <- st_polygon(list(rbind(pentagono,pentagono[1,])))
#se obtiene un pentagono con las coordenadas correctas
pentagono_of
#se plotea el pentagono
plot(pentagono_of)


#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#(5pts) tipo de geometria
#(5pts) dimensión de los puntos
#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#(5pts) cantidad de variables y observaciones
#(5pts) extensión


install.packages("sf")
library(sf)
install.packages("tibble")

read_sf("lagos/Inventario_Lagos.shp")
inventario_lagos <- read_sf("Lagos/Inventario_Lagos.shp")

#tipo de geometria
inventario_lagos$geometry
st_geometry(inventario_lagos)

#dimension de los puntos 
inventario_lagos
#XY, tiene 2D
st_dimension(inventario_lagos)

#src (datum, proyectada o no proyectada, huso si corresponde y código EPSG)

#WGS 84 / UTM zone 19S

#datum, huso y codigo epsg
st_crs(inventario_lagos)

#codigo epsg de manera más rápida 
st_crs(inventario_lagos)$epsg

#cantidad de variables y observaciones 

#observaciones 
nrow(inventario_lagos)

#variables
ncol(inventario_lagos)

#extension 
#xmin: 16712.94 ymin: 3870128 xmax: 697838.5 ymax: 8051367


#3. Con la capa de Inventario Lagos realice lo siguiente:
#(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

inventario_lagos$PROVINCIA
lagos_stgo <- inventario_lagos[inventario_lagos$PROVINCIA == "Santiago", ]
length(lagos_stgo)
lagos_stgo
#34

#(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

lagos_stgo <- st_transform(lagos_stgo,4326)
st_crs(lagos_stgo)


#(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo)

plot(lagos_stgo["AREA_KM2"], main = "Variación de la variable area de Lagos en Santiago", col = "red")

#(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

primlago <- lagos_stgo[1, ]
plot(primlago)

#simplificacion: funcion st_simplify, dtolerance: me indica la tolerancia, en metros en este caso 30 

simpprimlago <- st_simplify(primlago, dTolerance = 30)

#mfrow me permite tener dos paneles
par(mfrow = c(1, 2))

#para plotear lago original y lago simplificado: 
plot(primlago, main = "geometria original")
plot(simpprimlago, main = "geometria simplificada")


#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

read_sf("Indice_calidad_aguas/ICA_Indice_Calidad_Aguas.shp")
indice_calidad <- read_sf("Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")


#(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
romeral <- indice_calidad[indice_calidad$NOM_COM == "ROMERAL",]
romeral
ext(romeral)
#3 features: 3 puntos


#(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

#para crear buffer: st_buffer 
calag_rom_buf <-st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

#(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
calag_rom_buf
names(calag_rom_buf)
#variable1 : OBJECTID_1
#variable2: OBJECTID
#variable3: NOMBRE_APR
#variable4: NOMBRE_BNA
#variable5: COD_BNA


#(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

#funcion st_write permite guardar el obejto 
st_write(calag_rom_buf,"calidad_agua_romeral_buffer_1000m.gpkg",append=TRUE)



#4. RASTER 

install.packages("terra")
library(terra)

#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#-Fila 1: 9, 6, 4, 1
#-Fila 2: 10, 25, NA, 2
#-Fila 3: 5, 10, 15, 25
#-Fila 4: 100, 5, 30, 50

#se creara un raster de dos dimensiones: latitud y longitud 
#Al hablar de latitud y longitud hablamos de grados, cada grado esta en 60min.

fila1 <- c(9,6,4,1)
fila2<- c(10, 25, 1, 2)
fila3 <- c(5, 10, 15, 25)
fila4<- c(100, 5, 30, 50)
r <-rast(ymax=-70.250,ymin=-71.833,xmax=-35.333,xmin= -37.500,ncols=4,nrows=4,nlyr=4)
r
dim(r)

#2. (15pts) Considere el siguiente raster:

library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)


#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

r <- project(r,"EPSG:32719")
crs(r,describe=TRUE)
r

#3. 20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel. 
#raiz cuadrada del pixel +10

r
#sumen 10 y se calcule la raiz cuadrada a cada pixel:
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)
sqrt(pixel + 10)
r2 <- r+10


#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
# NA cambiar por menores que 46 y mayores que 54
rp2 <- r<46;r>54


#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.
#raster p2:
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
prom(r)
median(r)

#global permite obtener un valor resumen de todo el raster 
#promedio = 42.5
#desviacion estandar = 23.80476
#mediana = 42.5
global(r,mean) 
global(r,sd)
global(r,median)

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

library(terra)
dem_chile <- rast ("dem_chile.tif")
dem_chile

#(5pts) clase del objeto
class(dem_chile)
#es una clase SpatRaster

#(5pts) número de columnas, filas y capas
dim(dem_chile)
#filas, columnas y capas 

#(5pts) resolución espacial
res(dem_chile)

#(5pts) sistema de referencia de coordenadas
crs(dem_chile)

#(5pts) el archivo se encuentra almacenado en la memoria o en el disco

getwd()
sources(dem_chile)
#no esta guardada en la memoria, esta guardada en el disco 
inMemory(dem_chile) 


#(15pts) cuál es la elevación máxima y mínima
dem_chile
#max : 6414
#mn: -256
minmax(dem_chile)


#7.Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

im_copiapo <- rast ("imagen_copiapo.tif")
im_copiapo

#(15pts) cree un raster que corresponda a la suma de las cuatro capas.

capa1 <- im_copiapo[[1]]
capa2 <- im_copiapo[[2]]
capa3 <- im_copiapo[[3]]
capa4 <- im_copiapo[[4]]
suma <- capa1+capa2+capa3+capa4
suma

suma <- im_copiapo[[1]]+im_copiapo[[2]]+im_copiapo[[3]]+im_copiapo[[4]]


#ahora es la suma de las cuatro capas y es solo una capa 

#(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(im_copiapo) <- "EPSG:4326"
crs(im_copiapo)

#(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

#plotRGB
plott <- im_copiapo[[1:3]]
plottGB <- plot(plott)

#(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif

primcapa <- im_copiapo[[1]]
writeRaster(primcapa, "copiapo_capa1.tif")


    
