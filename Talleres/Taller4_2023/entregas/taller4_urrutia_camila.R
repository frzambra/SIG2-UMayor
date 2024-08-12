# instala {sf}
install.packages('sf')

# cargar {sf} en el entorno de R para poder utilizar 
# las funciones adicionales para manejo de datos vectoriales que contiene

library(sf)

# Ejercicios

# 1. Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str

?str

library(sf)

# Crear objetos sfg de punto
point_2d <- st_point(c(-72.65, -36.25), dim = 2)
point_3d <- st_point(c(-72.65, -36.25, 200))
point_4d <- st_point(c(-72.65, -36.25, 200,90))

# Verificar la estructura
str(point_2d)
str(point_3d)
str(point_4d)

# 2.Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg: MULTIPOINT y LINESTRING. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.

#definir df
df <- data.frame(
  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396),
 latitud = c(-33.38991,-33.38959,-33.38929,-33.38893))
df

# Convertir el data frame en una matriz
matriz_1 <- as.matrix(df)
matriz_1

# Verificar la estructura de la matriz
str(matriz_1)
matriz_1

library(sf)

# Crear un objeto sfg de tipo MULTIPOINT a partir de la matriz
multipoint <- st_multipoint(matriz_1)
str(multipoint)
plot(multipoint)
# Crear un objeto sfg de tipo LINESTRING a partir de la matriz
linestring <- st_linestring(list(matriz_1[1:4,],matriz_1[5:8,]))
plot(linestring)

# Verificar la clase y geometría de los objetos
class(multipoint)
class(linestring)

# Hacer un plot de cada objeto
plot(multipoint)
plot(linestring)


# 3.(20pts) Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
#df <- data.frame(
  #linea = c(rep('linea_1',4),rep('linea_2',8)),
  #latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
           #   -33.38943,-33.38911,-33.38883,-33.38846),
  #longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
          #     -70.63566,-70.63531,-70.63500,-70.63461))

# Crear objeto MULTILINESTRING
df_2 <- data.frame(
  linea = c(rep('linea_1', 4), rep('linea_2', 4)),
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396,
               -70.63566, -70.63531, -70.63500, -70.63461),
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893,
              -33.38943, -33.38911, -33.38883, -33.38846))
df_2
matriz_2 <- as.matrix(df_2[,2:3])
multilinestring <- st_multilinestring(list(matriz_2[1:4,],matriz_2[5:8,]))

# Verificar la clase y geometría
class(multilinestring)

# Hacer un plot del objeto
plot(multilinestring)

# 4.(20pts) Utilice las coordenadas en el data.frame df_pol para crear un objeto sfg de tipo POLYGON. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto
#df_pol <- data.frame(
 # latitud = c(-33.38943,-33.38911,-33.38959,-33.38991),
  #longitud = c(-70.63566,-70.63531,-70.63468,-70.63500))

# Crear objeto POLYGON
df_pol <- data.frame( longitud = c(-70.63566, -70.63531, -70.63468, -70.63500),latitud = c(-33.38943, -33.38911, -33.38959, -33.38991))
matriz_pol <- as.matrix(df_pol)
matriz_pol
df_pol
pol <-st_polygon(list(rbind(matriz_pol,matriz_pol[1,])))
pol
# Verificar la clase y geometría
class(pol)

# Hacer un plot del objeto
plot(pol)

# 5.20pts) Utilice las coordenadas en el data.frame df_mpol para crear un objeto sfg de tipo MULTIPOLYGON que contenga dos polygonos. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
#df_mpol <- data.frame(
 # poligono = c(rep('poligono_1',4),rep('poligono_2',4)),
  #latitud = c(-33.38943,-33.38911,-33.38959,-33.38991,
   #           -33.38883,-33.38846,-33.38893,-33.38929),
  #longitud = c(-70.63566,-70.63531,-70.63468,-70.63500,
   #            -70.63500,-70.63461,-70.63396,-70.63435))

# Crear objeto MULTIPOLYGON
df_mpol <- data.frame(
  poligono = c(rep('poligono_1', 4), rep('poligono_2', 4)),longitud = c(-70.63566, -70.63531, -70.63468, -70.63500,
               -70.63500, -70.63461, -70.63396, -70.63435),
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991,
              -33.38883, -33.38846, -33.38893, -33.38929))
df_mpol
matriz_mpol <-as.matrix(df_mpol[,2:3])
matriz_mpol
multi_polygon <- st_multipolygon(
  list(
  list(rbind(matriz_mpol[1:4,],matriz_mpol[1,])),
  list(rbind(matriz_mpol[5:8,],matriz_mpol[5,]))))

# Verificar la clase y geometría
class(multi_polygon)

# Hacer un plot del objeto
plot(multi_polygon)

# 6. Junte todas las geometrias anteriores en un objteo sfg de tipo GEOMETRY COLLECTION. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto

# Crear un objeto GEOMETRY COLLECTION
geometry_collection <- st_sfc(point_2d,point_3d,point_4d,pol,multi_polygon,multilinestring,linestring,multipoint,)

# Verificar la clase y geometría
class(geometry_collection)

# Hacer un plot de cada objeto en el Geometry Collection
plot(geometry_collection)

# 7. Utilice las función st_sfc para convertir los objetos sfg en tipo sfc (salvo para la geometry collection), luego utilice la función st_sf para crear un objeto sf que contenga todas las geometrias. Agregue una columna nombre_geometria a los atributos en donde se identifique el tipo de geometria (ej, multipoligono, multilinea, multipuntos,etc).

# Crear un objeto sfc con todos los objetos anteriores
sfc_objects <- st_sfc(geometry_collection)

