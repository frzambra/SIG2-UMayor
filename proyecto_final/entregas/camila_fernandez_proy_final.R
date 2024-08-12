
#proyecto final CAMILA FERNANDEZ- SEBASTIAN ACEVEDO


#Instalar paquetes
install.packages("terra")
install.packages("sf")
install.packages("tmap")
install.packages("geodata")

#Cargar paquetes
library(sf)
library(terra)
library(tmap)
library(geodata)

### 1
#Crear un objeto sf de tipo polígono que defina la extensión del aŕea de estudio. Esta debe ir desde la latitud -38.075 y longitud -74.00 a latitud -48.00 y longitud -70.75.

#xmin es la longitud menor
xmin <- -74.00

#xmax es la longitud mayor
xmax <- -70.75

#ymin es la latitud menor
ymin <- -48.00

#ymax es la latitud mayor
ymax <- -37.89669

#ESTA FORMA ME RESULTO
#Crear bbox
ext <- st_bbox(c(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax))

#Crear objeto sf que contenga el polígono anterior
area_est <- st_as_sf(st_as_sfc(ext,crs=4326))

#Verificar clase de objeto
class(area_est) #objeto de clase sf

#Verificar Sistema de Referencia de Coordenadas (SRC en adelante)
st_crs(area_est)
#Observación: No tiene el SRC correctamente asignado, por lo tanto, asignar:
st_crs(area_est) <- 4326
st_crs(area_est) #SRC correctamente asignado


###2
#A partir de la planilla con las coordenadas de presencia de la especie Frickius Variolosus, debe crear un objeto sf con geometrias de tipo puntos. Haga un gráfico de la ubicación de los puntos en el área de estudio.

#Cargar archivo .csv
planilla <- read.csv("/Users/camilafernandezcarrasco/Desktop/proyectofinal/planilla_presencia_frickius_variolosus.xlsx - Datos_iNaturalist.csv",dec=".")

#Crear objeto sf, de nombre p1, para definir los puntos de presencia
p1 <- st_as_sf(planilla,coords=c("longitude","latitude"),crs=4326)

#Verificar SRC
st_crs(p1) #Correctamente asignado

#Graficar puntos de presencia, de color "verde", dentro del área de estudio
plot(area_est)
plot(p1$geometry,add=TRUE,col="green")

#Graficar con tmap
tmap_mode("view") 

tm_shape(area_est) + tm_borders() + tm_shape(p1) + tm_dots(col="green")

###3
#Debe crear 100 puntos de pseudo-ausencia de la especie, estos deben ser creados de forma aleatoria y deben estar dentro del área de estudio. Utilice la función de {sf} st_sample.

#Crear objeto sf, de nombre p0, para 100 puntos al azar contenidos dentro del área de estudio
set.seed(123)
p0 <- st_as_sf(st_sample(area_est,100))

#Graficar puntos de pseudo-ausencia, de color "rojo", dentro del área de estudio
plot(area_est)
plot(p1$geometry,col="green",add=TRUE)
plot(p0,col="red",add=TRUE)

#Graficar con tmap
tmap_mode("view")
tm_shape(area_est) + tm_borders() + tm_shape(p1) + tm_dots(col="green") + tm_shape(p0) + tm_dots(col="red") 

###4
#Cree áreas de influencia de 2500m en cada uno de los puntos de presencia de Frickius Variolosus. Utilice estas áreas de influencia para eliminar los puntos de pseudo-ausencia que se encuentran a menos de 250m de uno de presencia.

#Verificar el Sistema de Referencia de Coordenadas (SRC)
st_crs(p1) #Es epsg: 4326, por lo tanto hay que reproyectar el objeto a coordenadas utm

#Reproyectar objeto sf para modificar su SRC a uno con coordenadas medidas en metros
p1_32719 <- st_transform(p1,32719)
st_crs(p1_32719) #correctamente reproyectado

#Crear buffer de 250m que represente el área de influencia
buf <- st_buffer(p1_32719, dist=2500)
st_geometry(buf) #Resulta un objeto sf de geometría tipo polígono



#Revisar SRC de p0, objeto sf que contiene los puntos de pseudo-ausencia
st_crs(p0)

#Reproyectar para que su SRC sea igual al del buffer
p0_32719 <- st_transform(p0,32719)

#Confirmar asignación realizada de forma correcta
st_crs(p0_32719)

