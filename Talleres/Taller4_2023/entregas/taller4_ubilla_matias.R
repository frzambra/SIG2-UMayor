install.packages("sf")
library("sf")
install.packages("tibble")
library("tibble")




# 1. (10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

x <- st_point(c(-36.25,-72.65,200,90))
plot(x)
str(x)

# 2. (20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:
MULTIPOINT
LINESTRING
#Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396)
)
dfm <- as.matrix(df)
dmp <- st_multipoint(dfm)
plot(dmp)
ln <- st_linestring(dmp)
plot(ln)

# 3. (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
df <- data.frame(
  linea = c(rep('linea_1',4),rep('linea_2',4)),
  latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
              -33.38943,-33.38911,-33.38883,-33.38846),
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
               -70.63566,-70.63531,-70.63500,-70.63461)
)
dfmln <- as.matrix(df[,2:3])
dfml <- st_multilinestring(list(dfmln[1:4,2:1],dfmln[5:8,2:1]))
plot(dfml)

# 4. (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
df_pol <- data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500)
)
dpol <- as.matrix(df_pol)
de <- st_polygon(list(rbind(dpol[1:4,],dpol[1,])))
de
plot(de)

# 5. (20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435)
)



df_mpol 

dmpl <- as.matrix(df_mpol[,3:2])


mpol <- st_multipolygon(list(list(rbind(dmpl[1:4,],dmpl[1,])),list(rbind(dmpl[5:8,],dmpl[5,]))))


mpol


plot(mpol)

# 6. (20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

col <- st_geometrycollection(list(dmp,dfml,de,mpol))
col
plot(col)
 plot(dmp)
plot(dfml)
plot(de)
plot(mpol)

# 7. (20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

sfcmp <-st_sfc(dmp)
sfcmp
sfcml <-st_sfc(dfml)
sfcml
sfcpol <-st_sfc(de)
sfcpol
sfcmulpol <- st_sfc(mpol)
sfcmulpol
ll <- st_sf(geometry = c(sfcmp,sfcml,sfcmulpol,sfcpol))
ll$nombre_geometria <- c("multipunto","multilinea","multipoligono","poligono")
ll

#8. (30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).
df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)
)
emas <- st_as_sf(df,coords = c("longitud","latitud"))
emas$nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector: nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

emas$nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")
emas
# 9. (20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

st_crs(emas) <-4326
st_crs(emas)
st_transform(emas, crs = 32719)
st_crs(emas)
# 10. (30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

files <- list.files("Aire_-_Shapefile",pattern = "shp$",full.names = TRUE)
files
capa1 <-read_sf(files[1])
capa2 <-read_sf(files[2])
capa3 <-read_sf(files[3])
capa3
capa1
capa2
files1 <- list.files("Biodiversidad_-_Shapefile",pattern = "shp$",full.names = TRUE)
files1
capa11 <-read_sf(files1[1])
capa22 <-read_sf(files1[2])
capa32 <-read_sf(files1[3])
capa4 <- read_sf(files1[4])
capa5 <-read_sf(files1[5])
#tipo de geometría
class(capa1$geometry)
class(capa2$geometry)
class(capa3$geometry)
class(capa11$geometry)
class(capa22$geometry)
class(capa32$geometry)
class(capa4$geometry)
class(capa5$geometry)



#cantidad de variables y observaciones
dim(capa1)
dim(capa2)
dim(capa3)
dim(capa11)
dim(capa22)
dim(capa32)
dim(capa4)
dim(capa5)
#sistema de referencia de coordenadas y código EPSG
st_crs(capa1)$epsg
st_crs(capa2)$epsg
st_crs(capa3)$epsg
st_crs(capa11)$epsg
st_crs(capa22)$epsg
st_crs(capa32)$epsg
st_crs(capa4)$epsg
st_crs(capa5)$epsg
# 11. (20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.
capa1 <-st_transform(capa1, crs = 4326)
st_crs(capa1)$epsg
capa2 <-st_transform(capa2, crs = 4326)
st_crs(capa2)$epsg
capa3 <-st_transform(capa3, crs = 4326)
st_crs(capa3)$epsg
capa11 <-st_transform(capa11, crs = 4326)
st_crs(capa11)$epsg
capa22 <-st_transform(capa22, crs = 4326)
st_crs(capa22)$epsg
capa32 <-st_transform(capa32, crs = 4326)
st_crs(capa32)$epsg
capa4 <- st_transform(capa4, crs = 4326)
st_crs(capa4)$epsg
capa5<-st_transform(capa5, crs = 4326)
st_crs(capa5)$epsg



# 12. (30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.
capa5
l <-capa5$region %in% "Metropolitana" 
rm <- capa5 [l,]
plot(capa5 [l,])
write.csv2(rm,"areas_protegidad_RM.csv")

# 13. (20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.
st_write(rm,dsn ="areas_protegidad_RM.gpkg",layer = "areas_protegidad_RM.gpkg",driver = "GPKG" )






