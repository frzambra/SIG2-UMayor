#PROYECTO FINAL
#INTEGRANTES: JAVIERA CERDA Y BARBARA SEPULVEDA 
#FECHA DE ENTREGA: LUNES 4 DICIEMBRE

#DATOS A UTILIZAR:
#Planilla Excel con datos de presencia de Frickius Variolosus
#Datos climáticos ERA5-Land (seis años de datos mensuales de precipitación acumulada mensual y temperatura promedio mensual)
#Datos de elevación (utilizando el paquete {geodata} yla función elevation_global)

#Prepararemos el data collection. 
#Puntos rojos indicarán en donde se ha encontrado la especie (presencia) (valor 1)
#Cruces negras indicarán que no hay presencia de la especie (pseudoausencia) (valor 0)

#instalar y cargar paquetes primero que todo 
install.packages("sf")
library(sf)
install.packages("geodata")
library(geodata)
install.packages("tmap")
library(tmap)
install.packages("terra")
library(terra)
install.packages("tibble")
library(tibble)

#para temperatura:
files <-  list.files("data/era5-monthly_pre_temp/era5-monthly_2m_mean_temperature", pattern = "tif$", full.names = TRUE)

temp <- rast(files)
temp
plot(temp)

#para precipitacion:
files <-  list.files("data/era5-monthly_total_precipitation", pattern = "tif$", full.names = TRUE)
pre <- rast(files)
plot(pre)

temp
pre

#cargar geodata para datos de elevacion:
library(geodata)

dem <- elevation_global(res = 10,path = tempdir())
dem <- elevation_30s(country = "Chile", path = tempdir())
plot(dem)
arg <- elevation_30s(country = "Argentina", path = tempdir())
plot(arg)


#PREGUNTA 1.
#CREAR UN OBJETO SF DE TIPO POLIGONO QUE DEFINA LA EXTENSION DEL AREA DE ESTUDIO. ESTA DEBE IR DESDE LA LATITUD -38,075 Y LONGITUD -74,00 A LA LATITUD -48,00 Y LONGITUD -70,75

#definir objetos tanto para xmin, xmax, ymin, ymax, es decir, definir extension
library(sf)
xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -38.075
ptos <- matrix(c(xmin,xmax,
                 xmax,xmin,
                 ymin,ymin,
                 ymax,ymax), ncol = 2)
ext<- st_polygon(list(rbind(ptos,ptos[1,])))
ext <- st_as_sf(st_sfc(ext),crs=4326)
plot(ext)
plot(ext, add= TRUE)
class(ptos)


#indexando temp y crop del raster de temp respecto a la extension 
plot(temp)
temp_c <- crop(temp,ext)
plot(temp_c)


#PREGUNTA 2.
#A PARTIR DE LA PLANILLA CON LAS COORDENADAS DE PRESENCIA DE LA ESPECIE FRICKIUS VARIOLOSUS, DEBE CREAR UN OBJETO SF CON GEOMETRIAS DE TIPO PUNTOS. HAGA UN GRAFICO DE LA UBICACION DE LOS PUNTOS EN EL AREA DE ESTUDIO. 

#crear objeto sf con las coodenadas de presencia 
data <- read.csv2("data/planilla_presencia_frickius_variolosus.csv", dec = "-", sep = ";")
data <- read.csv("data/planilla_presencia_frickius_variolosus.csv", sep = ";")
data
str(data)

#debemos crear un objeto sf
data_sf <- st_as_sf(data,coords = c("longitude", "latitude"), crs=4326)
data_sf
st_crs(data_sf)
ext <- st_bbox(c(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax))
plot(ext)
pol_ext <- st_as_sf(st_as_sfc(ext),crs=4326)
pol_ext
plot(pol_ext)

plot(data_sf$geometry, add=TRUE, col="green")


#PREGUNTA 3
#Debe crear 100 puntos de pseudo-ausencia de la especie, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.

#crear puntos de pseudoausencia 
set.seed(123)
data_pseudo <- st_sample(pol_ext,100)
data_pseudo

data_sf_utm <- st_transform(data_sf,32719)
data_sf_utm
buff <- st_buffer(data_sf_utm,2500)

plot(data_sf$geometry, add= TRUE, col ="red")

