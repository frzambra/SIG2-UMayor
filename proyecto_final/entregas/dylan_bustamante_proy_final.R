#Proyecto Final 
# Dylan Bustamante y Bastian Quintero


install.packages('sf')
library(sf)
#csv, no reconoce el ';', como separador, por ello se usa sep=';'.
#csv2, reconoce el separador,   

data <- read.csv2('planilla_presencia_frickius_variolosus.csv', dec='.')
data
str(data)

#1 Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud........
data_sf <- st_as_sf(data, coords = c('longitude', 'latitude'), crs= 4326)
data_sf



xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -38.075


ext <- st_bbox(c(xmin= xmin, xmax = xmax, ymin = ymin, ymax =ymax))

pol_ext <- st_as_sf(st_as_sfc(ext), crs=4326)
plot(pol_ext)

#2 A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio

plot(data_sf$geometry, main = "Ubicación de puntos de presencia de Frickius Variolosus",add=TRUE, col= "red")


#3 Debe crear 100 puntos de pseudo-ausencia de la espeice, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.

set.seed(123)
data_pseudo <- st_sample(pol_ext,100)  #CREAR LOS PUNTOS DE PSEUDO 

plot(pol_ext, main = "Ubicación de puntos de presencia y pseudo-ausencia de Frickius Variolosus")
plot(data_pseudo, add = TRUE, col = "blue") #PSEUDO AUSENCIA

plot(data_sf$geometry, add = TRUE, col = "red") #PRESENCIA






#4  Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.


data_sf_utm <- st_transform(data_sf,32719)
buff <- st_buffer(data_sf_utm,2500)

# USO DE TMAP
install.packages('tmap')  # TMAP paquete de R,  que permite mapas más interactivos 
library(tmap)

set.seed(123) 
tmap_mode('view')


tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_sf) +
  tm_dots() +
  tm_shape(data_pseudo) +
  tm_dots(col='red') +
  tm_shape(buff) +
  tm_fill(col = 'green') +  # Utilizar tm_fill en lugar de tm_polygons
  tm_borders()



#CONFIRMAR EL SISTEMA DE COORDENADAS DE PRESENCIA Y PSEUDO-AUSENCIA

st_crs(buff)
st_crs(data_pseudo)

#se debe cambiar el src 
data_pseudo_proj <- st_transform(data_pseudo,st_crs(buff))
st_crs(data_pseudo_proj)  # SE USA EL 32719

#busca que puntos de pseudo-ausencia se intersectan con los buffers
#st_intersection a buscar quienes se intersectan (el buffer con los de pseudoausencia)

ptos_inter <- st_intersection(data_pseudo_proj,buff) 

dim(data_pseudo_proj)

#UNION DE LOS PUNTOS DE PSEUDO AUSENCIA CON LOS BUFFER

ptos_selec <- st_difference(data_pseudo_proj,ptos_inter, col= 'yellow') 
plot(ptos_selec) 





#5  Una los puntos de pseudo-ausencia seleccionados(ptos_selec) con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

#unir los datos de presencia con los de pseudo ausencia, ambos deben tener una columna que identifique si es de presencia o no. 

data_sf_utm # DATOS DE PRESENCIA CON CRS 32719
#tiene 4 variables, se puede agregar una columna que se llame presencia y lo seteamos como 1

#agregar columna de presencia a datos de pseudo ausencia 

a<- data_sf_utm$presencia <- 1   # 1 -> PRESENCIA
a

#puntos de presencia con la columna presencia seteado con el valor 1 (valor 1 indica presencia)
data_sf_utm # AHORA CUENTA CON COLUMNA PRESENCIA (1)

#segunda forma
data_sf_presencia <- data_sf_utm[, c('geometry', 'presencia')]
data_sf_presencia
class(ptos_selec)
ncol(data_sf_presencia)


#queremos aregarle un atributo a una list colum, la unica manera es incluirlo a un sf en un data frame 

data_ausen <- st_as_sf(ptos_selec) 
data_ausen


data_ausen$presencia <- 0  # PUNTOS DE PSEUDO-AUSENCIA

st_geometry(data_ausen) <- "geometry"
data_ausen

#UNIR LOS PUNTOS DE PSEUDO AUSENCIA Y PRESENCIA 
st_crs(data_sf_presencia)
st_crs(data_ausen)
st_crs(data_sf_utm)


#DEBEN TENER EL MISMO SISTEMA DE COORDENDAS 

data_sf_utm_proj <- st_transform(data_sf_presencia,st_crs(data_ausen))
st_crs(data_sf_utm_proj)  # SE USA EL 32719

data_union <- rbind(data_ausen,data_sf_utm_proj) #UNIR LOS PRESENDIA CON PSEUDO AUSENCIA
View(data_union)



#visualizacion con tmap
tm_shape(pol_ext) +
  tm_borders()+
  tm_shape(data_union)+
  tm_dots(col="presencia",style="cat")




#6 Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.
#debe cortar los datos climaticos raster de temperatura media y precipitaion 

library(terra)
files_temp <- list.files("data/era5-monthly_2m_mean_temperature", 
                         full.names =TRUE)
files_pre <- list.files("data/era5-monthly_total_precipitation",
                        full.names = TRUE)

temp <- rast(files_temp)
names(temp)
pre <- rast(files_pre)
names(temp)
names(pre)

#cortar de acuerdo a la extension 
temp_c <- crop(temp,pol_ext)
pre_c <- crop(pre,pol_ext)

plot(temp_c[[1]]) #TEMPERATURA
plot(pre_c[[1]]) # PRECIPITACIÓN


#7 Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#creo vector con el patron de los meses del año
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






