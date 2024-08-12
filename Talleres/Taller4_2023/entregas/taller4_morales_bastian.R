#TALLER 4
##BASTIAN MORALES

# instala {sf}
install.packages('sf')

# cargar {sf} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene

library(sf)

#1 (10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

latitud <- -36.25
longitud <- -72.65
elevacion <- 200
direccion <- 90

D2 <-st_point(c(longitud,latitud)) #Punto de dos dimensiones
D3 <-st_point(c(longitud,latitud,elevacion)) #Punto de 3 dimensiones
D4 <-st_point(c(longitud,latitud,elevacion,direccion)) #Punto de 4 dimensiones

str(D2)
str(D3)
str(D4)

#2.(20pts)Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg: MULTIPOINT y LINESTRING.Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893))

dfm <-as.matrix(df)

#Creacion de los objetos
mp <- st_multipoint(dfm)
ls <- st_linestring(dfm)

# Verificar la clase y geometría de los objetos
class(mp)
class(ls)
st_geometry_type(mp)
st_geometry_type(ls)
# Plot de los objetos
plot(mp)
plot(ls)

#3 (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df2 <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846)

)
mdf2<-as.matrix(df2[,2:3])

ml<-st_multilinestring(
  list(mdf2[1:4,],mdf2[5:8,]))

class(ml)
st_geometry_type(ml)
plot(ml)

#4 (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

df_pol <- data.frame(
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991)
  
)
mdf_pol<-as.matrix(df_pol)

p<-st_polygon(
  list(
    rbind(mdf_pol,mdf_pol[1,])
  )
)

class(p)
st_geometry_type(p)
plot(p)

#5 (20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,-70.63500,-70.63461,-70.63396,-70.63435),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929))

matrizmpol<-as.matrix(df_mpol[,2:3])

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

#6 (20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

geometry_collection<-st_geometrycollection(
  list(mp,ls,ml,p,Multipoygon)
)

class(geometry_collection)
st_geometry_type(geometry_collection)
plot(geometry_collection)

#7 (20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

multipoint_sfc<-st_sfc(mp)
linestring_sfc<-st_sfc(ls)
multilinestring_sfc<-st_sfc(ml)
polygon_sfc<-st_sfc(p)
Multipoygon_sfc<-st_sfc(Multipoygon)

obj_sf<-st_sf("geometry"=c(multipoint_sfc,linestring_sfc,multilinestring_sfc,polygon_sfc,Multipoygon_sfc))

obj_sf

nombre_geom<-c("Multipunto","Linea","Multilinea","Poligono","Multipoligono")

obj_sf_nombre<-cbind(nombre_geom,obj_sf)
obj_sf_nombre

#8 (30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

dfemas <- data.frame(
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71),
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21))

emas<-st_as_sf(dfemas,coords = c("longitud","latitud"))
emas

nombres_ema <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#agregar el nombre de las nuevas columnas
emas_nombres<-cbind(nombres_ema,emas)
emas_nombres
class(emas_nombres)

#9 (20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

st_crs(emas_nombres)

st_crs(emas_nombres)<-4326
st_crs(emas_nombres)

emas_32719<-st_transform(emas_nombres,32719)
emas_32719

#10(30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:
  
  #tipo de geometría
#cantidad de variables y observaciones
#sistema de referencia de coordenadas y código EPSG

#biodiversidad

#c1
area_preservacion_ecologica<-st_read("Bio/area_preservacion_ecologica")
st_geometry_type(area_preservacion_ecologica)
str(area_preservacion_ecologica)
st_crs(area_preservacion_ecologica)

#c2
area_prohibicion_caza<-st_read("Bio/area_prohibicion_caza")
st_geometry_type(area_prohibicion_caza)
str(area_prohibicion_caza)
st_crs(area_prohibicion_caza)

#c3
vegetacionales_gajardo<-st_read("Bio/vegetacionales_gajardo")
st_geometry_type(vegetacionales_gajardo)
str(vegetacionales_gajardo)
st_crs(vegetacionales_gajardo)

#c4
pisosvegetacionalespliscoff2017<-st_read("Bio/pisosvegetacionalespliscoff2017")
st_geometry_type(pisosvegetacionalespliscoff2017)
str(pisosvegetacionalespliscoff2017)
st_crs(pisosvegetacionalespliscoff2017)

#c5
snaspe_2021<-st_read("Bio/snaspe_2021")
st_geometry_type(snaspe_2021)
str(snaspe_2021)
st_crs(snaspe_2021)

#Aire

#c6
Emisiones_fuentes_puntuales_contaminante<-st_read("Aire/Aire_Emisiones_fuentes_puntuales_contaminante")
st_geometry_type(Emisiones_fuentes_puntuales_contaminante)
str(Emisiones_fuentes_puntuales_contaminante)
st_crs(Emisiones_fuentes_puntuales_contaminante)

#c7
planes_prevencion_descontaminacion<-st_read("Aire/Aire_planes_prevencion_descontaminacion")
st_geometry_type(planes_prevencion_descontaminacion)
str(planes_prevencion_descontaminacion)
st_crs(planes_prevencion_descontaminacion)

#c8
Zonas_Saturadas_Latentes<-st_read("Aire/Aire_Zonas_Saturadas_Latentes")
st_geometry_type(Zonas_Saturadas_Latentes)
str(Zonas_Saturadas_Latentes)
st_crs(Zonas_Saturadas_Latentes)

#11 (20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

ape4326<-st_transform(area_preservacion_ecologica,4326)
st_crs(ape4326)

apc4326<-st_transform(area_prohibicion_caza,4326)
st_crs(apc4326)

vg4326<-st_transform(vegetacionales_gajardo,4326)
st_crs(vg4326)

pv2017_4326<-st_transform(pisosvegetacionalespliscoff2017,4326)
st_crs(pv2017_4326)

s2021_4326<-st_transform(snaspe_2021,4326)
st_crs(s2021_4326)

efpc4326<-st_transform(Aire_Emisiones_fuentes_puntuales_contaminante,4326)
st_crs(efpc4326)

ppc4326<-st_transform(planes_prevencion_descontaminacion,4326)
st_crs(ppc4326)

zsl4326<-st_transform(Zonas_Saturadas_Latentes,4326)
st_crs(zsl4326)

#12,Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.
snaspe_2021
RM<-snaspe_2021$region=="Metropolitana"
RM

srm<-snaspe_2021[RM,]
srm

srm2<-srm[c("categoria","nom_unidad")]
srm2

write.csv2(srm2,"areas_protegidad_RM.csv")

#13.Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

st_write(snaspe_RM2,dsn="areas_protegidad_RM.gpkg",layer="areas_protegidad_RM.gpkg",driver="GPKG")

#14.Respecto a la capa de fuentes puntuales contaminantes, seleccione las que emiten Dioxido de Carbono y se encuentran en la región Metropolitana. Guarde el resultado en un archivo geopackage llamado fuentes_pun_cont_RM_CO2.gpkg.
head(Emisiones_fuentes_puntuales_contaminante)

erm<-Emisiones_fuentes_puntuales_contaminante$region=="Metropolitana de Santiago"

erm2<-Emisiones_fuentes_puntuales_contaminante[erm,]


co2<-erm2$contaminan=="Carbon dioxide"

Emisiones_fuentes_puntuales_DIOX2<-erm2[co2,]


st_write(Emisiones_fuentes_puntuales_DIOX2,dsn="fuentes_pun_cont_RM_CO2.gpkg",layer="fuentes_pun_cont_RM_CO2.gpkg",driver="GPKG")

