##Pia Fuentes.

install.packages('sf')
library(sf)


#1. (10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

#sfg: geometría individual de cada sf.
#2D (X,Y), (E, N), (Lon,Lat): XY
#3D : XYZ (Z: Altitud)
#3D : XYM (M: medición asociada con el punto)
#4D : XYZM
##Un punto es un vector númerico.

#2 dimensiones.
sfg_2 <- st_point(c(-72.65, -36.25)) 
class(sfg_2)
str(sfg_2)

#3 dimensiones.
sfg_3 <- st_point(c(-72.65, -36.25, 200))
class(sfg_3)
str(sfg_3)

#4 dimensiones.
sfg_4 <- st_point(c(-72.65, -36.25, 200, 90))
str(sfg_4)

#2. (20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg: MULTIPOINT y LINESTRING. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893)
)

#Multipoint
mpoint <- st_multipoint(as.matrix(df))
mpoint
str(mpoint)
class(mpoint)
plot(mpoint)

#Linestring 
l <- st_linestring(as.matrix(df))
class(l)
str(l)
plot(l)


#3. (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df2 <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846)
)

#Multilinestring
dfm <- as.matrix(df2[,2:3])
dfm
## Recordar que multilinestring se crea desde una LISTA. 
multili <- st_multilinestring(list(dfm[1:4, 1:2], dfm[5:8, 1:2]))
class(multili)
plot(multili)

#4. (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

df_pol <- data.frame(
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500, -70.63566),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991, -33.38943)
)

##Polígono (RECORDAR: en las coordenadas, debe ir la misma al principio y al final para que tenga la forma de un polígono)
mpol <- as.matrix(df_pol)
mpol
pol <- st_polygon(list(mpol))
class(pol)
plot(pol)

#5. (20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

#Orden correcto: Longitud y latitud.
h <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929)
)

df_mpolm <- as.matrix(h[,2:3])
mp <- st_multipolygon(
  list(
    list(
      rbind(df_mpolm[1:4,], df_mpolm[1,])
    ),
    list(
      rbind(df_mpolm[5:8,], df_mpolm[5,])
    )
  )
)
  
class(mp)
plot(mp)

#6. (20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

gcollection <- st_geometrycollection(list(sfg_2, sfg_3, sfg_4,mpoint, l, multili, pol, mp)) #No se puede con sfg_3 y sfg_4 (tienen más dimensiones)

gcollection <- st_geometrycollection(list(mpoint, l, multili, pol, mp))
class(gcollection)
plot(gcollection)

#7. (20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

sfg_2_sfc <- st_sfc(sfg_2)
mpoint_sfc <- st_sfc(mpoint)
l_sfc <- st_sfc(l)
multili_sfc <- st_sfc(multili)
pol_sfc <- st_sfc(pol)
mp_sfc <- st_sfc(mp)

?st_sf
obj_sf <- st_sf(geometry= c(sfg_2_sfc, mpoint_sfc, l_sfc, multili_sfc, pol_sfc, mp_sfc))

class(obj_sf)
obj_sf
obj_sf$nombre_geometría <- c('Punto', 'Multipunto', 'Linea', 'Multilinea', 'Poligono', 'Multipoligono')
obj_sf

#8. (30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

df <- data.frame(
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71), 
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21)
)

#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector:
nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")


df
?st_as_sf
emas <- st_as_sf(df, coords = c('longitud', 'latitud'))
class(emas)

nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

emas$nombres_emas <- nombres_emas
#o
emas <- cbind(nombres_emas, emas)
emas

#9. (20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

st_crs(emas)

#SRC datum WGS85, psg 4326 (huso 18)
st_crs(emas) <-4326 
st_crs(emas)

#SRC datum WGS84, psg 32719 (huso 19)
emas_32719 <- st_transform(emas, 32719)
st_crs(emas_32719)

#10. (30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

#tipo de geometría
# cantidad de variables y observaciones
#sistema de referencia de coordenadas y código EPSG.

#para saber el directorio
getwd() 

#definir directorio de trabajo
setwd("/cloud/project/Datos/Aire_-_Shapefile")

#abrir capa vectorial
aire_emisiones_puentes_puntuales <- st_read("bdide_OWD_Aire_Emisiones_fuentes_puntuales_contaminante.shp")
aire_emisiones_puentes_puntuales #geometría tipo punto.  217359 features and 31 fields. SRC WGS 84


