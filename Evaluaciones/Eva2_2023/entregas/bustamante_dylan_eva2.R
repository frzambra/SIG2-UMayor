#evaluación 2 DYLAN BUSTAMANTE

install.packages("sf")
install.packages("tibble")
install.packages("terra")
install.packages("raster")
library(raster)
library(terra)
library(tibble)
library(sf)

#2.CONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOSCONCEPTOS

#1. (10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

# EL SOFTWARE DE R SE PUEDE UTILIZAR PARA REALIZAR ANALISIS ESPACIALES Y REPRESENTAR DATOS GEOGRAFICOS 

#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters .
 #SE PODRÍA UTILIZAR EL OBJETO SF, SP, RASTER ENTRE OTROS 

#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .

#polygon, multipolygon
#line, linestring, multilinestring
#point, multipoint
#entre otros más


#4. (10pts) Describa los objetos de clase sf .

#Este paquete ( simple feature) se usa con su mismo nombre (sf) y se puede utilizar para representar datos geoespaciales vectoriales 
#hay varios que se pueden utilizar 

# Crear un punto
#punto <- st_point

# Crear un objeto
#objeto_sf <- st_sf
  
# Crear una línea
#linea <- st_linestring

# Crear un polígono
#poligono <- st_polygon

# entre otros más 


# 3. VECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALESVECTORIALES

#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
  
#A(0,0)
#B(4,0)
#C(6,2√3)
#D(4,4√3)
#E(0,4√3)
#F(-2,2√3)

# Coordenadas de los puntos A, B, C, D, E, F
coords <- matrix(c(0, 4, 6, 4, 0, -2, 0,
                   0, 0, 2 * sqrt(3), 4 * sqrt(3), 4 * sqrt(3), 2 * sqrt(3), 0),
                 ncol = 2, byrow = TRUE)
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)

pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol) 

                  
#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :

getwd()

# Cargar la capa vectorial del Inventario Lagos
inventario_lagos <- st_read("Evaluaciones/Eva2_2023/data/Lagos/")
inventario_lagos3
# a. Tipo de geometría
tipo_geometria <- st_geometry_type(inventario_lagos)

tipo_geometria
# b. Dimensión de los puntos
dimension_puntos <- st_dimension(inventario_lagos)

dimension_puntos
# c. Sistema de referencia de coordenadas
sistema_referencia <- st_crs(inventario_lagos)

sistema_referencia
# d. Cantidad de variables y observaciones
cantidad_variables <- ncol(inventario_lagos)
cantidad_observaciones <- nrow(inventario_lagos)

cantidad_variables 
cantidad_observaciones

# e. Extensión
extension <- st_bbox(inventario_lagos)

extension 


#3. Con la capa de Inventario Lagos realice lo siguiente:

#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?


unique(inventario_lagos$COMUNA)
lagos_stgo <- inventario_lagos[inventario_lagos$PROVINCIA == "Santiago" ,]
lagos_stgo

cantidad_puntos_lagos_stgo <- nrow(lagos_stgo)
cantidad_puntos_lagos_stgo


#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

lagos_stgo
lagos_stgo <- st_transform(lagos_stgo,4326)

st_crs(lagos_stgo)


#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

plot(lagos_stgo)

plot(lagos_stgo["AREA_KM2"], main = "Variación del Área de Lagos en Santiago", col = "yellow")


#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.


# Seleccionar el primer lago
primer_lago <- lagos_stgo[1, ]

# Simplificar la geometría con una tolerancia de 30m
lago_simplificado <- st_simplify(primer_lago, dTolerance = 30)

# Plot de la geometría original y simplificada
par(mfrow = c(1, 2))
plot(primer_lago$geometry, main = "Geometría Original", col = "blue")
plot(lago_simplificado$geometry, main = "Geometría Simplificada", col = "pink")



#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

ICAS <- st_read("/cloud/project/data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")
 
unique(ICAS$NOM_COM)

str(ICAS)
# a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
    
  observaciones_romeral <- subset(ICAS, NOM_COM== "Romeral")
  cantidad_puntos_romeral <- nrow(observaciones_romeral)
  
  observaciones_romeral
  cantidad_puntos_romeral
  
# b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
  
  calag_rom_buf <- st_buffer(observaciones_romeral, dist = 1000)
  
#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
  
# Obtener los nombres de las cinco primeras variables
nombres_variables_calag_rom_buf <- names(calag_rom_buf)[1:5]

# Imprimir los nombres de las variables
print(nombres_variables_calag_rom_buf)

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

st_write(calag_rom_buf, "calidad_agua_romeral_buffer_1000m.gpkg")




# 4. RASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTERRASTER

# 1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50

r<-rast(xmin=-71.833,xmax=-70.25,
        ymin=-37.5,ymax=-35.333,
        nrows=4,ncol=4,
        crs="EPSG:4326")

values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)

r

#2. (15pts) Considere el siguiente raster:4 Raster


r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r2);text(r2)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84

r2 <- raster(matrix(1:16*5, 4, byrow = FALSE))
crs(r2) <- "+proj=longlat +datum=WGS84"

r2_nuevo <- projectRaster(r2, crs="+proj=utm +zone=19 +south +datum=WGS84")

st_crs(r2_nuevo)




#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

r2 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
r2 
dim(r)
# Sumar 10 a cada pixel del raster original
r2_sumado <- r2 + 10

# Calcular la raíz cuadrada de cada pixel del raster sumado
r2_raiz_cuadrada <- sqrt(r2_sumado)



#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .

# Cambiar los valores que son menores que 46 y mayores que 54 por NA

r2_nuevo <- rast(r2, cbind(-Inf, 46, NA, 46, 54, NA, 54, Inf, NA))

r2_nuevo
# Imprimir y graficar el nuevo raster
print(r2_nuevo)
plot(r2_nuevo)
text(r2_nuevo)

#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .

promedio <- mean(r2[], na.rm = TRUE)
promedio

mediana <- median(r2[], na.rm = TRUE)
mediana

desviacion_estandar <- sd(r2[], na.rm = TRUE)
desviacion_estandar

#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile <- raster("/cloud/project/data_eva2/dem_chile.tif")
dem_chile
# a. Clase del objeto
clase_objeto <- class(dem_chile)
#R: raster

# b. Número de columnas, filas y capas
num_columnas <- ncol(dem_chile)
num_filas <- nrow(dem_chile)
num_capas <- nlayers(dem_chile)

#R: Tiene 1884 columnas, 4656 filas, y 1 capa


# c. Resolución espacial
resolucion_espacial <- res(dem_chile)

#R:0.008333333 0.008333333

# d. Sistema de referencia de coordenadas
sistema_referencia <- crs(dem_chile)
print(paste("d. Sistema de referencia de coordenadas:", proj4string(sistema_referencia)))

#R: "EPSG",4326

# e. Almacenamiento en memoria o en disco
inMemory(dem_chile)

#R: Se almacena en disco 


#7. Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:


#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.

imagen_copiapo<-rast("/cloud/project/data_eva2/imagen_copiapo.tif")
imagen_copiapo_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)

#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.

mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif

capa1_copiapo<-imagen_copiapo[[1]]
dim(capa1_copiapo
    writeRaster(capa1_copiapo,'copiapo_capa1.tif')   
    


