#dos maneras de hacerlo:
#1:
#calcular el promedio temp de cada mes 
temp_ene <- temp_c[[ind_ene]]
temp_ene
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

#2 segunda forma
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
#de los 72 nos quedamos con 12 de temperatura, ya que lo promediamos 

temp_12 <- c(temp_ene_mean,temp_feb_mean,temp_mar_mean, temp_abr_mean, temp_may_mean, temp_jun_mean, temp_jul_mean, temp_ago_mean, temp_sep_mean, temp_oct_mean, temp_nov_mean, temp_dic_mean)

plot(temp_12)

names(temp_12) <- c("temp enero","temp febrero","temp marzo", "temp abril", "temp mayor", "temp junio","temp junlio","temp agosto", "temp septiembre", "temp octubre", "temp noviembre", "temp diciembre")
plot(temp_12)

#de los 72 nos quedamos con 12 de precipitacion, ya que lo promediamos 

pre_12 <- c(pre_ene_mean,pre_feb_mean,pre_mar_mean, pre_abr_mean,pre_may_mean,pre_jun_mean, pre_jul_mean,pre_ago_mean,pre_sep_mean, pre_oct_mean,pre_nov_mean,pre_dic_mean)
plot(pre_12)

str(pre_12)
head(pre_12)
summary(pre_12)

names(pre_12) <- c("pre enero","pre febrero","pre marzo", "pre abril","pre mayo","pre junio", "pre julio","pre agosto","pre septiembre", "pre octubre","pre noviembre","pre diciembre")
plot(pre_12)


#8 Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.
#descargue la elevacion global utilizando la funcion elevation_global de {geodata}. corte el raster de elevacion para el area de estudio. haga un resampleo 

install.packages('geodata')
library(geodata)
dem <- elevation_global(res=5, path = tempdir())

#lo que importa es que la resolucion sea al menos igual o mejor que los datos de temperatura 
dem_ext <- crop(dem,pol_ext)
plot(dem_ext) # ELEVACIÓN SEGÚN LA EXTENSIÓN
res(dem_ext)
res(temp_12)

dem_ext_res <- resample(dem_ext,temp_12)
res(dem_ext_res) 
res(temp_12)

names(dem_ext)
#9 Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.


predictores<-c(pre_12,temp_12,dem_ext_res)  #RASTER MULTICAPA
plot(predictores)
names(predictores)[12]<-"elevacion"

#verificacion del SRC
crs(predictores,describe=TRUE)
st_crs(data_union)



#Hago una transformacion d4el sistema de referencia de coordenadas
data_union_t<- st_transform(data_union,crs(predictores))

df<- extract(predictores,data_union_t)

dim(df);View(df)

df_final<- cbind(df,data_union_t[,"presencia"])
names(df_final)
View(df_final)

#SE MULTIPLICA POR 1000 PARA DEJARLO EN mL
pre_acum_anual<-sum(pre_12*1000)
plot(pre_acum_anual)
#K a grados celsius
temp_prom_anual<-mean(temp_12-273.15)
plot(temp_prom_anual)


plot(data_union_t['presencia'])

library(terra)
df<- extract(predictores,data_union_t) #USO DE LA FUNCIÓN EXTRACT DE TERRA

#unir los datos extraido con la columna de presencia 
df_final<- cbind(df,data_union_t['presencia'])

saveRDS(df_final,'data/datos_predictores.rds')


#10 Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png

#MAPA TEMPERATURA
tmap_mode("plot")

temp_12
temp_12_cel<-temp_12-273.15
temp_12_cel

class(temp_12_cel)
crs(temp_12_cel)

class(data_union_t)
st_crs(data_union_t)

mapa_temperatura<-tm_shape(temp_12_cel)+
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)")+
  tm_shape(data_union_t)+
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
  tm_shape(data_union_t)+
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
  tm_shape(data_union_t)+
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








#11 Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.


temp_12 <- c(temp_ene_mean,temp_feb_mean,temp_mar_mean, temp_abr_mean, temp_may_mean, temp_jun_mean, temp_jul_mean, temp_ago_mean, temp_sep_mean, temp_oct_mean, temp_nov_mean, temp_dic_mean)


names(temp_12) <- c("temp enero","temp febrero","temp marzo", "temp abril", "temp mayor", "temp junio","temp junlio","temp agosto", "temp septiembre", "temp octubre", "temp noviembre", "temp diciembre")
plot(temp_12)


pre_12 <- c(pre_ene_mean,pre_feb_mean,pre_mar_mean, pre_abr_mean,pre_may_mean,pre_jun_mean, pre_jul_mean,pre_ago_mean,pre_sep_mean, pre_oct_mean,pre_nov_mean,pre_dic_mean)

names(pre_12) <- c("pre enero","pre febrero","pre marzo", "pre abril","pre mayo","pre junio", "pre julio","pre agosto","pre septiembre", "pre octubre","pre noviembre","pre diciembre")

plot(pre_12)

#multiplicamos por mil para llevarlo a milimetros 

precipitacion_acum_anual <- sum(pre_12*1000)
precipitacion_acum_anual


#para temperatura la convierto de kelvin a °C restando 273.15
temp_prom_anual <- mean(temp_12-273.15)
plot(temp_prom_anual)





#12 Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

tmap_mode("view")
class(pre_acum_anual)
dem_ext

#mapa pre acu anual

mapa1<-tm_shape(precipitacion_acum_anual)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)",
            alpha = 0.7) 

mapa2<-tm_shape(temp_prom_anual)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)


mapa_interactivo<-mapa1 + mapa2 + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia")

tmap_save(mapa_interactivo,"mapa_interactivo_pf.html")


