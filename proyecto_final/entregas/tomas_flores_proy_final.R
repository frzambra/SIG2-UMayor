library(sf)
library(terra)
library(tmap)
library(geodata)
library(viridis)
#Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud -38,075 y longitud -74,00 a latitud -48,00 longitud -70.75. A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio. 
setwd("C:/Users/tomas/OneDrive/Documentos/R/data")
data <- read.csv2("planilla_presencia_frickius_variolosus.csv", dec = ".", sep = ";")
data
str(data)

#Objeto SF con las coordenadas de presencia

data_sf <- st_as_sf(data,coords = c("longitude","latitude"),crs = 4326) 
data_sf

#Definir extensión
xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -37.89

ext <- st_bbox(c(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax))
ext
pol_ext <- st_as_sf(st_as_sfc(ext), crs = 4326) 
plot(pol_ext) 
plot(data_sf$geometry,add=T)

#Debe crear 100 puntos de pseudo-ausencia de la espeice, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.


tmap_mode("view")

#pseudo-ausencia 
set.seed(123)
data_pseudo <- st_sample(pol_ext,100)
data_sf_utm <- st_transform(data_sf, 32719) 
buff <- st_buffer(data_sf_utm, 250)
st_crs(buff)
st_crs(data_pseudo)
data_pproject <- st_transform(data_pseudo, st_crs(buff))

#pseudo-ausencia intersectados con buffers
ptos_int <- st_intersection(data_pproject, buff)  
ptos_selec <- st_difference(data_pproject, ptos_int) 

#presencia con pseudo-ausencia
data_sf_utm$presencia <- 1 

#Puntos de presencia con la columna presencia
data_sf_utm <- data_sf_utm [,6:5] 

#columna de presencia a datos de pseudo ausencia 
data_ausen <- st_as_sf(ptos_selec)  
data_ausen$presencia <- 0 

#visualización 
tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_sf) +
  tm_dots() +
  tm_shape(data_pseudo) +
  tm_dots(col="blue") +
  tm_shape(buff) +
  tm_polygons(col= "red")

tm_shape(buff) +
  tm_polygons()

#datos de presencia con pseudo-ausencia
st_geometry(data_ausen) <- "geometry"
data_unida <- rbind(data_ausen[, 2:1], data_sf_utm)

#visualización 
tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_unida) +
  tm_dots(col= "presencia", style = "cat") 

#datos climáticos de temperatura media y precipitacion acumulada mensual cortados

file_temp <- list.files("era5-monthly_2m_mean_temperature", full.names = T)

file_pre <- list.files("era5-monthly_total_precipitation", full.names = T)

temp <-rast(file_temp) 
pre <-rast(file_pre)

#extension

temp_c <- crop(temp,pol_ext)
pre_c <- crop(pre, pol_ext)
plot(temp_c)
plot(pre_c)


#Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#temperatura
ind_ene <- seq(1, 72, 12)
ind_feb <- seq(2, 72, 12)
ind_mar <- seq(3, 72, 12)
ind_abr <- seq(4, 72, 12)
ind_may <- seq(5, 72, 12)
ind_jun <- seq(6, 72, 12)
ind_jul <- seq(7, 72, 12)
ind_ago <- seq(8, 72, 12)
ind_sep <- seq(9, 72, 12)
ind_oct <- seq(10, 72, 12)
ind_nov <- seq(11, 72, 12)
ind_dic <- seq(12, 72, 12)

#capas de cada mes 
temp_ene <- temp_c[[ind_ene]]
temp_ene
temp_feb <- temp_c[[ind_feb]]
temp_feb
temp_mar <- temp_c[[ind_mar]]
temp_mar
temp_abr <- temp_c[[ind_abr]]
temp_abr
temp_may <- temp_c[[ind_may]]
temp_may
temp_jun <- temp_c[[ind_jun]]
temp_jun
temp_jul <- temp_c[[ind_jul]]
temp_jul
temp_ago <- temp_c[[ind_ago]]
temp_ago
temp_sep <- temp_c[[ind_sep]]
temp_sep
temp_oct <- temp_c[[ind_oct]] 
temp_oct
temp_nov <- temp_c[[ind_nov]]
temp_nov
temp_dic <- temp_c[[ind_dic]]
temp_dic

#promedios
tpen <- mean(temp_ene)  
tpen
tpfe <- mean(temp_feb)
tpfe
tpma <- mean(temp_mar)
tpma
tpab <- mean(temp_abr)
tpab
tpmay <- mean(temp_may)
tpmay
tpjun <- mean(temp_jun)
tpjun
tpjul <- mean(temp_jul)
tpjul
tpag <- mean(temp_ago)
tpag
tpse <- mean(temp_sep)
tpse
tpoc <- mean(temp_oct)
tpoc
tpno <- mean(temp_nov)
tpno
tpdi <- mean(temp_dic)
tpdi

temp_12 <- c(tpen, tpfe, tpma, tpab, tpmay, tpjun, tpjul, tpag, tpse, tpoc, tpno, tpdi)  
temp_12
plot(temp_12)

