# Conceptos

#1.(10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#R es un sistema completo para hacer diversas funciones, desde preparar presentaciones hasta ser utilizado para la creación de mapas, o generar gráficos que nos ayuden a comprender la complejidad de el área de una zona, al usar la función plot podemos graficar funciones que nos muestren como en una zona en partícular, así como obtener histogramas, graficos de distribución, entre otras, uno de los paquetes más comunes y poderosos para trabajar con datos geoespaciales en R es sf

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#En R, para trabajar con datos geoespaciales, especialmente en el ámbito de datos vectoriales y rasters, se utilizan clases de objetos específicas proporcionadas por el paquete sf para datos vectoriales y por el paquete raster para datos raster. 
#el raster se obtiene a partir de una matriz que contiene los valores de cada celda.los objetos son data.frame o tibbles.

#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete `{sf}`.

#point,multipoint,multilinestring,linestring,polygon,multipolygon,

#4. (10pts) Describa los objetos de clase sf

#simple feautures,talescomo listas, matrices, vectores.se refieren a datos espacial y temporal.

#Vectoriales
install.packages('sf')
library(sf)
#1(20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
numero<-3
rc<-sqrt(numero)
rc
coords<-matrix(c(
  c(0,0),
  c(4,0),
  c(6,2,rc),
  c(4,4,rc),
  c(0,4,rc),
  c(-2,2,rc)
),ncol=2,byrow=TRUE)

pentagono<-st_polygon(list(coords))
pentagono_sf<-st_sf(geometry=st_sfc(pentagono),crs=4326)
plot(pentagono_sf,col="lightblue",main="Pentágono")

install.packages("tibble")

#2Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
capa_lagos<-read_sf('data_eva2/Lagos/Inventario_Lagos.shp')
lagos_stgo <- capa_lagos[inven_lagos$
                           
                           PROVINCIA == "Santiago", ]
#(5pts) tipo de geometria
class(capa1$geometry)
#(5pts) dimensión de los puntos

#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(capa1)$epsg

#(5pts) cantidad de variables y observaciones
#observaciones y variables
print(capa1)

#(5pts) extensión
#3.Con la capa de Inventario Lagos realice lo siguiente:

#a.(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?
lagos_stgo<-capa_lagos[capa_lagos$PROVINCIA=="Santiago"),]
#hay 34 lagos
#b.  (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
lagos_stgo<-st_set_crs(emas_sf, 4326)
#c.(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo[, c(2, 22)], main = "Variación de la variable área (AREA_KM2)")
#d.(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
lagos_stgo_sim30<- lagos_stgo[1,]
lagos_stgo_sim30<-st_simplify(lagos_stgo,dTolerance=30)
plot(lagos_stgo_sim30$geometry)
par(mfrow = c(1,2))

plot(lagos_stgo_sim30$geometry, main = "Geometria simplificada tolerancia 30m")

plot(lagos_stgo[1, 22], main = "Geometria original")

#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
capa_agua<-read_sf('data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp')  

#a.(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
obs_comun <- capa_agua[capa_agua$NOM_COM=="Romeral"),] 
#b.(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.
calag_rom_buf<-st_buffer(obs_comun,1000)
#c.(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
colnames(calag_rom_buf)[1:5]
#d.(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf,'calidad_agua_romeral_buffer_1000m.gpkg',append = TRUE)

#4.Raster
#(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#-Fila 1: 9, 6, 4, 1
#-Fila 2: 10, 25, NA, 2
#-Fila 3: 5, 10, 15, 25
#-Fila 4: 100, 5, 30, 50

# install.packages("terra")
install.packages("terra")
library(terra)

# Definir las coordenadas y el sistema de referencia del nuevo raster
ext <- c(-71.50, -70.15, -37.50, -35.33333)
res <- c((ext[2] - ext[1]) / 4, (ext[4] - ext[3]) / 4)
crs <- "+proj=longlat +datum=WGS84"

# Crear el raster de 4 filas y 4 columnas
raster_nuevo <- rast(nrows = 4, ncols = 4, ext = ext, res = res, crs = crs)

