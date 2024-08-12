##Pia Fuentes.

install.packages('terra')
install.packages('sf')
install.packages('geodata')
install.packages('tmap')
library(geodata)
library(terra)
library(sf)
library(tmap)

files_temp <- list.files('data/era5-monthly_2m_mean_temperature/', pattern = 'tif$', full.names = TRUE)

temp <- rast(files_temp)
temp
plot(temp)

files_pp <- list.files('data/era5-monthly_total_precipitation/', pattern = 'tif$', full.names = TRUE)
pp <- rast(files_pp)

dem <- elevation_global(res=10, path=tempdir())
dem <- elevation_30s(country = 'Chile', path= tempdir())
arg <- elevation_30s(country = 'Argentina', path= tempdir())


data_fri <- st_as_sf(data, coords = c('longitude', 'latitude'), crs = 4326)
data_fri

plot(temp[[1]])
plot(st_geometry(data_fri), add = TRUE)


#1. Crear un objeto sf de tipo poígono que define la extension del área de estudio. Esta debe ir desde la latitud -38.075 y longitud -74.00 a latitud -48.00 y longitud -70.75
xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -37.89669
ptos <- matrix(c(xmin, xmax,
                 xmax, xmin,
                 ymin, ymin,
                 ymax, ymax), ncol= 2)
ext <- st_polygon(list(rbind(ptos, ptos[1,])))
plot(ext)
pol_ext <- st_as_sf(st_sfc(ext), crs =4326)
plot(pol_ext)

#2. A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrías de tipo punto. Haga un gráfico de la ubicación de los puntos en el área de estudio.

data <- read.csv('data/planilla_presencia_frickius_variolosus.csv', sep=';')
str(data)

data_fri <- st_as_sf(data, coords = c('longitude', 'latitude'), crs = 4326)
data_fri

tmap_mode('view')

tm_shape(pol_ext)+
  tm_borders() +
  tm_shape(data_fri) +
  tm_dots(col='green') 

#3. Debe crear 100 puntos de pseudo-ausencia de la especie, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.

set.seed(123)
data_pseudo <- st_sample(pol_ext, 100)

data_sf_utm <- st_transform(data_fri, 32719)
buff <- st_buffer(data_sf_utm, 2500)
tmap_mode('view')

tm_shape(pol_ext)+
  tm_borders() +
  tm_shape(data_fri) +
  tm_dots() +
  tm_shape(data_pseudo) +
  tm_dots(col='red')+
  tm_shape(buff) +
  tm_polygons(col='darkgreen')

tm_shape(buff) +
  tm_polygons()

#4. Cree áreas de influencia de 2500m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 2500m de uno de presencia.

data_sf_utm <- st_transform(data_fri, 32719)
buff <- st_buffer(data_sf_utm, 2500)

data_pseudo_proj <- st_transform(data_pseudo, st_crs(buff))
ptos_inter <- st_intersection(data_pseudo_proj, buff) #hay un solo punto que se intersecta con el buffer, hay que eliminarlo.

ptos_selec <- st_difference(data_pseudo_proj, ptos_inter)

class(ptos_selec)
st_geometry(ptos_selec)


#5. Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

#puntos de presencia
data_sf_utm$presencia <- 1
names(data_sf_utm)
data_sf_utm <- data_sf_utm[6:5]

#puntos de pseudo ausencia
class(ptos_selec)
data_ausencia <- st_as_sf(ptos_selec)
data_ausencia$presencia <- 0

#unir presencia con pseudoausencia
##Forma 1 con rbind
st_geometry (data_ausencia) <- 'geometry'
data_unida <- rbind(data_ausencia[,2:1], data_sf_utm)

#6. Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.

files_temp <- list.files('data/era5-monthly_2m_mean_temperature/', pattern = 'tif$', full.names = TRUE)
temp <- rast(files_temp)
temp


files_pp <- list.files('data/era5-monthly_total_precipitation/', pattern = 'tif$', full.names = TRUE)
pp <- rast(files_pp)

#Hay que cortar según la extensión
temp_cortada <- crop(temp, pol_ext)
plot(temp_cortada[[1]]) #para verificar

pp_cortada <- crop(pp, pol_ext)
plot(pp_cortada[[1]]) #para verificar


