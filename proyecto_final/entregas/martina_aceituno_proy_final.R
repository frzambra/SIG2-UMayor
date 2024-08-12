#Proyecto final
#Integrantes Martina Aceituno y María Esperanza Baeza

install.packages('sf')
library(sf)

data<-read.csv2('planilla_presencia_frickius_variolous.csv',
                dec='.',sep=';')
data<-read.csv('planilla_presencia_frickius_variolous.csv',
               sep=';')
str(data)


# Guardar los datos en un archivo CSV editando la planilla excel y guardandola como archivo csv

str(data)

#crear objeto sf con las coordenadas de presencia

data_sf<-st_as_sf(data,coords=c('longitude','latitude'),crs=4326)
?st_as_s2.sf

#definir extensión

xmin<- -74.00
xmax<- -70.75
ymin<- -48.00
ymax<- -37.89669


ext<-st_bbox(c(xmin=xmin,xmax=xmax,ymin=ymin,ymax=ymax))

pol_ext<-st_as_sf(st_as_sfc(ext),crs=4326)

plot(pol_ext)
plot(data_sf$geometry,add=TRUE)

#visualización con Tmap
install.packages('tmap')
library(tmap)
tmap_mode('view')

#crear puntos de pseudo ausencia

set.seed(123)
data_pseudo<-st_sample(pol_ext,100)

data_sf_utm<-st_transform(data_sf,32719)
buff<-st_buffer(data_sf_utm,2500)

st_crs(buff)
st_crs(data_pseudo)

data_pseudo_proj<- st_transform(data_pseudo,st_crs(buff))

#buscar que puntos de pseudo-ausencia se intersectan con los buffer
ptos_inter<- st_intersection(data_pseudo_proj,buff)

ptos_selec<-st_difference(data_pseudo_proj,ptos_inter)

plot(ptos_selec)
#unir los datos de presencia con los de pseudo-ausencia
#columna que identifique si es de presencia o no
data_sf_utm$presencia<-1

#puntos de presencia con la columna de presencia a datos de pseudo ausencia
data_sf_utm<-data_sf_utm[,6:5]

data_ausen<-st_as_sf(ptos_selec)
data_ausen$presencia<-0

#unir los datos de presencia con pseudo ausencia
st_geometry(data_ausen)<-'geometry'
data_union<-rbind(data_ausen[,2:1],data_sf_utm)


#visualización con tmap
tm_shape(pol_ext)+
  tm_borders()+
  tm_shape(data_union)+
  tm_dots(col='presencia',style='cat')

#debe cortar los datos climaticos raster de la temperatura media y precipitaciones
files_pre<-list.files('era5-monthly_total_precipitation', full.names=TRUE)
files_temp<-list.files('era5-monthly_2m_mean_temperature', full.names=TRUE)

library(terra)
print(files_temp)

temp<-rast(files_temp)
pre<-rast(files_pre)

#cortar de acuerdo a la extension
temp_c<-crop(temp,pol_ext)
pre_c<-crop(pre,pol_ext)


#con los datos raster climatologicos cortados para el area de estudio, debe creer promedios de precipitaciones acumuladas
#mensual y temperatura media mensual, entre los años 2017 al 20..

#se extraen los meses de ambas carpetas
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


#indexar un name a cada temperatura mensual
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

#indexar un name a cada precipitación mensual
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


#se selecciona la capa de temperatura mensual
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

#se selecciona la capa de precipitación mensual
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

#calcular el promedio de temperatura cada mes
temp_ene_mean<-mean(temp_ene)
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

#calcular el promedio de precipitacion cada mes
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

temp_12<-c(temp_ene_mean,temp_feb_mean,temp_mar_mean,temp_abr_mean,temp_may_mean,temp_jun_mean,
           temp_jul_mean,temp_ago_mean,temp_sep_mean,temp_oct_mean,temp_nov_mean,temp_dic_mean)
plot(temp_12)

names(temp_12)<-c('temp_enero','temp_febrero','temp_marzo','temp_abril','temp_mayo','temp_junio','temp_julio',
                  'temp_agosoto','temp_septiembre','temp_octubre','temp_noviembre','temp_diciembre')
plot(temp_12)

pre_12<-c(pre_ene_mean,pre_feb_mean,pre_mar_mean,pre_abr_mean,pre_may_mean,pre_jun_mean,
          pre_jul_mean,pre_ago_mean,pre_sep_mean,pre_oct_mean,pre_nov_mean,pre_dic_mean)
plot(pre_12)

names(pre_12)<-c('pre_enero','pre_febrero','pre_marzo','pre_abril','pre_mayo','pre_junio','pre_julio',
                 'pre_agosto','pre_septiembre','pre_octubre','pre_noviembre','pre_diciembre')
plot(pre_12)

#descargue la elevación global utilizando la función elevation_global de (geodata). Corte el raster de
#elevacion para el área de estudio.haga un resampleo(funcion)...
install.packages("geodata")
library (geodata)


dem<-elevation_global(res=5,path=tempdir())

dem_ext<-crop(dem,pol_ext)
plot(dem_ext)
res(dem_ext)
res(temp_12)

#resamplear el dem
dem_ext_res<-resample(dem_ext,temp_12)
res(dem_ext_res)
res(temp_12)

