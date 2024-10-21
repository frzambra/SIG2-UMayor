#Nombre: Macarena Gaete

# 1. Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=1
install.packages("sf")
library(sf)

a = 1
df_pol <- data.frame( x = c(-a/2,a/2,a,a/2,-a/2,-a),y = c(a,a,0,-a,-a,0 ))
m_pol = as.matrix(df_pol)
m_pol_inicio = m_pol[1,]
hexagono = st_polygon(list(rbind(m_pol,m_pol_inicio)))


#2 Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.
install.packages("terra")
library(terra)
lng1 = -(74+50/60+5/3600)
lng2 = -(72+24/60+30/3600)
lat1=-(37+50/60+20/3600)
lat2= -(35+25/60+25/3600)
r = rast(xmin=lng1, xmax=lng2, ymin=lat1, ymax=lat2,nrow= 50, ncol= 25, crs= "epsg:4326")
values(r) = rnorm(1250, mean=100,sd = 20)


#3. Cargue en R el archivo "aviones.csv", escriba un scrip en R que permita obtener lo siguiente:

aviones = read.csv2("aviones.csv")
#1) clase de objeto que corresponde
class(aviones)
#2) cantidad de observaciones
nrow(aviones)
#3) cantidad de variables
ncol(aviones)
#4) tipo de datos de cada variable
str(aviones)
#5) filtrar los datos que corresponden a fabricante "Boeing" y año 2001
boeing2001 = aviones[aviones$anio==2001 & aviones$fabricante=="BOEING",]
#6) respecto a la pregunta anterior indique cuantos aviones corresponden al fabricante "Boeing" y año 2001
nrow(boeing2001)

#4. Cargue el archivo vectorial de cuenca "cuenca_codigo_033.gpkg" y escriba el script que permita indicar:

#1) Cantidad de variables

#2) Cantidad de observaciones

#3) Tipo de geometria

#4) Dimensión de las geometrias

#5) extraiga la geometria y guardela en un objeto "cuenca_geom"

#6) haga un mapa (base) de la geometria

#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)

#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

#5. Cargue el archivo "viento_cuenca_codigo_032.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
install.packages("terra")
library(terra)

v_032= rast("viento_cuenca_codigo_032.tif")

#1) identificar la clase de objeto a que corresponde
class(v_032)

#2) la cantidad de filas, columnas y cantidad total de celdas
dim(v_032) #filas y columnas
ncell(v_032) #celdas

#3) el sistema de referencia de coordenadas en el que se encuentra
crs(v_032, describe= TRUE)

#4) la resolución espacial en unidades de metros
res(v_032)

#5) la extension en unidades de metros
ext(v_032)

#6) Haga un mapa (base)
plot(v_032)





