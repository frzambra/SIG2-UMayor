# Evaluacion 2 
#Belén Urrea Coa 

######################## C O N C E P T O S #########################

# 1 Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#El software R es una herramienta muy útil para la manipulación de los datos geospaciales, ya que este cuenta con paquetes que facilitan el trabajo con estos. Uno de los paquetes más usado es el 'sf' o simple fututre, el cual ayuda e la lectura de los archivos vectoriales y crear y manipular geometrias de tipo poligono, puntos, lineas, entre otras, de modo que se pueda crear un mapa. Sin embargo, para trabajar con archivos raster, se encuentra actualizada un nuevo paquete llamado 'terra' el cual es muy practico para crear raster,  cortarlos, y hacer pruebas logicas en diferentes capas del raster. 

# 2 Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#En R se pueden trabjar con objetos espaciales vectoriales; los cuales pueden ser discretos que son unicos e individuales, como los caminos y rios, si te posiicionas al lado del camino o rio, este no va a existir, es lineal, y continuos, que al posicionarte en cualquier punto del objeto va a arrojar algun dato o infromacion, como lo son la temperatura y la elevacion, en este se trabaja con objetos de tipo sf.
#Y para objetos espaciales Raster, este son un conjunto de pixeles que logran formar una imagen o raster, en este se trabaja con objetos de tipo spatraster o rast


# 3 Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}
#Las geometrias que se pueden trabajar con el paquete sf son Point, multipont, linestring, multilinestring, polygon y multipolygon. 

# 4 Describa los objetos de clase sf.
#Los objetos de clase sf son aquellos que contienen informacion de los atributos y la geomteria de la entidad, este trabaja con el data frame.

######################### V E C T O R I A L E S #####################
#Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
 
install.packages('sf')
library(sf)

pA <- st_point(c(0 , 0))
pB <- st_point(c(4 , 0))
pC <- st_point(c(6, 2*(sqrt(3))))
pD <- st_point(c(4, 4*(sqrt(3))))
pE <- st_point(c(0, 4*(sqrt(3))))
pF <- st_point(c(-2, 2*(sqrt(3))))
pP <- st_point(c(2, 2*(sqrt(3))))

st_multipoint(pA, pB, pC, pD, pE, pF, pP)
df_pentagono <- data.frame(pA, pB, pC, pD, pE, pF, pP)

df_pentag <- data.frame( 
  Longitud = c(0 , 4, 6, 4, 0, -2, 2), 
  latitud = c(0, 0, 2*(sqrt(3)), 4*(sqrt(3)), 4*(sqrt(3)), 2*(sqrt(3)), 2*(sqrt(3))) )
df_pentag

Pentag <- as.matrix(df_pentag)

Pentagono1 <- st_polygon(list(rbind(Pentag[,2:1], Pentag[1,2:1])))
plot(Pentagono1)

# Ejercicio 2 Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#tipo de geometria
#dimensión de los puntos
#sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#cantidad de variables y observaciones
#extensión

library(sf)
#Me aparecio un error de tipo tibble, asi que instalamos el paquete para poder cargar el archivo 
invent <- read_sf('Inventario_Lagos.shp')
install.packages('tibble')
invent

#Tipo de geometria 
geometria <- st_geometry(invent)
geometria

#dimensión de los puntos
dim(invent)

#sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
SRC <- st_crs(invent)

#cantidad de variables y observaciones
var_obs <- dim(invent)   #2067 features and 21 fields

#extensión

#Ejercicio 3 : Con la capa de Inventario Lagos realice lo siguiente:
#seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?
lagos_stgo <- invent[invent$PROVINCIA == 'Santiago', ]
lagos_stgo
#Los lagos que pertenecen a Santiago son 10 


#reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
st_crs(lagos_stgo) <- 4326

#no se encontraban las funciones, se procedio a volver instalar el paquete sf
library(sf)
install.packages('sf')
Lag_sat <- st_transform(lagos_stgo, 4326)
Lag_sat
st_crs(Lag_sat)

#haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
invent$AREA_KM2


#seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
Lago_1_sat <- Lag_sat[1,]
Lago_1_sat
lago_sel_sim30 <- st_simplify(Lago_1_sat,dTolerance = 30)
par(mfrow = c(1,3))
plot(lago_sel_sim30$geometry)


#Ejerccio 4 : Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
ind_cal <- read_sf('ICA_Indice_Calidad_Aguas.shp')

#Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
obs_romeral <- ind_cal[ind_cal$NOM_COM == "ROMERAL", ]
obs_romeral #solo hay tres puntos de Romeral

#cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

calag_rom_buf <- st_buffer(obs_romeral, 1000)
par(mfrow = c(1,2))
plot(calag_rom_buf$geometry)

#¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
#guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
calag_rom_buf


calag_rom_buf
dir <- tempdir()
write_sf(calag_rom_buf,file.path(dir,'calidad_agua_romeral_buffer_1000m.csv'))
write_sf(calag_rom_buf,file.path(dir,'calidad_agua_romeral_buffer_1000m.gpkg'))


################################ R A S T E R ##############################
install.packages('terra')
library(terra)

#Ejercicio 1 : Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
-Fila 1: 9, 6, 4, 1
-Fila 2: 10, 25, NA, 2
-Fila 3: 5, 10, 15, 25
-Fila 4: 100, 5, 30, 50

install.packages('terra')
library('terra')
r4 <- rast(xmax = 71.83, xmin=70.25, ymax=37.50, ymin=35.33, ncol=4, nrow=4)
r4
crs(r4)


# Ejercicio 2 : Considere el siguiente raster:
library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
crs(r) <- "EPSG:32719"
crs(r)

# Ejercicio 3 Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
#Para realizar las operaciones, se hizo otro  objeto para no perder los datos.  Ahora se procederá a hacer la suma 
r2 <- r
r_sum <- r2 + 10
plot(r_sum) ; text(r_sum)

# Ahora la raiz en cada celda 
rnew <- sqrt(r)
plot(rnew,main= 'r raiz');text(rnew)

#Ejercicio 4 Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.
R_04 <-  rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

 
R_4[l1] <- NA
l4 <- R_04 > 46 | R_04 < 54
R_04[l4] <- 'NA'
values(R_04[l4] <- "NA")
plot(R_04); text(R_04)

#Ejercicio 5 Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.
r
global(r,prom)
global(r,mean)
E5 <- global(r,var)
D.S <- global(E5,sqrt)

#Ejercicio 6 : 
#Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
DEM_CHILE <- rast('dem_chile.tif')
#clase del objeto
class(DEM_CHILE) 
#número de columnas, filas y capas
dim(DEM_CHILE)
#resolución espacial
res(DEM_CHILE)

#sistema de referencia de coordenadas
crs(DEM_CHILE, describe = TRUE)
#el archivo se encuentra almacenado en la memoria o en el disco.
gewd
#cuál es la elevación máxima y mínima
min(DEM_CHILE)
max(DEM_CHILE)
  