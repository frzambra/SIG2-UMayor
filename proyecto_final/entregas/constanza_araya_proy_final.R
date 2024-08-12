#TRABAJO FINAL
#Constanza Araya

install.packages("terra")
library(terra)
##CARGAR ARCHIVOS

#Temperatura
files<-list.files("C:/Users/Cony/Desktop/trabajo.s/era5-monthly_2m_mean_temperature", pattern = "tif$", full.names = TRUE)
files
temp<-rast(files)
plot(temp)

#Precipitacion
files2<-list.files("C:/Users/Cony/Desktop/trabajo.s/era5-monthly_total_precipitation",pattern = "tif$",full.names = TRUE)
files2

pre<-rast(files2)
plot(pre)

install.packages("sf")
library(sf)
#Excel
dta<-read.csv("C:/Users/Cony/Desktop/trabajo.s/planilla_presencia_frickius_variolosus.csv", sep=";")
str(dta)


#1-Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud -38,075 y longitud -74,00 a latitud -48,00 y longitud -70,75

xmin<- -74.00
xmax <- -70.75
ymin<- - 48.00
ymax <- -37.89669

ext<- st_bbox(c(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax))
pol_ext<-st_as_sf(st_as_sfc(ext),crs=4326)
plot(pol_ext)

#2- A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio.
data_sf<-st_as_sf(dta,coords = c("longitude","latitude"),crs=4326)
plot(data_sf$geometry,add= TRUE)

install.packages("tmap")
library(tmap)
tmap_mode("view")
#3- Debe crear 100 puntos de pseudo-ausencia de la espeice, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.
set.seed(123)
data_pseudo<- st_sample(pol_ext,100)
data_sf_utm<-st_transform(data_sf, 32719)

#4-Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.

buff<-st_buffer(data_sf_utm,2500)

tm_shape(pol_ext)+tm_borders()+tm_shape(data_sf)+tm_dots()+tm_shape(data_pseudo)+tm_dots(col="red")+tm_shape(buff)+tm_polygons(col="darkgreen")

tm_shape(buff)+ tm_polygons()

#5.Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

st_crs(buff)
st_crs(data_pseudo)
data_pseudo_proj<- st_transform(data_pseudo,st_crs(buff))

ptos_inter<- st_intersection(data_pseudo_proj,buff)#va a buscar donde se intersectan
ptos_selec<- st_difference(data_pseudo_proj,ptos_inter)
plot(ptos_selec)


data_sf_utm$presencia<-1

#puntos de precensia
data_sf_utm<- data_sf_utm[,6:5]

#agregar columna de presencia a datos de pseudo ausencia
data_ausen<-st_as_sf(ptos_selec)
data_ausen$presencia<- 0

#unir los datos de presencia con pseudo-ausencia
st_geometry(data_ausen)<- "geometry"
data_unida<-rbind(data_ausen[,2:1],data_sf_utm)

#visualizacion 
tm_shape(pol_ext)+tm_borders()+tm_shape(data_unida)+tm_dots(col="presencia",style="cat")

#6-Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.

#cortar
temp_c<- crop(temp,pol_ext)
pre_c<- crop(pre,pol_ext)

#7-.Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#creo vector con el patron con los meses de temperatura y presipitacion
ind_ene<-seq(1,72,12)
ind_feb<-seq(2,72,12)
ind_mar<-seq(3,72,12)
ind_abr<-seq(4,72,12)
ind_may<-seq(5,72,12)
ind_jun<-seq(6,72,12)
ind_jul<-seq(7,72,12)
ind_ago<-seq(8,72,12)
ind_sep<-seq(9,72,12)
ind_oct<-seq(10,72,12)
ind_nov<-seq(11,72,12)
ind_dic<-seq(12,72,12)
##TEMPERATUTA
names(temp_c)[ind_ene]
names(temp_c)[ind_feb]
names(temp_c)[ind_mar]
names(temp_c)[ind_abr]
names(temp_c)[ind_may]
names(temp_c)[ind_jun]
names(temp_c)[ind_jul]
names(temp_c)[ind_ago]
names(temp_c)[ind_sep]
names(temp_c)[ind_oct]
names(temp_c)[ind_nov]
names(temp_c)[ind_dic]
##PRECIPITACION
names(pre_c)[ind_ene]
names(pre_c)[ind_feb]
names(pre_c)[ind_mar]
names(pre_c)[ind_abr]
names(pre_c)[ind_may]
names(pre_c)[ind_jun]
names(pre_c)[ind_jul]
names(pre_c)[ind_ago]
names(pre_c)[ind_sep]
names(pre_c)[ind_oct]
names(pre_c)[ind_nov]
names(pre_c)[ind_dic]