#7. Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#Crear vector con el patrón de los meses
ind_ene <- seq (1, 72 ,12) #para indexar todos los eneros, el 12 es uno para cada mes.
names(temp_cortada) [ind_ene]
ind_feb <- seq (2, 72 ,12)
ind_mar <- seq (3, 72 ,12)
ind_abr <- seq (4, 72 ,12)
ind_may <- seq (5, 72 ,12)
ind_jun <- seq (6, 72 ,12)
ind_jul <- seq (7, 72 ,12)
ind_ago <- seq (8, 72 ,12)
ind_sep <- seq (9, 72 ,12)
ind_oct <- seq (10, 72 ,12)
ind_nov <- seq (11, 72 ,12)
ind_dic <- seq (12, 72 ,12)

#2 formas de seleccionar capas.
#forma 1
temp_ene <- temp_cortada[[ind_ene]]

#forma 2
temp_ene <- subset(temp_cortada, ind_ene)


##continuar con el resto de  las capas Tempratura
temp_feb <- temp_cortada[[ind_feb]]
temp_mar <- temp_cortada[[ind_mar]]
temp_abr <- temp_cortada[[ind_abr]]
temp_may <- temp_cortada[[ind_may]]
temp_jun <- temp_cortada[[ind_jun]]
temp_jul <- temp_cortada[[ind_jul]]
temp_ago <- temp_cortada[[ind_ago]]
temp_sep <- temp_cortada[[ind_sep]]
temp_oct <- temp_cortada[[ind_oct]]
temp_nov <- temp_cortada[[ind_nov]]
temp_dic <- temp_cortada[[ind_dic]]

#Seleccionar capas pp
pp_ene <- pp_cortada[[ind_ene]]
pp_feb <- pp_cortada[[ind_feb]]
pp_mar <- pp_cortada[[ind_mar]]
pp_abr <- pp_cortada[[ind_abr]]
pp_may <- pp_cortada[[ind_may]]
pp_jun <- pp_cortada[[ind_jun]]
pp_jul <- pp_cortada[[ind_jul]]
pp_ago <- pp_cortada[[ind_ago]]
pp_sep <- pp_cortada[[ind_sep]]
pp_oct <- pp_cortada[[ind_oct]]
pp_nov <- pp_cortada[[ind_nov]]
pp_dic <- pp_cortada[[ind_dic]]


#Calcular promedio de cada mes (temperatura)
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

#hacer lo mismo con pp
pp_ene_mean <- mean(pp_ene)
pp_feb_mean <- mean(pp_feb)
pp_mar_mean <- mean(pp_mar)
pp_abr_mean <- mean(pp_abr)
pp_may_mean <- mean(pp_may)
pp_jun_mean <- mean(pp_jun)
pp_jul_mean <- mean(pp_jul)
pp_ago_mean <- mean(pp_ago)
pp_sep_mean <- mean(pp_sep)
pp_oct_mean <- mean(pp_oct)
pp_nov_mean <- mean(pp_nov)
pp_dic_mean <- mean(pp_dic)

#luego unir promedio de todos los meses para temp mean y pp mean
##Temperatura
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

names(temp_anual) <- c('temperatura enero',
                    'temperatura febrero',
                    'temperatura marzo', 
                    'temperatura abril',
                    'temperatura mayo',
                    'temperatura junio',
                    'temperatura julio',
                    'temperatura agosto',
                    'temperatura septiembre',
                    'temperatura octubre',
                    'temperatura noviembre',
                    'temperatura diciembre')
plot(temp_anual)

#Precipitación acumulada
pp_anual <- c(pp_ene_mean,
              pp_feb_mean,
              pp_mar_mean,
              pp_abr_mean,
              pp_may_mean,
              pp_jun_mean,
              pp_jul_mean,
              pp_ago_mean,
              pp_sep_mean,
              pp_oct_mean,
              pp_nov_mean,
              pp_dic_mean)

names(pp_anual) <- c('pp enero',
                  'pp febrero',
                  'pp marzo',
                  'pp abril',
                  'pp mayo',
                  'pp junio',
                  'pp julio',
                  'pp agosto',
                  'pp septiembre',
                  'pp octubre',
                  'pp noviembre',
                  'pp diciembre')
plot(pp_anual)

#8. Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (función resampleen {terra`}) de la elevación a la resolución de los datos climáticos.

library(geodata)
dem <- elevation_global(res=5, path=tempdir())
dem_ext <- crop (dem, pol_ext)
res(dem_ext)
res(temp_anual)

##resolucion debe ser al menos igual o mejor que la de temperatura. Habrá que resamplar.

