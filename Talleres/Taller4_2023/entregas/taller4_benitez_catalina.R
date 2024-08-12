#paquetes que vienen por defecto (6):
#stats
#graphics
#grDevices
#utils
#datasets
#methods
#base

install.packages("sf")
library(sf)


#Ejercicios


#1-.(10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

#Crear tres ojeto sfg tipo punto
(punto_2d <- st_point(x = c(-72.65,-36.25),dim = "XY")) #Punto de 2 dimensiones
(punto_3d <- st_point(x=c(-72.65,-36.25,200), dim = "XYZ")) #Punto de 3 dimensiones
(punto_4d <- st_point(x=c(-72.65,-36.25,200,90),dim = "XYZM")) #Punto de 4 dimensiones

#comprobar que la clase de cada objeto es la que corresponde (sfg tipo punto)
class(punto_2d)
class(punto_3d)
class(punto_4d)




#2-.(20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:
      #MULTIPOINT
      #LINESTRING
#Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396))

#Primero se debe transformar el objeto en matriz
#Además, hay que reordenar las columnas porque primero va longitud y luego latitud

#Crear matriz a partir del data.frame, cuyas columnas estén al revés
df_mat <- as.matrix(df[,2:1])

multipunto <- st_multipoint(df_mat) #Crear objeto de clase sfg tipo multipunto
plot(multipunto) #Graficar para poder visualizar el objeto multipunto

linea <- st_linestring(df_mat) #Crear objeto de clase sgf tipo línea 
plot(linea) #Graficar para poder visualizar el objeto linea




#3-. (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df2 <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461))

#Crear las dos matrices necesarias
linea1<- as.matrix(df2[1:4,3:2]) #Contiene las 4 coordenadas de linea 1
linea2 <- as.matrix(df2[5:8,3:2]) #Contiene las 4 coordenadas de linea 2

#Crear el objeto multilinea
multilinea <- st_multilinestring(x = list(linea1,linea2))

#Graficar el objeto multilinea
plot(multilinea)

#Verificar la clase y geometría del objeto multilinea
class(multilinea) #Efectivamente, es de clase "sfg" y geometría MULTILINESTRING




#4-.(20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df_pol <- data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500))

#Crear matriz que contenga los valores de df_pol
#En el orden correspondiente: longitud, latitud
mat_pol <- as.matrix(df_pol[,2:1])

#Crear el objeto de clase sfg y de geometría tipo polígono
#Debido a que las coordenadas iniciales de df_pol no permiten crear un anillo cerrado de polígono, se tiene que repetir la primera coordenada al final de la matriz
poligono <- st_polygon(list(rbind(mat_pol,mat_pol[1,])))

#Graficar el objeto poligono
plot(poligono)




#5-.(20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df_mpol <- data.frame(
    longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,-70.63500,-70.63461,-70.63396,-70.63435),
    latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,-33.38883,-33.38846,-33.38893,-33.38929))

#Crear matriz con los elementos de df_mpol
mat_mpol <- as.matrix(df_mpol)

#Crear objeto a partir de la matriz anterior
#Se consideraron las primeras 4 coordenadas como los cuatro puntos del primer polígono y las últimas 4 coordenadas como los cuatro puntos del segundo polígono
#Además, se tuvieron que repetir las primeras coordenadas de cada polígono para que el anillo de estos se pueda cerrar
multipoligono <- st_multipolygon(list(list(rbind(mat_mpol[1:4,],mat_mpol[1,]),rbind(mat_mpol[5:8,],mat_mpol[5,]))
))

#Graficar objeto multipolígono
plot(multipoligono)

#Verificar clase y geometría del objeto
class(multipoligono) #Objeto de clase sfg y geometría tipo MULTIPOLYGON




#6-.(20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

#Crear objeto
coleccion <- st_geometrycollection(list(multipunto,linea,multilinea,poligono,multipoligono))
#NOTA: No se pueden incluir los objetos punto_3d y punto_4d porque tienen más de dos dimensiones. Y además se decidió no incluir el punto_2d porque, pese a sí presentar dos dimensiones, sus coordenadas se encuentran a una distancia considerable de los otros objetos, la cual dificulta la visibilidad al momento de graficar.

