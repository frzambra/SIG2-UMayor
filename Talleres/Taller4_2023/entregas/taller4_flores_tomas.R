#instalar paquete 

install.packages("sf")


#cargar sf

library(sf)




# 1. OBJETOS SFG DE TIPO PUNTO DE DOS, TRES Y CUATRO DIMENSIONES.


#coordenadas y atributos 

latitud <- -36.25

longitud <- -72.65 

elevacion <- 200 

direccion <- 90 

#se utilizan los SFG para representar las geometrías simples de un objeto espacial(solo SF)


#2d

dosd <- st_sfc(st_point(c(longitud, latitud)))

dosd

str(dosd)

#3d

tresd <- st_sfc(st_point(c(longitud, latitud, elevacion)))

tresd

str(tresd)

#4d

cuatrod <- st_sfc(st_point(c(longitud, latitud, elevacion, direccion)))

cuatrod

str(cuatrod)

#ST_POINT crea un objeto de punto geoespacial definido por lat y long (solo SF)

#STF sirve para obtener la estructura de un objeto (R en general)




# 2. TIPOS DE OBJETOS SFG MULTIPOINT Y LINESTRING      


#data frame dado

df <- data.frame(
  
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893),
  
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396))

#multipoint 

mpoint <- st_multipoint(matrix(c(df$longitud, df$latitud), ncol = 2))

#MULTIPOINT sirve para representar puntos individuales en un solo objeto.


#clase y geometría del multipoint

class(mpoint)

st_geometry_type(mpoint)

#ST_GEOMETRY extrae la geometría de un objeto espacial (Solo SF). 


#linestring

lstring <- st_linestring(matrix(c(df$longitud, df$latitud), ncol = 2))

#LINESTRING secuencia de puntos unidos por una línea recta. 

#ST_LINESTRING o ST_MULTIPOINT crea el linestring o el multipoint (ST).


#clase y geometría del linestring

class(lstring)

st_geometry_type(lstring)

#gráficos

plot(mpoint, col = , pch = 19, cex = 2, main = "MULTIPOINT")

plot(lstring, col = , lwd = 2, main = "LINESTRING")




# 3. OBJETO SFG MULTILINESTRING 2 LINEAS.

#MULTILINESTRING es lo mismo que linestring pero presenta lineas multiples.


#data frame con las coordenadas dadas 

df <- data.frame(
  
  linea = c(rep('linea_1', 4), rep('linea_2', 4)),
  
  latitud = c(-33.38991, -33.38959, -33.38929, -33.38893, -33.38943, -33.38911, -33.38883, -33.38846),
  
  longitud = c(-70.63500, -70.63468, -70.63435, -70.63396, -70.63566, -70.63531, -70.63500, -70.63461))

#multilinestring

multring <- st_multilinestring(list(
  
  st_linestring(matrix(c(df$longitud[df$linea == 'linea_1'], df$latitud[df$linea == 'linea_1']), ncol = 2)),
  
  st_linestring(matrix(c(df$longitud[df$linea == 'linea_2'], df$latitud[df$linea == 'linea_2']), ncol = 2))))

multring

#RECORDAR $ para acceder a dato especifico.


#clase y geometría

class(mustring)

st_geometry_type(mustring)

#gráficos

plot(multiline_string, col = , lwd = 2, main = "MULTILINESTRING")




# 4. OBJETO SFG DE TIPO POLYGON.


#data frame con las coordenadas dadas (cerrado (valores invertidos entre lat y long))

df_pol <- data.frame(
  
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991, -33.38943), 
  
  longitud = c(-70.63566, -70.63531, -70.63468, -70.63500, -70.63566))

#matriz (para agrupar las coordenadas del poligono)

cdns <- cbind(df_pol$longitud, df_pol$latitud)

#poligono

pol <- st_polygon(list(cdns))

#clase y geometría del poligono.

class(pol)

st_geometry_type(pol)

#gráfico

plot(polygon, col = "magenta", main = "POLYGON")




# 5. OBJETO SFG DE TIPO MULTIPOLYGON 


#data frame dado.

df_mpol <- data.frame(
  
  poligono = c(rep('poligono_1', 4), rep('poligono_2', 4)),
  
  latitud = c(-33.38943, -33.38911, -33.38959, -33.38991,
              
              -33.38883, -33.38846, -33.38893, -33.38929),
  
  longitud = c(-70.63566, -70.63531, -70.63468, -70.63500,
               
               -70.63500, -70.63461, -70.63396, -70.63435))

#SF con las coordenadas

sfmpol <- st_as_sf(df_mpol, coords = c("longitud", "latitud"))

#ST_AS_SF sirve para convertir objetos de datos en un objeto SF


#Agrupar por polígono y crear un multipolygon

sfmpolg <- st_combine(sfmpol)

#ST_COMBINE combina geometrías en un objeto espacial.


#clase y geometría

class(sfmpolg)

st_geometry_type(sfmpolg)

#polígonos

plot(sfmpolg)




# 6. OBJETO GEOMETRY COLLECTION


#lista con geometrias

geomlist <- list(dosd, tresd, cuatrod, mpoint, lstring, mustring, pol, sfmpolg)

geomlist

#union de geometrias

ungeom <- do.call(st_union, geomlist)

ungeom

#SFG geometry collection

geomcol<- st_sfc(ungeom)

geomcol

#clase y geometría del objeto unido

class(geomcol)

st_geometry_type(geomcol)

#plot del objeto unido

