#Prueba 1

install.packages('terra')
install.packages('sf')



#1 Para el hexágono de la imagen cree un objeto "sfg" de tipo polígono utilizando la libreria {sf}. Considere un valor de a=10

library(sf) 
# Valor de a 
a <- 10 
coords <- matrix(c( a, 0,  #A 
                a/2,a, #B 
                -a/2, a, #c
                -a,0, #d
                -a/2,-a, #e
                a/2,-a, #f
                a,0),
                 ncol = 2, byrow = TRUE) 
        
# Crear el objeto polígono 
hexagon <- st_polygon(list(coords)) 
                
# Convertirlo en una simple feature geometry (sfg) 
sfg_hexagon <- st_sfc(hexagon, crs = 4326) 
                
# Mostrar el objeto 
print(sfg_hexagon)
 
#plotear             
plot(sfg_hexagon)

#2 Cree un objeto raster que tenga una extension en latitud entre los -35°25'25" y -37°50'20" y en longitud -72°24'30" y -74°50'5", que tenga 50 filas y 25 columnas y el sistema de referencia en coordenadas geográficas datum WGS84. Asignele a cada pixel valores aleatorios de acuerdo a una distribución normal con promedio igual a 100 y desviación estandar igual a 20.
# Cargar el paquete 'terra'
library(terra)

# Definir la extensión del raster en grados decimales

#Longitud entre: de -74°50'5" a -72°24'30"
lonmin <- -74 - 50/60 - 5/3600   # Convertir -74°50'5" a grados decimales,conservando el grado, dividiendo por min 60 y por 3600 los segundos
lonmax <- -72 - 24/60 - 30/3600  # Convertir -72°24'30" a grados decimales,conservando el grado, dividiendo por min 60 y por 3600 los segundos

#comprobar
lonmin
lonmax

#latitud entre: -35°25'25" y -37°50'20"
latmin <- -37 - 50/60 - 20/3600  # Convertir -37°50'20" a grados decimales, conservando el grado, dividiendo por min 60 y por 3600 los segundos
latmax <- -35 - 25/60 - 25/3600  # Convertir -35°25'25" a grados decimales, conservando el grado, dividiendo por min 60 y por 3600 los segundos

#comprobar
latmax
latmin

# Crear un objeto raster con 50 filas y 25 columnas
r <- rast(nrows = 50, ncols = 25,xmin=lonmin,xmax=lonmax,ymin=latmin,ymax=latmax)

# Asignar el sistema de referencia WGS 84 
crs(r) <- "EPSG:4326" # CRS: WGS 84

# Generar valores aleatorios de acuerdo a una distribución normal (media igual a 100, desviacionn estandar igual 20)
val <- rnorm(ncell(r), mean = 100, sd = 20)

# Asignar los valores aleatorios al raster creado
values(r) <- val

# Mostrar informacion del raster
print(r)

# PLotear/ graficar  el raster
plot(r)

                


#3 Cargue en R el archivo "aviones.csv", escriba un scrip en R que permita obtener lo siguiente:

aviones <-read.csv2('C:/Users/vicente/OneDrive/Documentos/datosprueba/aviones.csv')

print(aviones)


#1) clase de objeto que corresponde

class(aviones)

#2) cantidad de observaciones
nrow(aviones)

#3) cantidad de variables
ncol(aviones)


#4) tipo de datos de cada variable

str(aviones$codigo_cola)
str(aviones$anio)
str(aviones$tipo)
str(aviones$fabricante)
str(aviones$modelo)
str(aviones$motores)
str(aviones$asientos)
str(aviones$velocidad)
str(aviones$tipo_motor)


#5) filtrar los datos que corresponden a fabricante "Boeing" y año 2001
 
#filtrar primero por boing
boeing <- aviones[aviones$fabricante == "BOEING", ]

#comprobar
print(boeing)

#filtrar luego por el año 2001
boeing2001 <- boeing[boeing$anio==2001, ]

#comprobar
print(boeing2001)


#6) respecto a la pregunta anterior indique cuantos aviones corresponden al fabricante "Boeing" y año 2001

#numero de aviones que corresponden al fabricante boening y año 2001

nrow(boeing2001)
#32



#4 Cargue el archivo vectorial de cuenca "cuenca_codigo_060.gpkg" y escriba el script que permita indicar:

library(sf)

file1 <- 'C:/Users/vicente/OneDrive/Documentos/datosprueba/cuenca_codigo_060.gpkg'

cuenca60  <-st_read(file1)

plot(cuenca60)
#1) Cantidad de variables
ncol(cuenca60)

#2) Cantidad de observaciones
nrow(cuenca60)

#3) Tipo de geometria

st_geometry(cuenca60)


#4) Dimensión de las geometrias

st_dimension(cuenca60)

print(cuenca60)

#5) extraiga la geometria y guardela en un objeto "cuenca_geom"

cuenca_geom <-st_geometry(cuenca60)




#6) haga un mapa (base) de la geometria
 
 plot(cuenca_geom)


#7) filtre con indexación la geometria (subsubcuenca) que tiene la mayor área (Shape.Area)
 
 #ordenar de mayor a menor
 maxcuenca <- cuenca60[order(cuenca60$Shape_Area, decreasing = TRUE),]
 maxcuenca
 
 #extraer la fila numero 1
 maxcuenca1 <-maxcuenca[1,]

 st_geometry(maxcuenca1)
 
#comprobar 
maxcuenca1 

#plotear subcuenca con mayor area
plot(maxcuenca1)

#8) el resultado de la pregunta anterior guardelo como un archivo shapefile con nombre "subcuenca_max_area.shp"

st_write(maxcuenca1,"subcuenca_max_area.shp")

#comprobacion

file2 <- 'C:/Users/vicente/OneDrive/Documentos/datosprueba/subcuenca_max_area.shp'


subcuencamax<- st_read(file2)
print(subcuencamax)


#5Cargue el archivo "viento_cuenca_codigo_114.tif" en R. Este archivo corresponde a valores de velocidad del viento para el mes de enero en Chile. Cree un script que permita :
  
file3 <- 'C:/Users/vicente/OneDrive/Documentos/datosprueba/viento_cuenca_codigo_114.tif'

vientosenero <-rast(file3)

plot(vientosenero)

#1) identificar la clase de objeto a que corresponde

class(vientosenero)

#2) la cantidad de filas, columnas y cantidad total de celdas

#numero de filas
nrow(vientosenero)

#numero de columnas
ncol(vientosenero)

# numero de cell
ncell(vientosenero)

#3) el sistema de referencia de coordenadas en el que se encuentra

crs(vientosenero) #ID[\"EPSG\",4326]]

#4) la resolución espacial en unidades de metros

crsUTM <- "EPSG:32719" #UTM Huso 19

#comprobar
 vientoseneroUTM<-project(vientosenero,crsUTM)
crs(vientoseneroUTM)

#resolucion
res(vientoseneroUTM)

#5) la extension en unidades de metros

ext(vientoseneroUTM)


#6) Haga un mapa (base)
plot(vientoseneroUTM)