#Seleccionar capas
#TEMPERATURA
temp_ene<-temp_c[[ind_ene]]
temp_feb<-temp_c[[ind_feb]]
temp_mar<-temp_c[[ind_mar]]
temp_abr<-temp_c[[ind_abr]]
temp_may<-temp_c[[ind_may]]
temp_jun<-temp_c[[ind_jun]]
temp_jul<-temp_c[[ind_jul]]
temp_ago<-temp_c[[ind_ago]]
temp_sep<-temp_c[[ind_sep]]
temp_oct<-temp_c[[ind_oct]]
temp_nov<-temp_c[[ind_nov]]
temp_dic<-temp_c[[ind_dic]]
#PRECIPITACION
pre_ene<-pre_c[[ind_ene]]
pre_feb<-pre_c[[ind_feb]]
pre_mar<-pre_c[[ind_mar]]
pre_abr<-pre_c[[ind_abr]]
pre_may<-pre_c[[ind_may]]
pre_jun<-pre_c[[ind_jun]]
pre_jul<-pre_c[[ind_jul]]
pre_ago<-pre_c[[ind_ago]]
pre_sep<-pre_c[[ind_sep]]
pre_oct<-pre_c[[ind_oct]]
pre_nov<-pre_c[[ind_nov]]
pre_dic<-pre_c[[ind_dic]]

#calcular promedio
#TEMPERATURA
temp_ene_mean<- mean(temp_ene)
temp_feb_mean<-mean(temp_feb)
temp_mar_mean<-mean(temp_mar)
temp_abr_mean<-mean(temp_abr)
temp_may_mean<-mean(temp_may)
temp_jun_mean<-mean(temp_jun)
temp_jul_mean<-mean(temp_jul)
temp_ago_mean<-mean(temp_ago)
temp_sep_mean<-mean(temp_sep)
temp_oct_mean<-mean(temp_oct)
temp_nov_mean<-mean(temp_nov)
temp_dic_mean<-mean(temp_dic)
#PRECIPITACION
pre_ene_mean<-mean(pre_ene)
pre_feb_mean<-mean(pre_feb)
pre_mar_mean<-mean(pre_mar)
pre_abr_mean<-mean(pre_abr)
pre_may_mean<-mean(pre_may)
pre_jun_mean<-mean(pre_jun)
pre_jul_mean<-mean(pre_jul)
pre_ago_mean<-mean(pre_ago)
pre_sep_mean<-mean(pre_sep)
pre_oct_mean<-mean(pre_oct)
pre_nov_mean<-mean(pre_nov)
pre_dic_mean<-mean(pre_dic)


#tener todas las capas juntas y asignarle nombre de los meses
#TEMPERARURA
temp_12<-c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_may_mean,temp_jun_mean,temp_jul_mean,temp_ago_mean,temp_sep_mean,temp_oct_mean,temp_nov_mean,temp_dic_mean)
names(temp_12)<-c("temp_enero","temp_febrero","temp_marzo","temp_abril","temp_mayo","temp_junio","temp_julio", "temp_agosto","temp_septiembre","temp_octubre","temp_noviembre","temp_diciembre")
plot(temp_12)
#Precipitacion
pre_12<-c(pre_ene_mean,pre_feb_mean,pre_mar_mean,pre_abr_mean,pre_may_mean,pre_jun_mean,pre_jul_mean,pre_ago_mean,pre_sep_mean,pre_oct_mean,pre_nov_mean,pre_dic_mean)
names(pre_12)<-c("pre_enero","pre_febrero","pre_marzo","pre_abril","pre_mayo","pre_junio","pre_julio", "pre_agosto","pre_septiembre","pre_octubre","pre_noviembre","pre_diciembre")
plot(pre_12)