#Graficar el objeto
plot(coleccion)

#Veridicar la clase y tipo de geometría del objeto
class(coleccion) #Objeto de clase sfg y de geometría de tipo GEOMETRYCOLLECTION




#7-.(20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

#Crear objetos de tipo sfc o Simple Feature geometry list-Column a partir de cada objeto sfg
multipunto_sfc <- st_sfc(multipunto)
linea_sfc <- st_sfc(linea)
multilinea_sfc <- st_sfc(multilinea)
poligono_sfc <- st_sfc(poligono)
multipoligono_sfc <- st_sfc(multipoligono)

#Crear objeto sf que contenga todos las geometrías
objeto_sf <- st_sf(geometry=c(multipunto_sfc,linea_sfc,multilinea_sfc,poligono_sfc,multipoligono_sfc))
#Observacion: No todas las geometrias de una list column deben ser la misma geometria

#Agregarle atributos al objeto sf
objeto_sf$nombre_geometria <- c("multipunto","línea","multilínea","polígono","multipoligono")

#Visualizar objeto
plot(objeto_sf)




#8-.(30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

df3 <- data.frame(
  latitud = c(-33.70,-33.07,-33.12,-33.67,-33.70,-33.65,-33.67,-33.66,-33.86,-33.21),
  longitud = c(-71.37,-70.75,-70.83,-70.58,-70.70,-71.1,-70.92,-70.76,-70.63,-70.71))

emas <- st_as_sf(df3,coords=c("longitud","latitud"))
emas #10 objetos sfg de tipo multipunto

#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector:
nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#Agregar vector de nombre de las emas al objeto sf
#Forma 1
emas$Nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#Forma 2
#emas <- cbind(nombres_emas,emas)

#Visualizar objeto sf en consola
emas

#Graficar objeto sf
plot(emas)




#9-.(20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.


st_crs(emas) #Este objeto no tiene asignado ningún SRC

#Asignar el SRC datum WGS84, cuyo código ESPG es 4326
st_crs(emas) <- 4326
st_crs(emas) #Ahora sí tiene asignado un SRC

#Al momento de crear el objeto sf emas, se pudo especificar el SRC deseado:
emas <- st_as_sf(df3,coords=c("longitud","latitud"),crs=4326)
st_crs(emas)
#NOTA: No se puede transformar un SRC si no había uno asignado previamente

#ERROR COMÚN AL MOMENTO DE ASIGNAR UN SRC:
#emas <- st_as_sf(df3,coords=c("longitud","latitud"),crs=32719
#Es un ERROR, por asignar un crs que se mide en metros a un objeto que tiene medidas en longitud y latitud

#Graficar objeto sf emas
plot(emas)

#Crear objeto sf a partir de transformar las coordenadas del objeto emas
emas_32719 <- st_transform(emas,32719) #Transforma de coordenadas 4326 a 32719
emas_32719
##
coords_utm <- st_coordinates(emas_32719) #No devuelve como un dtfr sino como matriz



#Otras formas de hacer el ejercicio
coords_utm_df <- as.data.frame(coords_utm)
names(coords_utm_df) <- c("Este","Norte")
st_as_sf(coords_utm_df,coords=c("Este","Norte"),crs=32719)




#10-.(30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:
  
      #tipo de geometría
      #cantidad de variables y observaciones
      #sistema de referencia de coordenadas y código EPSG

#NOTA: Se creó una carpeta llamada "data" dentro de la carpeta "project", en donde se cargaron todas las capas de interés.

#Cargar todos los archivos vectoriales. Se crean 7 objetos sf en total
planes <- st_read("data/bdide_OWD_Aire_planes_prevencion_descontaminacion.shp")
zonas <- st_read("data/bdide_OWD_Aire_Zonas_Saturadas_Latentes.shp")
preservacion <- st_read("data/biodi_area_preservacion_ecologica.shp")
prohibicion <- st_read("data/biodi_area_prohibicion_caza.shp")
vegetacion <- st_read("data/biodi_f_vegetacionales_gajardo.shp")
pisos <- st_read("data/biodi_pisosvegetacionalespliscoff2017.shp")
snaspe <- st_read("data/biodi_snaspe_2021.shp")

