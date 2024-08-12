#camila urrutia
#Trabajo final


install.packages(c('terra','sf','geodata','viridisLite','tmap'))
install.packages('spDataLarge',
                 repos='https://nowosad.github.io/drat/',
               type='source')
install.packages("Rtools")

library(terra)
library(sf)
library(geodata)
library(tmap)
library(spData)
library(viridisLite)


################################
#1.
temperatura <- list.files('era5-monthly_2m_mean_temperature', pattern = 'tif$', full.names = TRUE)
temperatura

temp1 <- rast(temperatura)
temp1

precipitacion<- list.files('era5-monthly_total_precipitation', pattern = 'tif$', full.names = TRUE)
precipitacion

precip1<- rast(precipitacion)
precip1

dem<- elevation_global(res = 10, path = tempdir())
plot(dem)

chil <- elevation_30s(country = 'Chile',path = tempdir())
arg <- elevation_30s(country = 'Argentina',path = tempdir())

mapita <- cbind(arg,chil)


data <- read.csv2('planilla_presencia_frickius_variolosus.csv', header = TRUE, sep = ",")
class(data)
str(data)


data_fri <- st_as_sf(data, coords = c( 'longitude','latitude'))
sist_de_ref <- st_crs(4326)
data_fri <- st_set_crs(data_fri,sist_de_ref)
st_crs(data_fri)

plot(temp1[[1]])
plot(st_geometry(data_fri),add = TRUE)

xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -38.075

ptos <- matrix(c(xmin,xmax,xmax,xmin,ymin,ymin,ymax,ymax),ncol=2)

ext <- st_polygon(list(rbind(ptos,ptos[1,])))

ext <- st_as_sf(st_sfc(ext),crs = 4326)

plot(ext, add=TRUE)

#Temperatura
temp_c <- crop(temp1,ext)
plot(temp_c)

#Precipitacion
prec_c <- crop(precip1,ext)
plot(prec_c)

#Elevacion
dem_c <- crop(dem,ext)
plot(dem_c)

seudo <- st_sample(ext,100)

#2da clase



data <- read.csv2('planilla_presencia_frickius_variolosus.csv', header = TRUE, sep = ",")
?read.csv2    ####
str(data)
data
#crear objeto coordenadas
data_sf <- st_as_sf(data,coords=c('longitude','latitude'))
sist_de_ref_1 <- st_crs(4326)
data_sf <- st_set_crs(data_sf,sist_de_ref_1)
st_crs(data_sf)
data_sf

#definir extencion
xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax<- -37.89669

ext <- st_bbox(c(xmin = xmin ,xmax = xmax ,ymin = ymin ,ymax = ymax))


pol_ext <- st_as_sf(st_as_sfc(ext),crs=4326)

plot(pol_ext)
plot(data_sf$geometry, add= TRUE)

#visualizacion con tmap

tmap_mode('view')


#semilla
set.seed(123)
data_pseudo <- st_sample(pol_ext,100)

data_sf_utm <- st_transform(data_sf,32719)
buff <- st_buffer(data_sf_utm,250)


data_pseudo_32719 <- st_transform(data_pseudo,st_crs(buff))
ptos_inter <- st_intersection(data_pseudo_32719,buff)

#tmap
tm_shape(pol_ext) +
  tm_borders() +
  tm_shape(data_sf) + 
  tm_dots() +
  tm_shape(data_pseudo) +
  tm_dots(col = 'red') +
  tm_shape(buff) +
  tm_polygons(col = 'darkgreen')


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
plot(data_unida)

#visualizacion con tmap
tm_shape(pol_ext) +
  tm_borders()+
  tm_shape(data_unida)+
  tm_dots(col="presencia",style="cat")

#Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.
#debe cortar los datos climaticos raster de temperatura media y precipitaion 

files_temp <- list.files("data/era5-monthly_2m_mean_temperature", 
                         full.names =TRUE)
files_pre <- list.files("era5-monthly_total_precipitation", 
                        full.names = TRUE)