names(temp_12) <- c("enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
plot(temp_12)

#precipitacion

#capas de cada mes
pre_ene <- pre_c[[ind_ene]]
pre_ene
pre_feb <- pre_c[[ind_feb]]
pre_feb
pre_mar <- pre_c[[ind_mar]]
pre_mar
pre_abr <- pre_c[[ind_abr]]
pre_abr
pre_may <- pre_c[[ind_may]]
pre_may
pre_jun <- pre_c[[ind_jun]]
pre_jun
pre_jul <- pre_c[[ind_jul]]
pre_jul
pre_ago <- pre_c[[ind_ago]]
pre_ago
pre_sep <- pre_c[[ind_sep]]
pre_sep
pre_oct <- pre_c[[ind_oct]] 
pre_oct
pre_nov <- pre_c[[ind_nov]]
pre_nov
pre_dic <- pre_c[[ind_dic]]
pre_dic

#promedios 
ppen <- mean(pre_ene)  
ppen
ppfe <- mean(pre_feb)
ppfe
ppma <- mean(pre_mar)
ppma
ppab <- mean(pre_abr)
ppab
ppmay <- mean(pre_may)
ppmay
ppjun <- mean(pre_jun)
ppjun
ppjul <- mean(pre_jul)
ppjul
ppag <- mean(pre_ago)
ppag
ppse <- mean(pre_sep)
ppse
ppoc <- mean(pre_oct)
ppoc
ppno <- mean(pre_nov)
ppno
ppdi <- mean(pre_dic)
ppdi

pre_12 <- c(ppen, ppfe, ppma, ppab, ppmay, ppjun, ppjul, ppag, ppse, ppoc, ppno, ppdi)  
pre_12
plot(pre_12)

names(pre_12) <- c("enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
plot(pre_12)

#Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

dem <- elevation_global(res = 5, path = tempdir())
dem
dem_ext <- crop(dem, pol_ext)
dem_ext
plot(dem_ext)
res(dem_ext)
res(temp_12)

dem_ext_res <- resample(dem_ext, temp_12)
res(dem_ext_res)
res(temp_12)

#Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.

predictores <-c(pre_12, temp_12, dem_ext_res)
predictores

df <- extract(predictores,data_unida) 
dim(df)

df_final <- cbind(df, data_unida [, "presencia"]) 
df_final

saveRDS(df_final, "datos_predictores.rds")


#Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

df <- readRDS("datos_predictores.rds")
tm_style <- tmap_style("gray")
tm_borders <- tm_borders(lwd = 0.5)

#mapas de precipitacion
tm_precip_map <- tm_shape() +
  tm_borders +
  tm_layout(legend.outside = TRUE) +
  tm_compass(type = "arrow", position = c("RIGHT", "TOP"), color.dark = "black") +
  tm_scale_bar(breaks = c(0, 100, 200), position = c("RIGHT", "BOTTOM")) +
  tm_graticules() +
  tm_layout(panel.labels = month.name[1:12])

for (i in 1:12) {
  tm_precip_map <- tm_precip_map +
    tm_shape(df) +
    tm_dots("precipitacion_monthly_mean", title = paste("Mes", i)) +
    tm_fill("precipitacion_monthly_mean", palette = viridis(7))
}

#PNG
tmap_save(tm_precip_map, "mapa_estatico_pf_precipitacion.png")

#mapas de temperatura 
tm_temp_map <- tm_shape() +
  tm_borders +
  tm_layout(legend.outside = TRUE) +
  tm_compass(type = "arrow", position = c("RIGHT", "TOP"), color.dark = "black") +
  tm_scale_bar(breaks = c(0, 10, 20), position = c("RIGHT", "BOTTOM")) +
  tm_graticules() +
  tm_layout(panel.labels = month.name[1:12])

for (i in 1:12) {
  tm_temp_map <- tm_temp_map +
    tm_shape(df) +
    tm_dots("temperatura_monthly_mean", title = paste("Mes", i)) +
    tm_fill("temperatura_monthly_mean", palette = inferno(7))
}

#PNG
tmap_save(tm_temp_map, "mapa_estatico_pf_temperatura.png")

#mapa de elevación
tm_elevation_map <- tm_shape() +
  tm_borders +
  tm_layout(legend.outside = TRUE) +
  tm_compass(type = "arrow", position = c("RIGHT", "TOP"), color.dark = "black") +
  tm_scale_bar(breaks = c(0, 500, 1000), position = c("RIGHT", "BOTTOM")) +
  tm_graticules() +
  tm_layout(panel.labels = "Elevación")

tm_elevation_map <- tm_elevation_map +
  tm_shape(df) +
  tm_dots() +
  tm_fill("elevacion", palette = terrain.colors(10))

#PNG
tmap_save(tm_elevation_map, "mapa_estatico_pf_elevacion.png")

#Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.

#temperatura
temp_rast <- rast(file_temp)  
temp_rast
temp_promanual <- app(temp_rast, mean, na.rm = T)
temp_promanual
plot(temp_promanual)
#precipitacion
pre_rast <- rast(file_pre)
pre_rast
pre_promanual <- app(pre_rast, sum, na.rm = T) 
pre_promanual
plot(pre_promanual)


#Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

##NO LOGRE REALIZARLA 
