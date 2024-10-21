#Rosa Hidalgo
#Prueba 1

install.packages("sf")
library(sf)

#Pregunta 1 Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=10 


a = 10
df_pol <- data.frame( x= c(-a/2, a/2,a,a/2, -a/2,-a/2, y= c (a,a,a,0,-a,-a,0) ))
m_pol= as.matrix(df_pol)
m_pol_inicio=m_pol[,1]
hexagono = st_polygon(list(rbind(m_pol,m_pol_inicio)))

# Pregunta 2 Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20

install.packages("terra")
library("terra")

lng1  =-(74+50/60+5/3600)
lng2  =-(72+24/60+30/3600)
lat1  =-(37+50/60+20/3600)
lat2  =-(35+25/60+25/3600) 

r <- rast(xmin = lng1, xmax = lng2, ymin = lat1, ymax = lat2, nrows = 50, ncols = 25)

set.seed(42)
values(r) <- rnorm(ncell(r), mean = 100, sd = 20)
print(r)

plot(r, main = "Raster con valores aleatorios (terra)")


# Pregunta 3 Cargue en R el archivo "mtautos.csv", escriba un scrip en R que permita obtener lo siguiente:
mtautos <- read.csv("mtautos.csv")
# Cargar los datos del archivo CSV

mtautos <- read.delim("mtautos.csv", sep = ";", header = TRUE)


mtautos <- read.csv("mtautos.csv")

# 1) Clase del objeto 
class(mtautos)

# 2) Cantidad de observaciones (número de filas)
nrow(mtautos)

# 3) Cantidad de variables (número de columnas)
ncol(mtautos)

# 4) Tipo de datos de cada variable
sapply(mtautos, class)


# 5) Filtrar los datos que tienen cilindros igual a 6 y caballos de fuerza mayor a 100

autos_filtrados <- subset(mtautos, cilindros == 6 & caballos > 100)

cat("5) Autos con cilindros igual a 6 y caballos de fuerza mayor a 100:\n")
print(autos_filtrados)


# 6) Cantidad de autos con cilindros igual a 6 y caballos de fuerza mayor a 100
cantidad_autos_filtrados <- nrow(autos_filtrados)
cat("6) Cantidad de autos que cumplen la condición:", cantidad_autos_filtrados, "\n")

#Pregunta 4

#Cargue el archivo vectorial de cuenca "cuenca_codigo_060.gpkg" y escriba el script que permita indicar:

#1) Cantidad de variables

#2) Cantidad de observaciones

#3) Tipo de geometria

#4) Dimensión de las geometrias

#5) extraiga la geometria y guardela en un objeto "cuenca_geom"

#6) haga un mapa (base) de la geometria

#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)

#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

pregunta 5
#Cargue el archivo "viento_cuenca_codigo_114.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
rast("viento_cuenca_codigo_114.tif")
print(viento_raster)
#1) identificar la clase de objeto a que corresponde
class(viento_raster)

#2) la cantidad de filas, columnas y cantidad total de celdas
nrow(viento_raster)
columnas <- ncol(viento_raster)
total_celdas <- ncell(viento_raster)

#3) el sistema de referencia de coordenadas en el que se encuentra
sistema_coordenadas <- crs(viento_raster, describe = TRUE)

#4) la resolución espacial en unidades de metros
resolucion <- res(viento_raster)

#5) la extension en unidades de metros
extension <- ext(viento_raster)
#6) Haga un mapa (base)
plot(viento_raster, main = "Velocidad del Viento en Enero (Chile)")

