#Constanza Araya
#Taller 4 *longitud y latitud (como varia en x de y)
install.packages("sf")
library(sf)

#1. (10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str
latitud <- -36.25
longitud <- -72.65
elevacion <- 200
direccion <- 90
#dimension 2
d1<- st_point(c(longitud,latitud))
d1
str(d1)
class(d1)
#dimension 3
d2<-st_point(c(longitud,latitud,elevacion))
d2
str(d2)
class(d2)
#dimension 4
d3<-st_point(c(longitud,latitud,elevacion,direccion))
d3
str(d3)
class(d3)

#2. (20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:
df <- data.frame(
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396)
)
df
#MULTIPOINT
dfm<-as.matrix(df)
multi<- st_multipoint(dfm[,2:1])
class(multi)
st_geometry(multi)
plot(multi)
#LINESTRING
ls<- st_linestring(dfm[2:1,2:1])
ls
class(ls)
st_geometry(ls)
plot(ls)
#Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.


#3. (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461)
)

dfm<-as.matrix(df[,2:3])
mls<-st_multilinestring(list(dfm[1:4,2:1],dfm[5:8,2:1]))
plot(mls)
class(mls)
st_geometry(mls)

#4. (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
df_pol <- data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500))

df_pola<-as.matrix(df_pol)
pol<-st_polygon(list(rbind(df_pola,df_pola[1,])))
plot(pol)
class(pol)
st_geometry(pol)

#5. (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435)
)
#convierto df mpol a una matris, solo tomo la columna de la latitud y longitud 
df_mpoli<- as.matrix(df_mpol[,3:2])
mpo<- st_multipolygon(list(list(rbind(df_mpoli[1:4,],df_mpoli[1,])),(list(rbind(df_mpoli[5:8,],df_mpoli[5,])))))
plot(mpo)
class(mpo)
st_geometry(mpo)
#6. (20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
gc<-st_geometrycollection(list(pol,mpo,multi,ls,mls))
plot(gc)
class(gc)

#7. (20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).
multi_sfc<-st_sfc(multi)
class(multi_sfc)
ls_sfc<-st_sfc(ls)
class(ls_sfc)
mls_sfc<-st_sfc(mls)
class(mls_sfc)
pol_sfc<-st_sfc(pol)
class(pol_sfc)
mpo_sfc<-st_sfc(mpo)
class(mpo)

obj_sf<-st_sf(geometry=c(multi_sfc,ls_sfc,mls_sfc,pol_sfc,mpo_sfc))
obj_sf$nombre_geometria<-c("multipunto","linea","multilinea","poligono","multipoligono")
obj_sf

#8. (30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).
#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector:
df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71))
emas<-st_as_sf(df, coords = c("longitud","latitud"))

nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

emas$nombres_emas<-nombres_emas
plot(emas)
st_crs(emas)
class(emas)

#9. (20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.
st_crs(emas)

st_crs(emas)<-4326
st_crs(emas)

emas_32719<-st_transform(emas,32719)
emas_32719

#10. (30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

##biodiversidad

#capa1
a_preservacion_ecologica<-st_read("biodiversidad/bio_area_preservacion")
st_geometry_type(a_preservacion_ecologica)
str(a_preservacion_ecologica)
st_crs(a_preservacion_ecologica)

#capa2
bio_area_prohibicion<-st_read("biodiversidad/bio_area_prohibicion")
st_geometry_type(bio_area_prohibicion)
str(bio_area_prohibicion)
st_crs(bio_area_prohibicion)

#capa3
bio_vegetales<-st_read("biodiversidad/bio_vegetacionales")
st_geometry_type(bio_vegetales)
str(bio_vegetales)
st_crs(bio_vegetales)

#capa4
bio_pisosvegetacionales<-st_read("biodiversidad/bio_pisosvegetacionales")
st_geometry_type(bio_pisosvegetacionales)
str(bio_pisosvegetacionales)
st_crs(bio_pisosvegetacionales)

#capa5
bio_snaspe<-st_read("biodiversidad/bio_snaspe")
st_geometry_type(bio_snaspe)
str(bio_snaspe)
st_crs(bio_snaspe)

##Aire

#capa7
aire_preservacion<-st_read("aire/aire_prevension")
st_geometry_type(aire_preservacion)
str(aire_preservacion)
st_crs(aire_preservacion)

#capa8
Zonas_Saturadas_Latentes<-st_read("aire/aire_saturadas")
st_geometry_type(Zonas_Saturadas_Latentes)
str(Zonas_Saturadas_Latentes)
st_crs(Zonas_Saturadas_Latentes)


#11. (20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.
a_preservacion_ecologica_4326<-st_transform(a_preservacion_ecologica,4326)
st_crs(a_preservacion_ecologica_4326)

a_prohibicion_caza_4326<-st_transform(bio_area_prohibicion,4326)
st_crs(a_prohibicion_caza_4326)

vegetacionales_gajardo_4326<-st_transform(bio_vegetales,4326)
st_crs(vegetacionales_gajardo_4326)

pisos_vegetacionalespliscoff2017_4326<-st_transform(bio_pisosvegetacionales,4326)
st_crs(pisos_vegetacionalespliscoff2017_4326)

snaspe_2021_4326<-st_transform(bio_snaspe,4326)
st_crs(snaspe_2021_4326)

planes_prevencion_descontaminacion_4326<-st_transform(aire_preservacion,4326)
st_crs(planes_prevencion_descontaminacion_4326)

Zonas_Saturadas_Latentes_4326<-st_transform(Zonas_Saturadas_Latentes,4326)
st_crs(Zonas_Saturadas_Latentes_4326)

#12. (30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.
bio_snaspe
snaspe_RM_posiciones<-bio_snaspe$region=="Metropolitana"
snaspe_RM_posiciones

snaspe_RM<-bio_snaspe[snaspe_RM_posiciones,]
snaspe_RM

snaspe_RM2<-snaspe_RM[c("categoria","nom_unidad")]
snaspe_RM2

write.csv2(snaspe_RM2,"areas_protegidad_RM.csv")

#13. (20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.
st_write(bio_snaspe,dsn="areas_protegidad_RM.gpkg",layer="areas_protegidad_RM.gpkg",driver="GPKG")
