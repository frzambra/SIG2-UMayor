#Taller 4 Dylan Bustamante y Bastian Quinteros

install.packages('sf')
library('sf')


# 1. Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

x2 <- st_point(c(-36.25,72.65))
x3 <- st_point(c(-36.25,72.65,200))
x4 <- st_point(c(-36.25,72.65,200,90))
str(x2)
str(x3)
str(x4)


#  2. Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:

#MULTIPOINT
#LINESTRING


#se tienen que crear desde una matrix
#cada geometria corresponde a un objeto sfg 

df <- data.frame(
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893)
  
)

#crear la matrix, para luego poner el multipoint y/o linestring
df <- as.matrix(df)
df

# multipoint
mpt <- st_multipoint(df[,2:1])
plot(mpt)


# linestring  

df <- data.frame(
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893)
  
)
l <- st_linestring(matrix(c(df$longitud,df$latitud),
                          ncol=2,byrow= TRUE))
plot(l)

# 3. Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  latitud= c(-33.38991,-33.38959,-33.38929,-33.38893,
             -33.38943,-33.38911,-33.38883,-33.38846),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461)
)
dfmm <- as.matrix(df[ ,3:2])
dfmm


class(df$latitud)
class(df$longitud)

mls <- st_multilinestring(
  list(dfmm[1:4, ],
       dfmm[5:8, ]))

plot(mls)

plot(mls[[1]])
plot(mls[[2]])


#4 Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
df_pol <- data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500)
)

df_polm <- as.matrix(df_pol)
coords <- rbind(df_polm, df_polm[1, ])
pol <- st_polygon(list(coords))
plot(pol)


#5 (20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435)
)

df_mpolm <- as.matrix(df_mpol[,3:2])
df_mpolm

plot(df_mpol)

mp <- st_multipolygon(
  list(
    list(
      rbind(df_mpolm[1:4,], df_mpolm[1, ])),
    list(
      rbind(df_mpolm[5:8,], df_mpolm[5, ])))
)

#Este código dividirá las geometrías en el objeto sf_df_mpol en dos grupos según el valor de la columna "poligono" y luego creará un objeto MULTIPOLYGON a partir de estos grupos. Finalmente, verifica la clase del objeto y realiza un plot de cada objeto poligonal.

class(mp)


#El objeto resultante será de clase MULTIPOLYGON y contendrá dos polígonos, uno para "poligono_1" y otro para "poligono_2". Puedes utilizar plot(mp) para visualizar los polígonos.

plot (mp)
#6 unte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto


gc <- st_geometrycollection(list(mpt,mls,pol,mp))
mpt_sfc <- st_sfc(mpt)
mls_sfc <- st_sfc(mls)
pol_sfc <- st_sfc(pol)
mp_sfc <- st_sfc(mp)

obj_sf <- st_sf(geometry= c(mpt_sfc, mls_sfc, mls_sfc, pol_sfc))
obj_sf$nombre_geometria <- c('multipunto', 'linea', 'multilinea', 'poligono')
obj_sf

#7 Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc)

mpt_sfc <- st_sfc(mpt)
ls_sfc <- st_sfc(l)
mls_sfc <- st_sfc(mls)
pol_sfc <- st_sfc(pol)
mpol_sfc <- st_sfc(mp)


obj_sf <- st_sf("geometry"=c(mpt_sfc,ls_sfc,mls_sfc,pol_sfc,mpol_sfc))

obj_sf

nombre_geom<- c("Multipunto","Linea","Multilinea","Poligono","Multipoligono")

obj_sf_nombre <- cbind(nombre_geom,obj_sf)
obj_sf_nombre

#8 Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)
)
emas <- st_as_sf(df,coords = c("longitud","latitud"))
emas$nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector: nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

emas$nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")
emas

plot(emas)



#9Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.
df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)
)

st_crs(emas)

st_crs(emas)<-4326
st_crs(emas)

emas_32719<-st_transform(emas,32719)
emas_32719

#10 Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique
#tipo de geometría
#cantidad de variables y observaciones
#sistema de referencia de coordenadas y código EPSG


getwd() # <- paara saber el directorio de trabajo


read_sf('Aire_-_Shapefile/bdide_OWD_Aire_Emisiones_fuentes_puntuales_contaminante.shp')
files <- list.files('Aire_-_Shapefile', pattern = 'shp$', full.names = TRUE)
files


capa1 <- read_sf(files[1])
capa2 <- read_sf(files[2])


#tipo de geometria
class(capa1$geometry)
class(capa2$geometry)

files2 <- list.files('Biodiversidad_-_Shapefile', pattern = 'shp$', full.names = TRUE)
files2
capa3 <- read_sf(files2[1])
capa4 <- read_sf(files2[2])
capa5 <- read_sf(files2[3])
capa6 <- read_sf(files2[4])
capa8 <- read_sf(files2[5])

#código EPSG
st_crs(capa1)$epsg
st_crs(capa2)$epsg
st_crs(capa3)$epsg
st_crs(capa4)$epsg
st_crs(capa5)$epsg
st_crs(capa6)$epsg
st_crs(capa7)$epsg

#cant de variable y observaciones
capa1
capa2
capa3
capa4
capa5
capa6
capa7

#forma rapida de leer
l_sf <- lapply(files2, read_sf)

#forma rapida para consultar geometria
lapply(l_sf,\(x) classst_geometry(x))

#para observaciones y variables 
lapply(l_sf,\(x) class(st_geometry(x)))

#para SRC
lapply(l_sf, st_crs)

#SRC EPSG 
lapply(l_sf, \(x) st_crs(x)$epsg)
#11 Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.


capa1 <-st_transform(capa1,4326)
st_crs(capa1)
capa2 <- st_transform(capa2,4326)
st_crs(capa2)
capa3 <- st_transform(capa3, 4326)
st_crs(capa3)
capa4 <- st_transform(capa4, 4326)
st_crs(capa4)
capa5 <- st_transform(capa5, 4326)
st_crs(capa5)
capa6 <- st_transform(capa6, 4326)
st_crs(capa6)
capa7 <- st_transform(capa7, 4326)
st_crs(capa7)

#12 Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

st_write(rm,dsn ="areas_protegidad_RM.gpkg",layer = "areas_protegidad_RM.gpkg",driver = "GPKG" )


#13 Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

capa5
l <-capa5$region %in% "Metropolitana" 
rm <- capa5 [l,]
plot(capa5 [l,])
write.csv2(rm,"areas_protegidad_RM.csv")