install.packages("geodata")
library(geodata)
#8-Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.
dem<-elevation_global(res=5,path=tempdir())
dem_ext<-crop(dem,pol_ext)
plot(dem_ext)
res(dem_ext)
res(temp_12) 

dem_ext_res<-resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)
ext(dem_ext_res)
ext(temp_12)


#9-Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.
predictores<-c(pre_12,temp_12,dem_ext_res)
plot(predictores)
names(predictores)[25]<-"elevacion"

#verificacion del SRC
crs(predictores,describe=TRUE)
st_crs(data_unida)
#Hago una transformacion d4el sistema de referencia de coordenadas
data_unida_t<-st_transform(data_unida,crs(predictores))

df<-extract(predictores,data_unida_t)

#Hago una transformacion d4el sistema de referencia de coordenadas
dim(df)

df_final<-cbind(df,data_unida_t[,"presencia"])
names(df_final)

saveRDS(df_final,"C:/Users/Cony/Desktop/trabajo.s/datos_predictores.rds")

#10-Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.
#MAPA TEMPERATURA
temp_12_cel<- temp_12-273.15
mapa_temperatura<-tm_shape(temp_12_cel)+
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)")+
  tm_shape(data_unida_t)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_layout(panel.labels = c("temp_enero","temp_febrero","temp_marzo","temp_abril","temp_mayo","temp_junio","temp_julio", "temp_agosto","temp_septiembre","temp_octubre","temp_noviembre","temp_diciembre"))+ tm_compass(position = c("RIGHT", "BOTTOM"), type = "arrow", size = 1, color.dark = NA)+
  tm_graticules()

tmap_save(mapa_temperatura,"mapa_estatico_pf_temperatura.png")
#MAPA PRECIPITACION
pre_12_mil<-pre_12*1000
mapa_temperatura<-tm_shape(pre_12_mil)+
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Precipitacion(milimetros)")+
  tm_shape(data_unida_t)+
  tm_dots(col = "presencia", 
          style="cat",
          title = "Presencia",
          palette=viridis::turbo(2))+
  tm_layout(panel.labels = c("pre_enero","pre_febrero","pre_marzo","pre_abril","pre_mayo","pre_junio","pre_julio", "pre_agosto","pre_septiembre","pre_octubre","pre_noviembre","pre_diciembre"))+ tm_compass(position = c("RIGHT", "BOTTOM"), type = "arrow", size = 1, color.dark = NA)+
  tm_graticules()

tmap_save(mapa_temperatura,"mapa_estatico_pf_precipitacion.png")

#MAPA ELEVACION
mapa_elevacion<-tm_shape(dem_ext_res)+
  tm_raster(style = "cont", 
            palette = terrain.colors(3),
            title="Elevación(m)",
            alpha = 0.7)+
  tm_shape(data_unida_t)+
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


#11-Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022
#pasar a milimimetros
pre_acum_anual<-sum(pre_12*1000)
plot(pre_acum_anual)
#K a grados celsius
temp_prom_anual<-mean(temp_12-273.15)
plot(temp_prom_anual)

#12-Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

install.packages("spData")
library(spData)

tmap_mode("view")
class(pre_acum_anual)
dem_ext

#mapa precipitacion acumulada anual

mapa1<-tm_shape(pre_acum_anual)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)",
            alpha = 0.7) 
#mapa temperatura 
mapa2<-tm_shape(temp_prom_anual)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)


mapa_interactivo<-mapa1 + mapa2 + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia")

tmap_save(mapa_interactivo,"mapa_interactivo_pf.html")
