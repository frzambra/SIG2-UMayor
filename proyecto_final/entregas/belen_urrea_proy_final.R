#Proyecto final R 
#Belén Urrea Coa      
install.packages('terra')
install.packages('sf')
install.packages('geodata')

library(terra)
library(sf)
library(geodata)

install.packages('tmap')
install.packages('spData')
install.packages('spDataLarge')

install.packages('tmaptools')
install.packages('shiny')
install.packages('shinyjs')


#Cargaremos todos los archivos para posteriormente solo llamarlos 
#archivos de presencia 
data <- read.csv2('planilla_presencia_frickius_variolosus_CSV.csv', dec = '-')
str(data)      #aqui no hay separacion, no reconoce el ; 

data <- read.csv('planilla_presencia_frickius_variolosus_CSV.csv', sep = ';')

#Aqui tranformamos el archivo o mas bien la latitud y longitud en numerico...en este caso, reconoce el ; como separador y ahora el punto es el decimal para las coordenadas, debido a esto ya esta bien separado 

#Temperatura 
files_temp <- list.files('era5-monthly_2m_mean_temperature', pattern = 'tif$', full.names = TRUE)  #subi la carpeta de era5-monthly_2m_mean_temperature
files_temp

library(terra)
temp <- rast(files_temp)
temp
plot(temp)

#Precipitación
files_pp <- list.files('era5-monthly_total_precipitation', pattern = 'tif$', full.names = TRUE)
files_pp
pp <- rast(files_pp)

library(geodata)
dem <- elevation_global(res=10, path=tempdir())
dem <- elevation_30s(country = 'Chile', path= tempdir())
arg <- elevation_30s(country = 'Argentina', path= tempdir())


#Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud 
#y longitud 
#a latitud 
#y longitud 
#CREAR OBJETO 
xmin <- -74.00
xmax <- -70.75
ymin <- -48.00
ymax <- -37.89669

library(sf)
ext <- st_bbox(c(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax))

#Crear objeto sf que contenga el polígono anterior
library(sf)
pol_ext <- st_as_sf(st_as_sfc(ext), crs=4326)


plot(pol_ext)
#Presencia es data_sf
data_sf <- st_as_sf(data, coords = c('longitude','latitude'), crs = 4326)
data_sf

plot(data_sf$geometry, add = TRUE)
#los puntos son la presencica del Frickius Variolosus


# 2 A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio.
#Crear objeto sf
str(data)
#Presencia es data_sf
data_sf <- st_as_sf(data, coords = c('longitude','latitude'), crs = 4326)
data_sf

#para saber si el src fue correctamente asignado se puede usar str o st_crs(nombre del objeto)
str(data)

#Puntos de presencia seran de color verde dentro de la area de estudio 
plot(pol_ext)
plot(data_sf$geometry,add=TRUE,col="green")

#Otra forma de hacerlo 
# Se instala el paquete "tmap" que permite ver visualizaciones interactivas en los mapas de R(interactivos en vez de estaticos) 
#Por defecto pasa a WDS 84, Tmap hace la transformacion , no hay que cambiar el src
tmap_mode('view')

library(tmap)
install.packages('tmap')
tm_shape(pol_ext)+
  tm_borders() +
  tm_shape(data_sf) +
  tm_dots(col='darkgreen')

# 3 Debe crear 100 puntos de pseudo-ausencia de la especie, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.
#Graficar puntos de presencia, de color "verde", dentro del área de estudio
set.seed(123)
library(sf)
data_pseudo <- st_sample(pol_ext,100)
library(sf)
data_pseudo2 <- st_as_sf(st_sample(pol_ext, 100))

data_sf_utm <- st_transform(data_sf, 32719)
buff <- st_buffer(data_sf_utm, 2500)

#Visto en clases
library(tmap)
tm_shape(pol_ext)+
  tm_borders()+
  tm_shape(data_sf)+
  tm_dots()+
  tm_shape(data_pseudo)+
  tm_dots(col='red')+
  tm_shape(buff)+
  tm_polygons(col='darkgreen')

# 4 Cree áreas de influencia de 250m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.
data_sf_utm <- st_transform(data_sf, 32719)
st_crs(data_sf_utm)

#Creamos un buffer de 250m que represente el area de influencia 
buff <- st_buffer(data_sf_utm, 250)
buff2<- st_buffer(data_sf_utm, 250)
st_geometry(buff)

#para que se pueda reproyectar, es improtante que todo este en el mismo SRC

library(sf)
#Forma 1 
data_pseudo_proj <- st_transform(data_pseudo, 32719)
st_crs(data_pseudo_proj)
ptos_inter <- st_intersection(data_pseudo_proj, buff)

#forma 2 cambio de SRC
st_crs(data_pseudo) <- 32719
st_crs(data_pseudo, describe= TRUE)
#Ahora el objeto data_pseudo tiene el src32719
#Confirmar igualdad de SRC entre los objetos de puntos de pseudo-ausencia y del área de influencia
st_crs(buff2) == st_crs(data_pseudo_proj)