aire_planes_prevencion <- st_read("bdide_OWD_Aire_planes_prevencion_descontaminacion.shp") 

aire_planes_prevencion #Geometría tipo  MULTIPOLYGON. 21 features and 14 fields. WGS 84

a_z_s_l <- st_read("Datos/bdide_OWD_Aire_Zonas_Saturadas_Latentes.shp")
a_z_s_l  # Geometría tipo MULTIPOLYGON. 28 features and 13 fields. WGS 84.

#Clases
getwd()

#Metodo 1.
read_sf ('Aire_-_Shapefile/Datos/bdide_OWD_Aire_Zonas_Saturadas_Latentes.shp')

#Metodo 2 (para cuando hay varios archivos)
files <- list.files('Datos/Aire_-_Shapefile', pattern = 'shp$', full.names = TRUE)   #lista los archivos de una carpeta. 'pattern' para buscar un patron-

files
capa1 <- st_read(files[1]) #capa pesada. Al abrirlo queda pegado (capa que el profesor elimino en clases). epsg 3857
st_crs(capa1)$epsg

capa2 <- st_read(files[2]) #Geometría tipo MULTIPOLYGON. 21 features (observaciones) and 14 fields (variables). WGS 84. epsg 3857
st_crs(capa2)$epsg

capa3 <- st_read(files[3]) #Geometría tipo MULTIPOLYGON. 28 features and 13 fields. WGS 84 epsg 3857
st_crs(capa3)$epsg

files2 <- list.files('Datos/Biodiversidad_-_Shapefile', pattern='shp$', full.names = TRUE)
files2
capa4 <- st_read(files2[1]) #Geometría tipo MULTIPOLYGON. 40 features and 15 fields. WGS 84 epsg 3857
st_crs(capa4)$epsg

capa5 <- st_read(files2[2]) #Geometrái tipo MULTIPOLYGON. 20 features and 16 fields. WGS 84 epsg 3857
st_crs(capa5)$epsg


capa6 <- st_read(files2[3]) #Geometría tipo  POLYGON. 939 features (observaciones)  and 17 fields (variables), WGS 84 epsg 3857
str(capa6) #Considera la geometría, en cambio, el de arriba no. Solo cuenta las columnas. 
st_crs(capa6)
st_crs(capa2)$epsg  


capa7 <- st_read(files2[4]) #Geometría tipo  MULTIPOLYGON. 126 features and 11 fields. WGS 84 epsg 3857
st_crs(capa7)$epsg

capa8 <- st_read(files2[5]) #Geometría tipo MULTIPOLYGON. 105 features and 18 fields. WGS 84 epsg 3857
capa8$geometry
st_crs(capa8)$epsg

#11. (20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

st_set_crs(capa2, capa3, capa4, capa5, capa6, capa7, capa8) <- 4326 #no funciona
st_transform(capa2) <- 4326
st_set_crs(capa2, 4326)
st_crs(capa2)

capa2_4326 <- st_transform(capa2, 4326)
st_crs(capa2)

capa3_4326 <- st_transform(capa3, 4326)
st_crs(capa3_4326)

capa4_4326 <- st_transform(capa4, 4326)
st_crs(capa4_4326)

capa5_4326 <- st_transform(capa5, 4326)
st_crs(capa5_4326)

capa6_4326 <- st_transform(capa6, 4326)
st_crs(capa6_4326)

capa7_4326 <- st_transform(capa7, 4326)
st_crs(capa7_4326)

capa8_4326 <- st_transform(capa8, 4326)
st_crs(capa8_4326)


st_set_crs(capa4, 4326) # 'st_set:crs' para crear el SRC

#12. (30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

#Profesor. no me carga positcloud para hacer el ejercicio. Son las 12:26 y se entrega  alas 12:30. Por eso no podré hacer estos dos ejercicios.


capa8_region_met <- capa8[,wich(capa8$region == 'Metropolitana')]
View(capa8_region_met)


c2 <- capa8_region_met[,c(6,7)]
View(c2)

#13. (20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

#driver es el formato del archivo. La funcion st_red reconoce la extensión y lo guarda con esa extensión.




              