
library(geodata)
library(agrometR)
library(tidyverse)

library(sf) # para trabajar con datos vectoriales
library(terra) # para trabajar con datos raster
library(tmap) #para realizar mapas temáticos

#cargar datos

estaciones_agromet |> 
  distinct(region)

estaciones_agromet |> 
  filter(region == 'Metropolitana')

# cargar datos de estaciones climáticas

ids <- estaciones_agromet |> 
  distinct(ema) |> 
  pull(ema)

# ejemplo para una estacion

data <- get_agro_data(stations_id = '41',
                      date_start = "2024-07-01",
                      date_end = "2024-08-12")

data |> 
  ggplot(aes(fecha_hora,temp_promedio_aire)) + 
  geom_point() +
  geom_line() +
  ggtitle('Estación Til-Til',
          subtitle = 'Temperatura promedio del aire')

# Pero si lo queremos hacer para N estaciones

lapply(ids[1:10],\(id){
  data <- get_agro_data(stations_id = id,date_start = "2024-08-01",date_end = "2024-08-12")
  nombre_estacion <- estaciones_agromet |> 
    filter(ema == id) |> 
    pull(nombre_ema)
  
  data |> 
    ggplot(aes(fecha_hora,radiacion_solar_max)) + 
    geom_point() +
    geom_line() +
    ggtitle(paste0('Estación ', nombre_estacion),
            subtitle = 'Temperatura promedio del aire')
})

# Trabajar con datos vectoriales
estaciones <- estaciones_agromet

plot(estaciones$longitud,estaciones$latitud)

est_sf <- estaciones |> 
  st_as_sf(coords = c('longitud','latitud'),crs = 4326)

plot(est_sf$geometry)

# Ahora con datos raster

# Descargar datos climatológicos para Chile, Tmin y Tmax
tmin <- geodata::worldclim_country('chile','tmin',path = tempdir())
tmax <- geodata::worldclim_country('chile','tmax',path = tempdir())

# Descargar unidades administrativas
chl <- geodata::gadm('chl',path = tempdir()) |> 
  st_as_sf()

plot(chl |> st_geometry())
chl |> distinct(NAME_1)

# Seleccionar región Metropolitana
chl[2,] |> st_geometry() |> plot()

ara <- chl[2,]

### 

tmin_ara <- crop(tmin,ara)
tmin_ara <- mask(tmin_ara,ara)

names(tmin_ara) <- month.name
tmean <- mean(tmin_ara)

metro <- st_transform(metro,st_crs(est_sf))

est_ara <- st_intersection(est_sf,metro)

plot(tmax_metro)
  
library(tmap)

tmap_mode('plot')

map <- tm_shape(tmean) +
  tm_raster(style = 'cont')  +
  tm_shape(ara) +
  tm_borders(lwd =2) +
  tm_shape(est_sf) + 
  tm_dots() +
  tm_compass() +
  tm_graticules() +
  tm_layout(legend.outside = TRUE)

tmap_save(map,'mapaejeomlo.png')  
