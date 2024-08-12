#Taller 4
#Camila Fernández- Sebastian Acevedo

# instala {sf}
install.packages('sf')
# cargar {sf} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene
library(sf)

#1.(10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

# Coordenadas
latitud <- -36.25
longitud <- -72.65
elevacion <- 200
direccion <- 90
# Crear un objeto sfg de punto en 2D
punto_2d <- st_point(c(longitud, latitud))

# Crear un objeto sfg de punto en 3D
punto_3d <- st_point(c(longitud, latitud, elevacion))

# Crear un objeto sfg de punto en 4D
punto_4d <- st_point(c(longitud, latitud, elevacion, direccion))


#2.(20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:

df <- data.frame(latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),longitud = c(-70.63500,-70.63468,-70.63435,-70.63396))
# MULTIPOINT
multipoint <- st_multipoint(matrix(c(df$longitud, df$latitud), ncol = 2, byrow = FALSE))
plot(multipoint)
#LINESTRING
linea <- st_linestring(matrix(c(df$longitud, df$latitud), ncol = 2, byrow = FALSE))
plot(linea)

#opcion profesor

#transformar matriz mi data.frame
dfm <- as.matrix(df)
st_multipoint(dfm)
st_linestring(dfm)
plot(st_linestring(dfm))

#3.(20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df <- data.frame(linea = c(rep('linea_1',4),rep('linea_2',4)),longitud= c(-33.38991,-33.38959,-33.38929,-33.38893,-33.38943,-33.38911,-33.38883,-33.38846),latitud = c(-70.63500,-70.63468,-70.63435,-70.63396,-70.63566,-70.63531,-70.63500,-70.63461))

coords <- cbind(df$longitud, df$latitud)
lineas <- df$linea[1:2]

#crear objeto sfg
#uniendo matrices por columnas:
u<-cbind(coords,lineas)
m<-as.matrix(u)
st_multipoint(m)

#otra opcion.
st_multilinestring(list(matrix(c(df$longitud, df$latitud), ncol = 2)))
dfm<-as.matrix(df)

#4.(20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
df_pol <- data.frame(longitud = c(-33.38943,-33.38911,-33.38959,-33.38943),latitud = c(-70.63566,-70.63531,-70.63468,-70.63566)) #cambie coordendas manualmente
m<-as.matrix(df_pol)
is.list(m)
list(m)
st_polygon(list(m))

# Realizar un plot del objeto POLYGON
plot(st_polygon(list(m)))
#clase
class(st_polygon(list(m)))


#5.(20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.


df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,-70.63500,-70.63461,-70.63396,-70.63435),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929))
#convertir en matriz
matrizmpol<-as.matrix(df_mpol[,3:2]) #todos del mismo tipo, todas las filas y columna 2 hasta a la 3, primero longitud y despues latitud.

#poligonos individual en una lista cada uno

Multipoygon<-st_multipolygon(
  list(
    list(
      rbind(matrizmpol[1:4,],matrizmpol[1,]) 
    ),
    list(
      rbind(matrizmpol[5:8,],matrizmpol[5,])
    )
  )
)

class(Multipoygon)
st_geometry_type(Multipoygon)
plot(Multipoygon)

#6.Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

geometry_collection<-st_geometrycollection(
  list(multipoint,linestring,multilinestring,polygon,Multipoygon)
)

class(geometry_collection)
st_geometry_type(geometry_collection)
plot(geometry_collection)

#7. Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

multipoint_sfc<-st_sfc(multipoint)
linestring_sfc<-st_sfc(linestring)
multilinestring_sfc<-st_sfc(multilinestring)
polygon_sfc<-st_sfc(polygon)
Multipoygon_sfc<-st_sfc(Multipoygon)

obj_sf<-st_sf("geometry"=c(multipoint_sfc,linestring_sfc,multilinestring_sfc,polygon_sfc,Multipoygon_sfc))

obj_sf

nombre_geom<-c("Multipunto","Linea","Multilinea","Poligono","Multipoligono")

obj_sf_nombre<-cbind(nombre_geom,obj_sf)
obj_sf_nombre




#---------------------------------------------------------------------------------------------
#8.30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

df <- data.frame(latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71))

#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector:

nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#  dataframe
df <- data.frame(latitud = c(-33.70, -33.07, -33.12, -33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.10, -70.92, -70.76, -70.63, -70.71),nombre_ema = c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina"))
#sfg
sfg_list <- lapply(1:nrow(df), function(i) {st_sfc(st_point(c(df[i, "longitud"], df[i,"latitud"])))})

#otra opcion 8

dfemas <- data.frame(longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71),latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21))

emas<-st_as_sf(dfemas,coords = c("longitud","latitud"))
emas

#nombre de las columnas
nombres_ema <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#agregar el nombre de las nuevas columnas
emas_nombres<-cbind(nombres_ema,emas)
emas_nombres
class(emas_nombres)


#9(20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.
# objeto sf con los nombres_emas


# Crear un objeto de puntos en SRC geográficas (WGS84)
sf <- st_sfc(st_point(c(-70.0, -33.5)))

# Asigna la nueva coordenada a puntos
emas_nombres <- st_sfc(sf, crs = 4326)  # 4326 es el código EPSG para WGS84

#transformacion:

sf_utm <- st_transform(coordendas, crs = 32719)



#(30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:
##biodiversidad

getwd()

read_sf("Aire_-_Shapefile/bdide_OWD_Aire_Emisiones_fuentes_puntuales_contaminante.shp")

