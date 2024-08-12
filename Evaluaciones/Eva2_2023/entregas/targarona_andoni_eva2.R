#EVALUACION 2

#NOMBRE: ANDONI TARGARONA

library(sf)
library(terra)

#----CONCEPTOS----#

#(10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#(10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#(10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.

#- Point
#- Multipoint
#- Linestring
#- Multilinestring
#- Polygon
#- Multipolygon

#(10pts) Describa los objetos de clase sf.


#----VECTORIALES----#

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

a= st_point(c(0,0))

b= st_point(c(4,0))

c= st_point(c(6,2*sqrt(3)))

d= st_point(c(4,4*sqrt(3)))

e= st_point(c(0,4*sqrt(3)))

f= st_point(c(-2,2*sqrt(3)))

multip= st_multipoint(c(a,b,c,d,e,f))

plot(multip)

#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

lagos= read_sf(("C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/Lagos/Inventario_Lagos.shp"))

#(5pts) tipo de geometria
st_geometry(lagos)

#(5pts) dimensión de los #puntos
dim(lagos)

#(10pts) sistema dereferencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
crs(lagos,describe=TRUE)

#(5pts) cantidad de variables y observaciones
dim(lagos)
#2067 obs, 22 variables

#(5pts) extensión
ext(lagos)

#3. a. Con la capa de Inventario Lagos realice lo siguiente:
#(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

lagos_stgo= lagos[lagos$PROVINCIA %in% 'Santiago',]

lagos= st_transform(lagos,st_crs(lagos_stgo))

lagos_stgo= st_intersection(lagos,lagos_stgo)
#Son 9 lagos

#b.(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

st_crs(lagos_stgo)= 4326

nuevo_crs= st_transform(lagos_stgo,32719)
nuevo_crs

#c.(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

plot(lagos_stgo$AREA_KM2,add = TRUE,col='red',main='Area Km2')

#d.(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

lago1= lagos_stgo[1,]
lago1

simp_lago1= st_simplify(lago1,dTolerance = 30)

par(mfrow=c(1,2))

#lago normal
plot(lago1$geometry,main='Lago 1')

#lago simplificado
plot(simp_lago1$geometry,main='Lago simplificado')

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

cal_aguas= read_sf("C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")

#a.(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?

romeral=cal_aguas[cal_aguas$NOM_COM %in% 'ROMERAL',]

cal_aguas= st_transform(cal_aguas,st_crs(romeral))

romeral= st_intersection(cal_aguas,romeral)

dim(romeral)
#3 obs, 53 variables

plot(romeral$geometry)
#tiene 3 puntos

#b.(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

calag_rom_buf= st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

#c.(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.

names(calag_rom_buf[1:5])

#d.(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,"C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/Indice_Calidad_de_Aguas/calidad_agua_romeral_buffer_1000m.gpkg",append = TRUE)

#----RASTER----#

#1.(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:

r <- rast(ymax=-70.25000,ymin=-71.66667, xmax = -35.33333,xmin=-37.50000, crs='EPSG:4326', nrow=4,ncol=4)

values(r)= c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)
values(r)
plot(r)
text(r)

#2.(15pts) Considere el siguiente raster:

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

crs(r,describe=TRUE)
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:5361")
plot(r)
text(r)
crs(r,describe=TRUE)

#3.(20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

r2= sqrt(r+10)
plot(r2);text(r2)

#4.(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

#5.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

#promedio
mean(values(r))

#mediana
median(values(r))

#desviacion estandar
sd(values(r))

#6.Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem= rast("C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/dem_chile.tif")

#a.(5pts) clase del objeto
class(dem)

#b.(5pts) número de columnas, filas y capas
dim(dem)

#c.(5pts) resolución espacial
res(dem)

#d.(5pts) sistema de referencia de coordenadas
crs(dem,describe=TRUE)

#e.(5pts) el archivo se encuentra almacenado en la memoria o en el disco.
sources(dem)
#En el disco

#f.(15pts) cuál es la elevación máxima y mínima
max(dem)
min(dem)

#Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

cop= rast("C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/imagen_copiapo.tif")

#(15pts) cree un raster que corresponda a la suma de las cuatro capas.


#(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

nuevo_crs<-st_transform(cop,4326)


#(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

plotRGB(cop)

#(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif

writeRaster(cop,"C:/Users/andon/OneDrive/Documentos/datosr/data_eva2/imagen_copiapo.tif/copiapo_capa1.tif")