#Confirmar igualdad de SRC entre los objetos de puntos de pseudo-ausencia y del área de influencia
st_crs(buf) == st_crs(p0_32719)

#Quitar atributos al objeto buf
ncol(buf) #la quinta columna corresponde a la geometría
buf[,c(1:4)] <- NULL
#Verificar que la eliminación fue bien hecha
str(buf)

#Graficar área de influencia, de color "azul", dentro del área de estudio
plot(area_est)
plot(p0,col="red",add=TRUE)
plot(buf$geometry,col="blue",add=TRUE)
plot(buf,col="blue")
#El área de influencia se grafica bien, pero no puedo graficar todos los objetos juntos :( igual no importa porque en tmap sí funciona >:D

#Graficar con tmap
tmap_mode("view")
tm_shape(area_est) + tm_borders() + tm_shape(p1_32719) + tm_dots(col="green") + tm_shape(p0_32719) + tm_dots(col="red") + tm_shape(buf) + tm_polygons(col="blue")

#Definir la intersección entre el área de influencia y los puntos de pseudo-ausencia
#st_intersection(x,y)
eliminar <- st_intersection(buf,p0_32719)
eliminar #Hay un punto de pseudo ausencia dentro del área de influencia

#Definir la diferencia entre x e y
p0_buf <- st_difference(p0_32719,eliminar)

#Verificar clase de objeto y su tipo de geometría
class(p0_buf) #Objeto de clase sf
st_geometry(p0_buf) #De geometría tipo punto


###5
#Una los puntos de pseudo-ausencia seleccionados con los de presencia. Debe quedar con un sólo set de datos de puntos, estos deben tener un atributo denóminado presencia que sea 1 para las observaciones de presencia y 0 en los puntos de pseudo-ausencia.

#Crear columna para objeto presencia que contenga los valores de 1
p1_32719$presencia <- rep(1,nrow(p1_32719))

#Ordenar columna "presencia" como primera columna y eliminar los atributos restantes
p1_32719_ord <- p1_32719[,c(6,5)]

#Crear columna para objeto pseudo_ausencia que contenga valores de 0
p0_buf$presencia <- rep(0,nrow(p0_buf))

#Ordenar columna "presencia" como primera columna
p0_32719_ord <- p0_buf[,2:1]

#Verificar orden
colnames(p0_32719_ord)
colnames(p1_32719_ord)

#Observación: se detectó que el nombre de la lista de geometría para el objeto de puntos de pseudo-ausencia no es igual al del objeto de puntos de presencia. Por lo tanto, a continuación se cambia:
st_geometry(p0_32719_ord) <- "geometry"

#Unir
puntos <- rbind(p1_32719_ord,p0_32719_ord)

#Visualización con tmap
tm_shape(area_est) + tm_borders() + tm_shape(puntos) + tm_dots(col="presencia",style="cat")



###6
#Debe cortar los datos climáticos raster de temperatura media y precipitacion acumulada mensual para el área de estudio.

#Enlistar todos los arvhicos .tif de temperatura media
arch_temp <- list.files("data/era5-monthly_2m_mean_temperature",pattern="tif$",full.names=TRUE)

#Crear objeto spatRaster de temperatura media
tm <- rast(arch_temp)

#Cortar tm según el área de estudio
tm_est <- crop(tm,area_est)

#Enlistar todos los archivos .tif de presipitacion acumulada
arch_prep <- list.files("data/era5-monthly_total_precipitation",pattern="tif$",full.names=TRUE)

#Crear objeto spatRaster de precipitación acumulada
pp <- rast(arch_prep)

#Cortar pp según el área de estudio
pp_est <- crop(pp,area_est)


###7
#Con los datos raster climáticos cortados para el área de estudio, debe crear promedios de precipitación acumulada mensual y temperatura media mensual, entre los años 2017 al 2022. Como resultado debe obtener un raster con 12 capas para precipitación acumulada mensual y otro raster multicapa de 12 capas para temperatura media mensual.

#Crear secuencias que recorren el mes correspondiente de cada año:
ene <- seq(1,72,12)
#secuencia que comienza en 1 y termina en 72 con un intervalo de 12
feb <- seq(2,72,12)
mar <- seq(3,72,12)
abr <- seq(4,72,12)
may <- seq(5,72,12)
jun <- seq(6,72,12)
jul <- seq(7,72,12)
ago <- seq(8,72,12)
sep <- seq(9,72,12)
oct <- seq(10,72,12)
nov <- seq(11,72,12)
dic <- seq(12,72,12)