files_pre
temp <- rast(files_pre)
pre <- rast(files_pre)

#cortar de acuerdo a la extension 
temp_c <- crop(temp,pol_ext)
pre_c <- crop(pre,pol_ext)

plot(temp_c[[1]])
plot(pre_c[[1]])


#Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#creo vector con el patron de los meses de enero hasta dic
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

names(temp_c)[ind_ene][ind_feb][ind_mar][ind_abr][ind_may][ind_jun][ind_jul][ind_ago][ind_sep][ind_oct][ind_nov][ind_dic]

#dos maneras de hacerlo:
#1:
#temperatura
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

#precipitaciones
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
temp_feb <- subset(temp_c,ind_feb)
temp_mar <- subset(temp_c,ind_mar)
temp_abr <- subset(temp_c,ind_abr)
temp_may <- subset(temp_c,ind_may)
temp_jun <- subset(temp_c,ind_jun)
temp_jul <- subset(temp_c,ind_jul)
temp_ago <- subset(temp_c,ind_ago)
temp_sep <- subset(temp_c,ind_sep)
temp_oct <- subset(temp_c,ind_oct)
temp_nov <- subset(temp_c,ind_nov)
temp_dic <- subset(temp_c,ind_dic)

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

temp_12 <- c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_may_mean,temp_jun_mean,temp_jul_mean,temp_ago_mean,temp_sep_mean,temp_oct_mean,temp_nov_mean,temp_dic_mean)
plot(temp_12)

names(temp_12) <- c("temp enero","temp febrero","temp marzo","temp abril","temp mayo","temp junio","temp julio","temp agosto","temp septiembre","temp octubre","temp noviembre","temp diciembre")
plot(temp_12)

#de los 72 nos quedamos con 12 de temperatura y 12 de precipitacion 

pre_12 <- c(pre_ene_mean,pre_feb_mean,pre_mar_mean,pre_abr_mean,pre_may_mean,pre_jun_mean,pre_jul_mean,pre_ago_mean,pre_sep_mean,pre_oct_mean,pre_nov_mean,pre_dic_mean)
plot(pre_12)

names(pre_12) <- c("pre enero","pre febrero","pre marzo","pre abril","pre mayo","pre junio","pre julio","pre agosto","pre septiembre","pre octubre","pre noviembre","pre diciembre")
plot(pre_12)


#Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.
#descargue la elevacion global utilizando la funcion elevation_global de {geodata}. corte el raster de elevacion para el area de estudio. haga un resampleo 


dem <- elevation_global(res=5, path = tempdir())
plot(dem)

dem_ext <- crop(dem,pol_ext)
plot(dem_ext)
res(dem_ext)
res(temp_12)

#resampleo elevacion
dem_ext_res <- resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)

#ahora se pueden unir todo en un raster multicapa
predictores <- c(pre_12,temp_12,dem_ext_res)
plot(predictores)
names(predictores)[25] <- 'elevacion'
plot(predictores)
writeRaster(predictores,'predictores.tif')

#Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.


crs(predictores,describe=TRUE)
st_crs(data_unida)

data_unida_t <- st_transform(data_unida,crs(predictores))

df <- extract(predictores,data_unida_t)
dim(df)

df_final <- cbind(df,data_unida_t[,'presencia']) 
names(df_final)
df_final

####
?writeRDS
?saveRDS

df_RDS <- saveRDS(df_final, 
                  file="datos_predictores.rds", 
                  ascii = FALSE,
                  version = NULL, 
                  compress=TRUE, 
                  refhook = NULL)
data_RDS_reloaded <-readRDS("datos_predictores.rds")

####
#Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

library(viridis)
library(tmap)
library(sf)
library(spData)
?tmap
df_final
#calcular raster's acumulada
pre_12
temp_12

pre_acum_anual <- sum(pre_12*1000) #en mm
temp_acum_anual <- mean(temp_12-273.15) #en °C

plot(pre_acum_anual)
plot(temp_acum_anual)


plot(data_unida[,'presencia'])
plot(pol_ext)