#visualizacion tmap 
library(tmap)
tmap_mode("view")
tm_shape(pol_ext)+
  tm_borders()+
  tm_shape(data_sf)+
  tm_dots()+
  tm_shape(data_pseudo)+
  tm_dots(col="red")+
  tm_shape(buff)+
  tm_polygons(col= "darkgreen")


#PREGUNTA 4.
#Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.

set.seed(123)
data_pseudo <- st_sample(pol_ext,100)

data_sf_utm <- st_transform(data_sf,32719)
#Crear buffer de 2500m (ya no es 250m)
buff <- st_buffer(data_sf_utm,2500)

#st_intersection a buscar quienes se intersectan (el buffer con los de pseudoausencia)

#verificar el src de presencia y pseudo ausencia 
st_crs(buff)
st_crs(data_pseudo)

#se debe cambiar el src 
data_pseudo_proj <- st_transform(data_pseudo,st_crs(buff))
st_crs(data_pseudo_proj)

#busca que puntos de pseudo-ausencia se intersectan con los buffers
ptos_inter <- st_intersection(data_pseudo_proj,buff)
dim(data_pseudo_proj)

ptos_selec <- st_difference(data_pseudo_proj,ptos_inter)
plot(ptos_selec)


#PREGUNTA 5
#Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

#unir los datos de presencia con los de pseudo ausencia
#AMBOS deben tener una columna que identifique si es de presencia o no. 

data_sf_utm
#tiene 4 variables,geometria punto, en crs wgs 84/utm zone 19s, se puede agregar una columna que se llame presencia y lo seteamos como 1

#PRESENCIA:
data_sf_utm$presencia <- 1

#puntos de presencia con la columna presencia seteado con el valor 1 (valor 1 indica presencia)
data_sf_utm <- data_sf_utm[,6:5]
data_sf_utm

#agregar columna de presencia a datos de pseudo ausencia 
class(ptos_selec)

#para agregarle un atributo a una list colum, la unica manera es incluirlo a un sf en un data frame 
data_ausen <- st_as_sf(ptos_selec)
data_ausen$presencia <- 0 

#unir los datos de presencia con pseudo-ausencia 
st_geometry(data_ausen) <- "geometry"
#unir 
data_unida <- rbind(data_ausen,data_sf_utm)

#visualizacion con tmap
tm_shape(pol_ext) +
  tm_borders()+
  tm_shape(data_unida)+
  tm_dots(col="presencia",style="cat")

#PREGUNTA 6
#Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.

#debe cortar los datos climaticos raster de temperatura media y precipitaion 

library(terra)
files_temp <- list.files("data/era5-monthly_2m_mean_temperature", 
                         full.names =TRUE)
files_pre <- list.files("data/era5-monthly_total_precipitation",
                        full.names = TRUE)
temp <- rast(files_temp)
pre <- rast(files_pre)

#cortar de acuerdo a la extension correspondiente, tanto para temperatura como para precipitacion 
temp_c <- crop(temp,pol_ext)
pre_c <- crop(pre,pol_ext)

#temperatura:
plot(temp_c[[1]])
#precipitacion:
plot(pre_c[[1]])

#PREGUNTA 7 
#Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#creo vector con el patron de los meses de enero (TODOS, LOS 12)
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

#existen dos maneras de hacerlo en las que se pueden, con funcion subset o con [[]] 

#1:
temp_ene <- subset(temp_c,ind_ene)

#2 (a mi gusto, mucho mejor)
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

#calcular el promedio temperatura de cada mes;
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


#despues de ésto, se debe unir:
#PARA TEMPERATURA:
temp_anual <- c(temp_ene_mean,
             temp_feb_mean,
             temp_mar_mean,
             temp_abr_mean,
             temp_may_mean,
             temp_jun_mean,
             temp_jul_mean,
             temp_ago_mean,
             temp_sep_mean,
             temp_oct_mean,
             temp_nov_mean,
             temp_dic_mean)
plot(temp_anual)
names(temp_anual) <- c("temp enero",
                       "temp febrero",
                       "temp marzo", 
                       "temp abril",
                       "temp mayo",
                       "temp junio",
                       "temp julio",
                       "temp agosto",
                       "temp septiembre",
                       "temp octubre",
                       "temp noviembre",
                       "temp diciembre")
plot(temp_anual)

#PARA PRECIPITACION:
pre_anual <- c(pre_ene_mean,
               pre_feb_mean,
               pre_mar_mean,
               pre_abr_mean,
               pre_may_mean,
               pre_jun_mean, 
               pre_jul_mean,
               pre_ago_mean,
               pre_sep_mean, 
               pre_oct_mean,
               pre_nov_mean,
               pre_dic_mean)
