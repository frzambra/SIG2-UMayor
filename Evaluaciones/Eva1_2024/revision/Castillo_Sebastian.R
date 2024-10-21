#Solucion: Evalucion Parcial 1
#Fecha: 30-09-2024
#Integrantes:
#Sebastian Castillo

library(sf)
library(terra)

#1. Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=25

v <- matrix(c(25, 0,
              12.5, 25,
             -12.5, 25,
             -25, 0,
             -12.5, -25,
              12.5, -25,
              25, 0),
              ncol = 2, byrow=TRUE)
v
hex_sfg <- st_polygon(list(v))
plot(hex_sfg)

#2. Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.

r <- rast(nrows=50, ncols=25, 
          xmin= -73.16, xmax= -71.59, 
          ymin= -36.16, ymax= -34.57, 
          crs="EPSG:4326")
values(r) <- rnorm(ncell(r),mean=100,sd=20)
plot(r)

#3. Cargue en R el archivo "paises.csv", escriba un script en R que permita obtener lo siguiente:
#1) clase de objeto que corresponde
#2) cantidad de observaciones
#3) cantidad de variables
#4) tipo de datos de cada variable
#5) filtrar los datos que corresponden a "Europa" y año 2007
#6) respecto a la pregunta anterior indique cuantos paises se encuentran en "Europa" y año 2007.

paises <- read.csv2("paises.csv")
class(paises)
nrow(paises)
ncol(paises)
str(paises)

europa_2007 <- subset(paises, paises$continente == "Europa" & paises$anio == 2007)
nrow(europa_2007)

#4. Cargue el archivo vectorial de cuenca "cuenca_codigo_056.gpkg" y escriba el script que permita indicar:
#1) Cantidad de variables
#2) Cantidad de observaciones
#3) Tipo de geometria
#4) Dimensión de las geometrias
#5) extraiga la geometria y guardela en un objeto "cuenca_geom"
#6) haga un mapa (base) de la geometria
#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

cuenca <- st_read("cuenca_codigo_056.gpkg")
ncol(cuenca)
nrow(cuenca)
print(cuenca)
st_dimension(cuenca)

cuenca_geom <- st_geometry(cuenca)
plot(cuenca_geom)

sub_max_area <- subset(cuenca, cuenca$COD_SUBC == max(cuenca$COD_SUBC))
st_write(sub_max_area, "subcuenca_max_area.shp")


#5. Cargue el archivo "viento_cuenca_codigo_046.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
#1) identificar la clase de objeto a que corresponde
#2) la cantidad de filas, columnas y cantidad total de celdas
#3) el sistema de referencia de coordenadas en el que se encuentra
#4) la resolución espacial en unidades de metros
#5) la extension en unidades de metros
#6) Haga un mapa (base)

viento <- rast("viento_cuenca_codigo_046.tif")
class(viento)
nrow(viento)
ncol(viento)
ncell(viento)
st_crs(viento)
res(viento)
print(viento)
plot(viento)
