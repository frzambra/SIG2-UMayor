#valentina Court Trabajo Final 

library(geodata)
install.packages("terra")
install.packages("sf")
library(terra)
library(sf)
install.packages("tmap")
library(tmap)

data<-read.csv("/cloud/project/trabajo final /planilla_presencia_frickius_variolosus.xlsx - Datos_iNaturalist.csv",dec = ",",header = TRUE)

files_pre<-list.files("/cloud/project/trabajo final/era5-monthly_total_precipitation",full.names = TRUE)

files_temp= list.files("/cloud/project/trabajo final /era5-monthly_2m_mean_temperature",pattern='tif$',full.names = TRUE)

dem= elevation_global(res=10,path=tempdir())

dem= elevation_30s(country = 'Chile', path= tempdir())

arg= elevation_30s(country = 'Argentina', path = tempdir())     
plot(arg)
plot(dem)

data<-read.csv("/cloud/project/trabajo final /planilla_presencia_frickius_variolosus.xlsx - Datos_iNaturalist.csv",dec = ",",header = TRUE)

str(data)


data_fri= st_as_sf(data,coords= c('longitude','latitude'),crs=4326)

data_fri

plot(st_geometry(data_fri),add=TRUE)


#1. Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud  y longitud  a latitud  y longitud.
xmin= -74.00
xmax= -70.75
ymin=-48.00
ymax=-38.075

ext<-st_bbox(c(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax))

pol_ext<-st_as_sf(st_as_sfc(ext),crs=4326)

plot(pol_ext)
plot(data_fri$geometry,add=TRUE)



#2. A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio.

tmap_mode("view")


#3. Debe crear 100 puntos de pseudo-ausencia de la espeice, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.


set.seed(123)
data_pseudo<-st_sample(pol_ext,100)

data_sf_utm<-st_transform(data_fri,32719)


#4. Cree áreas de influencia de 2500m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 2500m de uno de presencia.

buff<-st_buffer(data_sf_utm,2500)


plot(buff)

#5. Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.
st_crs(buff)
st_crs(data_pseudo)

data_pseudo_proj<-st_transform(data_pseudo,st_crs(buff))

pts_inter<-st_intersection(data_pseudo_proj,buff)
pts_select<-st_difference(data_pseudo_proj,pts_inter)

plot(pts_inter)
plot(pts_select)


data_sf_utm$presencia<- 1 #columna de presencia 

data_sf_utm<- data_sf_utm[,6:5] #puntos de presencia mas columna seteada con el valor asigando 

data_ausen<-st_as_sf(pts_select) #columna de presencia a datos de pseudo ausencia

data_ausen$presencia<- 0

#union de datos de presencia y pseudo ausencia

st_geometry(data_ausen)<-'geometry'
data_unida<- rbind(data_ausen[,2:1],data_sf_utm)


#6. Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.


tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_unida) +
  tm_dots(col= 'presencia',style= 'cat') 

temp= rast(files_temp)
pre= rast(files_pre)

temp_c<-crop(temp,pol_ext)
pre_c<-crop(pre,pol_ext)

#7. Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

ind_ene= seq(1,72,12)
ind_feb= seq(2,72,12)
ind_mar= seq(3,72,12)
ind_abr= seq(4,72,12)
ind_may= seq(5,72,12)
ind_jun= seq(6,72,12)
ind_jul= seq(7,72,12)
ind_ago= seq(8,72,12)
ind_sep= seq(9,72,12)
ind_oct= seq(10,72,12)
ind_nov= seq(11,72,12)
ind_dic= seq(12,72,12)

names(temp_c)[ind_ene]
names(pre_c)[ind_ene]

#selección de capas
temp_ene= temp_c[[ind_ene]]
temp_feb= temp_c[[ind_feb]]
temp_mar= temp_c[[ind_mar]]
temp_abr= temp_c[[ind_abr]]
temp_may= temp_c[[ind_may]]
temp_jun= temp_c[[ind_jun]]
temp_jul= temp_c[[ind_jul]]
temp_ago= temp_c[[ind_ago]]
temp_sep= temp_c[[ind_sep]]
temp_oct= temp_c[[ind_oct]]
temp_nov= temp_c[[ind_nov]]
temp_dic= temp_c[[ind_dic]]

pre_ene= pre_c[[ind_ene]]
pre_feb= pre_c[[ind_feb]]
pre_mar= pre_c[[ind_mar]]
pre_abr= pre_c[[ind_abr]]
pre_may= pre_c[[ind_may]]
pre_jun= pre_c[[ind_jun]]
pre_jul= pre_c[[ind_jul]]
pre_ago= pre_c[[ind_ago]]
pre_sep= pre_c[[ind_sep]]
pre_oct= pre_c[[ind_oct]]
pre_nov= pre_c[[ind_nov]]
pre_dic= pre_c[[ind_dic]]