plot(geomcol, main = "Objeto unido")




# 7. SFG A SFC

#SFC se utiliza para crear objetoss que se utilizan para representar colecciones de geometrías geoespaciales simples.


#lista de todas las geometrías

geometries_list <- list(
  
  dosd = dosd,
  
  tresd = tresd,
  
  cuatrod = cuatrod,
  
  mpoint = mpoint,
  
  lstring = lstring,
  
  mustring = mustring,
  
  pol = pol,
  
  sfmpolg = sfmpolg)

#SFC y agregar la columna "nombre_geometria"

for (geom_name in names(geometries_list)) {
  
  geom <- geometries_list[[geom_name]]
  
  geomsfc <- st_sfc(geom)
  
  geometries_list[[geom_name]] <- data.frame(nombre_geometria = geom_name, geometria = geomsfc)}

#geometrías en un SF

geoms <- do.call(rbind, geometries_list)

geoms




# 8. PUNTO SFG, CONVERTIRLOS EN SFC Y LUEGO EN SF


#data frame dado

df <- data.frame(
  
  latitud = c(-33.70, -33.07, -33.12, -33.67, -33.70, -33.65, -33.67, -33.66, -33.86, -33.21),
  
  longitud = c(-71.37, -70.75, -70.83, -70.58, -70.70, -71.1, -70.92, -70.76, -70.63, -70.71))

#SFG de tipo punto para cada fila

psfg <- lapply(1:nrow(df), function(i) {
  
  st_point(c(df$longitud[i], df$latitud[i]))})

psfg

#FUNCTION(i) define una función que toma argumento i

#1:NROW crea una secuencia de numeros enteros desde 1 hasta la cantidad de filas en el df


#lista de puntos en SFC

psfc <- st_sfc(psfg, crs = 4326)

#SF con los puntos

sfp <- st_sf(geometry = psfc)

sfp

#nombres de las EMAs

nombres_emas <- c("San Diego", "Huechún Ex Lampa", "Til til", "Pirque", "Buin", "Melipilla", "Talagante", "Lo Herrera", "Huelquen", "Colina")

#agregar "nombre_ema" al SF

sf_emas <- st_sf(data = data.frame(nombre_ema = nombres_emas), geometry = psfc)

sf_emas




# 9. SRC WGS84 Y UTM HUSO 19 SUR.


#SRC geográfico (WGS84)

sfemas <- st_set_crs(sfemas, 4326)

sfemas

#SRC a UTM huso 19 Sur (WGS84)

sfemash <- st_transform(sfemas, crs = 32719)

sfemash




# 10. CARGAR CAPAS VECTORIALES 


#Setear directorio de trabajo 

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas")

getwd()

#shape AIRE 

aire <- st_read("Aire_-_shapefile") 

aire

#geometria

geometria<- st_geometry_type(aire)

geometria

#variables y observaciones

variables <- ncol(aire)

variables

observaciones <- nrow(aire)

observaciones

# Sistema de referencia de coordenadas y código EPSG

referencia <- st_crs(aire)

referencia

#código EPSG si está disponible

cepsg <- ifelse(is.null(referencia), NA, referencia$epsg)

cepsg

#shape BIODIVERSIDAD 

biodiversidad <- st_read ("Biodiversidad_-_shapefile")

biodiversidad

#geometria

geometria<- st_geometry_type(biodiversidad)

geometria

#variables y observaciones

variables <- ncol(biodiversidad)

variables

observaciones <- nrow(biodiversidad)

observaciones

#Sistema de referencia de coordenadas y código EPSG

referencia <- st_crs(biodiversidad)

referencia

#código EPSG si está disponible

cepsg <- ifelse(is.null(referencia), NA, referencia$epsg)

cepsg




# 11.SRC de cada una de las capas al que corresponde al código EPSG:4326.

#aire

aire2 <- st_transform(aire, crs = st_crs(4326))

aire2

#biodiversidad 

biodiversidad2 <- st_transform(aire,crs = st_crs (4326))

biodiversidad2




# 12.


#setear el directorio de trabajo 

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas/Biodiversidad_-_shapefile")

getwd()

#extraer shape requerido

bio<- st_read("biodi_snaspe_2021.shp")

bio

#definir el nombre de la Región Metropolitana 

met <- "Metropolitana"

met

#áreas protegidas en la Región Metropolitana

protecRM <- bio[bio$region == met, ]

protecRM

#seleccionar columnas de categoría y nombre de la unidad

areaselec <- protecRM[, c("categoria", "nom_unidad")]

areaselec

#guardar como csv

write.csv(areaselec, "areas_protegidas_RM.csv", fileEncoding = "latin1")




# 13. GUARDAR COMO GPKG

st_write(areaselec, "areas_protegidad_RM.gpkg")




# 14. FUENTES CONTAMINANTES


#setear directorio de trabajo 

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas/Aire_-_shapefile")

getwd()

#fuentes puntuales contaminantes

contam <- st_read("bdide_OWD_Aire_Emisiones_fuentes_puntuales_contaminante.shp") 

#definir el nombre de la Región Metropolitana 

met1 <- "Metropolitana de Santiago"

met1

#fuentes que emiten Dióxido de Carbono (CO2) y se encuentran en la Región Metropolitana

fuentesRM <- contam[contam$contaminan == "Carbon dioxide" & contam$region == met1, ]

fuentesRM

#geopackage

st_write(fuentesRM, "fuentes_pun_cont_RM_CO2.gpkg", append = F)