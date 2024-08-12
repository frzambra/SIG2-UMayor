#Integrantes: Matias Ubilla - Jadeline Arratia 
# Proyecto Final
# Fecha de Entrega: 04 de diciembre 2023 

install.packages('sf')
library(sf)
#csv, no reconoce el ';', como separador, por ello se usa sep=';'.
#csv2, reconoce el separador,   
data <- read.csv2('planilla_presencia_frickius_variolosus', dec = ".")
data
str(data)
colnames(data)
data_sf <- st_as_sf(data,coords = c('longitude','latitude'), crs= 4326)
data_sf
?st_as_sf

xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -38.075


ext <- st_bbox(c(xmin= xmin, xmax = xmax, ymin = ymin, ymax =ymax))

pol_ext <- st_as_sf(st_as_sfc(ext), crs=4326)
plot(pol_ext)
plot(data_sf$geometry, add=TRUE)



install.packages('tmap')  # paquete de R,  que permite 
library(tmap)

set.seed(123)
tmap_mode('view')

data_sf_utm <- st_transform(data_sf, 32719)
buff <- st_buffer(data_sf_utm, 250)

tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_sf) +
  tm_dots() +
  tm_shape(data_pseudo) +
  tm_dots(col='red') +
  tm_shape(buff) +
  tm_polygons(col='darkgreen')

tm_shape(buff) +
  tm_polygons()

#crear puntos de pseudo ausencia.

#Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.

set.seed(123)
data_pseudo <- st_sample(pol_ext,100)

data_sf_utm <- st_transform(data_sf,32719)
buff <- st_buffer(data_sf_utm,2500)

#st_intersection a buscar quienes se intersectan (el buffer con los de pseudoausencia)

st_crs(buff)
st_crs(data_pseudo)
#se debe cambiar el src 
data_pseudo_proj <- st_transform(data_pseudo,st_crs(buff))

#busca que puntos de pseudo-ausencia se intersectan con los buffers
ptos_inter <- st_intersection(data_pseudo_proj,buff)

dim(data_pseudo_proj)

ptos_selec <- st_difference(data_pseudo_proj,ptos_inter)
plot(ptos_selec)



#Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.
#unir los datos de presencia con los de pseudo ausencia, ambos deben tener una columna que identifique si es de presencia o no. 

data_sf_utm
#tiene 4 variables, s epuede agregar una columna que se llame presencia y lo seteamos como 1

data_sf_utm$presencia <- 1

#puntos de presencia con la columna presencia seteado con el valor 1 (valor 1 indica presencia)
data_sf_utm <- data_sf_utm[,6:5]

#agregar columna de presencia a datos de pseudo ausencia 
class(ptos_selec)

#quremos aregarle un atributo a una list colum, la unica manera es incluirlo a un sf en un data frame 
data_ausen <- st_as_sf(ptos_selec)

data_ausen$presencia <- 0 

#unir los datos de presencia con pseudo-ausencia 

st_geometry(data_ausen) <- "geometry"
data_unida <- rbind(data_ausen[,2:1],data_sf_utm)


#visualizacion con tmap
tm_shape(pol_ext) +
  tm_borders()+
  tm_shape(data_unida)+
  tm_dots(col="presencia",style="cat")

#Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.
#debe cortar los datos climaticos raster de temperatura media y precipitaion 
library(terra)
files_temp <- list.files("data/era5-monthly_2m_mean_temperature", 
                         full.names =TRUE)
files_pre <- list.files("data/era5-monthly_total_precipitation"
                        full.names = TRUE)
temp <- rast(files_temp)
pre <- rast(files_pre)

#cortar de acuerdo a la extension 
temp_c <- crop(temp,pol_ext)
pre_c <- crop(pre,pol_ext)

plot(temp_c[[1]])
plot(pre_c[[1]])


#Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#creo vector con el patron de los meses de enero 
ind_ene <- seq(1,72,12)
ind_feb <- seq(2,72,12)
ind_mar <- seq(3,72,12)
ind_abr <- seq(4,72,12)
ind_may <- seq(5,72,12)
ind_jun <- seq(6,72,12)
ind_jul <- seq(7,72,12)
ind_ago <- seq(8,72,12)
ind_sep <- seq(9,72,12)
ind_oct <- seq(10,72,12)
ind_nov <- seq(11,72,12)
ind_dic <- seq(12,72,12)

