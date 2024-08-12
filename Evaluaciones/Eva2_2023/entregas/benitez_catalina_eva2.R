      #Uso Avanzado de Información Geográfica
                    #PARCIAL 2


#Instalar paquetes necesarios
install.packages("sf")
install.packages("terra")

#Cargar paquetes
library(sf)
library(terra)


            ###1     D A T O S

#Los datos que utilizará para la evaluación son los siguientes:

    #Indice Calidad de Aguas: datos de la Dirección General de Aguas (DGA) con ubicaciones de puntos de Agua Potable Rural (APR) con mediciones de índices de calidad de agua.

    #Inventario Lagos: datos de la Dirección General de Aguas (DGA) con los lagos presentes en el territorio nacional.

    #dem Chile: datos de elevación (metros) para el territorio de Chile continental.

    #imagen Copiapo: imagen aérea capturada sobre una zona de la ciudad de Copiapo.




                ###2    C O N C E P T O S

#1-.(10pts) Describa como puede utilizar el software R como un Sistema de Información Geográfica.

#A lo largo de los últimos años, se han creado distintos paquetes o packages que permiten trabajar con datos geoespacaiales en el software R, como el paquete {sf} y el paquete {terra}, con los cuales se pueden manipular datos vectoriales y datos raster respectivamente, ya que proveen de clasificación de objetos espaciales y funciones exclusivas de los paquetes para trabajr con ellos. Además, utilizar este software para la creación de mapas tiene la ventaja de poder replicarlos fácilmente, porque se utiliza un código que se puede compartir como un archivo .R


#2-.(10pts) Describa que clase de objetos se utilizan en R para trabajar con objetos geoespaciales de tipo vectoriales y rasters.

#Con R base, se pueden utilizar data.frames para almacenar datos de coordenadas, no obstante, se han desarrollado paquetes que permiten trabajar con datos espaciales porque proveen de la estructura y de funciones para ello. Estos son los paquetes {sf} y {terra}.

#Por un lado, {sf} permite manipular datos vectoriales, cuyos objetos se definen como objetos de clase sf o Simple Feature. Un objeto sf está compuesto por un data.frame y una lista. La lista es la que contiene la información acerca de la geometría del objeto y se denomina como sfc (Simple Feature geometry list-Column). Esta lista está compuesta por todas las geometrías que contiene el objeto sf, y cada geometría individual se denomina como un objeto sfg (Simple Feature Geometry).

#Por otro lado, "terra" permite trabajar con datos raster. Sus objetos se clasifican como objetos spatRaster.


#3-.(10pts) Liste los tipos de geometrias que se pueden trabajar con el paquete {sf}.

#Las geometrías (o objetos sfg) que se pueden trabajar con {sf} son:
#POINT, como un punto
#MULTIPOINT, como un conjunto de puntos
#STRING, como una línea
#MULTILINESTRING, como un conjunto de líneas
#POLYGON, como un polígono
#MULTIPOLYGON, como un conjunto de polígonos
#GEOMETRYCOLECCTION, como un conjunto de distintas geometrías


#4-.(10pts) Describa los objetos de clase sf.

#los objetos de clase sf o Simple Feature,  están compuesto por un data.frame y una lista. La lista es la que contiene la información acerca de la geometría del objeto y se denomina como sfc (Simple Feature geometry list-Column). Esta lista está compuesta por todas las geometrías que contiene el objeto sf, y cada geometría individual se denomina como un objeto sfg (Simple Feature Geometry). 





                    ###3 V E C T O R I A L E S

#1-.20pts) Cree un pentágono con las coordenadas que se indican en los puntos A, B, C, D, E y F:

#Crear vectores para cada uno de los puntos
p1 <- c(0,0)
p2 <- c(4,0)
p3 <- c(6,2*sqrt(3))
p4 <- c(4,4*sqrt(3))
p5 <- c(0,4*sqrt(3))
p6 <- c(-2,2*sqrt(3))

