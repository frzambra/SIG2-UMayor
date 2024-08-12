
#Integrantes: Florencia Celis, Jonathan Hernandez

install.packages("terra")
install.packages("geodata")
install.packages("sf")
library(terra)
library(sf)
library(geodata)

temperatura<-list.files("era5-monthly_2m_mean_temperature", pattern ="tif$",full.names = TRUE)

temp<-rast(temperatura)

precipitacion<-list.files("era5-monthly_total_precipitation", pattern ="tif$",full.names = TRUE)

pre<-rast(precipitacion)


#1.Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud -38,075 y longitud -74,00 a latitud -48,00 y longitud -70,75.

xmin<- -74.00
xmax<--70.75
ymin<--48.00
ymax<--38.075

obj_ext<-matrix(c(xmin,xmax,xmax,xmin,ymin,ymin,ymax,ymax),ncol=2)
obj_ext

extension_estudio<-st_polygon(list(rbind(obj_ext,obj_ext[1,])))
extension_estudio
class(extension_estudio)
plot(extension_estudio)

extension_estudio_final<-st_as_sf(st_sfc(extension_estudio), crs=4326)
plot(extension_estudio_final,add=TRUE)
class(extension_estudio_final)

#2.A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio.

data<-read.csv("planilla_presencia_frickius_variolosus.xlsx - Datos_iNaturalist.csv")
data


data_sf<-st_as_sf(data, coords = c("longitude","latitude"),crs=4326)


plot(extension_estudio_final)
plot(st_geometry(data_sf),add=TRUE)
st_geometry(data_sf)

#3.Debe crear 100 puntos de pseudo-ausencia de la especie, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample
install.packages("lwgeom")
library(lwgeom)
#semilla 
set.seed(123)

pseudo_ausencia<-st_sample(extension_estudio_final,100)
plot(pseudo_ausencia)

#4.Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.

data_sf_utm<-st_transform(data_sf,32719)
buffer<-st_buffer(data_sf_utm,2500)
plot(st_geometry(buffer))

st_crs(buffer)
st_crs(pseudo_ausencia)

pseudo_ausencia_utm<-st_transform(pseudo_ausencia, st_crs(buffer))
st_crs(pseudo_ausencia_utm)

interseccion_puntos<-st_intersection(pseudo_ausencia_utm, buffer)

puntos_seleccionados<-st_difference(pseudo_ausencia_utm,interseccion_puntos)
plot(puntos_seleccionados)
class(puntos_seleccionados)
st_crs(puntos_seleccionados)


#5.Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

data_sf_utm$presencia<-1
data_sf_utm<-data_sf_utm[,6:5]

class(puntos_seleccionados)

class(puntos_seleccionados)
ausencia<-st_as_sf(puntos_seleccionados)
class(ausencia)

ausencia$presencia<-0
ausencia<-ausencia[,2:1]
ausencia

st_geometry(ausencia)<-"geometry"


puntos_unidos<-rbind(ausencia,data_sf_utm)
puntos_unidos
plot(puntos_unidos)
class(puntos_unidos)
st_crs(puntos_unidos)

#6.Cortar los datos climaticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio

#temperatura

temp_ext<-crop(temp,extension_estudio_final)
plot(temp_ext[[1]])

#precipitación 
pre_ext<-crop(pre,extension_estudio_final)
plot(pre_ext[[1]])

#7.Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#vectores con los patrones de los meses
ind_ene<-seq(1,72,12)
ind_feb<-seq(2,72,12)
ind_mar<-seq(3,72,12)
ind_abr<-seq(4,72,12)
ind_mayo<-seq(5,72,12)
ind_junio<-seq(6,72,12)
ind_julio<-seq(7,72,12)
ind_agos<-seq(8,72,12)
ind_sept<-seq(9,72,12)
ind_oct<-seq(10,72,12)
ind_nov<-seq(11,72,12)
ind_dic<-seq(12,72,12)

temp_ene<-temp_ext[[ind_ene]]
temp_feb<-temp_ext[[ind_feb]]
temp_mar<-temp_ext[[ind_mar]]
temp_abr<-temp_ext[[ind_abr]]
temp_mayo<-temp_ext[[ind_mayo]]
temp_junio<-temp_ext[[ind_junio]]
temp_julio<-temp_ext[[ind_julio]]
temp_agos<-temp_ext[[ind_agos]]
temp_sept<-temp_ext[[ind_sept]]
temp_oct<-temp_ext[[ind_oct]]
temp_nov<-temp_ext[[ind_nov]]
temp_dic<-temp_ext[[ind_dic]]

temp_ene_mean<-mean(temp_ene)
temp_feb_mean<-mean(temp_feb)
temp_mar_mean<-mean(temp_mar)
temp_abr_mean<-mean(temp_abr)
temp_mayo_mean<-mean(temp_mayo)
temp_junio_mean<-mean(temp_junio)
temp_julio_mean<-mean(temp_julio)
temp_agos_mean<-mean(temp_agos)
temp_sept_mean<-mean(temp_sept)
temp_oct_mean<-mean(temp_oct)
temp_nov_mean<-mean(temp_nov)
temp_dic_mean<-mean(temp_dic)

