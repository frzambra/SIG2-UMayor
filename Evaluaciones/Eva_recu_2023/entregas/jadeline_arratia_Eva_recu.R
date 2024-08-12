# Jadeline Arratia Kaigar
# Prueba Recuperativa

# Instalar paquetes 
install.packages("sf")
install.packages("tibble")
install.packages("terra")
library("sf")
library("tibble")
library("terra")

# Objetos vectoriales: Cuencas y Estaciones
# Objetos Raster: Temperatura y precipitacion 


# 1 (10 pts) Cargar en R el archivo “Cuencas_BNA.shp” y asignarlo al objeto “cuencas”.

setwd("/cloud/project/data/cuencas_Chile")
cuencas <- read_sf("data/cuencas_Chile/Cuencas_BNA.shp")

# 2(10 pts) Cargar en R el archvio “estaciones_chile.shp” y asignarlo al objeto “estaciones”

setwd("/cloud/project/data/estaciones_chile")
estaciones <- read_sf("data/estaciones_chile/estaciones_chile.shp")

# 3 (10 pts) Cargar en R el archvio “CHELSA_pr_v2.1_20190101.tif” y asignarlo al objeto “prec” (precipitación acumulada mensual enero 2019).

#para crear un objeto spatraster desde cero ocupamos la funcion rast, por lo que se le asigna al objeto prec

setwd("/cloud/project/data")
prec <- rast("data/CHELSA_pr_v2.1_20190101.tif")

# 4 (10 pts) Cargar en R el archvio “CHELSA_tas_v2.1_20190101.tif” y asignarlo al objeto “temp” (temperatura promedio mensual enero 2019).

setwd("/cloud/project/data")
temp <- rast("data/CHELSA_tas_v2.1_20190101.tif")

# 5 (30 pts) Obtenga la cantidad de geometrias, cantidad de variables (y sus nombres) y sistema de referencia de coordenadas de los objetos vectoriales anteriores.

# Geometrias

length(st_geometry(cuencas))
length(st_geometry(estaciones))

# Variables y nombre 

ncol(cuencas) - 1
ncol(estaciones) - 1
names(cuencas)
names(estaciones)

# Crs y epsg

st_crs(cuencas)
st_crs(estaciones)
st_crs(cuencas)$epsg
st_crs(estaciones)$epsg

# 6 (30 pts) Obtenga la resolución, número de columnas, número de filas, sistema de referencia de coordenadas de los objetos raster anteriores.

# Resolución

res(prec)
res(temp)


# Número de Columnas y Filas

ncol(prec)
ncol(temp)
nrow(prec)
nrow(temp)

#De todas maneras, la funcion dim nos entrega numero de filas, columas y capas, de una manera más rápida
dim(prec)
dim(temp)

# Src
crs(prec)
crs(temp)

# 7 (40 pts) Haga un “crop” y “mask” de los datos raster para la cuenca del Río Maipo. Elimine las filas o columnas con NAs en los bordes del raster si es necesario.

cuenca_rioma <- cuencas[cuencas$NOM_CUEN == "Rio Maipo",]
cuenca_rioma <- st_transform(cuenca_rioma,st_crs(prec))
plot(cuenca_rioma)


# Precipitacion
prec_rioma <- crop(prec,cuenca_rioma)
prec_rioma <- mask(prec_rioma,cuenca_rioma)
plot(prec_rioma)


# Temperatura 
temp_rioma <- crop(temp,cuenca_rioma)
temp_rioma <- mask(temp_rioma,cuenca_rioma)
plot(temp_rioma)


# 8 (30 pts) Seleccione las estaciones climáticas que se encuentran en la cuenca asignada. Asigne el resultado a “estaciones_cuenca”.

estaciones <- st_transform(estaciones,st_crs(prec))
estaciones_cuenca <- st_intersection(estaciones,cuenca_rioma)

# saldra warning porque la geometria no cuenta como 1 variable 

# 9 (30 pts) Una los dos raster en un raster multicapa en donde la primera capa sea precipitación y la segunda temperatura; asígnelo al objeto “prec_temp”.


prec_temp <- c(prec_rioma,temp_rioma)
names(prec_temp) <- c('precipitacion','temperatura')
plot(prec_temp)

# 10 (50 pts) Extraiga los valores de precipitación y temperatura en la ubicación de las estaciones. El resultado asignelo al objeto “prec_temp_ex”.

prec_temp_ex <- extract(prec_temp,estaciones_cuenca)
plot(prec_temp_ex)

# 11 (40 pts) Cree buffers de 1000m para la estaciones que se encuentran en la cuenca, asignelo al objeto “buffer_estaciones”.

buffer_estaciones <- st_buffer(estaciones_cuenca,1000)
plot(buffer_estaciones$geometry)

# 12 (20 pts) Guarde el raster cortado y enmascarado con el nombre “precipitacion_temperatura_cuenca_{nombre_cuenca}.tif”

setwd("/cloud/project/data") 
writeRaster(prec_temp,"precipitacion_temperatura_cuenca_rioma.tif")


# 13 (20pts) Guarde la cuenca seleccionada como “cuenca_{nombre_cuenca}.shp” 

setwd("/cloud/project/data")
write_sf(cuenca_rioma,"/cloud/project/data/cuenca_rioma.shp")


# 14 (20 pts) Guarde las estaciones seleccionadas como “estaciones_cuenca_{nombre_cuenca}.shp”

write_sf(estaciones_cuenca,"estaciones_cuenca_rioma.shp")

# 15 (20 pts) Guarde el buffer de las estaciones como “buffer_estaciones_cuenca_{nombre_cuenca}.shp”

setwd("/cloud/project/data")
write_sf(buffer_estaciones,'/cloud/project/data/buffer_estaciones_cuenca_rioma.shp')