#Crear data.frame
df1 <- data.frame(p1,p2,p3,p4,p5,p6)

#Crear matriz a parti del data.frame
#NOTA: las columnas se transformaron en filas
mat1 <- rbind(df1[,1],df1[,2],df1[,3],df1[,4],df1[,5],df1[,6])

#Añadir la primera coordenada al final para que el anillo cierre
anillo <- rbind(mat1,mat1[1,])

#Crear lista que contenga la matriz
poligono <- list(anillo)

#Crear objeto sfg de clase polígono
hexagono <- st_polygon(poligono)

#Graficar hexagono
par(mfrow=c(1,1))
plot(hexagono)





#2-.Cargue la capa vectorial correspondiente al Inventario Lagos e indique lo siguiente :
#a-. (5pts) tipo de geometria
#b-. (5pts) dimensión de los puntos
#c-. (10pts) sistema de referencia de coordenadas (datum, proyectada o no proyectada, huso si corresponde y código EPSG)
#d-. (5pts) cantidad de variables y observaciones
#e-. (5pts) extensión

#Cargar capa vecrtorial
lagos <- st_read("data/data_eva2/Lagos/Inventario_Lagos.shp")

#Responder los insisos en orden

st_geometry(lagos)
#a-.
#La geometría es de tipo MULTIPOLYGON (o multipolígono)
#b-.
#La dimensión es XY

st_crs(lagos)
#c-.
#Las coordenadas son proyectadas, porque el sistema de referencia de coordenadas es UTM huso 19 Sur, que se basa en el datúm WGS 84, y su cógido EPSG es 32719

str(lagos)
#d-.
#Presenta 22 variables y 2067 observaciones

st_bbox(lagos)
#e-.
#Su extensión es:
#xmin: 16712.94 m
#xmax: 697838.5 m
#ymin: 3870128 m
#ymax: 8051367 m





#3-.Con la capa de Inventario Lagos realice lo siguiente:

#a-.(15pts) seleccione los lagos que pertenecen a la provincia de Santiago y asignelo a un objeto lagos_stgo. ¿Cuántos son?

#Verificar nombre exacto de la provincia solicitada
lagos$PROVINCIA #es "Santiago"

#Indexar
lagos_stgo <- lagos[lagos$PROVINCIA=="Santiago",]

#Colsultar por cantidad de filas (observaciones)
nrow(lagos_stgo) #Por lo tanto, se tratan de 34 lagos.



#b-. (10pts) reproyecte (transforme) el sistema de referencias de coordendas de lagos_stgo a SRC EPSG 4326 y reemplázelo.

#Reemplazar el mismo objeto con su transformación de SRC
lagos_stgo <- st_transform(lagos_stgo,crs = 4326)

#Combrobar que la transformación fue bien realizada
st_crs(lagos_stgo)


#c-.(15pts) haga un mapa (con plot) en donde se muestre con colores la variación de la variable área (AREA_KM2)

#Verificar el índice de las columnas de interés
colnames(lagos_stgo)
#AREA_KM2, columna 2
#geometry, columna 22

#Realizar un mapa que muestra con colores la variación de la variable área
plot(lagos_stgo[,c(2,22)])



#d-.(20pts) seleccione el primer lago de lagos_stgo y simplifique su geometria, considerando una tolerancia de 30m. Haga un plot de la geometría original y simplificada.

#Indexar primera fila del objeto lagos_stgo
primlago <- lagos_stgo[1,]

#Verificar su SRC
st_crs(primlago)
#Observación: Puesto que su SRC es de coordenadas no proyectadas, se debe transformar a un SRC cuyas coordenadas sí sean proyectadas, porque la tolerancia sugerida está medida en metros

#Transformar SRC a UTM 19S
primlago_32719 <- st_transform(primlago,32719)

#Simplificar su geometría con la tolerencia deseada
primlago_sim <- st_simplify(primlago_32719,dTolerance=30)