list.files("Aire_-_Shapefile", pattern = "shp$", full.names = TRUE). #me lee los archivos que estan dentro de la carpeta

capa1<- read_sf(files[1]) #indexo el primer archivo
capa2<-read_sf(files[2])
files2<- list.files("Biodiversidad_-_Shapefile", pattern = "shp$", full.names = TRUE)


#area ecologica
area_ecologica<-st_read("Biodiversidad/BIO_area_preservacion")
st_geometry_type(area_ecologica)
str(area_ecologica)
st_crs(area_ecologica)

#area prohibicion caza
areaprohibicioncaza<-st_read("Biodiversidad/BIO_area_prohibicion_caza")
st_geometry_type(areaprohibicioncaza)
str(areaprohibicioncaza)
st_crs(areaprohibicioncaza)

#vegetacionales
vegetacionales_gajardo<-st_read("Biodiversidad/BIO_vegetacionales")
st_geometry_type(vegetacionales_gajardo)
str(vegetacionales_gajardo)
st_crs(vegetacionales_gajardo)

#pisosvegetacional
pisosvegetacionalespliscoff2017<-st_read("Biodiversidad/BIO_pisosvegetacionales")
st_geometry_type(pisosvegetacionalespliscoff2017)
str(pisosvegetacionalespliscoff2017)
st_crs(pisosvegetacionalespliscoff2017)

#capa5
snaspe_2021<-st_read("Biodiversidad/BIO_snaspe")
st_geometry_type(snaspe_2021)
str(snaspe_2021)
st_crs(snaspe_2021)

##Aire

#emesiones contaminantes
Emisiones_fuentes_puntuales_contaminante<-st_read("Biodiversidad/Aire_fuentedeemisiones")
st_geometry_type(Emisiones_fuentes_puntuales_contaminante)
str(Emisiones_fuentes_puntuales_contaminante)
st_crs(Emisiones_fuentes_puntuales_contaminante)

#descontaminacion
planes_prevencion_descontaminacion<-st_read("Biodiversidad/Aire_planesprevencion")
st_geometry_type(planes_prevencion_descontaminacion)
str(planes_prevencion_descontaminacion)
st_crs(planes_prevencion_descontaminacion)

#zonas
Zonas_Saturadas_Latentes<-st_read("Biodiversidad/Aire_zonassaturadas")
st_geometry_type(Zonas_Saturadas_Latentes)
str(Zonas_Saturadas_Latentes)
st_crs(Zonas_Saturadas_Latentes)

#11.Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

area_preservacion_ecologica_4326<-st_transform(area_preservacion_ecologica,4326)
st_crs(area_preservacion_ecologica_4326)

area_prohibicion_caza_4326<-st_transform(area_prohibicion_caza,4326)
st_crs(area_prohibicion_caza_4326)

vegetacionales_gajardo_4326<-st_transform(vegetacionales_gajardo,4326)
st_crs(vegetacionales_gajardo_4326)

pisosvegetacionalespliscoff2017_4326<-st_transform(pisosvegetacionalespliscoff2017,4326)

snaspe_2021_4326<-st_transform(snaspe_2021,4326)
st_crs(snaspe_2021_4326)

Emisiones_fuentes_puntuales_contaminante_4326<-st_transform(Emisiones_fuentes_puntuales_contaminante,4326)
st_crs(Emisiones_fuentes_puntuales_contaminante_4326)

planes_prevencion_descontaminacion_4326<-st_transform(planes_prevencion_descontaminacion,4326)
st_crs(planes_prevencion_descontaminacion_4326)

Zonas_Saturadas_Latentes_4326<-st_transform(Zonas_Saturadas_Latentes,4326)
st_crs(Zonas_Saturadas_Latentes_4326)

#12,Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.
snaspe_2021
snaspe_RM_posiciones<-snaspe_2021$region=="Metropolitana"
snaspe_RM_posiciones

snaspe_RM<-snaspe_2021[snaspe_RM_posiciones,]
snaspe_RM

snaspe_RM2<-snaspe_RM[c("categoria","nom_unidad")]
snaspe_RM2

write.csv2(snaspe_RM2,"areas_protegidad_RM.csv")

#13.Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

st_write(snaspe_RM2,dsn="areas_protegidad_RM.gpkg",layer="areas_protegidad_RM.gpkg",driver="GPKG")

#14.Respecto a la capa de fuentes puntuales contaminantes, seleccione las que emiten Dioxido de Carbono y se encuentran en la región Metropolitana. Guarde el resultado en un archivo geopackage llamado fuentes_pun_cont_RM_CO2.gpkg.
head(Emisiones_fuentes_puntuales_contaminante)

Emisiones_fuentes_puntuales_RM<-Emisiones_fuentes_puntuales_contaminante$region=="Metropolitana de Santiago"

Emisiones_fuentes_puntuales_RM2<-Emisiones_fuentes_puntuales_contaminante[Emisiones_fuentes_puntuales_RM,]


Emisiones_fuentes_puntuales_DIOX<-Emisiones_fuentes_puntuales_RM2$contaminan=="Carbon dioxide"

Emisiones_fuentes_puntuales_DIOX2<-Emisiones_fuentes_puntuales_RM2[Emisiones_fuentes_puntuales_DIOX,]


st_write(Emisiones_fuentes_puntuales_DIOX2,dsn="fuentes_pun_cont_RM_CO2.gpkg",layer="fuentes_pun_cont_RM_CO2.gpkg",driver="GPKG")
