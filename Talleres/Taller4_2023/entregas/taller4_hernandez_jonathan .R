#Jonathan Hernandez y Florencia Celis
# instala {sf}
install.packages('sf')

# cargar {sf} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene

library(sf)

#1. 
latitud<- -36.25
longitud<- -72.65
elevacion<- 200
direccion <- 90

punto2d<- st_point(c(longitud,latitud))
punto3d<- st_point(c(longitud,latitud,elevacion))
punto4d<- st_point(c(longitud,latitud,elevacion,direccion))

str(punto2d)
str(punto3d)
str(punto4d)

#2. 
dfmatriz<- as.matrix(df)
dfmatriz

mpt<- st_multipoint(dfmatriz)
ls<- st_linestring(dfmatriz)

#Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
class(mpt) 
class(ls)

st_geometry_type(mpt)
st_geometry_type(ls)
#plot
plot(mpt)
plot(ls)

#3.
df2 <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461)
)
df2
dfm1<- as.matrix(df2[,2:3])
dfm1
multilinestring<- st_multilinestring(list (dfm1[1:4,], dfm1[5:8,]))


#clase y geometria 
class(multilinestring)
st_geometry_type(multilinestring)
plot(multilinestring)

#4.
df_pol <- data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500)
)
df_pol

df_polm<- as.matrix(df_pol)
df_polm

#polygon
polygon<- st_polygon(list(rbind(df_polm,df_polm[1,])))

class(polygon)
st_geometry_type(polygon)
plot(polygon)

#5.
df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435)
)
df_mpol
df_mpolmatriz<- as.matrix(df_mpol[ ,2:3])
df_mpolmatriz

mp<- st_multipolygon(list(list(rbind(df_mpolmatriz[1:4, ],df_mpolmatriz[1, ])),list(rbind(df_mpolmatriz[5:8, ], df_mpolmatriz[5, ]))))
class(mp)
st_geometry_type(mp)
plot(mp)

#6. Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
gc<- st_geometrycollection(list(mp,polygon,multilinestring,ls,mpt))
class(gc)
plot(gc)

#7.
mpt_sfc<- st_sfc(mpt)
ls_sfc<- st_sfc(ls)
multilinestring_sfc<- st_sfc(multilinestring)
polygon_sfc<- st_sfc(polygon)
mp_sfc<- st_sfc(mp)

obj_sf<- st_sf(geometry= c(mpt_sfc,ls_sfc,multilinestring_sfc,polygon_sfc,mp_sfc))
obj_sf$nombre_geometria<- c('multipunto','linea','multilinea', 'poligono','multipoligono')
obj_sf

#8.
df3 <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)
)
emas<- st_as_sf(df3,coords = c('longitud','latitud'))
nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")
#metodo 1
emas$nombres_emas<- nombres_emas
#metodo 2 
emas<- cbind(nombres_emas,emas)

#9. sistema de referencias de coordenadasgeograficas
st_crs(emas)
#asignar src
#metodo 1 
st_crs(emas)<- 4326
st_crs(emas)

#metodo 2 
emas<- st_as_sf(df3,coords = c('longitud','latitud'),crs= 4326)
emas_32719<- st_transform(emas,32719)
st_crs(emas_32719)

coords<- st_coordinates(emas_32719)
coords

#10.(30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

#tipo de geometría
#cantidad de variables y observaciones
#sistema de referencia de coordenadas y código EPSG

# AIRE

# cap 1

Emisiones_fuentes<-st_read("Emisiones")
st_geometry_type(Emisiones_fuentes)
str(Emisiones_fuentes)
st_crs(Emisiones_fuentes)

# cap 2

Planes_prevencion<-st_read("Planes")
st_geometry_type(Planes_prevencion)
str(Planes_prevencion)
st_crs(Planes_prevencion)

# cap 3

Zonas_Saturadas<-st_read("Aire_Saturado")
st_geometry_type(Zonas_Saturadas)
str(Zonas_Saturadas)
st_crs(Zonas_Saturadas)

#BIODIVERSIDAD

# cap4
preservacion<-st_read("Area_preservacion")
st_geometry_type(preservacion)
str(preservacion)
st_crs(preservacion)

# cap5
prohibicion_caza<-st_read("Area_prohibicion_caza")
st_geometry_type(prohibicion_caza)
str(prohibicion_caza)
st_crs(prohibicion_caza)

# cap6
vegetacionales<-st_read("Vegetacional")
st_geometry_type(vegetacionales)
str(vegetacionales)
st_crs(vegetacionales)

# cap7
pisosvegetacionales2017<-st_read("Pisosvegetacionales")
st_geometry_type(pisosvegetacionales2017)
str(pisosvegetacionales2017)
st_crs(pisosvegetacionales2017)

# cap8
snaspe<-st_read("Snapes")
st_geometry_type(snaspe)
str(snaspe)
st_crs(snaspe)

#11(20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

Emisiones_fuentes_4326<-st_transform(Emisiones_fuentes,4326)
st_crs(Emisiones_fuentes_4326)

Planes_prevencion_4326<-st_transform(Planes_prevencion,4326)
st_crs(Planes_prevencion_4326)

Zonas_Saturadas_4326<-st_transform(Zonas_Saturadas,4326)
st_crs(Planes_prevencion_4326)

preservacion_4326<-st_transform(preservacion,4326)
st_crs(preservacion_4326)

prohibicion_caza_4326<-st_transform(prohibicion_caza,4326)
st_crs(prohibicion_caza_4326)

vegetacioneles_4326<-st_transform(vegetacionales,4326)
st_crs(prohibicion_caza_4326)

pisosvegetacionales2017_4326<-st_transform(pisosvegetacionales2017,4326)
st_crs(pisosvegetacionales2017_4326)

snaspe_4326<-st_transform(snaspe,4326)
st_crs(snaspe_4326)

#12,Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

snaspe
snaspe_RM<-snaspe$region=="Metropolitana"
snaspe_RM

snaspe_RM<-snaspe[snaspe_RM,]
snaspe_RM

snaspe_RMC<-snaspe_RM[c("categoria","nom_unidad")]
snaspe_RMC

write.csv2(snaspe_RMC,"areas_protegidad_RM.csv")

#13,(20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre

st_write(snaspe_RMC,dsn="areas_protegidad_RM.gpkg",layer="areas_protegidad_RM.gpkg",driver="GPKG")

#14.Respecto a la capa de fuentes puntuales contaminantes, seleccione las que emiten Dioxido de Carbono y se encuentran en la región Metropolitana. Guarde el resultado en un archivo geopackage llamado fuentes_pun_cont_RM_CO2.gpkg.
head(Emisiones_fuentes)

Emisiones_puntuales_RM<-Emisiones_fuentes$region=="Metropolitana de Santiago"

Emisiones_puntuales_RMC<-Emisiones_fuentes[Emisiones_puntuales_RM,]


Emisiones_puntuales_DIOX<-Emisiones_puntuales_RMC$contaminan=="Carbon dioxide"

Emisiones_puntuales_DIOX2<-Emisiones_puntuales_RMC[Emisiones_puntuales_DIOX,]


st_write(Emisiones_fuentes_puntuales_DIOX2,dsn="fuentes_pun_cont_RM_CO2.gpkg",layer="fuentes_pun_cont_RM_CO2.gpkg",driver="GPKG")