#Otra forma más sencilla de hacerlo!

#Crear objeto que contenga los nombres de los 8 archivos de interés
files <- list.files("data",pattern="shp$",full.names=TRUE)

#Cargar y crear los 8 objetos a partir de los archivos
planes <- st_read(files[1])
zonas <- st_read(files[2])
preservacion <- st_read(files[3])
prohibicion <- st_read(files[4])
vegetacion <- st_read(files[5])
pisos <- st_read(files[6])
snaspe <- st_read(files[7])

#Verificar el tipo de geometría de cada objeto
class(planes$geometry) #Geometría MULTIPOLYGON
class(zonas$geometry) #Geometría MULTIPOLYGON
class(preservacion$geometry) #Geometría MULTIPOLYGON
class(prohibicion$geometry) #Geometría MULTIPOLYGON
class(vegetacion$geometry) #Geometría POLYGON
class(pisos$geometry) #Geometría MULTIPOLYGON
class(snaspe$geometry) #Geometría MULTIPOLYGON
#Observación: La mayoría de los objetos son de geometría tipo multipolígono, salvo por el objeto de nombre vegetacion, cuya geometría es de tipo polígono.

#Contabilizar cantidad de variables y observaciones
str(planes) #15 variables y 21 observaciones
str(zonas) #14 variables y 28 observaciones
str(preservacion) #16 variables y 40 observaciones
str(prohibicion) #17 variables y 20 observaciones
str(vegetacion) #18 variables y 939 observaciones
str(pisos) #12 variables y 126 observaciones
str(snaspe) #19 variables y 105 observaciones

#Verificar Sistema de Referencia de Coordenadas (SRC) y Código EPSG
st_crs(planes) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(zonas) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(preservacion) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(prohibicion) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(vegetacion) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(pisos) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
st_crs(snaspe) #SRC: WGS 84 / Pseudo-Mercator y CÓDIGO EPSG: 3857
#Observacion: Los Sistema de Referencia de Coordenadas de cada objeto son iguales




#11-.(20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

planes2 <- st_transform(planes,4326)
st_crs(planes2) 

zonas2 <- st_transform(zonas,4326)
st_crs(zonas2) 

preservacion2 <- st_transform(preservacion,4326)
st_crs(preservacion2) 

prohibicion2 <- st_transform(prohibicion,4326)
st_crs(prohibicion2) 

vegetacion2 <- st_transform(vegetacion,4326)
st_crs(vegetacion2)

pisos2 <- st_transform(pisos,4326)
st_crs(pisos2)

snaspe2 <- st_transform(snaspe,4326)
st_crs(snaspe2) 




#12-.(30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

#Para saber cómo se llama la columna que contiene la información de la región de cada observacion
colnames(snaspe2) #La columna de interés se llama "region"

#Crear objeto que tenga sólo las observaciones de la región Metropolitana
snaspe2_met <- snaspe2[which(snaspe2$region=="Metropolitana"),]

#Mostrar data.frame de las geometrías seleccionadas
View(snaspe2_met)

#Crear objeto, seleccionando las columnas de "categoria" y "nom_unidad"
#Mostrar data.frame creado
snaspe_final <- snaspe2_met[,c(6,7)]
View(snaspe_final)

#Guardar el resultado en un archivo .csv de configuracion latina
write.csv2(snaspe_final,"data/areas_protegidad_RM.csv")




#13-.(20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

st_write(obj = snaspe_final, dsn = "data/areas_protegidas_RM.gpkg")


#14-.(30pts) Respecto a la capa de fuentes puntuales contaminantes, seleccione las que emiten Dioxido de Carbono y se encuentran en la región Metropolitana. Guarde el resultado en un archivo geopackage llamado fuentes_pun_cont_RM_CO2.gpkg.
#Pregunta que no se considera.