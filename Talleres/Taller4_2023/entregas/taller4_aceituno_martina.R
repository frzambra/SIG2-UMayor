#taller 4          
#Nombres: Martina Aceituno y Maria Esperanza Baeza

#1.10pts) Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

# Instala y carga la biblioteca 'sf' si aún no lo has hecho
install.packages("sf")
library(sf)

# Crear un punto de dos dimensiones
point2D <- st_point(c(-72.65, -36.25))
str(point2D)

# Crear un punto de tres dimensiones
point3D <- st_point(c(-72.65, -36.25, 200))
str(point3D)

# Crear un punto de cuatro dimensiones
point4D <- st_point(c(-72.65, -36.25, 200, 90))
str(point4D)

#2.(20pts) Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg: MULTIPOINT y LINESTRING
# Crear un objeto MULTILINESTRING

# Crear un objeto MULTIPOINT
df <- data.frame(
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893),
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396)
)
multipoint <- st_multipoint(matrix(c(df$longitud, df$latitud), ncol = 2))
str(multipoint)

# Crear un objeto LINESTRING
linestring <- st_linestring(matrix(c(df$longitud, df$latitud), ncol = 2))
str(linestring)

# Hacer un plot de los objetos
par(mfrow=c(2, 2))  # Dividir el espacio de gráficos en 2x2

plot(point2D, main="Punto 2D")
plot(point3D, main="Punto 3D")
plot(point4D, main="Punto 4D")
plot(multipoint, main="MULTIPOINT")
plot(linestring, main="LINESTRING")

#3.(20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

df <- data.frame(
  linea = c(rep('linea_1', 4), rep('linea_2', 4)),
  latitud = c(
    -33.38991, -33.38959, -33.38929, -33.38893,
    -33.38943, -33.38911, -33.38883, -33.38846
  ),
  longitud = c(
    -70.63500, -70.63468, -70.63435, -70.63396,
    -70.63566, -70.63531, -70.63500, -70.63461
  )
)

# Organizar el DataFrame por 'linea'
df <- df[order(df$linea), ]

# Crear un objeto MULTILINESTRING
lines <- list()
for (line_id in unique(df$linea)) {
  line_df <- df[df$linea == line_id, ]
  line_coords <- matrix(c(line_df$longitud, line_df$latitud), ncol = 2)
  line <- st_linestring(line_coords)
  lines[[line_id]] <- line
}
multilinestring <- st_multilinestring(lines)

# Verificar la clase y geometría del objeto
class(multilinestring)
st_geometry_type(multilinestring)

# Hacer un plot del objeto MULTILINESTRING
plot(multilinestring, col = c("green", "purple"), lwd = 2, main = "MULTILINESTRING")

#4.(20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

# Crear un objeto POLYGON
df_pol <- data.frame(
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991, -33.38943),
  longitud = c(-70.63566, -70.63531, -70.63468, -70.63500, -70.63566)
)

# Crear una matriz de coordenadas (x, y) en el orden correcto
coords <- cbind(df_pol$longitud, df_pol$latitud)

# Crear el objeto POLYGON
polygon <- st_polygon(list(coords))
polygon <- st_sfc(polygon)

# Verificar la clase y geometría del objeto
class(polygon)
st_geometry_type(polygon)

# Hacer un plot del objeto POLYGON
plot(polygon, main = "POLYGON", col = "pink", lwd = 2)

#5.(20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

# Crear un objeto MULTIPOLYGON
df_mpol <- data.frame(
  poligono = c(rep('poligono_1', 4), rep('poligono_2', 4)),
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991,
    -33.38883, -33.38846, -33.38893, -33.38929),
  longitud = c(
    -70.63566, -70.63531, -70.63468, -70.63500,
    -70.63500, -70.63461, -70.63396, -70.63435
  ))

# Organizar el DataFrame utilizando la funcion poligono
df_mpol <- df_mpol[order(df_mpol$poligono), ]

# Crear una lista de POLYGONs
polygons <- list()
for (polygon_id in unique(df_mpol$poligono)) {
  polygon_df <- df_mpol[df_mpol$poligono == polygon_id, ]
  
  # Agregar el primer punto al final de cada polígono para cerrarlo
  coords <- rbind(
    matrix(c(polygon_df$longitud, polygon_df$latitud), ncol = 2),
    matrix(c(polygon_df$longitud[1], polygon_df$latitud[1]), ncol = 2)
  )
  
  polygon <- st_polygon(list(coords))
  polygons[[polygon_id]] <- polygon
}
multipolygon <- st_multipolygon(polygons)

