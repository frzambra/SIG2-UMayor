install.packages('raster')
install.packages('sf')
library(raster)
library(sf)
#1.Describa como puede utilizar el software R como un Sistema de Información Geográfica.
#R al ser un lenguaje de programación y su entorno de software ampliamente utilizado en estadísticas y análisis de datos,se puede utilizar paquetes específicos para el análisis espacial y la manipulación de datos que sean geográficos. El paquete más conocido para trabajar con datos geoespaciales en R es sf, el cual se usa para analisis de datos raster y vectoriales.

#2.Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.
#En R, los paquetes sf y raster se utilizan para trabajar con objetos geoespaciales de tipo vectorial y raster. Estos paquetes introducen clases específicas de objetos que facilitan la manipulación y el análisis de datos geoespaciales.

#3.Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.
#los tipos de geometria que se pueden trabajar en R con el paquete sf son los puntos, linea, poligono y las coleccion de geometrias como multilinea, multipunto y multipoligono.

#4.Describa los objetos de clase sf.
#los objetos de clase sf se utilizan para representar datos geoespaciales vectoriales. La clase sf es una extensión del objeto data.frame de R, enriquecida con información geométrica que permite trabajar con datos espaciales de manera eficiente.
#geometria: un objeto sf que almacena la información geométrica asociada con cada observación. Puede contener puntos, líneas, polígonos u otras geometrías más complejas, SCR: el sistema de referencia de coordenadas (CRS). El CRS especifica cómo se interpretan las coordenadas espaciales y es fundamental para realizar operaciones espaciales correctamente, un objeto sf también incluye un data.frame que almacena atributos asociados a cada geometría. Los atributos representan información no espacial sobre cada observación y se almacenan en las columnas del data.frame.


#vectorial
#1(20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
#a (0,0)
#b(4,0)
#c(6, 2*sqrt 3)
#d(4, 4*sqrt 3)
#e(0, 4*sqrt 3)
#f(-2, 2*sqrt 3)

#a(0,0) b(4,0) c(6,2√3) d(4,4√3) e(0,4√3) f(-2,2√3) p(2,2√3)

df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol)                  


#2.Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
inventario_lagos<- read_sf("/cloud/project/data/Inventario_Lagos.shp")
#(5pts) tipo de geometria
st_geometry_type(inventario_lagos)
#(5pts) dimensión de los puntos #xy
dim(inventario_lagos) 
#(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
st_crs(inventario_lagos) #EPSG 32719 WGS84 UTM sone 19s
#(5pts) cantidad de variables y observaciones
str(inventario_lagos) #2067 y 22obs
#(5pts) extensión  SpatExtent : 16712.9393999996, 697838.4798, 3870127.723, 8051367.3989 (xmin, xmax, ymin, ymax)
ext(inventario_lagos)

#3.Con la capa de Inventario Lagos realice lo siguiente:
inventario_lagos<- read_sf("/cloud/project/data/Inventario_Lagos.shp")
#(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son? #34 lagos
lagos_stgo<- inventario_lagos[inventario_lagos$PROVINCIA== 'Santiago',]
lagos_stgo
str(lagos_stgo)
lagos_stgo<- nrow(lagos_stgo)
lagos_stgo
#(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.
st_crs(inventario_lagos)
st_crs(lagos_stgo)
lagos_stgo4326<- st_transform(lagos_stgo,crs = "epsg:4326")
st_crs(lagos_stgo4326)
#(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_stgo$AREA_KM2,col='red' ,add=TRUE )

#(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
primer_lago <- lagos_stgo[1, ]
simplificado<- st_simplify(primer_lago, dTolerance = 30)

par(mfrow = c(1, 2))
plot(primer_lago, main = "Geometría Original", col = "blue",max.plot = 21)
plot(simplificado, main = "Geometría Simplificada", col = "red")


#4.Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
indice_calidad<- read_sf("/cloud/project/data/ICA_Indice_Calidad_Aguas.shp")
#(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”.
#¿Cuántas puntos hay? 3 obs
Indice_Romeral<-indice_calidad[indice_calidad$NOM_COM %in% c("ROMERAL"),]
Indice_Romeral
str(Indice_Romeral)

#(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.
calag_rom_buf<- st_buffer(comuna_romeral,1000)
calag_rom_buf
#(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
names(calag_rom_buf)[1:5]

#(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m
st_write(calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")

#5.Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:

Fila1<-c(9, 6, 4, 1)
Fila2<-c(10, 25, NA, 2)
Fila3<- c(5, 10, 15, 25)
Fila4<- c(100, 5, 30, 50)

r<- rast(xmax=-70.25,xmin=-71.83333,ymax=-35.33333,ymin= -37.5,nrow=4,ncol=4, crs='EPSG:4326')
r
values(r)<-matrix(c(Fila1, Fila2, Fila3, Fila4), nrow = 4, byrow = TRUE)

#latitud
#20/60+35max
#30/60+37min 
#longitud
#50/60+71min 
#15/60+70max

#2.Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
library(terra)
r2<- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r2)
text(r2)

#2.Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.
crs(r2)<- "EPSG:32719"
crs(r2)
cat(crs(r2))

#3.Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.
nuevoraster <- sqrt(r2+10)
nuevoraster
plot(nuevoraster)
text(nuevoraster,digits=2)

#4.Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

nuevoraster2<- r2
nuevoraster2[nuevoraster2 < 46 | nuevoraster2 > 54] <- NA
nuevoraster2
#5.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la prgunta 2. Utilice una función de {terra}.
?global
op<- global(r2,c("sum","mean","sd"),na.rm=TRUE)
op
#   sum mean       sd
#lyr.1 680 42.5 23.80476

demchile<- rast('/cloud/project/dem_chile.tif')
demchile
#(5pts) clase del objeto, Terra 
class(demchile)
#(5pts) número de columnas, filas y capas
dim(demchile) #4656 1884    1
#(5pts) resolución espacial
res(demchile) #0.008333333 0.008333333
#(5pts) sistema de referencia de coordenadas
st_crs(demchile) #["EPSG",4326]]
#(5pts) el archivo se encuentra almacenado en la memoria o en el disco. se encuentra en el disco 
inMemory(demchile)
#(15pts) cuál es la elevación máxima y mínima: SpatExtent : -56.1, -17.3 
elevaciondem <- range(values(dem_chile), na.rm = TRUE)

print(paste("Elevación Máxima:", max(elevaciondem)))
print(paste("Elevación Mínima:", min(elevaciondem)))



#Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:
imagencopiapo<-rast('/cloud/project/imagen_copiapo.tif')
str(imagencopiapo)
#(15pts) cree un raster que corresponda a la suma de las cuatro capas.
cuatrocapas<- sum(imagencopiapo)
cuatrocapas

#(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
st_crs(imagencopiapo)
imagencopiapo4326<- st_transform(imagencopiapo,crs = "epsg:4326")
#(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
plotRGB(imagen_copiapo[[1:3]])
#(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
capa1 <- imagencopiapo[[1]]
writeRaster(capa1, filename = '/cloud/project/copiapo_capa1.tif', format = 'GTiff', overwrite = TRUE)