#Crear un sólo mapa que contenga la geometría original y la simplificada
par(mfrow=c(1,2)) #Para que en el mapa aparezcan dos objetos
plot(primlago_32719$geometry) #geometría original
plot(primlago_sim$geometry) #geometría simplificada






#4-.Cargue la capa de Indice Calidad Aguas y realice lo siguiente:

#Cargar capa vectorial solicitada
calidad <- st_read("data/data_eva2/Indice_Calidad_de_Aguas/ICA_Indice_Calidad_Aguas.shp")


#a-.(15pts) Seleccione las observaciones que se encuentran en la comuna de “Romeral”. ¿Cuántas puntos hay?

#Indexar y crear objeto sf de nombre romeral
romeral <- calidad[calidad$NOM_COM=="ROMERAL",]

#Cantidad de filals (observaciones)
nrow(romeral) #Por lo tanto, en la comuna de Romeral se encuentran 3 puntos



#b-. (10pts) cree un buffer de 1000 metros en los puntos que se encuentran en Romeral y asignelo al objeto calag_rom_buf.

#Verificar SRC de romeral
st_crs(romeral)
#Su SRC sí es de coordenadas proyectadas, por lo que no es necesario transformarlo

#Crear un nuevo objeto en el que se le aplique un buffer a romeral
calag_rom_buf <- st_buffer(romeral,dist = 1000)

#NOTA: Sólo para comprobar que el buffer fue correctamente aplicado
par(mfrow=c(1,2))
plot(romeral$geometry)
plot(calag_rom_buf$geometry)



#c-.(10pts) ¿cuáles son los nombres de las cinco primeras variables de calag_rom_buf.

colnames(calag_rom_buf)[1:5]
#"OBJECTID_1" "OBJECTID"   "NOMBRE_APR" "NOMBRE_BNA" "COD_BNA"   



#d-.(15pts) guarde el objeto calag_rom_buf en formato geopackage y con el nombre calidad_agua_romeral_buffer_1000m

#Guardar en el directorio de trabajo
st_write(obj=calag_rom_buf,dsn="calidad_agua_romeral_buffer_1000m.gpkg")






                ###4 R A S T E R


#1-.(30pts) Cree un raster de 4 filas y 4 columnas que se encuentre entre 35°20’ y 37°30’ de latitud Sur; y 71°50’ y 70°15’ de longitud Oeste. El sistema de referencia de coordenadas debe ser coordenadas geográficas y datum WGS84. En cada fila el raster debe tener los siguientes valores:
# -Fila 1: 9, 6, 4, 1
# -Fila 2: 10, 25, NA, 2
# -Fila 3: 5, 10, 15, 25
# -Fila 4: 100, 5, 30, 50

#Observacion: Las coordenadas se encuentran en el cuadrante Oeste y Sur. Por lo tanto, los valores son todos negativos

#NOTA: se deben transformar las coordenadas de unidad GMS a GD. El cálculo fue realizado en internet

#Observación:
#x mínimo es la longitud más lejana del meridiano de Greenwich = -71°50’ = -71.83
#x máximo es la longitud más cercana del meridiano de Greenwich = -70°15’ = -70.25
#y mínimo es la latitud más lejana del ecuador = -37°30’ = -37.5
#y máximo es la latitud más cercana del ecuador = -35°20’ = -35.33

#Crear objeto spatRaster con la información solicitada
r1 <- rast(xmin=-71.83,xmax=-70.25,ymin=-37.5,ymax=-35.33,
           ncols=4,nrows=4,
           crs="EPSG:4326")

#Crear vectores en base a las filas solicitadas
fila1 <- c(9, 6, 4, 1)
fila2 <- c(10, 25, NA, 2)
fila3 <- c(5, 10, 15, 25)
fila4 <- c(100, 5, 30, 50)

#Asignar a r1 los valores solicitados
values(r1) <- c(fila1,fila2,fila3,fila4)

#Graficar para comprobar que esté correcto
par(mfrow=c(1,1))
plot(r1);text(r1)





