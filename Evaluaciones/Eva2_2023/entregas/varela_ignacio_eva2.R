#EVALUACIÓN
install.packages('sf')
library(sf)

#1. **Uso de R como un Sistema de Información Geográfica (SIG):**
  #En los sistemas de informacion geografica el uso de paquetes especializados como 'sf', 'raster' Estos  permiten la lectura, modificacion y visualización de datos geoespaciales ya sea de tipo vectorial/raster. Incluso R le ofrece capacidades estadísticas y de modelado que se pueden aplicar directamente a estos datos espaciales.

#2.  (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
  
  # Para datos vectoriales: En R, los objetos de clase 'sf' (simple features) se utilizan para representar datos geoespaciales vectoriales. Pueden contener información como puntos, líneas o polígonos, multipunto, mulitipoligono, multilinea junto con atributos asociados.
 #Para datos raster: Los objetos de clase `Raster` del paquete 'raster' se emplean para representar datos raster. Estos pueden contener información continua o discreta.

#3.  (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .
#El paquete 'sf' muchas geometrias
#Puntos (`POINT`)
#MULTIPUNTO
#Líneas (`LINESTRING`)
#Multilinea
#Polígonos (`POLYGON`)
#Multipoligono
#Colecciones de geometrías (`GEOMETRY`)

#4. **Objetos de clase `sf`:**
  #Los objetos de clase `sf` representan datos espaciales vectoriales y contienen información geométrica y atributos asociados. Pueden contener una variedad de geometrías (puntos, líneas, polígonos, multilinea, multipunto e incluso multipoligono), estos se pueden manipular fácilmente con funciones proporcionadas por el paquete 'sf', como la realización de operaciones espaciales y la visualización de mapas. Los objetos de clase 'sf' son compatibles con la mayoría de las funciones de análisis espacial y estadístico en R.

  
  
#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

# Coordenadas de los puntos A, B, C, D, E, F

coords <- matrix(c(0, 4, 6, 4, 0, -2, 0,
                   0, 0, 2 * sqrt(3), 4 * sqrt(3), 4 * sqrt(3), 2 * sqrt(3), 0),
                 ncol = 2, byrow = TRUE)
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol) 


#2 Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

install.packages('sf')
library(sf)

getwd()
i_lagos <- st_read('../I_Lagos/Inventario_Lagos.shp')

#a(5pts) tipo de geometria
i_lagos$geometry
#Es Multipoligono

#b(5pts) dimensión de los puntos
dim(i_lagos) 2067 puntos y 22 columns


#c(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(i_lagos,describe=TRUE)                                               
st_crs(i_lagos,describe=TRUE)$epsg 
st_crs(i_lagos,describe=TRUE)$datum

#Es un datum WGS84/UTM ZONE 19S
#Es proyectada
#HUSO 19
#Codigo 32719

#d. (5pts) cantidad de variables y observaciones

ncol(i_lagos) #variables
nrow(i_lagos) #observaciones

#e. (5pts) extensión


#3. Con la capa de Inventario Lagos realice lo siguiente:
getwd()
i_lagos <- st_read('../I_Lagos/Inventario_Lagos.shp')
names(i_lagos)
unique((i_lagos$PROVINCIA))


#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a unobjeto lagos_stgo .¿Cuántos son?

lagos_stgo <- i_lagos[i_lagos$PROVINCIA == "Santiago" ,]
lagos_stgo
nrow(lagos_stgo) #SON 34 LAGOS

#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.



st_crs <- 4326 #ASISGNADO
lagos_stgo_4326<- st_transform(lagos_stgo,4326) #PROYECTANDO
lagos_stgo_4326
st_crs(lagos_stgo_4326)


#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

plot(lagos_stgo_4326)

plot(lagos_stgo_4326["AREA_KM2"], main = "Variación del Área de Lagos en Santiago", col = "red")


#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerandouna tolerancia de 30m. Haga un plot de la geometría original y simplificada.

#slecciona el primer lago : 
primer_lago <- lagos_stgo[1, ]
plot(primer_lago)
str(primer_lago)

#PARA SIMFLIFICARLO SE USA LA FUNCION St_SIMPLIFY
lago_simplificado <- st_simplify(primer_lago, dTolerance = 30)

par(mfrow = c(1, 2))  # Configura el diseño para mostrar dos gráficos en una fila

plot(primer_lago, main = "Geometría Original", col = "blue", border = "black")
plot(lago_simplificado, main = "Geometría Simplificada", col = "red", border = "black")






#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
install.packages('sf')
library(sf)

