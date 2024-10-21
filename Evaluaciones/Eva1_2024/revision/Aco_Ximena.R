# Evaluacion 1 
# Ximena Aco Vera

#1.Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=50

install.packages('sf')
library(sf)

a <- 50
a
p
p <- rbind(c(-a/2,a), c(a/2,a), c(a,0), c(a/2,-a), c(-a/2,-a), c(-a,0), c(-a/2,a) )
plg <-st_polygon(list(p))
plg
class(plg)
plot(plg)


#2. Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.

library(terra)

#lat_max <- -35.42361 ->  "-35°25'25"
#lat_min <- -37.83889 ->  "-37°50'20"
#lon_max <- -72.40833 ->  "-72°24'30"
#lon_min <- -74.83472 ->  "-74°50'5"

r <- rast(ncol=25, nrow=50, xmax= -72.40, xmin= -74.83, ymin= -37.83, ymax= -35.4)
r
set.seed(123)
values(r) <- rnorm(ncell(r), mean = 100, sd = 20)
values(r)
crs(r) <- "+proj=longlat +datum=WGS84 +no_defs"
crs(r)
plot(r)
text(r)


#3.Cargue en R el archivo "mtautos.csv", escriba un scrip en R que permita obtener lo siguiente:
#1) clase de objeto que corresponde
#2) cantidad de observaciones
#3) cantidad de variables
#4) tipo de datos de cada variable
#5) filtrar los datos que tienen cilindros igula a 6 y caballos (de fuerza) mayor a 100.
#6) respecto a la pregunta anterior indique cuantos autos tienen cilindros igula a 6 y caballos (de fuerza) mayor a 100.

mtautos <- read.csv2("C:/Users/Ximena/Downloads/data_evaluación1/data/mtautos.csv")
mtautos
View(mtautos)
class(mtautos)
nrow(mtautos)
ncol(mtautos)
mtautos
tipos_datos <- sapply(mtautos, class)
tipos_datos
autos_filtrados <- mtautos[mtautos$cilindros=="6" & mtautos$caballos > "100",]
autos_filtrados
cantidad_autos_filtrados <- nrow(autos_filtrados)
cantidad_autos_filtrados


#4. Cargue el archivo vectorial de cuenca "cuenca_codigo_054.gpkg" y escriba el script que permita indicar:
#1) Cantidad de variables
#2) Cantidad de observaciones
#3) Tipo de geometria
#4) Dimensión de las geometrias
#5) extraiga la geometria y guardela en un objeto "cuenca_geom"
#6) haga un mapa (base) de la geometria
#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

library(sf)
cuenca <- st_read('C:/Users/Ximena/Downloads/data_evaluación1/data/cuenca_codigo_054.gpkg')
cuenca
ncol(cuenca)
nrow(cuenca)
st_geometry(cuenca)
st_dimension(cuenca)
cuenca_geom <- st_geometry(cuenca)
cuenca_geom
plot(cuenca_geom)
subcuenca_max_area <- cuenca[which.max(cuenca$Shape.Area), ]
subcuenca_max_area
st_write(subcuenca_max_area, "subcuenca_max_area.shp", delete_dsn = TRUE)


#5. Cargue el archivo "viento_cuenca_codigo_046.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
#identificar la clase de objeto a que corresponde
#la cantidad de filas, columnas y cantidad total de celdas
#el sistema de referencia de coordenadas en el que se encuentra
#la resolución espacial en unidades de metros
#la extension en unidades de metros
#Haga un mapa (base)

library(terra)
viento <- rast('C:/Users/Ximena/Downloads/data_evaluación1/data/viento_cuenca_codigo_046.tif')
viento
class(viento)
dim(viento)
ncell(viento)
crs(viento)
?res
res(viento)
ext(viento)
plot(viento)