names(temp_c)[ind_ene]

#1:
temp_ene <- temp_c[[ind_ene]]
temp_feb <- temp_c[[ind_feb]]
temp_mar <- temp_c[[ind_mar]]
temp_abr <- temp_c[[ind_abr]]
temp_may <- temp_c[[ind_may]]
temp_jun <- temp_c[[ind_jun]]
temp_jul <- temp_c[[ind_jul]]
temp_ago <- temp_c[[ind_ago]]
temp_sep <- temp_c[[ind_sep]]
temp_oct <- temp_c[[ind_oct]]
temp_nov <- temp_c[[ind_nov]]
temp_dic <- temp_c[[ind_dic]]

pre_ene <- pre_c[[ind_ene]]
pre_feb <- pre_c[[ind_feb]]
pre_mar <- pre_c[[ind_mar]]
pre_abr <- pre_c[[ind_abr]]
pre_may <- pre_c[[ind_may]]
pre_jun <- pre_c[[ind_jun]]
pre_jul <- pre_c[[ind_jul]]
pre_ago <- pre_c[[ind_ago]]
pre_sep <- pre_c[[ind_sep]]
pre_oct <- pre_c[[ind_oct]]
pre_nov <- pre_c[[ind_nov]]
pre_dic <- pre_c[[ind_dic]]

#2:
temp_ene <- subset(temp_c,ind_ene)

#calcular el promedio temp de cada mes 
temp_ene_mean <- mean(temp_ene)
temp_feb_mean <- mean(temp_feb)
temp_mar_mean <- mean(temp_mar)
temp_abr_mean <- mean(temp_abr)
temp_may_mean <- mean(temp_may)
temp_jun_mean <- mean(temp_jun)
temp_jul_mean <- mean(temp_jul)
temp_ago_mean <- mean(temp_ago)
temp_sep_mean <- mean(temp_sep)
temp_oct_mean <- mean(temp_oct)
temp_nov_mean <- mean(temp_nov)
temp_dic_mean <- mean(temp_dic)

#calcular el promedio de precipitacion de cada mes 
pre_ene_mean <- mean(pre_ene)
pre_feb_mean <- mean(pre_feb)
pre_mar_mean <- mean(pre_mar)
pre_abr_mean <- mean(pre_abr)
pre_may_mean <- mean(pre_may)
pre_jun_mean <- mean(pre_jun)
pre_jul_mean <- mean(pre_jul)
pre_ago_mean <- mean(pre_ago)
pre_sep_mean <- mean(pre_sep)
pre_oct_mean <- mean(pre_oct)
pre_nov_mean <- mean(pre_nov)
pre_dic_mean <- mean(pre_dic)

#luego se debe unir:

temp_12 <- c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_may_mean,temp_jun_mean, temp_jul_mean,temp_ago_mean,temp_sep_mean, temp_oct_mean,temp_nov_mean,temp_dic_mean)
plot(temp_12)

names(temp_12) <- c("temp enero","temp febrero","temp marzo", "temp abril","temp mayo","temp junio", "temp julio","temp agosto","temp septiembre","temp octubre","temp noviembre", "temp diciembre")
plot(temp_12)


#de los 72 nos quedamos con 12 de temperatura y 12 de precipitacion 

pre_12 <- c(pre_ene_mean,pre_feb_mean,pre_mar_mean, pre_abr_mean,pre_may_mean,pre_jun_mean, pre_jul_mean,pre_ago_mean,pre_sep_mean, pre_oct_mean,pre_nov_mean,pre_dic_mean)
plot(pre_12)

names(pre_12) <- c("pre enero","pre febrero","pre marzo, pre abril","pre mayo","pre junio","pre julio","pre agosto","pre septiembre, pre octubre","pre noviembre","pre diciembre")
plot(pre_12)


#Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

library(geodata)
dem <- elevation_global(res=5, path = tempdir())

dem_ext <- crop(dem,pol_ext)
plot(dem_ext)
res(dem_ext)
res(temp_12)

