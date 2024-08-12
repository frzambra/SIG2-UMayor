#Examen
#Diego Montero

#1 Cargue la capa correspondiente a los distritos censales y asignelo al objeto dis_cens 

library(sf)

dis_cens <- read_sf("~/Universidad MAYOR/2023/2do semestre/R sig/Examen2/distritos_censales.gpkg")
dis_cens

dis_selec <- dis_cens <- dis_cens[dis_cens$nom_dis %in% c("Los tricahues", "Ránguil", "Nilahue cornejo","Santa Cruz","Nilahue","Patacón","Hualañé","Caone"),]

Centroide_dis <- st_centroid(dis_cens)
Centroide_dis
plot(Centroide_dis)


buffer_centroide <-st_buffer(Centroide_dis,2000)
plot(buffer_centroide)



buffer_los_tricahues <- st_buffer('los_tricahues')
  
  
  

library(raster)

library(terra)

files <- list.files('~/Universidad MAYOR/2023/2do semestre/R sig/Examen2/',pattern = 'tif$',full.names = TRUE)

files
lai <- rast(files)
plot(lai)



lai_promedio <- mean(lai, na.rm = TRUE)
lai_promedio
plot(lai_promedio)

lai_promedio_geo <- st_transform(lai_promedio, crs = 4326)











