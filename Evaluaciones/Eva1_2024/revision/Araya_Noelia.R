#1.Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=50
library(sf)

a <- 50
pol1 <- rbind(c(-a/2,a), c(a/2,a), c(a,0), c(a/2,-a), c(-a/2,-a), c(-a,0), c(-a/2,a) ) 

poligono <-st_polygon(list(p))
class(poligono)
plot(poligono)



#2.Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.

library(terra)
o<- rast()
ext(o) <- ext(-74.834722,-72.40833,-37.838889,-35.423611)
nrow(o) = 50
ncol(o) = 25
crs(o) = 'EPSG:4326'
ncell(o)
valoresA <- rnorm(n = ncell(o), mean = 100, sd = 20)
values(o) <- valoresA
text(o)
plot(o)  


#3.Cargue en R el archivo "paises.csv", escriba un script en R que permita obtener lo siguiente:
install.packages("readr")
library(readr)
paises<- read.csv2("C:/Users/hola/Desktop/SIG AVANZADO/data/paises.csv")
View(paises)



#1) clase de objeto que corresponde
class(paises)
#2) cantidad de observaciones
dim(paises)
#3) cantidad de variables
length(paises)
#4) tipo de datos de cada variable
str(paises)


#5) filtrar los datos que corresponden a "Europa" y año 2007

año<- paises[paises$anio == '2007',]
europa<- año[año$continente == 'Europa',]
View(europa)

#6) respecto a la pregunta anterior indique cuantos paises se encuentran en "Europa" y año 2007.
nrow(europa)

#4.Cargue el archivo vectorial de cuenca "cuenca_codigo_046.gpkg" y escriba el script que permita indicar:
library(sf)
cuenca<- st_read('C:/Users/hola/Desktop/SIG AVANZADO/data/cuenca_codigo_046.gpkg')

#1) Cantidad de variables
ncol(cuenca)

#2) Cantidad de observaciones
nrow(cuenca)

#3) Tipo de geometria
st_geometry_type(cuenca)

#4) Dimensión de las geometrias
st_dimension(cuenca)

#5) extraiga la geometria y guardela en un objeto "cuenca_geom"
View(cuenca)
cuenca_geom<- st_geometry(cuenca)

#6) haga un mapa (base) de la geometria
plot(cuenca_geom)


#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
?which.max
subcuenca_max_area <- cuenca[which.max(cuenca$Shape.Area), ]

print(subcuenca_max_area)


#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

st_write(subcuenca_max_area, "subcuenca_max_area.shp")

#5.Cargue el archivo "viento_cuenca_codigo_119.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :

viento<-rast('C:/Users/hola/Desktop/SIG AVANZADO/data/viento_cuenca_codigo_119.tif')


#1) identificar la clase de objeto a que corresponde
class(viento)


#2) la cantidad de filas, columnas y cantidad total de celdas
nrow(viento)
ncol(viento)
ncell(viento)


#3) el sistema de referencia de coordenadas en el que se encuentra
crs(viento)

#4) la resolución espacial en unidades de metros
metros<-project(viento,'EPSG:32719')
res(viento)

#5) la extension en unidades de metros
ext(metros)

#6) Haga un mapa (base)
plot(viento)