# Crear un objeto sf con una columna "nombre_geometria" para identificar el tipo de geometría
sf_objects <- st_sf(data.frame(nombre_geometria = c("point_2d", "multi_point", "line_string", "multi_line_string", "polygon", "multi_polygon"), sfc_objects))

# Verificar la estructura de sf_objects
str(sf_objects)

# 8.(30pts) Las coordenadas siguientes corresponden a los puntos de ubicación de algunas estaciones meteorológicas automáticas (EMAs) en la región Metropolitana. Cree un objeto de tipo punto sfg para cada fila. Convierta todos los puntos en un objeto sfc y luego en un sf (revise la función st_as_sf).
#df <- data.frame(
 # latitud = c(-33.70, -33.07, -33.12,-33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  #longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71)).
#Agregue una columna nombre_ema como atributo con los nombres de acuerdo al siguiente vector:[  nombres_emas <- c("San Diego", "Huechúnb Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")     ]

# Crear un objeto de tipo punto sfg para cada fila
df <- data.frame(longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71),
  latitud = c(-33.70, -33.07, -33.12, -33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21)
)

# Agregar una columna "nombre_ema"
nombres_emas <- c("San Diego", "Huechún Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")
df$nombre_ema <- nombres_emas

# Crear un objeto de tipo punto sfg para cada fila
point_objects <- st_point(df)

# Convertir todos los puntos en un objeto sfc
sfc_objects <- st_sfc(point_objects)

# Convertir el sfc en un objeto sf
sf_emas <- st_as_sf(sfc_objects)

# Verificar la estructura de sf_emas
str(sf_emas)

# 9. Al objeto sf anterior asígnele el sistema de referencia de coordenadas (SRC) geográficas, datum WGS84. Luego cree otro objeto en donde se transforme el SRC del objeto anterior a coordenadas UTM huso 19 Sur, datum WGS84.

# Asignar el sistema de referencia geográfico (WGS84)
st_crs(sf_emas) <- st_crs("+proj=longlat +datum=WGS84")

# Transformar a UTM huso 19 Sur, datum WGS84
sf_emas_utm <- st_transform(sf_emas, crs = "+proj=utm +zone=19 +south +datum=WGS84")

# Verificar el sistema de referencia de sf_emas_utm
st_crs(sf_emas_utm)

# 10. (30pts) Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique:

   #tipo de geometría
   #cantidad de variables y observaciones
   #sistema de referencia de coordenadas y código EPSG

# Cargar una capa vectorial
capa_vectorial <- st_read("ruta/al/archivo.shp")

# Describir la capa vectorial
cat("Tipo de geometría: ", st_geometry_type(capa_vectorial), "\n")
cat("Cantidad de variables: ", ncol(capa_vectorial), "\n")
cat("Cantidad de observaciones: ", nrow(capa_vectorial), "\n")
cat("Sistema de referencia de coordenadas (EPSG): ", st_crs(capa_vectorial)$epsg, "\n")

# 11.  Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.

# Transformar el SRC al código EPSG:4326
capa_transformada <- st_transform(capa_vectorial, crs = "+init=epsg:4326")

# Verificar el sistema de referencia transformado
st_crs(capa_transformada)

# 12. Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitana. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.

# Cargar la capa biodi_snaspe_2021
biodi_snaspe <- st_read("ruta/al/archivo/biodi_snaspe_2021.shp")

# Seleccionar áreas protegidas en la región Metropolitana (asumiendo que la capa tiene una columna 'region' que indica la región)
areas_protegidas_RM <- biodi_snaspe[biodi_snaspe$region == "Metropolitana", ]

# Mostrar el data.frame de las geometrías seleccionadas y seleccionar las columnas de 'categoria' y 'nom_unidad'
areas_protegidas_RM_data <- data.frame(categoria = areas_protegidas_RM$categoria, nom_unidad = areas_protegidas_RM$nom_unidad)

# Guardar en un archivo CSV con configuración latina
write.csv(areas_protegidas_RM_data, "areas_protegidas_RM.csv", fileEncoding = "latin1")

# Guardar en un archivo GeoPackage
st_write(areas_protegidas_RM, "areas_protegidas_RM.gpkg")

# 13. Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.

# Cargar la capa de fuentes puntuales contaminantes
fuentes_contaminantes <- st_read("ruta/al/archivo/fuentes_pun_cont.shp")

# Seleccionar las fuentes que emiten Dióxido de Carbono (asumiendo que la capa tiene una columna 'emisiones' que indica el tipo de emisión)
fuentes_CO2_RM <- fuentes_contaminantes[fuentes_contaminantes$emisiones == "Dioxido de Carbono" & fuentes_contaminantes$region == "Metropolitana", ]

# Guardar en un archivo GeoPackage
st_write(fuentes_CO2_RM, "fuentes_pun_cont_RM_CO2.gpkg")

# 14. Respecto a la capa de fuentes puntuales contaminantes, seleccione las que emiten Dioxido de Carbono y se encuentran en la región Metropolitana. Guarde el resultado en un archivo geopackage llamado fuentes_pun_cont_RM_CO2.gpkg.

# Cargar la capa de fuentes puntuales contaminantes
fuentes_contaminantes <- st_read("ruta/al/archivo/fuentes_pun_cont.shp")

# Seleccionar las fuentes que emiten Dióxido de Carbono y se encuentran en la región Metropolitana (ajusta las condiciones según tus datos)
fuentes_CO2_RM <- fuentes_contaminantes[fuentes_contaminantes$emisiones == "Dioxido de Carbono" & fuentes_contaminantes$region == "Metropolitana", ]

# Guardar en un archivo GeoPackage
st_write(fuentes_CO2_RM, "fuentes_pun_cont_RM_CO2.gpkg")
