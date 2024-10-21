#prueba 1
#diego montero


#1 Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=50

library(sf)

hx <- rbind(c(-50/2,50),c(50/2,50),c(50,0),c(50/2,-50),c(-50/2,-50),c(-50,0),c(-50/2,50))


ml <- st_polygon(list(hx))

plot(ml)







#2 Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.

#cambio grados/decimal

#-35°25'25 -> -35 - 25/60 - 25/3600
#-37°50'20 -> -37 - 50/60 - 20/3600
#-72°24'30 -> -72 - 24/60 - 30/3600 
#-74°50'5 -> -74 - 50/60 - 5/3600

library(terra)

lat_min <- -37 - 50/60 - 20/3600  # -37°50'20" en decimal
lat_max <- -35 - 25/60 - 25/3600  # -35°25'25" en decimal
long_min <- -74 - 50/60 - 5/3600   # -74°50'5" en decimal
long_max <- -72 - 24/60 - 30/3600  # -72°24'30" en decimal


r <- rast(nrow=50, ncol=25, 
            xmin=long_min, xmax=long_max, 
            ymin=lat_min, ymax=lat_max, 
            crs=("+proj=longlat +datum=WGS84"))

#valores aleatorios 
values(r) <- rnorm(ncell(r), mean=100, sd=20)

plot(r)


#3 Cargue en R el archivo "pinguinos.csv", escriba un script en R que permita obtener lo siguiente:
library(sf)
pinguinos <-read.csv2("pinguinos.csv")
pinguinos
head(pinguinos)

#a) clase de objeto que corresponde
class(pinguinos)



#b) cantidad de observaciones
nrow(pinguinos)

#c) cantidad de variables
ncol(pinguinos)
#d) tipo de datos de cada variable
str(pinguinos)

#e) filtrar los datos que corresponden a la isla "Torgersen" y año 2007
pinguinos_filtro <- pinguinos[pinguinos$isla == "Torgersen" & pinguinos$anio == 2007, ]
pinguinos_filtro


#f) respecto a la pregunta anterior indique cuantos pinguinos corresponden a la isla "Torgersen" y año 2007.
pinguinos_filtro
numero_p <- nrow(pinguinos_filtro)
numero_p

#4 Cargue el archivo vectorial de cuenca "cuenca_codigo_033.gpkg" y escriba el script que permita indicar:

cuenca_33 <-st_read("cuenca_codigo_033.gpkg")
cuenca_33
plot(cuenca_33)
#a) Cantidad de variables
ncol(cuenca_33)

#b) Cantidad de observaciones
nrow(cuenca_33)

#c) Tipo de geometria
st_geometry_type(cuenca_33)

#d) Dimensión de las geometrias
dim_geometria <- st_dimension(cuenca_33)
dim_geometria

#e) extraiga la geometria y guardela en un objeto "cuenca_geom"
cuenca_geom <- st_geometry(cuenca_33)
cuenca_geom

#f) haga un mapa (base) de la geometria
plot(cuenca_geom)

#g) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
cuenca_max <- cuenca_33[which.max(cuenca_33$Shape.Area), ]

cuenca_max
plot(cuenca_max)

#h) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

st_write(cuenca_max, "subcuenca_max_area.shp")



# 5 Cargue el archivo "viento_cuenca_codigo_032.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :

library(terra)

viento <-rast("viento_cuenca_codigo_032.tif")
viento
#a) identificar la clase de objeto a que corresponde
class(viento)

#b) la cantidad de filas, columnas y cantidad total de celdas
nrow(viento)
ncol(viento)

ncell(viento)

#c) el sistema de referencia de coordenadas en el que se encuentra
crs_viento <- crs(viento)
crs_viento

viento_utm <- project(viento, "EPSG:32719")

#d) la resolución espacial en unidades de metros
resolucion <- res(viento_utm)
resolucion


#e) la extension en unidades de metros
extension <- ext(viento_utm)

extension


#f) Haga un mapa (base)
plot(viento)