# Verificar la clase y geometría del objeto para notar que es un multipolygon
class(multipolygon)
st_geometry_type(multipolygon)

# Hacer un plot del objeto MULTIPOLYGON
plot(multipolygon, col = c("lightblue", "lightgreen"), lwd = 2, main = "MULTIPOLYGON")

#6.(20pts) Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

# Crear un objeto POINT de dos dimensiones
point2D <- st_point(c(-72.65, -36.25))

# Crear un objeto POINT de tres dimensiones
point3D <- st_point(c(-72.65, -36.25, 200))

# Crear un objeto POINT de cuatro dimensiones
point4D <- st_point(c(-72.65, -36.25, 200, 90))

# Crear un objeto MULTIPOINT
df_multipoint <- data.frame(
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893),
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396)
)
multipoint <- st_multipoint(matrix(c(df_multipoint$longitud, df_multipoint$latitud), ncol = 2))

# Crear un objeto LINESTRING
df_linestring <- data.frame(
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893),
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396)
)
linestring <- st_linestring(matrix(c(df_linestring$longitud, df_linestring$latitud), ncol = 2))

# Crear un objeto POLYGON
df_polygon <- data.frame(
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991, -33.38943),
  longitud = c(-70.63566, -70.63531, -70.63468, -70.63500, -70.63566)
)
# Reorganiza las coordenadas en orden correcto (longitud, latitud)
polygon_coords <- st_polygon(list(rbind(cbind(df_polygon$longitud, df_polygon$latitud))))
polygon <- st_sfc(polygon_coords)

# Crear un objeto MULTIPOLYGON
df_mpol <- data.frame(
  poligono = c(rep('poligono_1', 4), rep('poligono_2', 4)),
  latitud = c(
    -33.38943, -33.38911, -33.38959, -33.38991,
    -33.38883, -33.38846, -33.38893, -33.38929
  ),
  longitud = c(
    -70.63566, -70.63531, -70.63468, -70.63500,
    -70.63500, -70.63461, -70.63396, -70.63435
  )
)

df_mpol <- df_mpol[order(df_mpol$poligono), ]
polygons <- list()
for (polygon_id in unique(df_mpol$poligono)) {
  polygon_df <- df_mpol[df_mpol$poligono == polygon_id, ]
  coords <- rbind(
    matrix(c(polygon_df$longitud, polygon_df$latitud), ncol = 2),
    matrix(c(polygon_df$longitud[1], polygon_df$latitud[1]), ncol = 2)
  )
  polygon <- st_polygon(list(coords))
  polygons[[polygon_id]] <- polygon
}
multipolygon <- st_multipolygon(polygons)

# Crear un objeto GEOMETRY COLLECTION
geometry_collection <- st_sfc(point2D, point3D, point4D, multipoint, linestring, polygon, multipolygon)

# Verificar la clase y geometría del objeto
class(geometry_collection)
st_geometry_type(geometry_collection)

# Hacer un plot del objeto GEOMETRY COLLECTION
plot(geometry_collection, col = "red", lwd = 2, main = "GEOMETRY COLLECTION")

#7.(20pts) Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

# Convertir los objetos sfg en sfc (excepto el objeto Geometry Collection)
point2D <- st_sfc(point2D)
point3D <- st_sfc(point3D)
point4D <- st_sfc(point4D)
multipoint <- st_sfc(multipoint)
linestring <- st_sfc(linestring)
polygon <- st_sfc(polygon)
multipolygon <- st_sfc(multipolygon)

# Crear un objeto sf para cada geometría
df_point2D <- st_sf(nombre_geometria = "point2D", geometry = point2D)
df_point3D <- st_sf(nombre_geometria = "point3D", geometry = point3D)
df_point4D <- st_sf(nombre_geometria = "point4D", geometry = point4D)
df_multipoint <- st_sf(nombre_geometria = "multipoint", geometry = multipoint)
df_linestring <- st_sf(nombre_geometria = "linestring", geometry = linestring)
df_polygon <- st_sf(nombre_geometria = "polygon", geometry = polygon)
df_multipolygon <- st_sf(nombre_geometria = "multipolygon", geometry = multipolygon)

# Combina todos los objetos sf en uno solo
sf_combined <- rbind(df_point2D, df_point3D, df_point4D, df_multipoint, df_linestring, df_polygon, df_multipolygon)

print(sf_combined)