#raster multicapa
predictores <-c(pre_12,temp_12,dem_ext_res)
plot(predictores)

names(predictores)[7]<-'elevacion'

writeRaster(predictores,'predictores.tif',overwrite=TRUE)

#una vez que tengo el rater multicapa con los 25 predictores se extraen los valores de temp,prep y elevacion en los puntos de presencia y pseudoausencia de frickius

df<-extract(predictores,data_union)
crs(predictores,describe=TRUE)
st_crs(predictores,data_union)

library(sp)
library(raster)
library(terra) 

crs_predictores <- crs(predictores)
crs_predictores <- st_crs(predictores)

data_union_t <- st_transform(data_union, crs=crs_predictores)
predictores_rast <- raster(predictores)


df<-extract(predictores,data_union_t)

#unir los datos extraidos con la columna presencia
df_final<-cbind(df,data_union[,'presencia'])

saveRDS(df_final,'crs_predictores.rds')

#datos<-readRDS('crs_predictores.rds')

#creacion de mapas estaticos y dinamicos con tmap
#calcular un raster de precipitacion acumulada anual
#dejar en milimetros
pre_acum_anual<-sum(pre_12*1000)
plot(pre_acum_anual)

#dejar en kelvin
temp_prom_anual<-mean(temp_12-273.15)
plot(temp_prom_anual)

plot(data_union[,'presencia'])
plot(pol_ext)

#creacion de mapas estaticos y dinamicos con tmap

install.packages('tmap')
library(tmap)
install.packages('spData')
library(spData)

plot(nz$geom)

#con tmap
tm_shape(nz)+
  tm_fill()+
  tm_borders()

map_nz<-tm_shape(nz)+
  tm_polygons()

map_nz

install.packages("spDataLarge", repos= "https://geocompr.r-universe.dev")
library(spDataLarge)
nz_elev<-rast(system.file("raster/nz_elev.tif", package= "spDataLarge"))

map_nz1<-map_nz+
  tm_shape(nz_elev)+
  tm_raster(alpha=0.7)

nz_water<-st_union(nz)
nz_water<-st_buffer(nz_water,22200)
nz_water<-st_cast(nz_water,to='LINESTRING')

map_nz2<-map_nz1+
  tm_shape(nz_water)+
  tm_lines()

map_nz3<-map_nz2+
  tm_shape(nz_height)+tm_dots()

mapa_final<-tmap_arrange(map_nz1,map_nz2,map_nz3)

tm_shape(data_union_t)+
  tm_dots()+
  tm_shape(temp_prom_anual)+
  tm_raster()+
  tm_shape(data_union_t)+
  tm_dots

tm_shape(nz)+
  tm_polygons(col='Name',alpha=.3,lwd=5,lty='dashed')
#con los datos de presencia y pseudo ausencia

tm_shape(data_union_t)+
  tm_dots(col='presencia',size=.2)
names(nz)

tm_shape(nz)+
  tm_fill(col="Land_area")

tm_shape(nz)+
  tm_fill(col="Land_area",tittle='Superficie[Km2]',
          style='jenks',
          palette='YLGn')+
  tm_borders()

install.packages('tmaptools')
install.packages('shiny')
install.packages('shinyjs')

tmaptools::palette_explorer()

#diseño del mapa
tmap_mode('view')

mapa<-map_nz+
  tm_compass(type='arrow', position = c('left','top'))+
  tm_graticules()+
  tm_basemap(server="OpenTopoMap")+
  tm_layout(title="Mapa de prueba",
          frame=FALSE,
          bg.color='grey',
          frame.double.line=TRUE)

tmap_save(mapa,'mapa.png')

#usemos tmap para crear mapas para los predictores

tmap_mode('plot')

temp_12_cel<-temp_12-273.15

temp_12_cel <- temp_12 - 273.15


mapa1_temp<-tm_shape(temp_12_cel)+
  tm_raster(style='cont',
            palette = viridis::viridis(20),
            title='temperatura(ºC)')+
  tm_shape(data_union_t)+
  tm_dots(col='presencia',style='cat',
          title='Presencia')+
  tm_graticules()+
  tm_layout(panel.labels=c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'))

tmap_save(mapa1_temp,'mapa1.png')

pre_12_cel<-pre_12_cel*1000

mapa2_pre<-tm_shape(pre_12_cel)+
  tm_raster(style='cont',
            palette = viridis::viridis(20),
            tittle='temperatura(ºC)')+
  tm_shape(data_union_t)+
  tm_dots(col='presencia',style='cat',
          tittle='Presencia')+
  tm_graticules()+
  tm_layout(panel.labels=c('Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'))

tmap_save(mapa1_temp,'mapa1.png')

#mapa interactivo se guarda como .html 

# Definir la interfaz de usuario (UI)
ui <- fluidPage(
  titlePanel("presencia"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider", "Selecciona un número:", min = 1, max = 100, value = 50)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Definir el servidor
server <- function(input, output) {
  output$plot <- renderPlot({
    hist(rnorm(input$slider))
  })
}

# Crea la aplicación Shiny
shinyApp(ui = ui, server = server)

# Guarda la aplicación Shiny como un archivo HTML
saveShinyApp("mapa1.html", appDir = getwd())

