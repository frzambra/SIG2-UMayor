install.packages('sf')
library(sf)

install.packages('terra')
library(terra)

#1.-Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=100

df_pol <- data.frame(
  y = c(0, 100, 100, 0, -100, -100),
  x= c(100,100/2, -100/2, -100, -100/2, 100/2))
df_pol
y <- c(0, 100, 100, 0, -100, -100, 0)
x <- c(100,100/2, -100/2, -100, -100/2, 100/2, 100)
m <- cbind(x, y)
l <- list(m)
pol <- st_polygon(l)
str(pol)
plot(pol)

#2-Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.

#No supe como hacerla

#3.-Cargue en R el archivo "pinguinos.csv", escriba un script en R que permita obtener lo siguiente:

#1) clase de objeto que corresponde
#2) cantidad de observaciones
#3) cantidad de variables
#4) tipo de datos de cada variable
#5) filtrar los datos que corresponden a la isla "Torgersen" y año 2007
#6) respecto a la pregunta anterior indique cuantos pinguinos corresponden a la isla "Torgersen" y año 2007.

library(sf)
pinguinos<- read.csv2('pinguinos.csv')

class(pinguinos)

nrow(pinguinos)
ncol(pinguinos)

str(pinguinos)

isla_2007<- pinguinos[pinguinos$isla == 'Torgersen' & pinguinos$anio == 2007, ]
isla_2007


#4.-Cargue el archivo vectorial de cuenca "cuenca_codigo_056.gpkg" y escriba el script que permita indicar:

#1) Cantidad de variables
#2) Cantidad de observaciones
#3) Tipo de geometria
#4) Dimensión de las geometrias
#5) extraiga la geometria y guardela en un objeto "cuenca_geom"
#6) haga un mapa (base) de la geometria
#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

#No supe como hacerlaa


#5.-Cargue el archivo "viento_cuenca_codigo_114.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :

#1) identificar la clase de objeto a que corresponde
#2) la cantidad de filas, columnas y cantidad total de celdas
#3) el sistema de referencia de coordenadas en el que se encuentra
#4) la resolución espacial en unidades de metros
#5) la extension en unidades de metros
#6) Haga un mapa (base)

library(terra)
#Elegir ruta de trabajo
setwd("C:/Users/Acer/Documents")

#llamar dato raster de viento
viento<- rast("viento_cuenca_codigo_114")
class(viento)
print(viento)
plot(viento)

