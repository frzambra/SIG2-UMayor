#2.1.(10pts) Describa como puede utilizar el software R como un Sistema de InformaciónGeográfica.

# utilizandolo como un sistema de informacion geo. mediante el uso de paquetes especializados como `{sf}`, `{raster}`, y `{terra}` etc. Estos paquetes nos permiten la lectura, manipulación y visualización de datos geoespaciales. Además, R ofrece capacidades estadísticas y de modelado que se pueden aplicar directamente a datos espaciales.




#2.2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespacialesde tipo vectoriales y rasters.

# *Objetos para datos geoespaciales en R:* Para datos vectoriales: En R, los objetos de clase `sf` (Simple Features) se utilizan para representar datos geoespaciales vectoriales. Pueden contener información como puntos, líneas o polígonos junto con atributos asociados. Para datos raster: Los objetos de clase `Raster` del paquete `{raster}` se emplean para representar datos raster. Estos pueden contener información continua o discreta distribuida en una cuadrícula.




#2.3. (10pts) Liste los tipos degeometrias que se pueden trabajar con el paquete {sf} 

#*- Puntos (POINT)
# Líneas (`LINESTRING`)
# Polígonos (`POLYGON`)
# Colecciones de geometrías (`GEOMETRY`)
# multipoint 
#multylinestring
#multypoligonos



# 2.4. (10pts) Describa los objetos de clase sf 

# **Objetos de clase `sf` representan datos espaciales vectoriales y contienen información geométrica y atributos asociadoos objetos de clase `sf`s. Pueden contener una variedad de geometrías (puntos, líneas, polígonos) y se pueden manipular fácilmente con funciones proporcionadas por el paquete `{sf}`, como la realización de operaciones espaciales y la visualización de mapas. Los objetos de clase `sf` son compatibles con la mayoría de las funciones de análisis espacial y estadístico en R.


#3.1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y 


# Coordenadas de los puntos A, B, C, D, E, F
coords <- matrix(c(0, 4, 6, 4, 0, -2, 0,
                   0, 0, 2 * sqrt(3), 4 * sqrt(3), 4 * sqrt(3), 2 * sqrt(3), 0),
                 ncol = 2, byrow = TRUE)
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol) 







#3.2 2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :a. (5pts) tipo de geometriab. (5pts) dimensión de los puntosc. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso sicorresponde y código EPSG)d. (5pts) cantidad de variables y observacionese. (5pts) extensión

install.packages('tibble')
library('tibble')
install.packages('sf')
library('sf')


dire <- "/cloud/project/data/data_eva2/lagos/"
files <- list.files(dire,pattern = 'shp$',full.names = TRUE,recursive = TRUE)

inv_lagos<- st_read('Inventario_Lagos.shp')

#a. (5pts) tipo de geometria
inv_lagos$geometry
#MULTYPOLYGON

#b. (5pts) dimensión de los puntos
dim(inv_lagos)
# 2067   22


#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso sicorresponde y código EPSG)
st_crs(inv_lagos)
#WGS 84 / UTM zone 19S / EPSG",32719 / proyectado



#d. (5pts) cantidad de variables y observaciones

str(inv_lagos)
#2067 obs. of  22 variables 

#e. (5pts) extensión

extencion<- st_bbox(inv_lagos)
#16712.94 3870127.72  697838.48 8051367.40 

#3.3 Con la capa de Inventario Lagos realice lo siguiente:

 #a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?

provi<-unique(inv_lagos$PROVINCIA)


lagos_stgo <- inv_lagos[inv_lagos$PROVINCIA == "Santiago" ,]
lagos_stgo




#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo aSRC EPSG 4326 y reemplázelo.


Nuevosrc <- st_transform(lagos_stgo,4326)
st_crs(lagos_stgo)





#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variableárea (AREA_KM2)

plot(lagos_stgo)

plot(lagos_stgo["AREA_KM2"], main = "Variación del Área de Lagos en Santiago", col = "green")



#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerandouna tolerancia de 30m. Haga un plot de la geometría original y simplificada.



primer_lago <- lagos_stgo[1, ]
plot(primer_lago)
str(primer_lago)


lago_simplificado <- st_simplify(primer_lago, dTolerance = 30)

par(mfrow = c(1, 2))  # Configura el diseño para mostrar dos gráficos en una fila

plot(primer_lago, main = "Geometría Original", col = "red", border = "green")
plot(lago_simplificado, main = "Geometría Simplificada", col = "blue", border = "green")





#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

dire <- "/cloud/project/data/data_eva2/Indice_Calidad_de_Aguas/"

indcalag<- st_read('ICA_Indice_Calidad_Aguas.shp')



#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

romeral <- ica[ica$NOM_COM %in% c("ROMERAL"),]
romeral
str(romeral)
#3 puntos

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .

calag_rom_buf <- st_buffer(romeral,1000)
calag_rom_buf
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .

names(calag_rom_buf)[1:5]


#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombrecalidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")







############4 Raster############

# 1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe sercoordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientesvalores:- Fila 1: 9, 6, 4, 1- Fila 2: 10, 25, NA, 2- Fila 3: 5, 10, 15, 25- Fila 4: 100, 5, 30, 50
install.packages('terra')
library('terra')

#LONGITUDES EN X, LATITUDES EN Y AL DIVIDIR POR 60.
#- Fila 1: 9, 6, 4, 1- Fila 2: 10, 25, NA, 2- Fila 3: 5, 10, 15, 25- Fila 4: 100, 5, 30, 50