temp_12<-c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_mayo_mean,temp_junio_mean,temp_julio_mean,temp_agos_mean,temp_sept_mean,temp_oct_mean,temp_nov_mean,temp_dic_mean)

names(temp_12)<-c("temp_ene_mean","temp_feb_mean","temp_mar_mean","temp_abr_mean","temp_mayo_mean","temp_junio_mean","temp_julio_mean","temp_agos_mean","temp_sept_mean","temp_oct_mean","temp_nov_mean","temp_dic_mean")

plot(temp_12)

pre_ene<-pre_ext[[ind_ene]]
pre_feb<-pre_ext[[ind_feb]]
pre_mar<-pre_ext[[ind_mar]]
pre_abr<-pre_ext[[ind_abr]]
pre_mayo<-pre_ext[[ind_mayo]]
pre_junio<-pre_ext[[ind_junio]]
pre_julio<-pre_ext[[ind_julio]]
pre_agos<-pre_ext[[ind_agos]]
pre_sept<-pre_ext[[ind_sept]]
pre_oct<-pre_ext[[ind_oct]]
pre_nov<-pre_ext[[ind_nov]]
pre_dic<-pre_ext[[ind_dic]]

pre_ene_mean<-mean(pre_ene)
pre_feb_mean<-mean(pre_feb)
pre_mar_mean<-mean(pre_mar)
pre_abr_mean<-mean(pre_abr)
pre_mayo_mean<-mean(pre_mayo)
pre_junio_mean<-mean(pre_junio)
pre_julio_mean<-mean(pre_julio)
pre_agos_mean<-mean(pre_agos)
pre_sept_mean<-mean(pre_sept)
pre_oct_mean<-mean(pre_oct)
pre_nov_mean<-mean(pre_nov)
pre_dic_mean<-mean(pre_dic)

pre_12<-c(pre_ene_mean,pre_feb_mean,pre_mar_mean,pre_abr_mean,pre_mayo_mean,pre_junio_mean,pre_julio_mean,pre_agos_mean,pre_sept_mean,pre_oct_mean,pre_nov_mean,pre_dic_mean)

names(pre_12)<-c("pre_ene_mean","pre_feb_mean","pre_mar_mean","pre_abr_mean","pre_mayo_mean","pre_junio_mean","pre_julio_mean","pre_agos_mean","pre_sept_mean","pre_oct_mean","pre_nov_mean","pre_dic_mean")

plot(pre_12)


#8.Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

dem<-elevation_global(res = 5,path = tempdir())
plot(dem)

#elevacion
dem_ext<-crop(dem,extension_estudio)
plot(dem_ext)
class(dem_ext)
crs(dem_ext)

res(dem_ext)
res(temp_12)

dem_ext_res<-resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)

#9.Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.


predictores<-c(temp_12,pre_12,dem_ext_res)
plot(predictores)

names(predictores)[[25]]<-"elevación"

st_crs(puntos_unidos)
st_crs(predictores)

class(puntos_unidos)
class(predictores)

puntos_unidos_final<-st_transform(puntos_unidos,crs(predictores))
st_crs(puntos_unidos_final)


Puntos_predictores<-extract(predictores,puntos_unidos_final)

puntos_predictores_final<-cbind(Puntos_predictores, puntos_unidos[,"presencia"])

puntos_predictores_final
class(puntos_predictores_final)
plot(puntos_predictores_final$geometry)

saveRDS(puntos_predictores_final,file="datos_predictores.rds")

#10.Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png}

install.packages("tmap")
library(tmap)
install.packages("viridis")
library(viridis)

#MAPA TEMPERATURA
tmap_mode("plot")

temp_12
temp_12_cel<-temp_12-273.15
temp_12_cel

class(temp_12_cel)
crs(temp_12_cel)

class(puntos_unidos_final)
st_crs(puntos_unidos_final)

mapa_temperatura<-tm_shape(temp_12_cel)+
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)")+
  tm_shape(puntos_unidos_final)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_layout(panel.labels = c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"))+ tm_compass(position = c("RIGHT", "BOTTOM"), type = "arrow", size = 1, color.dark = NA)+
  tm_graticules()


tmap_save(mapa_temperatura,"mapa_estatico_pf_temperatura.png")


#MAPA PRECIPITACION
pre_12_mm<-pre_12*1000
crs(pre_12_mm)

mapa_precipitacion<-tm_shape(pre_12_mm)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)")+
  tm_shape(puntos_unidos_final)+
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

#11.Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.


tem_prom_anual<-mean(temp_12-273,15)
plot(tem_prom_anual)

pre_acum_anual<-sum(pre_12*1000)
plot(pre_acum_anual)

#12.Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

tmap_mode("view")
class(pre_acum_anual)
dem_ext

#mapa pre acu anual

mapa_1<-tm_shape(pre_acum_anual)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)",
            alpha = 0.7) 

mapa_2<-tm_shape(tem_prom_anual)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)


mapa_interactivo<-mapa_1 + mapa2 + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia")

tmap_save(mapa_interactivo,"mapa_interactivo_pf.html")