###Raster de PRECIPITACION ACUMULADA:

#Confirmar que la secuencia está bien
names(pp_est)[ene] #Efectivamente, son todos los archivos que contienen la precipitación acumulada de enero para los 6 años solicitados

#Seleccionar los archivos que corresponden a las precipitaciones acumuladas mensuales, creando objetos spatRaster de 6 capas
pp_ene <- subset(pp_est,ene)
pp_feb <- subset(pp_est,feb)
pp_mar <- subset(pp_est,mar)
pp_abr <- subset(pp_est,abr)
pp_may <- subset(pp_est,may)
pp_jun <- subset(pp_est,jun)
pp_jul <- subset(pp_est,jul)
pp_ago <- subset(pp_est,ago)
pp_sep <- subset(pp_est,sep)
pp_oct <- subset(pp_est,oct)
pp_nov <- subset(pp_est,nov)
pp_dic <- subset(pp_est,dic)

#Calcular el promedio a lo largo de los años de la precipitacion acumulada de cada mes, creando objetos spatRaster de 1 capa
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

#Crear un objeto spatRaster de 12 capas, cada capa corresponde a la precipitacion acumulada mensual
pp_anual_12 <- c(pp_ene_mean,
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


#Asignar nombres a las capas del objeto temp_anual
names(pp_anual_12) <- c("Precipitacion ac. enero",
                        "Precipitacion ac. febrero",
                        "Precipitacion ac. marzo",
                        "Precipitacion ac. abril",
                        "Precipitacion ac. mayo",
                        "Precipitacion ac. junio",
                        "Precipitacion ac. julio",
                        "Precipitacion ac. agosto",
                        "Precipitacion ac. septiembre",
                        "Precipitacion ac. octubre",
                        "Precipitacion ac. noviembre",
                        "Precipitacion ac. diciembre")

#Visualizar
plot(pp_anual_12)


###Raster de TEMPERATURA MEDIA:

#Confirmar que la secuencia está bien
names(tm_est)[ene] #Efectivamente, son todos los archivos que contienen la temperatura media de enero para los 6 años solicitados

#Seleccionar los archivos que corresponden a las temperaturas mensuales, creando objetos spatRaster de 6 capas
tm_ene <- subset(tm_est,ene)
tm_feb <- subset(tm_est,feb)
tm_mar <- subset(tm_est,mar)
tm_abr <- subset(tm_est,abr)
tm_may <- subset(tm_est,may)
tm_jun <- subset(tm_est,jun)
tm_jul <- subset(tm_est,jul)
tm_ago <- subset(tm_est,ago)
tm_sep <- subset(tm_est,sep)
tm_oct <- subset(tm_est,oct)
tm_nov <- subset(tm_est,nov)
tm_dic <- subset(tm_est,dic)

#Calcular temperatura media mensual, creando objetos spatRaster de 1 capa
tm_ene_mean <- mean(tm_ene)
tm_feb_mean <- mean(tm_feb)
tm_mar_mean <- mean(tm_mar)
tm_abr_mean <- mean(tm_abr)
tm_may_mean <- mean(tm_may)
tm_jun_mean <- mean(tm_jun)
tm_jul_mean <- mean(tm_jul)
tm_ago_mean <- mean(tm_ago)
tm_sep_mean <- mean(tm_sep)
tm_oct_mean <- mean(tm_oct)
tm_nov_mean <- mean(tm_nov)
tm_dic_mean <- mean(tm_dic)

#Crear un objeto spatRaster de 12 capas, cada capa corresponde a la temperatura media mensual
tm_anual_12_Kelvin <- c(tm_ene_mean,
                        tm_feb_mean,
                        tm_mar_mean,
                        tm_abr_mean,
                        tm_may_mean,
                        tm_jun_mean,
                        tm_jul_mean,
                        tm_ago_mean,
                        tm_sep_mean,
                        tm_oct_mean,
                        tm_nov_mean,
                        tm_dic_mean)

#Transformar unidad de medida de Kelvin a grados Celsius
tm_anual_12 <- tm_anual_12_Kelvin - 273.15

#Asignar nombres a las capas del objeto temp_anual
names(tm_anual_12) <- c("Temperatura med. enero",
                     "Temperatura med. febrero",
                     "Temperatura med. marzo",
                     "Temperatura med. abril",
                     "Temperatura med. mayo",
                     "Temperatura med. junio",
                     "Temperatura med. julio",
                     "Temperatura med. agosto",
                     "Temperatura med. septiembre",
                     "Temperatura med. octubre",
                     "Temperatura med. noviembre",
                     "Temperatura med. diciembre")

#Visualizar
plot(tm_anual_12)


###8
#Descargue la elevación global utilizando la función elevation_global de {geodata}. Corte el raster de elevación para el área de estudio. Haga un resampleo (funciónresampleen {terra`}) de la elevación a la resolución de los datos climáticos.

library(geodata)

#Crear objeto spatRaster de elevacion global
dem <- elevation_global(res=5,path=tempdir())

#Verificar SRC para dem 
crs(dem,describe=TRUE) #Es el mismo SRC que el del área de estudio

#Cortar objeto dem según el área de estudio
dem_est <- crop(dem,area_est)

#Visualizar
plot(dem_est)
plot(area_est,add=TRUE)
plot(p1$geometry,add=TRUE)

#Preguntar por SRC de objetos de datos climáticos
crs(tm_anual_12,describe=TRUE)
crs(pp_anual_12,describe=TRUE)
#Observación: No tienen SRC correctamente asignado, por lo que se asigna a continuacion:

crs(tm_anual_12) <- "EPSG:4326"
crs(pp_anual_12) <- "EPSG:4326"

#Verificar que la asignación fue realizada de forma correcta
crs(tm_anual_12,describe=TRUE)
crs(pp_anual_12,describe=TRUE)

#Preguntar por resolucion de objetos de datos climáticos y del dem
res(tm_anual_12) #[1] 0.1000116 0.1000026
res(pp_anual_12) #[1] 0.1000116 0.1000026
res(dem_est) #[1] 0.08333333 0.08333333

#Resamplear
dem_rsmpl <- resample(dem_est,tm_anual_12)

#Verificar:
res(dem_rsmpl) == res(tm_anual_12) #correctamente resampleado

#Cambiar nombre de capa de elevacion
names(dem_rsmpl) #[1] "wc2.1_5m_elev"
names(dem_rsmpl) <- "Elevación"
names(dem_rsmpl) #[1] "Elevación"

###9
#Una los raster en un raster multicapa, con 25 capas, 12 de precipitación, 12 para temperatura y una para elevación. Luego, extraiga los datos del raster en los pixeles de ubicación de los puntos de ausencia y pseudo-ausencia. Utilice la funcion extract de {terra}. Con el resultado obtenido cree un data.frame que tenga los valores extraidos más la columna de presencia de los datos de presencia y pseudo-ausencia. Guarde el data.frame en formato RDS2 con la función writeRDS y con el nombre datos_predictores.rds.

#Crear un objeto spatRaster de 25 capas
tm_pp_dem <- c(tm_anual_12,pp_anual_12,dem_rsmpl)
nlyr(tm_pp_dem)



#informacion del pixel en el que cae cada punto
df <- extract(tm_pp_dem,puntos)
#NOTA: Arroja un warning de transformacion de SRC, prefiriendo reproyectar el SRC del vectorial al SRC del raster

#Visualizar
View(df) #data.frame 

#Incluir columna de presencia para indicar cuales puntos son de presencia y cuales son de pseudo-ausencia
df_final <- cbind(puntos[,"presencia"],df)

#Visualizar
View(df_final)

#Guardar archivo en formado RDS2
writeRDS(df_final,"datos_predictores.rds")


###10
#Debe crear mapas estáticos con grilla, leyenda, flecha norte y en coordenadas UTM de acuerdo al huso que corresponda. Debe crear un mapa para cada variable predictora (precipitación, temperatura, elevación). En el caso de precipitación y temperatura deben ser mapas con 12 paneles, para cada mes del año. Cada mapa debe mostrar los puntos de presencia y pseudo-ausencia en el que se pueda identificar cuál es cuál. Los mapas los debe crear utilizando {tmap}.Utilice las escalas de color viridis para precipitación e inferno para temperatura; ambos del paquete {viridis}. Para elevación utilice los colores que permite obtener la función terrain.colors de R-base. Exporte cada mapa a una imagen en formato PNG como mapa_estatico_pf_precipitacion.png, mapa_estatico_pf_temperatura.png y mapa_estatico_pf_elevación.png.

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


###11
#Cree un raster en el que se calcule el promedio anual con los datos de temperatura promedio mensual (2017-2022). Cree un raster en el que se calcule la precipitación acumulada anual, con los datos de precipitación promedio mensual 2017-2022.

#Raster creados
plot(tm_anual_12) #Objeto spatRaster de 12 capas
plot(pp_anual_12) #Objeto spatRaster de 12 capas

#Calcular la precipitación acumulada anual (2017-2022), creando un objeto spatRaster de 1 sola capa
pp_anual_1 <- sum(pp_anual_12)

#Calcular la temperatura media anual (2017-2022), creando un objeto spatRaster de 1 sola capa
tm_anual_1 <- mean(tm_anual_12)

#Visualizar ambos objetos:
plot(pp_anual_1) 

plot(tm_anual_1)




###12
#Debe crear un mapa interactivo en el que se muestre el raster de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia. Debe utilizar las mismas escalas de color que en el mapa estático. El mapa lo debe exportar a un archivo mapa_interactivo_pf.html



chl_vec <- geodata::gadm("Chile",level=2,path=tempdir())

class(chl_vec) #SpatVector
chl <- st_as_sf(chl_vec)
atacama <- chl[10,]

plot(tm)
plot(tm[[1]])

tm_atacama <- crop(tm,atacama)
plot(tm_atacama[[1]])

tm_atacama_mask <- mask(tm,atacama)
plot(tm_atacama_mask[[1]])

tm_atacama_trim <- trim(tm_atacama_mask)
plot(tm_atacama_trim[[1]])
plot(atacama$geometry,add=TRUE)


#Aggregate
r <- rast(ncol=4,nrow=4)
values(r) <- 1:ncell(r)

plot(r)
text(r)

r_ar <- aggregate(r,2)
plot(r_ar);text(r_ar)

#?aggregate, por defecto la función es "mean",que calcula el promedio de los valores que son parte del nuevo pixel

plot(r);text(r) #1,2,5,6
plot(r_ar);text(r_ar) #4 es el promedio de c(1,2,5,6)


r_max <- aggregate(r,2,fun="max")
plot(r_max);text(r_max)


#Disaggregate
#Para aumentar la resolución, es dcir aumenta la cantidad de pixeles
rd <- disagg(r_ar,2)
plot(rd):text(rd)



#Los valores que tienen números los mantiene y los que tienen NA los elimina
#Se puede crear una mascara utilizando un RASTER 


temp1 <- tm_atacama[[1]]
atacama

plot(temp1)
plot(atacama$geometry,add=TRUE)

#para la siguiente funcion necesitamos una coordenada de longitud y latitud, por eso vamos a utilizar un centroide 

cent <- st_centroid(atacama)
coord <- st_coordinates(cent)
coord
geodata::elevation_3s(lon=coord[1,1],lat=coord[1,2],path=tempdir())
#Los dos puntos es para indicar que la funcion que se esta utilizando (elevation_3s) es del paquete geodata. Ya que a veces pueden haber dos funciones de distintos paquetes y que se llamen igual.

dem_atacama <- crop(dem,atacama)
res(dem_atacama)
res(temp1)

plot(dem_atacama)

resample() #Funcion de remuestreo para dejar la misma resolución, aumenta la resolucion de manera distinta de dissagregate. Dissagregate solo copia el valor, pero resample hace una interpolación, asi que se aumenta la resolución de una manera más suave.

install.packages("spData")
library(spData)
plot(nz$geom)
tmap_mode("plot")
tmap_mode("view")
class(pre_anual_12)
dem_ext

#mapa pre acu anual

mapa1<-tm_shape(pp_anual_12)+
  tm_raster(style = "cont", 
            palette = viridis::viridis(24),
            title="Precipitación(mm)",
            alpha = 0.7) 

mapa2<-tm_shape(tm_anual_12)+ 
  tm_raster(style = "cont", 
            palette = viridis::inferno(30),
            title="Temperatura(°C)",
            alpha = 0.7)


mapa_interactivo<-mapa1 + mapa2 + mapa_elevacion+
  tm_layout(panel.labels = "Mapa interactivo de precipitación acumulada anual, temperatura promedio, elevación y la ubicación de los puntos de presencia y pseudo-ausencia")

tmap_save(mapa_interactivo,"mapa_interactivo_pf.html")