plot(pre_anual)
names(pre_anual) <- c("pre enero",
                      "pre febrero",
                      "pre marzo",
                      "pre abril",
                      "pre mayo",
                      "pre junio", 
                      "pre julio",
                      "pre agosto",
                      "pre septiembre", 
                      "pre octubre",
                      "pre noviembre",
                      "pre diciembre")
plot(pre_anual)



#PREGUNTA 8 
#Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

library(geodata)
dem <- elevation_global(res=5, path = tempdir())

plot(dem)
dem_ext <- crop(dem,pol_ext)
plot(dem_ext)
res(dem_ext)
res(temp_anual)
#para poder unirlos deben tener la misma extension y la misma resolucion 

#en este caso la extension no corresponde  pórque el tamaño de los pixeles son diferentes, se debe hacer un resampleo.

#realizar un resampleo del dem para que calce con la reoslucion y extension de los rasters de temperatura y precipitacion
#usar funcion resample para transformar la resolucion del dem 
dem_ext_res <- resample(dem_ext,temp_anual)

#ahora ambas tienen la misma resolucion
res(dem_ext_res)
res(temp_anual)

#ahora ambas tienen la misma extension
plot(dem_ext_res)
ext(dem_ext_res)
ext(temp_anual)
#lo que importa es que la resolucion sea al menos igual o mejor que los datos de temperatura 

#ahora verificamos que tenemos la misma resolucion y extension 


#PREGUNTA 9
#Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.

#raster de precipitacion de los 12 meses:
pre_anual
plot(pre_anual)
#raster de temperatura de los 12 meses: 
temp_anual
plot(temp_anual)
#raster de elevacion (solo uno):
dem_ext_res

#ahora que todos los predictores estan con la misma resolucion y la misma extension, los puedo unir en un raster multicapa
#unir raster con funcion c 
predictores <- c(pre_anual,temp_anual,dem_ext_res)
plot(predictores)
#ahora efectivamente tenemos un raster de 25 capas; 
predictores
#mostramos los nombres de las capas; 
names(predictores)
#cambiar nombre de elevacion para mejor comprension
names(predictores)[25] <- "elevacion"
names(predictores)

#para guardar raster;
library(terra)
writeRaster(predictores,"predictores.tif")

#una vez que tengo el raster multicapa con los 25 predictores, puedo extraer los valores de temperatura mensual, preciptacion mensual y elevacion en los puntos de presencia y pseudoausencia de frickius 

#transformacion del sistema de referencia de coordenadas 
crs(predictores,describe=TRUE)
st_crs(data_unida)
data_unida_t <- st_transform(data_unida,crs(predictores))
data_unida_t

df <- extract(predictores,data_unida_t)
df

#unir los datos extraidos con la columna presencia
df_final <- cbind(df,data_unida_t[,"presencia"])
names(df_final)
view(df_final)
str(df_final)

#saveRDS: formato nativo de r
saveRDS(df_final,"data/data_predictores.rds")


#PREGUNTA 10
#Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

#crear mapas ejemplos (esta es la manera general en la que siempre se crean, sin embargo no es la que se pide porque no son tan interactivos)
plot(data_unida$geometry)
plot(data_unida[,"presencia"])
plot(pol_ext)
#pero, esto no sirve, deben ser mapas diferentes, INTERACTIVOS 
#tm_grid (genera una grilla)
#tm_compass nos permite que muestre la flecha norte
#usar {tmap} para crear mapas para crear mapas para los predictores 
library(tmap)

#MAPA DE TEMPERATURA (TEMP)
temp_anual
tmap_mode("plot")
temp_anual_cel <- temp_anual-273.15