Indice_Agua <- st_read('../I_Calidad_agua/ICA_Indice_Calidad_Aguas.shp')

#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?

unique(Indice_Agua$NOM_COM)
c_romeral <- Indice_Agua[Indice_Agua$NOM_COM == "ROMERAL" ,]
c_romeral
ncol(c_romeral)
nrow(c_romeral) #SON 27x3-> 81
plot(c_romeral)

puntos <- st_geometry(shp[st_geometry_type(c_romeral ) == "POINT", ])



  
#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral yasignelo al objeto calag_rom_buf .

calag_rom_buf <- st_buffer(c_romeral,1000)
calag_rom_buf
plot(calag_rom_buf$geometry)



#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
names(calag_rom_buf)[1:5]

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
  

st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")







###RASTER###
install.packages('terra')
library(terra)

#(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur;71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientesvalores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50


#RESPUESTA
latitud_sur <- 35 + 20/60
latitud_norte <- 37 + 30/60
longitud_oeste <- -71 - 50/60
longitud_este <- -70 - 15/60


num_filas <- 4
num_columnas <- 4

r <- raster(matrix(NA, nrow = num_filas, ncol = num_columnas),
            xmn = longitud_oeste, xmx = longitud_este,
            ymn = latitud_sur, ymx = latitud_norte,
            crs = "+proj=longlat +datum=WGS84")

valores_filas <- list(c(9, 6, 4, 1), c(10, 25, NA, 2), c(5, 10, 15, 25), c(100, 5, 30, 50))

# Asigna los valores
for (i in 1:num_filas) {
  r[i,] <- valores_filas[[i]]
}

print(r)
plot(r)
text(r)



# 2. (15pts) Considere el siguiente raster:

r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

# Transformacion
utm_epsg <- "+proj=utm +zone=19 +south +datum=WGS84 +units=m +no_defs"

r_utm <- projectRaster(r, crs = utm_epsg)
crs(r_utm)


#3 (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen10 y se calcule la raiz cuadrada a cada pixel.

r2_sqrt <- sqrt(r+10)

plot(r2_sqrt)
text(r2_sqrt)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se lecambie los valores que son menores que 46 y mayores que 54, por el valor NA .

#raster pregunta 2
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r)
text(r)

rmod <- raster(r)
a <- rmod < 46 | rmod > 54
a
a <- NA
plot(a)
text(a)


#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster dela pregunta 2. Utilice una función de {terra} .
#raster pregunta 2
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r)
text(r)

summary(r)
mean(r)
median(r)
sd(r)


#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
getwd()
dem_chile <- rast('../project/dem_chile.tif')
dem_chile
plot(dem_chile)
#a. (5pts) clase del objeto
class(dem_chile)
#b. (5pts) número de columnas, filas y capas
ncol(dem_chile) 
nrow(dem_chile) 
nlyr(dem_chile)
#c. (5pts) resolución espacial
res(dem_chile)
#d. (5pts) sistema de referencia de coordenadas
crs(dem_chile)
crs(dem_chile,describe=TRUE)
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco.
getwd()
inMemory(dem_chile)
#NOS DA FLASO, OSEA QUE NO SE ENCUENTRA EN LA MEMORIA, SI EN EL DISCO


#e. (15pts) cuál es la elevación máxima y mínima

max(dem_chile)
min(dem_chile)


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

install.packages('terra')
library(terra)


copiapo <- rast('../project/imagen_copiapo.tif')
plot(copiapo)

#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
names(copiapo) # nombre de las capas
library(terra)
r_suma <- copiapo[[1]] + copiapo[[2]] + copiapo[[3]] + copiapo[[4]]
r_suma
plot(r_suma)

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(copiapo)
copiapo_4326 <- project(copiapo,4326)


crs_nuevo <- "+proj=longlat +datum=WGS84"

# Transformamos el sistema de referencia de cordenadas al nuevo
raster_nuevosrc <- projectRaster(raster_copibrk, crs = crs_nuevo)



#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizandolas tres primeras capas.


# Cargar el archivo GeoTIFF en un objeto raster brick

raster_guardar <- brick(ruta_archivo2)

# Seleccionar la primera capa
primeracapa <- raster_guardar[[1]]

# Guardar la primera capa en un nuevo archivo GeoTIFF
writeRaster(primeracapa, "copiapo_capa1.tif", format = "GTiff", overwrite = TRUE)


#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

primera_capa <- copiapo[[1]]
primera_capa
writeRaster(primera_capa,'copiapo_capa1.tif')