#mapa

library(spData)
spData::world$geom
plot(world$geom)
plot(nz$geom)

  
#presencia y pseudo ausencia

tm_ptos <- tm_shape(data_unida_t)+
  tm_dots(col = 'presencia', size = .2)

#10. 

# Cargar las librerías necesarias
library(tmap)
library(viridis)
#
temp_12_cel <- temp_12 - 273.15

tmap_mode('plot')
mapa_temp <- tm_shape(temp_12_cel) +
  tm_raster(style = 'cont',
            palette = viridis::viridis(20),
            title = 'Temperatura (°C)')+
  tm_shape(data_unida_t)+
  tm_dots(col = 'presencia', 
          style = 'cat', 
          title = 'Presencia') +
  tm_graticules()+
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'))
  
tmap_save(mapa_temp,'mapa_estatico_pf_temperatura.png')

#Precipitacion#
pre_12_mm <- pre_12*1000


tmap_mode('plot')
mapa_pre <- tm_shape(pre_12_mm) +
  tm_raster(style = 'cont',
            palette = viridis::viridis(20),
            title = 'Precipitacion [mm]')+
  tm_shape(data_unida_t)+
  tm_dots(col = 'presencia', 
          style = 'cat', 
          title = 'Presencia') +
  tm_graticules()+
  tm_layout(panel.labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'))

tmap_save(mapa_pre,'mapa_estatico_pf_precipitacion.png')

#Elevacion#
dim(dem_ext_res)

tmap_mode('plot')
mapa_elev <- tm_shape(dem_ext_res) +
  tm_raster(style = 'cont',
            palette = viridis::viridis(20),
            title = 'Elevacion')+
  tm_shape(data_unida_t)+
  tm_dots(col = 'presencia', 
          style = 'cat', 
          title = 'Presencia') +
  tm_graticules()+
  tm_layout()

tmap_save(mapa_elev,'mapa_estatico_pf_elevacion.png')


#11. Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.
#pasar a milimimetros


#pasar a milimimetros
pre_acum_anual<-sum(pre_12*1000)
plot(pre_acum_anual)
#K a grados celsius
temp_prom_anual<-mean(temp_12*273.15)
plot(temp_prom_anual)

#12. Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

install.packages("leaflet")

# Carga las bibliotecas necesarias
library(leaflet)
library(htmltools)

# Carga los mapas estáticos
mapa_temp <- readPNG("mapa_estatico_pf_temperatura.png")
mapa_pre <- readPNG("mapa_estatico_pf_precipitacion.png")
mapa_elev <- readPNG("mapa_estatico_pf_elevacion.png")

# Crea un mapa interactivo
mapa_interactivo <- leaflet() %>%
  
  # Agrega capa de temperatura
  addTiles() %>%
  addRasterImage(mapa_temp, opacity = 0.7, colors = viridis::viridis(20), layerId = "temp") %>%
  
  # Agrega capa de precipitación
  addTiles() %>%
  addRasterImage(mapa_pre, opacity = 0.7, colors = viridis::viridis(20), layerId = "precipitacion") %>%
  
  # Agrega capa de elevación
  addTiles() %>%
  addRasterImage(mapa_elev, opacity = 0.7, layerId = "elevacion") %>%
  
  # Agrega capa de puntos (presencia)
  addCircleMarkers(data = data_unida_t, lng = ~longitud, lat = ~latitud, 
                   color = ~presencia, radius = 5, group = "presencia",
                   stroke = FALSE, fillOpacity = 0.7,
                   label = ~presencia, labelOptions = labelOptions(noHide = TRUE)) %>%
  
  # Control de capas
  addLayersControl(baseGroups = c("temp", "precipitacion", "elevacion"),
                   overlayGroups = "presencia",
                   position = "topright",
                   options = layersControlOptions(collapsed = FALSE))

# Guarda el mapa interactivo
saveWidget(mapa_interactivo, file = "mapa_interactivo_pf.html", selfcontained = TRUE)

