#prueba P2 17 noviembre
#Camila Fernández Carrasco.
####Los datos que utilizará para la evaluación son los siguientes:
  
  
#Indice Calidad de Aguas: datos de la Dirección General de Aguas (DGA) con ubicaciones de puntos de Agua Potable Rural (APR) con mediciones de índices de calidad de agua.


#Inventario Lagos: datos de la Dirección General de Aguas (DGA) con los lagos presentes en el territorio nacional.
#dem Chile: datos de elevación (metros) para el territorio de Chile continental.
#imagen Copiapo: imagen aérea capturada sobre una zona de la ciudad de Copiapo.

######2 Conceptos
install.packages("sf")
library(sf)
#1.(10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.


#R se puede utilizar como un Sistema de Información Geográfica (SIG) a través de paquetes como sf y raster especializados que ofrecen funcionalidades para la manipulación, análisis y visualización de datos geoespaciales. Para que funcionen las funciones adicionales de cada paquete se carga el library () para manejar los datos vectoriales que contiene cada uno.
#leer y guardar archivos,
#manipular y resumir datos
#correr modelos y test estadísticos
#crear elegantes gráficos

#2.(10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#En R, se utilizan dos clases principales de objetos para trabajar con datos geoespaciales: objetos de tipo vectorial y objetos de tipo raster. Estas clases son gestionadas principalmente por los paquetes sf (para objetos vectoriales) y raster (para objetos raster). 



#3.(10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.

#point
#Linestring
#Polygon
#multipoint
#multilinestring
#multipolygon
#4.
#sf: la tabla (data.frame) con los atributos y geometría de la entidad , que contiene
#sfc : la list-colum con la geometría de cada entidad (registro), que está compuesto de
#sfg: la geometría de la entidad de cada simple feature individual




#######3 vectoriales
#1.(20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:


# Definir las coordenadas de los puntos A, B, C, D, E y F
coordenadas <- matrix(c(c(0, 1, 1.5, 0.5, 0, 0),c(0, 0, 1, 1.5, 1, 0)), ncol = 6, byrow = TRUE)

# Crear un data frame con las coordenadas
pentagono_df <- data.frame(x = coordenadas[1, ], y = coordenadas[2, ])
list(pentagono_df)

pentagonosf<-st_polygon(list(pentagono_df))
# Crear un objeto sf con el pentágono
pentagono_sf <- st_polygon(list(pentagono_df))

# Visualizar el pentágono
plot(pentagono_sf, main = "Pentágono", col = "lightblue", border = "blue")

library(sf)

#1.(20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:
df_pol <- data.frame(x=c(0,4,6,4,0,-2),y=c(0,0,2*sqrt(3),4*sqrt(3),4*sqrt(3),2*sqrt(3)))
df_pol
dfp <- as.matrix(df_pol)
pol <- st_polygon(list(rbind(dfp,dfp[1,])))
plot(pol)   

plot(poligono)

#2.Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#a.(5pts) tipo de geometria
getwd()

inv_lago<-st_read("data_eva2/Lagos/Inventario_Lagos.shp")

#b.(5pts) dimensión de los puntos
dim(inv_lago)
st_geometry(inv_lago)
st_dimension(inv_lago)


#c.(10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)

st_crs(inv_lago)
st_crs(inv_lago,describe=TRUE)


#d.(5pts) cantidad de variables y observaciones
dim(inv_lago)

#e.(5pts) extensión
st_bbox(inv_lago)


#3.Con la capa de Inventario Lagos realice lo siguiente:

#a.(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

lagos_prov_santiago<-inv_lago[inv_lago$PROVINCIA=="Santiago",]


#b(10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

#crs actual
st_crs(inv_lago)
#crs nuevo
crs_nuevo<- st_crs("EPSG:4326")
# Transformar los datos
lagos_stgo_t <- st_transform(lagos_prov_santiago, crs_nuevo)


#c.(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)
plot(lagos_prov_santiago$geometry)
plot(lagos_stgo_t$AREA_KM2)



plot(lagos_prov_santiago["AREA_KM2"], col="green")


