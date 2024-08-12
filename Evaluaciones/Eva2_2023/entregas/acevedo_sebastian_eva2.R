#Evaluacion 2
                                         #Conceptos
#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#R puede ser utilizado como un Sistema de Información Geográfica (SIG) mediante la integración de paquetes específicos diseñados para el análisis y la manipulación de datos geoespaciales. A continuación, te proporciono una descripción general de cómo puedes utilizar R como un SIG:
#sf proporciona funciones para manipular y visualizar datos vectoriales. Puedes realizar operaciones espaciales, filtrar datos y crear mapas utilizando las funciones integradas.
#raster te permite realizar operaciones sobre datos raster, como cálculos de estadísticas, recortes y visualización de mapas de calor.

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#sf (Simple Features):
#La clase básica para datos vectoriales en R es sf, que significa Simple Features. Esta clase es parte del paquete sf. Los objetos sf representan datos espaciales vectoriales y contienen información geométrica y atributos asociados.
#Permite trabajar con datos raster que son demasiado grandes para caber en la RAM.

#Raster (raster package):
#La clase básica para datos raster en R es Raster, que es parte del paquete raster. Los objetos Raster representan datos espaciales en forma de cuadrícula, donde cada celda tiene un valor asociado.
#
#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.
#
#POINT,	geometría dimensión cero, un punto
#LINESTRING,	varios puntos, secuencia de puntos conectados por líneas rectas que no se intersecan; geometría unidimensional
#POLYGON,	geometría con un área positiva (bidimensional); la secuencia de puntos forma un anillo cerrado que no se interseca
#MULTIPOINT,	grupo de POINT
#MULTILINESTRING,	grupo de LINESTRING
#MULTIPOLYGON, grupo de polygon 

#4. (10pts) Describa los objetos de clase sf.

#Simple Feature: se refiere a un estándar formal (ISO 19125-1: 2004) que describe cómo los objetos en el mundo real se pueden representar en computadoras, con énfasis en la geometría espacial de estos objetos.
#sf: la tabla (data.frame) con los atributos y geometría de la entidad , que contiene
#sfc : la list-colum con la geometría de cada entidad (registro), que está compuesto de
#sfg: la geometría de la entidad de cada simple feature individual

install.packages("sf")
library(sf)

                                           #Vectoriales

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

(df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3))))

m_pol <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(m_pol,m_pol[1,])))
plot(pol)   



#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#(5pts) tipo de geometria
#(5pts) dimensión de los puntos
#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#(5pts) cantidad de variables y observaciones
#(5pts) extensión

getwd()
inv_lagos <- st_read("C:/Users/56958/Desktop/evaluacion/data_eva2/data_eva2/Lagos/Inventario_Lagos.shp")
st_geometry(inv_lagos) #Geometry type: MULTIPOLYGON
                       #Dimension: XY
crs(inv_lagos, describe = TRUE) #WGS 84 / Proyectada / UTM zone 19S /EPSG 32719
str(inv_lagos) # 2067 obs. of  22 variables
ext(inv_lagos) # xmin: 16712.94 ymin: 3870128 xmax: 697838.5 ymax: 8051367

#3 Con la capa de Inventario Lagos realice lo siguiente:
#(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

lagos_stgo <- inv_lagos[inv_lagos$PROVINCIA %in% "Santiago",] # 9 observaciones

#(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

crs(lagos_stgo)
lagos_stgo_4326<-st_transform(lagos_stgo,4326)

#(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

plot(lagos_stgo["AREA_KM2"], col = "red")

#(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

prim_lago <- lagos_stgo[1, ]
simp_lago <- st_simplify(prim_lago, dTolerance = 30)
par(mfrow = c(1,2))
plot(prim_lago); plot(simp_lago)

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?

ind_agu <- st_read("C:/Users/56958/Desktop/evaluacion/data_eva2/data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")  


ind_rom <- ind_agu[ind_agu$NOM_COM == "ROMERAL",] # hay 3 observaciones
plot(ind_rom)

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

calag_rom_buf <- st_buffer(ind_rom, 1000)
plot(calag_rom_buf)

#c (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
#OBJECTED_1 / OBJECTID / NOMBRE_APR / NOMBRE_BNA / NOM_REG

calag_var <- calag_rom_buf[,1]

# d (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
getwd()
st_write(calag_rom_buf, "calidad_agua_romeral_buffer_1000m.gpkg")

                                            #Raster
install.packages("terra")
library(terra)
install.packages("raster")
library(raster)

#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#-Fila 1: 9, 6, 4, 1
#-Fila 2: 10, 25, NA, 2
#-Fila 3: 5, 10, 15, 25
#-Fila 4: 100, 5, 30, 50

r1 <- rast(xmin = -71.5, xmax = -70.25,
           ymin = -37.33 , ymax = -35.33, 
           ncols = 4, nrow = 4, crs="EPSG:4326")

values(r1)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)
plot(r1); text(r1)

#2. considere el siguiente:

r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

crs(r2)<-"EPSG:32719"
crs(r2)

  

#3 (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

r3 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
  plot(r3);text(r3)
  
r4 <- r3 +10  
plot(r4); text(r4)

r5 <- sqrt(r4)
plot(r5); text(r5, digits = 2)

#4 (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

r6 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

l <-  r6 < 46 | r6 > 54
plot(l); text(l)
r6[l]<- NA
plot(r6); text(r6)

#5 (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.


calc <- global(r2, c("sum", "mean", "sd"), na.rm=TRUE) 
calc

#6.Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

getwd()
dem_chile<-rast("data_eva2/dem_chile.tif")

#a.(5pts) clase del objeto
class(dem_chile)
  
#b.(5pts) número de columnas, filas y capas
dim(dem_chile)
  
#c.(5pts) resolución espacial
res(dem_chile)

#d(5pts) sistema de referencia de coordenadas
crs(dem_chile,describe=TRUE) 

#e (5pts) el archivo se encuentra almacenado en la memoria o en el disco.

sources(dem_chile)

#f (15pts) cuál es la elevación máxima y mínima
extension<-ext(dem_chile)

dem_chilerecorte<-crop(dem_chile,extension)


elevacion_maxima<-max(dem_chilerecorte)
elevacion_minima<-min(dem_chilerecorte)

elevacion_maxima #-256
elevacion_minima #6414


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
getwd()

imagen_copiapo <-rast("data_eva2/imagen_copiapo.tif")
plotRGB(imagen_copiapo)

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
imagen_copiapo_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(imagen_copiapo)
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)

#c (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)

#d (15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
capa1 <- imagen_copiapo[[1]]
writeRaster(capa1,"copiapo_capa1.tif")