#2-.(15pts) Considere el siguiente raster:

library(terra)
r <- rast(x=matrix(1:16*5,4,byrow = FALSE),crs="EPSG:4326")
plot(r);text(r)

#a-.Transforme el sistema de referencia de coordenadas del raster anterior a coordenadas UTM Huso 19 Sur datum WGS84.

#Transformar SRC y guardar transformación en objero rutm
rutm <- project(r,"EPSG:32719")

#Verificar que la transformación fue bien realizada
crs(rutm,describe=TRUE) 




#3-.(20pts) Cree un raster nuevo utilizando el raster de la pregunta anterior, en el que se le sumen 10 y se calcule la raiz cuadrada a cada pixel.

#Realizar operación
rnew <- sqrt(rutm+10)

#Graficar para verificar que la operación fue bien realizada
plot(rnew);text(rnew,digits=2)


#4-.(20pts) Cree un nuevo raster, tomando como referencia el raster de la pregunta 2, al que se le cambie los valores que son menores que 46 y mayores que 54, por el valor NA.

#Realizar pregunta lógica y guardar resultado en un objeto spatRaster de valores lógicos
rlog <- r < 46 | r > 54
plot(rlog);text(rlog)

#Duplicar raster, al cual se le aplicará la indexación
r4 <- r
plot(r4);text(r4)

#Indexar y reemplazar los TRUE del objeto de valores lógicos por NA
r4[rlog] <- NA
plot(r4);text(r4)






#5-.(20pts) Calcule el promedio, la mediana y desviación estandar de todos los valores del raster de la pregunta 2. Utilice una función de {terra}.

#Calcular el promedio
global(r,fun="mean")

#Calcular la mediana
global(r,fun= function(x) quantile(x,.5))

#Calcular desviacion estandar
global(r,fun="sd")





#6-.Cargue el archivo dem_chile.tif en R e indique utilizando una función de R:
 
dem <- rast("data/data_eva2/dem_chile.tif")

#a-.(5pts) clase del objeto
class(dem) #objeto de clase SpatRaster

#b-.(5pts) número de columnas, filas y capas
dim(dem) #4656 filas, 1884 columnas y 1 capa

#c-.(5pts) resolución espacial
res(dem) #resolución de 0.008333333 x 0.008333333

#d-.(5pts) sistema de referencia de coordenadas
crs(dem,describe=TRUE) #Sistema WGS84, de código EPSG = 4326

#e-.(5pts) el archivo se encuentra almacenado en la memoria o en el disco.
sources(dem) #está almacenado en la memoria

#f-.(15pts) cuál es la elevación máxima y mínima
max(dem) #La elevación máxima es de 6414
min(dem) #La elevación mínima es de -256





#7-.Cargue el archivo imagen_copiapo.tif en R. Realice lo siguiente:

#Cargar archivo raster 
copiapo <- rast("data/data_eva2/imagen_copiapo.tif")

#a-.(15pts) cree un raster que corresponda a la suma de las cuatro capas.
suma_capas <- sum(copiapo[[1]],copiapo[[2]],copiapo[[3]],copiapo[[4]])

#Comprobar que se creo un objeto spatRaster de una capa
class(suma_capas)
dim(suma_capas)

#b-.(10pts) reproyecte (transforme) el sistema de referencia de coordenadas a SRC EPSG 4326.
copiapo_4326 <- project(copiapo,"EPSG:4326")

#Comprobar que la transformación fue bien realizada
crs(copiapo_4326,describe=TRUE)

#c-.(10pts) haga un mapa en donde se pueda visualizar la composición de color RGB utilizando las tres primeras capas.
copiapo_RGB <- c(copiapo[[1]],copiapo[[2]],copiapo[[3]])
plotRGB(copiapo_RGB)

#d-.(15pts) guarde (writeRaster) la primera capa del raster con el nombre copiapo_capa1.tif
writeRaster(x = copiapo[[1]],"copiapo_capa1.tif")

