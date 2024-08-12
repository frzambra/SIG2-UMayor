#TALLER 4
#INTEGRANTES: TOMÁS GOUGAIN, ANDONI TARGARONA

install.packages('sf')

library(sf)

#1. (10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str.

longitud<--72.65
latitud<--36.25
elevacion<-200
direccion<-90

#dos dimensiones
xy<-st_point(c(longitud,latitud))

str(xy)

#tres dimensiones
xyz<-st_point(c(longitud,latitud,elevacion))

str(xyz)

#cuatro dimensiones
xyzm<-st_point(c(longitud,latitud,elevacion,direccion))

str(xyzm)

#2. (20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg:

df <- data.frame(latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),longitud = c(-70.63500,-70.63468,-70.63435,-70.63396))

df2<-as.matrix(df)
df2

#multipoint
multipoint<-st_multipoint(df2)
multipoint

#linestring
linestring<-st_linestring(df2)
linestring

#plots
plot(multipoint)

plot(linestring)

#3. (20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(linea = c(rep('linea_1',4),rep('linea_2',4)),latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,-33.38943,-33.38911,-33.38883,-33.38846),longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,-70.63566,-70.63531,-70.63500,-70.63461))

#crear primer linestring
latitud1<-(df$latitud[1:4])
longitud1<-(df$longitud[1:4])

C1<-cbind(latitud1,longitud1)
            
linea1<-st_linestring(C1)

#crear segundo linestring
latitud2<-(df$latitud[5:8])
longitud2<-(df$longitud[5:8])

C2<-cbind(latitud2,longitud2)

linea2<-st_linestring(C2)

multilinea<-st_multilinestring(list(linea1,linea2))

#clase
class(multilinea)

#geometria
st_geometry_type(multilinea)

#plot
plot(multilinea)

#4. (20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

df_pol<-data.frame(
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38943),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63566))

latitud<-df_pol$latitud
longitud<-df_pol$longitud

p<-cbind(latitud,longitud)

pol<-st_polygon(list(p))

#clase
class(pol)

#geometria
st_geometry_type(pol)

#plot
plot(pol)

#5. (20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df_mpol <- data.frame(
  poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
              -33.38883,-33.38846,-33.38893,-33.38929),
  longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
               -70.63500,-70.63461,-70.63396,-70.63435))

#transformar a matriz
df_mpol2<-as.matrix(df_mpol[,3:2])
df_mpol2

a<-rbind(df_mpol2[1:4,],df_mpol2[1,])

b<-rbind(df_mpol2[5:8,],df_mpol2[5,])

#crear primer poligono
pol1<-st_polygon(list(a))

#crear segundo poligono
pol2<-st_polygon(list(b))

#crear multipoligono
multipol<-st_multipolygon(list(pol1,pol2))

#clase
class(multipol)

#geometria
st_geometry_type(multipol)

#plot
plot(multipol)

#6. (20pts) Junte todas las geometrias anteriores en un objeto sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

col<-st_geometrycollection(list(multipoint,linestring,multilinea,pol,multipol))

class(col)

st_geometry_type(col)

plot(col)

#7.(20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

#transfomar
sfc<-st_sfc(multipoint,linestring,multilinea,pol,multipol)

sf<-st_sf(sfc)
sf

#8. (30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)
)

m<-as.matrix(df)
m


a <- st_point(m[1,])
b <- st_point(m[2,])
c <- st_point(m[3,])
d <- st_point(m[4,])
e <- st_point(m[5,])
f <- st_point(m[6,])
g <- st_point(m[7,])
h <- st_point(m[8,])
i <- st_point(m[9,])
j <- st_point(m[10,])
  
sfc <- st_sfc(a,b,c,d,e,f,g,h,i,j)  

sf <- st_as_sf(sfc)

#9. (20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

st_crs(sf) <- 4326
st_crs(sf)
st_transform(sf,crs = 32719)
st_crs(sf)

#10. (30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

files<-list.files("datosr/capas/Aire_-_Shapefile",pattern="shp$",full.names = TRUE)
files
capa1<-read_sf(files[1])
capa2<-read_sf(files[2])

capa1
capa2


#tipo de geometría
st_geometry_type(capa1)
st_geometry_type(capa2)

#cantidad de variables y observaciones
lapply(capa1,\(x) dim(x))
lapply(capa2,\(x) dim(x))

#sistema de referencia de coordenadas y código EPSG
lapply(capa1,st_crs)

#11. (20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

capa1<-st_transform(capa1,4326)
capa2<-st_transform(capa2,4326)

#12. (30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

biodi<-list.files("datosr/capas/Biodiversidad_-_Shapefile",pattern="shp$",full.names = TRUE)