mapa1_temp <- tm_shape(temp_anual_cel)+
  tm_raster(style = "cont",
            palette = viridis::inferno(30),
            title = "Temperatura (°C)")+
  tm_shape(data_unida_t)+
  tm_dots(col="presencia",style="cat",title = "Presencia")+
  tm_graticules()+
  tm_layout(panel.labels = c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"))+
  tm_compass(position = c("right","bottom",type="arrow",size=1,color.dark=NA))

#ahora el mapa de temperatura se debe guardar:
tmap_save(mapa1_temp,"mapa_estatico_pf_temperatura.png")


#MAPA DE PRECIPITACION
tmap_mode("plot")
pre_anual_cel <- pre_anual*1000

mapa2_pre <- tm_shape(pre_anual_cel)+
  tm_raster(style = "cont",
            palette = viridis::viridis(30),
            title = "Precipitacion (ml)")+
  tm_shape(data_unida_t)+
  tm_dots(col="presencia",style="cat",title = "Presencia")+
  tm_graticules()+
  tm_layout(panel.labels = c("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"))+
  tm_compass(position=c("right","bottom",type="arrow",size=1,color.dark=NA))

#ahora el mapa de precipitacion se debe guardar;
tmap_save(mapa2_pre,"mapa_estatico_pf_precipitacion.png")



#MAPA DE ELEVACION
tmap_mode("plot")
dem_ext_res

mapa3_elev <- tm_shape(dem_ext_res)+
  tm_raster(style = "cont",
            palette = terrain.colors(3),
            title = "Elevacion (m)",alpha=0.7)+
  tm_shape(data_unida_t)+
  tm_dots(col="presencia",style="cat",title = "Presencia")+
  tm_graticules()+
  tm_layout(legend.outside.position = "right",legend.outside = TRUE)+
  tm_compass(position=c("right","bottom",type="arrow",size=1,color.dark=NA))

#ahora el mapa de elevacion se debe guardar;
tmap_save(mapa3_elev,"mapa_estatico_pf_elevación.png")


#PREGUNTA 11
#Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.

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

#calcular el promedio temperatura de cada mes;
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


#despues de ésto, se debe unir:
#PARA TEMPERATURA:
temp_anual <- c(temp_ene_mean,
                temp_feb_mean,
                temp_mar_mean,
                temp_abr_mean,
                temp_may_mean,
                temp_jun_mean,
                temp_jul_mean,
                temp_ago_mean,
                temp_sep_mean,
                temp_oct_mean,
                temp_nov_mean,
                temp_dic_mean)
plot(temp_anual)
names(temp_anual) <- c("temp enero",
                       "temp febrero",
                       "temp marzo", 
                       "temp abril",
                       "temp mayo",
                       "temp junio",
                       "temp julio",
                       "temp agosto",
                       "temp septiembre",
                       "temp octubre",
                       "temp noviembre",
                       "temp diciembre")
plot(temp_anual)

#PARA PRECIPITACION:
pre_anual <- c(pre_ene_mean,
               pre_feb_mean,
               pre_mar_mean,
               pre_abr_mean,
               pre_may_mean,
               pre_jun_mean, 
               pre_jul_mean,
               pre_ago_mean,
               pre_sep_mean, 
               pre_oct_mean,
               pre_nov_mean,
               pre_dic_mean)
plot(pre_anual)
names(pre_anual) <- c("pre enero",
                      "pre febrero",
                      "pre marzo",
                      "pre abril",
                      "pre mayo",
                      "pre junio", 
                      "pre julio",
                      "pre agosto",
                      "pre septiembre", 
                      "pre octubre",
                      "pre noviembre",
                      "pre diciembre")
plot(pre_anual)

#calcular un raster de precipitacion acumulada anual 
#la precipitacion esta en metros, la multiplico por 1000 para dejarla en milimetros 
pre_acum_anual <- sum(pre_anual*1000)
plot(pre_acum_anual)

#para temperatura la convierto de kelvin a °C restando 271.15
temp_prom_anual <- mean(temp_anual-273.15)
plot(temp_prom_anual)

#PREGUNTA 12
#Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

#anteriormente utilizamos "plot", en este caso, utilizaremos "view"
tmap_mode("view")

#para realizar mapa de precipitacion anual:

mapa_precipitacion<-tm_shape(pre_acum_anual)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(30),
            title="Precipitación(mm)",
            alpha = 0.7) 

mapa_temperatura<-tm_shape(tem_prom_anual)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)

mapa_elevacion <- tm_shape(dem_ext_res)+ 
  tm_raster(style = "cont", 
            palette = terrain.colors(),
            title="elevacion (m)",
            alpha = 0.7)

mapa_final <- mapa_temperatura + mapa_precipitacion + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo (Precipitación acum anual, Temperatura prom, Elevación y Ubicación de presencia y pseudo-ausencia de Frickius Variolosus")

tmap_save(mapa_final,"mapa_interactivo_pf.html")