#Ahora veremos los atributos de buff
ncol(buff2)

buff2[,c(1:4)] <- NULL
#Verificar que la eliminación fue bien hecha
str(buff2)

#Graficar área de influencia, de color "azul", dentro del área de estudio
plot(pol_ext)
plot(data_pseudo,col="red",add=TRUE)
plot(buff2$geometry,col="blue",add=TRUE)
plot(buff2,col="blue")


#Ahora eliminaremos los puntos de interseccion, eliminar = ptos_inter
ptos_inter <- st_intersection(buff2, data_pseudo_proj) 
eliminar <- st_intersection(buff2, data_pseudo_proj)
#En esta parte solo hay un solo punto de #Hay un punto de pseudo ausencia dentro del área de influencia, hay que eliminarlo con la funcion intersection 

#definir la difernecia 
ptos_selec <- st_difference(data_pseudo_proj, ptos_inter)
class(ptos_selec)
st_geometry(ptos_selec)

#Definir la diferencia entre x e y
dp_buff <- st_difference(data_pseudo_proj,eliminar)

#Verificar clase de objeto y su tipo de geometría
class(dp_buff) #Objeto de clase sf

# 5 Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

#puntos de presencia
data_sf_utm$presencia <- rep(1,nrow(data_sf_utm))
names(data_sf_utm)
col(data_sf_utm)

##Ordenar columna "presencia" como primera columna y eliminar los atributos restantes
data_sf_utm_ord <- data_sf_utm[6:5]

#puntos de pseudo ausencia 
class(ptos_selec)
data_ausencia <- st_as_sf(ptos_selec)
data_ausencia$presencia <- 0

data_pseudo_proj_ord <- dp_buff[,2:1]

#Verificar orden 
colnames(data_pseudo_proj_ord)
colnames(data_sf_utm_ord)

#unir presencia con pseudoausencia
##Forma 1 con rbind
st_geometry(data_ausencia) <- 'geometry'
data_unida <- rbind(data_ausencia[,2:1], data_sf_utm)
#data_unida es igual a los puntos 

# 6 Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.
#Cragaremos el archivo previamente cargado de temperatura 
files_temp
files_pp

#A los archivos de precipitacion y temperatura hay que cortar según la extensión
library(terra)
temp_cortada <- crop(temp, pol_ext)
plot(temp_cortada[[1]]) #para verificar

pp_cortada <- crop(pp, pol_ext)
plot(pp_cortada[[1]]) #para verificar

# 7 Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.
#Para esta parte haremos un vector con una secuencia. Desde enero a diciembre 
ind_ene <- seq(1, 72, 12)
ind_feb <- seq(2, 72, 12)
ind_mar <- seq(3, 72, 12)
ind_abr <- seq(4, 72, 12)
ind_may <- seq(1, 72, 12)
ind_jun <- seq(2, 72, 12)
ind_jul <- seq(3, 72, 12)
ind_ago <- seq(4, 72, 12)
ind_sep <- seq(1, 72, 12)
ind_oct <- seq(2, 72, 12)
ind_nov <- seq(3, 72, 12)
ind_dic <- seq(4, 72, 12)


#selecciono las capas para cada mes
temp_ene <- temp_cortada[[ind_ene]]
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

#Ahora haremos el mismo procedimeinto pero con los archivos de pp
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

############## Calculo de promedios #################
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

#Calcular el promedio pero de precipitaciones 
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