if (!requireNamespace("raster", quietly = TRUE)) {
  install.packages("raster")
}
library(raster)

xmin <- -71.50
xmax <- -70.15
ymin <- -37.50
ymax <- -35.3333
rows <- 4
cols <- 4

ext <- extent(xmin, xmax, ymin, ymax)

r <- raster(ext, nrow=rows, ncol=cols)

projection(r) <- CRS("+proj=longlat +datum=WGS84")

valores <- matrix(c(
  9, 6, 4, 1,
  10, 25, NA, 2,
  5, 10, 15, 25,
  100, 5, 30, 50
), nrow=rows, byrow=TRUE)

r[] <- valores

writeRaster(r, "output_raster.tif", format="GTiff", overwrite=TRUE)

plot(r)
text(r)


#2. (15pts) Considere el siguiente raster:4 Raster
library(terra)

#este es el entregado
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84

r <- raster(matrix(1:16*5, 4, byrow = FALSE))
crs(r) <- "+proj=longlat +datum=WGS84"

r_nuevo <- projectRaster(r, crs="+proj=utm +zone=19 +south +datum=WGS84")

st_crs(r_nuevo)





#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen10 y se calcule la raiz cuadrada a cada pixel.


r2_sqrt <- sqrt(r_nuevo+10)

plot(r2_sqrt)
text(r2_sqrt)


#4  (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA

#raster pregunta 2
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r)
text(r)

rmagic <- raster(r)
rmagic[rmagic < 46 | rmagic > 54] <- NA

plot(rmagic)
text(rmagic)


#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster dela pregunta 2. Utilice una función de {terra} 

#raster preguna 2
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")

promedio <- terra::mean(r, na.rm = TRUE)
mediana <- terra::median(r, na.rm = TRUE)
desviacion_estandar <- terra::sd(r, na.rm = TRUE)


#6 Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

ruta_archivo <- "/cloud/project/data/data_eva2/dem_chile.tif"

raster_demch <- raster(ruta_archivo)

plot(raster_demch)


#a. (5pts) clase del objeto

class(raster_demch)

#b. (5pts) número de columnas, filas y capas
ncol(raster_demch)  #columnas 1884
nrow(raster_demch) # filas 4656
nlyr(raster_demch) 

str(raster_demch)




#c. (5pts) resolución espacial

res(raster_demch) #resolucion espacial=  0.008333333 0.008333333



#d. (5pts) sistema de referencia de coordenadas
crs(raster_demch)  # WGS84 / EPSG",9122





#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.

ruta_archivo <- "/cloud/project/data/data_eva2/dem_chile.tif"

raster_demch <- raster(ruta_archivo)

#utilizamos esta funcion para saber si es archivo esta en la memoria , de nos ser asi al aplicar la funcion print nos dira que se encuentra en el disco como es ese caso
if (is(raster_demch, "RasterBrick")) {
  print("El objeto raster está almacenado en la memoria.")
} else {
  print("El objeto raster está almacenado en el disco.")}


#e. (15pts) cuál es la elevación máxima y mínima

ruta_archivo <- "/cloud/project/data/data_eva2/dem_chile.tif"

raster_demch <- raster(ruta_archivo)

elevmax <- maxValue(raster_demch)
elevmax # elevacion maxima es de 6414m
elevmin<- minValue(raster_demch)
elevmin  #la elevacion minima es de -256m





#7 Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

ruta_archivo2 <- "/cloud/project/data/data_eva2/imagen_copiapo.tif"

raster_copi <- raster(ruta_archivo2)

plot(raster_copi)




# desde aqui comenzo a sufrir fallas rstudio cloud :(

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.

ruta_archivo2 <- "/cloud/project/data/data_eva2/imagen_copiapo.tif"

raster_copibrk <- raster(ruta_archivo2)

# Suma de las capas
raster_suma <- sum(raster_copibrk)

print(raster_suma)




#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

ruta_archivo2 <- "/cloud/project/data/data_eva2/imagen_copiapo.tif"

raster_copibrk <- raster(ruta_archivo2)

crs_nuevo <- "+proj=longlat +datum=WGS84"

# Transformamos el sistema de referencia de cordenadas al nuevo
raster_nuevosrc <- projectRaster(raster_copibrk, crs = crs_nuevo)



#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizandolas tres primeras capas.


# Ruta al archivo GeoTIFF con cuatro capas
ruta_archivo2 <- "/cloud/project/data/data_eva2/imagen_copiapo.tif"

# Cargar el archivo GeoTIFF en un objeto raster brick
raster_rgb <- brick(ruta_archivo2)

# Seleccionar las tres primeras capas (R, G, B)
raster_enrgb <- raster_rgb[[1:3]]

# Visualizar la composición de color RGB
plotRGB(raster_enrgb, scale = 1, stretch = "lin", main = "COLOR RGB")




#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombrecopiapo_capa1.ti
raster_enrgb <- raster_rgb[[1]]

# Ruta al archivo GeoTIFF original
ruta_archivo2 <- "/cloud/project/data/data_eva2/imagen_copiapo.tif"

# Cargar el archivo GeoTIFF en un objeto raster brick

raster_guardar <- brick(ruta_archivo2)

# Seleccionar la primera capa
primeracapa <- raster_guardar[[1]]

# Guardar la primera capa en un nuevo archivo GeoTIFF
writeRaster(primeracapa, "copiapo_capa1.tif", format = "GTiff", overwrite = TRUE)