#para poder unirlos deben tener la misma resolución. Se realiza cun resampleo para que tenga la misma resolución y extensión de temp y pp.
dem_ext_res <- resample(dem_ext, temp_anual)
res(dem_ext_res) #verificar resolución
res(temp_anual)
ext(dem_ext_res) #verificar extensión
ext(temp_anual)

#9. Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.

predictores <- c(pp_anual, temp_anual, dem_ext_res)
plot(predictores)

names(predictores) [7] <- 'elevación'

data_unida_proj <- st_transform(data_unida, st_crs(predictores))
df <- extract(predictores, data_unida_proj)
dim(df)

df_final <- cbind(df, data_unida_proj[, 'presencia'])
class(df_final)

writeRaster(predictores, 'predictores.tif')

#formato nativo de R (a diferencia de csv que pierdo datos, no se pierde nignuna configuración):
saveRDS(df_final, 'datos_predictores.rds')

#datos <- readRDS('datis_predictores.rds')

#10. Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

library(tmap)

#mapas estaticos para los predcitores.

tmap_mode('plot')

#Temperatura
temp_anual_cel <- temp_anual - 273.15

mapa1_temp <- tm_shape(temp_anual_cel) +
  tm_raster(style = 'cont',
            palette = viridis::inferno(20),
            title = 'Temperatura (°C)') +
  tm_shape(data_unida_proj) +
  tm_dots(col='presencia', 
          style='cat',
          title= 'Presencia') +
  tm_graticules() + 
  tm_compass(type = "arrow", position = c("left", "top"))+
  tm_layout(panel.labels = c('Enero',
                             'Febrero',
                             'Marzo',
                             'Abril',
                             'Mayo',
                             'Junio',
                             'Julio',
                             'Agosto',
                             'Septiembre',
                             'Octubre', 
                             'Noviembre',
                             'Diciembre'))
  


tmap_save(mapa1_temp, 'mapa_estatico_pf_temperatura.png')


#Precipitación

pp_anual_mm <- pp_anual*1000
  
mapa2_pp <- tm_shape(pp_anual_mm) +
  tm_raster(style = 'cont',
            palette = viridis::viridis(20),
            title = 'Precipitación (mm)') +
  tm_shape(data_unida_proj) +
  tm_dots(col='presencia', 
          style='cat',
          title= 'Presencia') +
  tm_graticules() + 
  tm_compass(type = "arrow", position = c("left", "top"))+
  tm_layout(panel.labels = c('Enero',
                             'Febrero',
                             'Marzo',
                             'Abril',
                             'Mayo',
                             'Junio',
                             'Julio',
                             'Agosto',
                             'Septiembre',
                             'Octubre', 
                             'Noviembre',
                             'Diciembre'))
tmap_save(mapa2_pp, 'mapa_estatico_pf_precipitación.png')

#Elevación

mapa3_dem <- tm_shape(dem_ext_res) +
  tm_raster(style = 'cont',
            palette = terrain.colors(9),
            title = 'Elevación')+
  tm_shape(data_unida_proj) +
  tm_dots(col='presencia', 
          style='cat',
          title= 'Presencia') +
  tm_graticules() + 
  tm_compass(type = "arrow", position = c("left", "top"))+
  tm_legend(position = c('left', 'bottom'), frame= TRUE)

tmap_save(mapa3_dem, 'mapa_estatico_pf_elevación.png')


#11. Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.

#pp en milimetros (esta en metros y se multiplica por 1000 para pasar a mm)
pp_acumulada_anual <- sum(pp_anual*1000)
plot(pp_acumulada_anual)

#Temperatura de Kelvin a °C al restar 273.15
temp_promedio_anual <- sum(temp_anual-273.15)

#12. Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html

tmap_mode("view")

mapa_inter <- tm_shape(temp_promedio_anual)+
  tm_raster(style='cont',
            palette = viridis::inferno(20),
            title = 'Temperatura (°C)') +
  tm_shape(pp_acumulada_anual) +
  tm_raster(style = 'cont',
            palette = viridis::viridis(20),
            title = 'Precipitación (mm)') +
  tm_shape(dem_ext_res) +
  tm_raster(style = 'cont',
            palette = terrain.colors(9),
            title = 'Elevación') +
  tm_shape(data_unida_proj) +
  tm_dots(col='presencia', 
          style='cat',
          title= 'Presencia') +
  tm_graticules() + 
  tm_compass(type = "arrow", position = c("left", "top"))
  
tmap_save(mapa_inter, 'mapa_interactivo_pf.html')
