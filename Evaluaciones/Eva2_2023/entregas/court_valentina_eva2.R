#EVALUACION 2
#Valentina Court

#1.Datos
#• Indice Calidad de Aguas : datos de la Dirección General de Aguas (DGA) con ubicaciones de
#puntos de Agua Potable Rural (APR) con mediciones de índices de calidad de agua.
#• Inventario Lagos: datos de la Dirección General de Aguas (DGA) con los lagos presentes en el territorio nacional.
#• dem Chile: datos de elevación (metros) para el territorio de Chile continental.
#• imagen Copiapo: imagen aérea capturada sobre una zona de la ciudad de Copiapo.

#2. Coneceptos

#2.1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#R cuenta con paquetes completos para el manejo de informacion geografica, tales como sf y sp en donde se manejan los datos vectoriales, los paquetes de terra y raster para poder hacer uso de los datos raster que cumplen con una cierta variedad de herramientas para poder leer y escribir datos espaciales, hacer analisis ecologico, cerar mapas, geoestadistica, algebra de raster, entre muchas otras funciones que sirven para poder manejar los datos geoespaciales.   

#2.2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.



#2.3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#Punto
#Linestring
#Poligono
#Multipunto
#Multipoligono
#Multilinestring


#2.4. (10pts) Describa los objetos de clase sf .

#sf: la tabla (data.frame) con los atributos y geometria de la entidad, que coniene sfc: list.colum con la geometria de cada entidad, que esta copuesto de sgf: la geometria de la entidad de cada simple feature individual.


#3. Vectoriales
#3.1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

a= st_point(c(0,0))

b= st_point(c(4,0))

c= st_point(c(6,2*sqrt(3)))

d= st_point(c(4,4*sqrt(3)))

e= st_point(c(0,4*sqrt(3)))

f= st_point(c(-2,2*sqrt(3)))

multip= st_multipoint(c(a,b,c,d,e,f))

plot(multip)




#3.2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

install.packages("tibble")
library(sf)
lagos<-st_read("/cloud/project/data_eva2/Lagos")



# a. (5pts) tipo de geometria
print(lagos)

st_geometry(lagos)
#Multipoligono

#b. (5pts) dimensión de los puntos
dim(lagos)
# XY


#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)

cat(crs(lagos))
# WGS 84 / UTM zone 19S
#DATUM["World Geodetic System 1984"


#d. (5pts) cantidad de variables y observaciones

dim(lagos)
#2067 variables y   22 observaciones 

#e. (5pts) extensión
ext(lagos)
# 16712.9393999996, 697838.4798, 3870127.723, 8051367.3989 (xmin, xmax, ymin, ymax)



#3. Con la capa de Inventario Lagos realice lo siguiente:
 # a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
lagos_stgo<- lagos[lagos$PROVINCIA == "Santiago",]

#34 lagos

 # b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

lagos_stgo<-st_transform(lagos_stgo,4326)
cat(crs(lagos_stgo))

#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

plot(lagos_stgo$AREA_KM2)

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

lago_primero<-lagos_stgo[1,] 

lago_primero_simp=st_simplify(lago_primero,dTolerance = 30)

plot(lago_primero_simp)





#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
aguas<- st_read("/cloud/project/data_eva2/Indice_Calidad_de_Aguas")

# a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.
#¿Cuántas puntos hay?
romeral<-aguas[aguas$NOM_COM == "ROMERAL",]
plot(romeral$geometry)
# 3 puntos

#  b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .

calag_rom_buf<- st_buffer(romeral,dist = 1000)
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
calag_rom_buf
c<-calag_rom_buf[1:5,]
names(c)

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre
#calidad_agua_romeral_buffer_1000m


st_write(calag_rom_buf,"/cloud/project/data_eva2/Indice_Calidad_de_Aguas/calidad_agua_romeral_buffer_1000m.gpkg",append = TRUE)




#4. Raster 
install.packages("terra")
library(terra)

#4.1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’(ymin) y 37°30’(ymax) de latitud
#Sur; y 71°50’(xmin) y 70°15’(xmax) de longitud Oeste. El sistema de referencia de coordenadas debe ser
#coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes
#valores:
# - Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50



r41 <- rast(ymax=-70.25000,ymin=-71.66667, xmax = -35.33333,xmin=-37.50000, crs='EPSG:4326', nrow=4,ncol=4)

values(r41)<- c(9,6,4,1,10,25,NA,2,5, 10, 15, 25,100, 5, 30, 50)

plot(r41)
text(r41)
print(r41)

#2. (15pts) Considere el siguiente raster:

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

 
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso
#19 Sur datum WGS84.



#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.


#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .



#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de
#la pregunta 2. Utilice una función de {terra} .

promedio <- mean(r, na.rm = TRUE)
mediana <- median(r, na.rm = TRUE)
desviacion_estandar <- sd(r, na.rm = FALSE)

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
 # a. (5pts) clase del objeto
#b. (5pts) número de columnas, filas y capas
#c. (5pts) resolución espacial
#d. (5pts) sistema de referencia de coordenadas
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.

dem_chile<-
