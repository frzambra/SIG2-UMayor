#Constanza Araya
#Evaluacion 2
install.packages("sf")
library (sf)
#CONCEPTOS
#1. (10pts) Describa como puede utilizar el software R como un Sistema de InformaciónGeográfica.
#R se puede utitilizar para crear o manejar datos geoespaciales, a través de paquetes como sp, sf, raster, maptools, entre otros. Esto permite manipular, analizar y visualizar datos geoespaciales. Con estas herramientas, puedes realizar operaciones de lectura, escritura, análisis espacial y visualización. Además de utilizarlos como herramientas, tambien integrar datos geográficos con análisis estadísticos y de aprendizaje automático. También es posible conectar R con bases de datos espaciales y construir aplicaciones web interactivas que incluyan mapas y análisis geoespaciales.


#2. (10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespacialesde tipo vectoriales y rasters.

#Datos Raster: Para datos geoespaciales tipo raster (cuadriculados), se utilizan objetos de clase RasterLayer, RasterStack, RasterBrick (del paquete raster) o de clase stars (del paquete stars). Estos objetos representan datos distribuidos en una cuadrícula regular, como imágenes satelitales o mapas de cobertura.
#Datos Geoespaciales Vectoriales: En R, los datos geoespaciales vectoriales se representan mediante objetos de clases como SpatialPoints, SpatialLines, SpatialPolygons (del paquete sp) o sf (Simple Features), que pueden contener información sobre ubicaciones puntuales, líneas o polígonos respectivamente, con atributos asociados a cada geometría


#3. (10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf} .
st_linestring()
st_multilinestring()
st_polygon()
st_multipolygon()
st_point()
st_multipoint()

#4. (10pts) Describa los objetos de clase sf .
#En R los objetos sf son utilizados para representar datos geoespaciales, utilizados para trabajar con gemetrias de tipo punto, linea y poligono. Estos objetos pueden contener ciertos atributos asociados a cada geometria y se pueden utilizar para realizar analisis espacieales y representar visualmente en mapas. estos datos pueden ser modificados mediante R
#sf: la tabla (data.frame) con los atributos y geometría de la entidad , que contiene
#sfc : la list-colum con la geometría de cada entidad (registro), que está compuesto de
#sfg: la geometría de la entidad de cada simple feature individual

#VECTORIALES
#1. (20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol)   


#2. Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
lagos<-st_read("data/lagos")
#a. (5pts) tipo de geometria
st_geometry(lagos)

#b. (5pts) dimensión de los puntos
dim(lagos)

#c. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(lagos)

#d. (5pts) cantidad de variables y observaciones
#variables:27
#observaciones:512

#e. (5pts) extensión
ext(lagos)

#3. Con la capa de Inventario Lagos realice lo siguiente:
#a. (15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo . ¿Cuántos son?
lagos_stgo <- lagos[lagos$PROVINCIA %in% "Santiago",]# 9 observaciones
lagos_stgo


#b. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
lagos_stgo_4326<-st_transform(lagos_stgo,4326)

#c. (15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo["AREA_KM2"], col = "red")

#d. (20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
lago_1<-lagos_stgo[1,]##
lago_sim<-st_simplify(lago_1,dTolerance = 30)
plot(lago_1)
plot(lago_sim)


# Hacer un plot de la geometría original y simplificada
par(mfrow = c(1, 2))
plot(lago_1, main = "Geometría Original", col = "blue",max.plot = 21)
plot(lago_sim, main = "Geometría Simplificada", col = "red")



#4. Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
calidad_agua<-st_read("data/indice_calidad")
#a. (15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.¿Cuántas puntos hay?
romeral<-calidad_agua[calidad_agua$NOM_COM=="ROMERAL",] #hay 3
romeral

#b. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf .
calag_rom_buf<-st_buffer(romeral,1000)
plot(calag_rom_buf$geometry)

#c. (10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf .
calidad_5<-calag_rom_buf[,1:5]
#OBJECTID_1
#OBJECTID
#NOMBRE_APR
#NOMBRE_BNA
#COD_BNA

#d. (15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf,"data/calidad_agua_romeral_buffer_1000m.gpkg",append = TRUE) 


install.packages("terra")
library(terra)
#RASTER
#1. (30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitudSur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
71+50/60
70+15/60
35+20/60
37+30/60

r1<-rast(xmin=-71.83,xmax=-70.25,ymin=-37.5,ymax=-35.33,ncol=4,nrow=4,crs="EPSG:4326")
#- Fila 1: 9, 6, 4, 1
#- Fila 2: 10, 25, NA, 2
#- Fila 3: 5, 10, 15, 25
#- Fila 4: 100, 5, 30, 50
values(r1)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)
plot(r1)
text(r1)
#2(15pts) Considere el siguiente raster:
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
crs(r)
plot(r);text(r)
#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso19 Sur datum WGS84.
crs(r)<-"EPSG:32719"
crs(r)

#3. (20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
nuevor <- sqrt(r+10)
nuevor
plot(nuevor)
text(nuevor,digits=2)

#4. (20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA .
r6 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

l <-  r6 < 46 | r6 > 54
plot(l); text(l)
r6[l]<- NA
plot(r6); text(r6)


#5. (20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra} .
?global
fun_3 <- global(r, c("sum", "mean", "sd"), na.rm=TRUE) 
fun_3


#6. Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
dem_chile<-rast("data/dem_chile.tif")
#a. (5pts) clase del objeto
class(dem_chile)
#b. (5pts) número de columnas, filas y capas
dim(dem_chile)
#c. (5pts) resolución espacial
res(dem_chile)
#d. (5pts) sistema de referencia de coordenadas
crs(dem_chile)
#e. (5pts) el archivo se encuentra almacenado en la memoria o en el disco
sources(dem_chile)
#EN EL DISCO

#e. (15pts) cuál es la elevación máxima y mínima
extension<-ext(dem_chile)

dem_chilerecorte<-crop(dem_chile,extension)


elevacion_maxima<-max(dem_chilerecorte)
elevacion_minima<-min(dem_chilerecorte)

elevacion_maxima
elevacion_minima

#min value   : -256 
#max value   : 6414


#7 Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente
imagen_copiapo<-rast("data/imagen_copiapo.tif")
dim(imagen_copiapo)
#a. (15pts) cree un raster que corresponda a la suma de las cuatro capas.
imagen_copiapo_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]

#b. (10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
crs(imagen_copiapo)
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)
#c. (10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)

#d. (15pts) guarde ( writeRaster ) la primera capa del raster con el nombre copiapo_capa1.tif
capa1 <- imagen_copiapo[[1]]
writeRaster(capa1,"data/copiapo_capa1.tif")