#8.(30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).

# Datos de coordenadas de las EMAs
df <- data.frame(
  latitud = c(-33.70, -33.07, -33.12, -33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.10, -70.92, -70.76, -70.63, -70.71)
)

# Nombres de las EMAs, de ahi tomamos algunos datos como ejemplos
nombres_emas <- c("San Diego", "Huechún Ex Lampa", "Til Til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

# Crear un objeto sf con coordenadas y nombres
emas_sf <- st_as_sf(df, coords = c("longitud", "latitud"), crs = 4326)

# crear una columna con los nombres
emas_sf$nombre_ema <- nombres_emas

# mostrar el objeto sf
print(emas_sf)

#9.(20pts) Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

# Asignar SRC geográficas (WGS84) al objeto emas_sf
emas_sf <- st_set_crs(emas_sf, 4326)

# Transformar a coordenadas UTM Huso 19 Sur (WGS84)
emas_sf_utm <- st_transform(emas_sf, 32719)

# mostrar el objeto sf con el nuevo SRC
print(emas_sf_utm)

#10.(30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:#tipo de geometría
#cantidad de variables y observaciones
#sistema de referencia de coordenadas y código EPSG

capa1<-read_sf('Aire_-_Shapefile/bdide_OWD_Aire_planes_prevencion_descontaminacion.shp')

files<-list.files('Aire_-_Shapefile',pattern = 'shp$',full.names = TRUE)
capa1<-read_sf(files[1])
capa2<-read_sf(files[2])

files2<-list.files('Biodiversidad_-_Shapefile',pattern = 'shp$',full.names = TRUE)

capa3<-read_sf(files2[1])
capa4<-read_sf(files2[2])
capa5<-read_sf(files2[3])
capa6<-read_sf(files2[4])
capa7<-read_sf(files2[5])

#tipo de geometria
class(capa1$geometry)
class(capa2$geometry)

#observaciones y variables
print(capa1)
print(capa2)

#sistema de referencia de coordenadas
st_crs(capa1)$epsg
st_crs(capa2)$epsg

#leer las capas
l_sf<-lapply(files2,read_sf)

#formas de consultar geometría
lapply(l_sf,\(x)dim(x))

#SRC
lapply(l_sf,\(x))

class(capa1$geometry)

#SRC EPSG
lapply(l_sf,\(x)st_crs(x)$epsg)
l_4326<-lapply(l_sf,\(x)st_transform(x,4326))

#11.(20pts) Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.


capa1<-st_transform(capa1,4326)
str_crs(capa1)
capa2<-st_transform(capa2,4326)
str_crs(capa2)
capa3<-st_transform(capa3,4326)
str_crs(capa3)
capa4<-st_transform(capa4,4326)
str_crs(capa4)
capa5<-st_transform(capa5,4326)
str_crs(capa5)
capa6<-st_transform(capa6,4326)
str_crs(capa6)
capa7<-st_transform(capa7,4326)
str_crs(capa7)
capa8<-st_transform(capa8,4326)
str_crs(capa8)

#otra forma

# Transformar el SRC al código EPSG:4326
mi_capa_transformada <- st_transform(capa1, crs = 4326)

# Comprobar el SRC de la capa original
crs_original <- st_crs(capa1)
lapply("SRC de la capa original:", crs_original, "\n")

# Comprobar el SRC de la capa transformada
crs_transformada <- st_crs(mi_capa_transformada)
lapply("SRC de la capa transformada:", crs_transformada, "\n")

#12.(30pts) Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

#capa cargada como "biodi_snaspe_2021" y la capa tiene las columnas "categoria" y "nom_unidad"

# Realiza la selección de áreas protegidas en la Región Metropolitana
areas_protegidas_RM <- biodi_snaspe_2021[biodi_snaspe_2021$REGION == "Metropolitana", c("categoria", "nom_unidad")]

# Guarda el resultado en un archivo .csv con configuración latina
write.csv(areas_protegidas_RM, file = "areas_protegidas_RM.csv", row.names = FALSE, fileEncoding = "latin1")


#13.(20pts) Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.


#capa en formato Geopackage
st_write(areas_protegidas_RM, "areas_protegidas_RM.gpkg")

#otra forma

nc=st_read(system.file("shape/nc.shp",package="sf"))
st_write(nc,dsn='areas_protegidas_RM.gpkg',layer='nc')

nc<-read_sf('areas_protegidas_RM.gpkg')
st_layers('areas_protegidas_RM.gpkg')