#d.(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.
primerlago<-lagos_prov_santiago[1,]
plot(primerlago)
primerlago_sim30<-st_simplify(primerlago,dTolerance = 30)

#Cargue la capa de Indice Calidad Aguas y realice lo siguiente:
indice_cal_agua<-st_read("data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")
#a.(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?
romeral<-indice_cal_agua[indice_cal_agua$NOM_COM=="ROMERAL",]
dim(romeral)
nrow(romeral)
#b(10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

calag_rom_buf<-st_buffer(romeral,1000)


#c(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.
calag_rom_buf$OBJECTID_1
calag_rom_buf$OBJECTID
calag_rom_buf$NOMBRE_APR
calag_rom_buf$NOMBRE_BNA
calag_rom_buf$COD_BNA
calag_rom_buf[,5:1]



#d(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

calidad_agua_romeral_buffer_1000m<- st_write(calag_rom_buf,"calag_rom_buf.shp", append = TRUE)

############ 4 RASTER#######

#1(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:

install.packages("terra")
library(terra)
#Fila 1: 9, 6, 4, 1
#Fila 2: 10, 25, NA, 2
#Fila 3: 5, 10, 15, 25
#Fila 4: 100, 5, 30, 50

values(r)<-c(9,6,4,1,10,25,NA,2,5,10,15,25,100,5,30,50)


r1 <- rast(xmin = -71.5, xmax = -70.25,
           ymin = -37.33 , ymax = -35.33)
# Imprimir el resumen del raster
print(r1)

#2.
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

crs(r)
crs(r,describe=TRUE)
crs(r)<-"EPSG:32719"
crs(r)


#3.(20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

#3
nuevor <- sqrt(r+10)
nuevor
plot(nuevor)
text(nuevor,digits=2)



#4.(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

r6 <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

l <-  r6 < 46 | r6 > 54
plot(l); text(l)
r6[l]<- NA
plot(r6); text(r6)


#5.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.
#5
?global
#forma1
op <- global(r2, c("sum", "mean", "sd"), na.rm=TRUE) 
op
#6.Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:

dem_chile<-rast("data_eva2/dem_chile.tif")
#a.(5pts) clase del objeto

class(dem_chile)

#b.(5pts) número de columnas, filas y capas
dim(dem_chile)

#c.(5pts) resolución espacial
res(dem_chile)
#d(5pts) sistema de referencia de coordenadas
crs(dem_chile)
crs(dem_chile,describe=TRUE) #mas detallado
#e.(5pts) el archivo se encuentra almacenado en la memoria o en el disco.
sources(dem_chile)
inMemory(dem_chile)
#f.cuál es la elevación máxima y mínima


extension<-ext(dem_chile)

dem_chilerecorte<-crop(dem_chile,extension)


elevacion_maxima<-max(dem_chilerecorte)
elevacion_minima<-min(dem_chilerecorte)

elevacion_maxima
elevacion_minima

#min value   : -256 
#max value   : 6414






#7.Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

imagen_copiapo<-rast("data_eva2/imagen_copiapo.tif")
#a(15pts) cree un raster que corresponda a la suma de las cuatro capas.
#cree un raster
r<-rast(nrow=3,ncol=3,nlyr=4)
values(r)<-1:9
r1<-r[[1]]
r2<-r[[2]]
r3<-r[[3]]
r4<-r[[4]]
r_sum1<-r[[1]]+r[[2]]+r[[3]]+r[[4]]
#imagen de copaipo
imagen_copiapo_sum<-imagen_copiapo[[1]]+imagen_copiapo[[2]]+imagen_copiapo[[3]]+imagen_copiapo[[4]]


#b.(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.

crs(imagen_copiapo)
crs(imagen_copiapo)<-"EPSG:4326"
crs(imagen_copiapo)



#c.(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
mapa <- imagen_copiapo[[1:3]]
mapaRGB <- plot(mapa)



#d.(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif

copiapo_capa1.tif
capa1 <- imagen_copiapo[[1]]
writeRaster(capa1,"copiapo_capa1.tif")