#Ahora se creara un objeto donde esten todos los promedios de temperatura de cada mes 
tmp_anual <- c(temp_ene_mean,
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

names(tmp_anual) <- c('temperatura enero',
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
plot(tmp_anual)
#Al plotear se observa el promedio por cada mes, en un raster de 12 capas 

#Ahora se creara un objeto donde esten todos los promedios de precipitacion de cada mes 
pre_anual <- c(pp_ene_mean,
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

names(pre_anual) <- c('pp enero',
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
plot(pre_anual)
#Pasa lo mismo, un raster de 12 capas donde cada una es el promedio de precepitacion acumulada. 


# 8 Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos
#crearemos un objeto spatraster de elevacion global, es importante cargar el paquete geodata para lo siguiente
dem <- elevation_global(res=5, path=tempdir())

#antes de seguir, consultaremos por el src 
crs(dem,describe=TRUE) #nos sirve 

library(geodata)
dem_est <- crop(dem, pol_ext)
dem_est
#Visualizar
plot(dem_est)
plot(pol_ext, add=TRUE)
plot(data_sf$geometry,add=TRUE)

#Veremos los SRC 
crs(tmp_anual,describe=TRUE)
crs(pre_anual, describe =TRUE)

#al no estar correctamente asginados, se le asignará
crs(tmp_anual) <- "EPSG:4326"
crs(pre_anual) <- "EPSG:4326"

crs(tmp_anual,describe=TRUE)
crs(pre_anual, describe =TRUE)

#Consultaremos la resolucion de los datos climaticos para que haya una correcta proyeccion 
res(tmp_anual) 
res(pre_anual) 
res(dem_est) 

#vamos a resamplear una de mayor resolucion a una de menor resolucion
dem_ext_res <-resample(dem_est, tmp_anual)
res(dem_ext_res)
res(tmp_anual)

res(dem_ext_res) == res(tmp_anual)
#correctamente resampleado 

#Cambiar nombre de capa de elevacion
names(dem_ext_res) #[1] "wc2.1_5m_elev"
names(dem_ext_res) <- "Elevación"
names(dem_ext_res) #[1] "Elevación"

# 9 Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.
library(terra)
library(geodata)
dem <- elevation_global(res = 5, path = tempdir())
dem_ext <- crop(dem, pol_ext)

plot(dem_ext)
res(dem_ext)
res(tmp_anual)

#para poder unirlas, deben tener la misma resolucion y extension, por lo que hay que resamplear. Resampleo del DEM para que calce con tmp y pp
dem_ext_res <- resample(dem_ext, tmp_anual)
res(dem_ext_res)
res(tmp_anual)

ext(dem_ext_res)
ext(tmp_anual)

#ahora que todos los predictores estan en la misma resolucion y extension se puede unir en un raster multicapa llamada predictores 
predictores <- c(tmp_anual, pre_anual, dem_ext_res)
#predictores = tm_pp_dem <- c(tmp_anual, pre_anual, dem_ext_res)

plot(predictores)
nlyr(predictores)

#Extrear los datos del nuevo raster 
names(predictores)[7] <-  'elevacion' #se observa la union de todas las capas

data_unida_proj <- st_transform(data_unida, st_crs(predictores))
df <- extract(predictores, data_unida_proj)
dim(df)

#visualizacion con tmap y dimensiones
dim(df)
view(df)

#Añadir al data frame un columna de presencia 
library(terra)
df_presencia <- cbind(data_unida[, "presencia"], df)
view(df_presencia)

df_presencia_final <- cbind(df, data_unida[, "presencia"] )
class(df_presencia_final)

writeRaster(predictores, 'predictores.tif')
#en este formato se pierde un poco de informacion , por lo tanto se guardara en RDS

#Guardar los archivos en formato RDS2
saveRDS(predictores, 'datos_predictores.rds')
saveRDS(df_presencia_final,"datos_predictores.rds")

#raster multi capa con 25 multicapas. procedo a extraer los valores de temperatura mensual , pp mensual y elevacion en los puntos de presencia y pseudo ausencia de frickius 
df <- extract(predictores, data_unida)
#se observa que data_unida y predictores tienen distintos src. Hay que tranformar
st_crs(predictores)

#Transformar el sistema de referencia de predictores 
crs(predictores, describe = TRUE)   #4326
crs(data_unida, describe=TRUE)      #32719
#los puntos o tambien llamdo data_unida tienen distintos SRC, hay que cambiarlos, necesitamos el 4326

data_unida_t <- st_transform(data_unida, st_crs(predictores))
st_crs(data_unida_t)
library(terra)
df <- extract(predictores, data_unida_t)

#Para comrprobar si esta bien hecha la tranformacion volvemos a ver el codigo 
df_presencia_final <- cbind(df4, data_unida_t[, "presencia"])

library(terra)

saveRDS(df_presencia_final, 'datos_predictores.rds')
datos <- readRDS('datos_predictores.rds')

# 10 Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.
library('spData')
library(spData)
nz # pertenece al paquete spData, Nueva Zelanda ....

#mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. temperatura escala de color inferno
#mapa de predictores 
tmap_mode('plot')

#Recuerda transfromar la temperatura a celcius 
tmp_anual_cel <- tmp_anual - 273.15 
library(tmap)
mapa1_tmp <- tm_shape(tmp_anual_cel) +
  tm_raster(style = 'cont', 
            palette = viridis::viridis(20), 
            title = 'Temperatura (°C)') +
  tm_shape(data_unida_t)+
  tm_dots(col= 'Presencia',
          style= 'cat' , 
          title = 'Presencia') +
  tm_grid(projection = 32719) +
  tm_compass(type = "arrow", position = c("left", "top")) +
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

tmap_save(mapa1_tmp, 'mapa_estatico_pf_temperatura.png')


#mapa 2 de precipitacion
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
###############Revisar data_unida _projj
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

# 11 Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.
plot(tmp_anual)
plot(pre_anual)

#Calculo de precicpitacion acumulada anual con respecto a los 12 raster promedio entre el 2017 a 2022
pre_anual_acu <- sum(pp_anual*1000)
plot(pre_anual_acu)

#Ahora calculo de temperatura acumulada restandole para que sea en grados celcius °c
tmp_anual_acu <- sum(tmp_anual-273.15)  
plot(tmp_anual_acu)






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
