#Prueba 1 "SIG 2": parte 2
# Nombre: Mihi'ua Pakomio Rapu 
# Fecha: 30/09/24

install.packages("sf")
library(sf)


#Pregunta 1 10 puntos: Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=1
st_polygon

a= 1
df_pol <- data.frame( x = c(-a/2,a/2,a,a/2, -a/2,-a/2),y = c(a,a,0,-a,-a,0))
m_pol = as.matrix(df_pol)
m_pol_inicio = m_pol[1,]
hexagono = st_polygon(list(rbind(m_pol,m_pol_inicio)))

#Pregunta 2 15 puntos: Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.
install.packages("terra")
library(terra)

longitud1 = -(74+50/60+5/3600)
longitud2 = -(72+24/60+30/3600)
latitud1 = -(37+50/60+20/3600)
latitud2 = -(35+25/60+25/3600)
r <- rast(xmin=longitud1, xmax=longitud2, ymin=latitud1, ymax=latitud2, nrow= 50, ncol= 25, crs= "epsg:4326")
values(r) = rnorm(1250, mean=100,sd = 20)

#Pregunta 3 20 puntos: Cargue en R el archivo "aviones.csv", escriba un scrip en R que permita obtener lo siguiente:

aviones = read.csv2("aviones.cvs")

#1) clase de objeto que corresponde
class(aviones)

#2) cantidad de observaciones
nrow(aviones)

#3) cantidad de variables
ncol(aviones)

#4) tipo de datos de cada variable
str(aviones)

#5) filtrar los datos que corresponden a fabricante "Boeing" y año 2001
boeing2001 = aviones[(aviones$anio==2001) & aviones$fabricante== "BOEING",]

#6) respecto a la pregunta anterior indique cuantos aviones corresponden al fabricante "Boeing" y año 2001
nrow(boeing2001)


#Pregunta 4 20 puntos: Cargue el archivo vectorial de cuenca "cuenca_codigo_051.gpkg" y escriba el script que permita indicar:

install.packages("sf")
library(sf)

archivo_vectorial <- "cuenca_codigo_051.gpkg"
cuenca_vectorial <- vect(archivo_vectorial)

#1) Cantidad de variables
cantidad_variables <- ncol(cuenca_vectorial)

#2) Cantidad de observaciones

#3) Tipo de geometria
geomtype(cuenca_vectorial)

#4) Dimensión de las geometrias
dim(cuenca_vectorial)

#5) extraiga la geometria y guardela en un objeto "cuenca_geom"
geom(cuenca_vectorial)

#6) haga un mapa (base) de la geometria
library(terra)
cuenca_vectorial <- vect("cuenca_codigo_051.gpkg")
cuenca_geom <- geom(cuenca_vectorial)
plot(cuenca_geom, main = "Mapa de la Cuenca", col = "verde", border = "azul")

#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)

#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"



#Pregunta 5 20 puntos : Cargue el archivo "viento_cuenca_codigo_119.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
install.packages("terra")
library(terra)

viento_raster <- rast("viento_cuenca_codigo_119.tif")
print(viento_raster)


#1) identificar la clase de objeto a que corresponde
clase_objeto <- class(viento_raster)

#2) la cantidad de filas, columnas y cantidad total de celdas
total_celdas <- ncell(viento_raster)

#3) el sistema de referencia de coordenadas en el que se encuentra
crs(vc_119, describe= TRUE)

#4) la resolución espacial en unidades de metros
sistema_referencia <- crs(viento_raster)

#5) la extension en unidades de metros
resolucion <- res(viento_raster)

#6) Haga un mapa (base)
library(terra)
viento_raster <- rast("viento_cuenca_codigo_119.tif")

plot(viento_raster, main = "Mapa de Velocidad del Viento en Enero",
     xlab = "Longitud", ylab = "Latitud", col = terrain.colors(100))

plot(viento_raster, add = TRUE)