#promedio de cada mes
temp_ene_mean= mean(temp_ene)
temp_feb_mean= mean(temp_feb)
temp_mar_mean= mean(temp_mar)
temp_abr_mean= mean(temp_abr)
temp_may_mean= mean(temp_may)
temp_jun_mean= mean(temp_jun)
temp_jul_mean= mean(temp_jul)
temp_ago_mean= mean(temp_ago)
temp_sep_mean= mean(temp_sep)
temp_oct_mean= mean(temp_oct)
temp_nov_mean= mean(temp_nov)
temp_dic_mean= mean(temp_dic)

pre_ene_mean= mean(pre_ene)
pre_feb_mean= mean(pre_feb)
pre_mar_mean= mean(pre_mar)
pre_abr_mean= mean(pre_abr)
pre_may_mean= mean(pre_may)
pre_jun_mean= mean(pre_jun)
pre_jul_mean= mean(pre_jul)
pre_ago_mean= mean(pre_ago)
pre_sep_mean= mean(pre_sep)
pre_oct_mean= mean(pre_oct)
pre_nov_mean= mean(pre_nov)
pre_dic_mean= mean(pre_dic)

temp_12= c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_may_mean,temp_jun_mean,temp_jul_mean,temp_ago_mean,temp_sep_mean,temp_oct_mean,temp_nov_mean,temp_dic_mean)

names(temp_12)= c('temp_enero','temp_febrero','temp_marzo','temp_abril','temp_mayo','temp_junio','temp_julio','temp_agosto','temp_septiembre','temp_octubre','temp_noviembre','temp_diciembre')
plot(temp_12)

pre_12= c(pre_ene_mean,pre_feb_mean,pre_mar_mean,pre_abr_mean,pre_may_mean,pre_jun_mean,pre_jul_mean,pre_ago_mean,pre_sep_mean,pre_oct_mean,pre_nov_mean,pre_dic_mean)

names(pre_12)= c('pre_enero','pre_febrero','pre_marzo','pre_abril','pre_mayo','pre_junio','pre_julio','pre_agosto','pre_septiembre','pre_octubre','pre_noviembre','pre_diciembre')
plot(pre_12)





#8. Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

library(geodaData)

dem<-elevation_global(res = 5,path = tempdir())

dem_ext<-crop(dem,pol_ext)
plot(dem_ext)

res(dem_ext)
res(temp_12)

dem_ext_res= resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)

#9

predictores= c(pre_12,temp_12,dem_ext_res)

names(predictores)[25]= 'elevacion' 

plot(predictores)

data_unida_t= st_transform(data_unida,crs(predictores))

df= extract(predictores,data_unida_t)
dim(df)

df_final= cbind(df,data_unida_t[,'presencia'])

saveRDS(df_final,"/cloud/project/trabajo final/datos_predictores.rds")


#10.
pre_acum_anual= sum(pre_12*1000)
plot(pre_acum_anual)

temp_acum_anual= sum(temp_12-273.15)
plot(temp_acum_anual)

plot(data_unida_t[,'presencia'])
plot(pol_ext)

tmap_mode('plot')


#mapas
#temperatura
temp_12_cel= temp_12-273.15

mapa1_temp= tm_shape(temp_12_cel) +
  tm_raster(style= 'cont',palette= viridis::inferno(20),title= 'Temperatura (ºC)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() +
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')) 

tmap_save(mapa1_temp,'mapa_temp.png')

#precipitación
pre_12_cel= pre_12*1000

mapa2_pre= tm_shape(pre_12_cel) +
  tm_raster(style= 'cont',palette= viridis::viridis(20),title= 'Precipitación (mm)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() +
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')) +
  tm_compass(type= '8star',position = c('left','top'))


tmap_save(mapa2_pre,'mapa_pre.png')

#elevación
mapa3_elev= tm_shape(dem_ext_res) + 
  tm_raster(style= 'cont',palette= viridis::cividis(20),title= 'Elevación (m)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() +
  tm_compass(type= '8star',position = c('left','top'))

tmap_save(mapa3_elev,'mapa_elev.png')



#Mapa Interactivo 

tmap_mode('view')

mapa1_temp= tm_shape(temp_12_cel) +
  tm_raster(style= 'cont',palette= viridis::inferno(20),title= 'Temperatura (ºC)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() +
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')) +
  tm_facets(as.layers= TRUE)

mapa1_temp

mapa2_pre= tm_shape(pre_12_cel) +
  tm_raster(style= 'cont',palette= viridis::viridis(20),title= 'Precipitación (mm)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() +
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')) +
  tm_facets(as.layers= TRUE)

mapa2_pre

mapa3_elev= tm_shape(dem_ext_res) + 
  tm_raster(style= 'cont',palette= viridis::cividis(20),title= 'Elevación (m)') +
  tm_shape(data_unida_t) +
  tm_dots(col='presencia',style='cat',title= 'Presencia') + 
  tm_grid() 

mapa3_elev

mapa4= tmap_arrange(mapa1_temp,mapa2_pre,mapa3_elev,ncol = 3)

tmap_save(mapa4,'mapa_interactivo_pf.html')