dem_ext_res <- resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)

predictores <- c(pre_12,temp_12,dem_ext_res)
plot(predictores)

#lo que importa es que la resolucion sea al menos igual o mejor que los datos de temperatura 


#Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.

df <- extract(predictores,data_unida)
dim(df)

df_final <- cbind(df,data_unida[,"presencia"])
names(df_final)
#ahora que todos los predictores estan con la misma resolucion y la misma extension, los puedo unir en un raster multicapa
#unir raster con funcion c 

predictores <- c(pre_anual,temp_anual,dem_ext_res)
plot(predictores)

#ahora efectivamente tenemos un raster de 25 capas; 
predictores

#mostramos los nombres de las capas; 
names(predictores)

#para guardar raster;
library(terra)
writeRaster(predictores,"predictores.tif")

#una vez que tengo el raster multicapa con los 25 predictores, puedo extraer los valores de temperatura mensual, preciptacion mensual y elevacion en los puntos de presencia y pseudoausencia de frickius 

#transformacion del sistema de referencia de coordenadas 
data_unida_t <- st_transform(data_unida,crs(predictores))
data_unida_t

df <- extract(predictores,data_unida_t)
df

#unir los datos extraidos con la columna presencia
df_final <- cbind(df,data_unida[,"presencia"])
names(df_final)
view(df_final)
str(df_final)

#saveRDS: formato nativo de r
saveRDS(df_final,"data/data_predictores.rds")


#PREGUNTA 10
#Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

#10.Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png}

install.packages("tmap")
library(tmap)
install.packages("viridis")
library(viridis)
tmap_mode("plot")

temp_12
temp_12c<-temp_12-273.15
temp_12c

class(temp_12c)
crs(temp_12c)

class(df_final)
st_crs(df_final)

mapa_t<-tm_shape(temp_12_cel)+
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)")+
  tm_shape(df_final)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_layout(panel.labels = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"))+ tm_compass(position = c("RIGHT", "BOTTOM"), type = "arrow", size = 1, color.dark = NA)+
  tm_graticules()


tmap_save(mapa_t,"mapa_estatico_pf_temperatura.png")


#MAPA PRECIPITACION
pre12<-pre_12*1000
crs(pre12)

mapa_precipitacion<-tm_shape(pre12)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)")+
  tm_shape(df_final)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_layout(panel.labels = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")) +tm_compass(position = c("RIGHT", "BOTTOM"), 
                                                                                                                                                                       type = "arrow", size = 1, 
                                                                                                                                                                       color.dark = NA)+
  tm_graticules()

tmap_save(mapa_precipitacion, "mapa_estatico_pf_precipitacion.png")

#MAPA ELEVACION

mapa_elevacion<-tm_shape(dem_ext_res)+
  tm_raster(style = "cont", 
            palette = terrain.colors(3),
            title="Elevación(m)",
            alpha = 0.7)+
  tm_shape(puntos_unidos_final)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_compass(position = c("RIGHT", "BOTTOM"), 
             type = "arrow", size = 1, 
             color.dark = NA)+
  tm_graticules()+
  tm_layout(legend.outside=TRUE,
            legend.outside.position ="right")

tmap_save(mapa_elevacion, "mapa_estatico_pf_elevación.png")
















#PREGUNTA 11
#Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.

#calcular un raster de precipitacion acumulada anual 
#la precipitacion esta en metros, la multiplico por 1000 para dejarla en milimetros 

pre_acum_anual <- sum(pre_anual*1000)
plot(pre_acum_anual)

#para temperatura la convierto de kelvin a °C restando 271.15
temp_prom_anual <- mean(temp_anual-273.15)
plot(temp_prom_anual)


#PREGUNTA 12
#Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html
tmap_mode("view")
class(pre_acum_anual)
dem_ext

#mapa pre acu anual

mapa1<-tm_shape(pre_acum_anual)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)",
            alpha = 0.7) 

mapa2<-tm_shape(tem_prom_anual)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)


mapa_interactivo<-mapa1 + mapa2 + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia")

tmap_save(mapa_interactivo,"mapa_interactivo_pf.html")