# Asignar los valores a las filas del raster
values(raster_nuevo) <- matrix(c(9, 6, 4, 1, 10, 25, NA, 2, 5, 10, 15, 25, 100, 5, 30, 50), nrow = 4, byrow = TRUE)

# Mostrar el nuevo raster
plot(raster_nuevo)
text(raster_nuevo)

#(15pts) Considere el siguiente raster:
library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

# Se define el nuevo sistema de referencia de coordenadas (UTM Huso 19 Sur)
utm_crs <- crs("+proj=utm +zone=19 +south +datum=WGS84")

# Imprimir  el raster al nuevo sistema de referencia asignandolo al nombre r_utm
r_utm <- project(r, utm_crs)

# Mostrar el raster luego de la transformación
plot(r_utm) #lo imprimimos
text(r_utm, col="pink", cex=0.8, pos=1) #le agregamos texto

#3.(20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
# Sumar 10 a cada pixel del raster original utilizado en la pregunta anterior
r_sumado <- r + 10

# Calcular la raíz cuadrada de cada pixel
r_raiz <- sqrt(r_sumado)

# Mostrar el raster original y los resultados con la funcion par que permite modificar el tamaño de los símbolos, nombres de los ejes, marcas de los ejes y títulos.
par(mfrow=c(1, 3)) #Utilizando mfrow que nos ayuda a dividir en forma de matriz
plot(r, main="Raster Original") #Utilizando la funcion main que modifica el tamaño de las marcas en ejes
text(r, col="red", cex=0.8, pos=1)

plot(r_sumado, main="Raster Sumado a 10")
text(r_sumado, col="blue", cex=0.8, pos=1)

plot(r_raiz, main="Raíz Cuadrada del Raster Sumado")
text(r_raiz, col="black", cex=0.8, pos=1)

#4.(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

# ocupando el mismo raster de la pregunta 2
r <- rast(x=matrix(1:16*5, 4, byrow=FALSE), crs="EPSG:4326")

# Mostrar el raster original ocupando las mismas funciones que en la pregunta anterior
plot(r)
text(r, col="red", cex=0.8, pos=1)

# Crear un nuevo raster con valores NA donde el valor original es menor que 46 o mayor que 54
r_nuevo <- r
r_nuevo[r_nuevo < 46 | r_nuevo > 54] <- NA #r_nuevo nos muestra que la min y maxima es  50 min value   :    50  max value   :    50

# Mostrar el raster modificado donde podemos ver que solo hay un valor
plot(r_nuevo)

#5.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

# Ocupando el mismo raster de la pregunta 2
r <- rast(x=matrix(1:16*5, 4, byrow=FALSE), crs="EPSG:4326")

# Mostrar el raster original ocupando las mismas funciones que en la pregunta anterior
plot(r)
text(r, col="red", cex=0.8, pos=1)

# Calcular el resumen estadístico del raster original con la funcion terra
resumen_original <- terra::summary(r)

#calcular promedio


#calcular mediana
#Median :42.50  
#5.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

#6.Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
dem_chile <- rast("data_eva2/dem_chile.tif"
)
#a. (5pts) clase del objeto
class(dem_chile) # SpatRaster
#b.(5pts) número de columnas, filas y capas
dim(dem_chile) # 4656 1884    1
#c.(5pts) resolución espacial
res(dem_chile) # 0.008333333 0.008333333
#d.(5pts) sistema de referencia de coordenadas
crs(dem_chile) 
#e.(5pts) el archivo se encuentra almacenado en la memoria o en el disco.
#en la memoria y disco por ser raster
#e.(15pts) cuál es la elevación máxima y mínima

#7.Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
imagen <- rast("data_eva2/imagen_copiapo.tif")
# a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
imagen_sum <- sum(imagen)
#b.(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
imagen <- project(imagen, "EPSG:4326")
#c.(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
plotRGB(imagen[[1:3]])
#d.(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
writeRaster(imagen[[1]], "copiapo_capa1.tif")