#Instalar paquete

install.packages("terra")


#Cargar paquete

library(terra)




# 1. CREAR OBJETO r DE TIPO SPATRASTER CON LAT Y LONG DADA.


#Coordenadas

lat <- c(-33.5, -32.5)

long <- c(-70.6667, -69.6667)

#SpatRaster

r <- terra::rast(ext = c(long[1], long[2], lat[1], lat[2]), resolution = c(0.01, 0.01), crs = "epsg:4326")

r




# 2. CREAR OBJETO r DE TIPO SPATRASTER CON LAT Y LONG DADA, MAS NUMERO DE FILAS Y COLUMNAS ESPECIFICAS Y VALORES EN LAS CELDAS DE NUMEROS DEL 1 AL 50.


#Coordenadas

lat <- c(-33.5, -32.5)

long <- c(-70.6667, -69.6667)


#SpatRaster

r <- terra::rast(ext = c(long[1], long[2], lat[1], lat[2]),
                 
                 resolution = c((long[2] - long[1]) / 5, (lat[2] - lat[1]) / 10),
                 
                 nrows = 10, ncols = 5,
                 
                 crs = "epsg:4326")

r

#valores del 1 al 50 

values(r) <- 1:50

r




# 3.


#Extension y resolucion

ext <- c(350000, 450000, 6400000, 6500000)

res <- c((ext[2] - ext[1])/10, (ext[4] - ext[3])/10)


#SpatRaster

r <- terra::rast(ext = ext, resolution = res, nrows = 10, ncols = 10, crs = "epsg:32719")

r

#Valores del 100 al 1

values(r) <- 100:1


plot(r, main="Raster")

#Valores en las celdas

text(r, values(r), cex = 0.8, col = "blue", pos = 4)





# 4. RASTER DE 3 CAPAS CON 3 FILAS Y 3 COLUMNAS.


r2<- rast(nrow =3,ncol=3,nlyr =3) 

values(r2)<- 1:27 

plot(r2)

# Asigna valores a cada capa

values(r2) <- matrix(1:27, nrow = 3, ncol = 3, byrow = T)

plot(r2)

text(r2, values(r2), cex = 0.8, col = "blue", pos = 4)



# 5. SUMA DE LAS TRES CAPAS

r1 <- rast(nrow =3, ncol = 3, nlyr = 3)

values(r1) <- 1:27

r1

plot(r1)


r2<- rast(nrow =3,ncol=3,nlyr =3) 

values(r2)<- 1:27 

r2

plot(r2)


r3 <- rast(nrow =3, ncol = 3, nlyr = 3)

values(r3) <- 1:27

r3

plot(r3)


c <- sum(r1,r2,r3)

c

plot(c)



getwd()

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas_rasters")


sta_olga <- rast("Santa_Olga.tif")

sta_olga


sta_olga_4326 <- project(sta_olga, "EPSG:4326")

sta_olga_4326


plot(sta_olga)


plotRGB(sta_olga)


getwd()

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas_rasters/dem_islas")


jfer <- rast("DEM J Fernandez 2m.tif")

jfer


jfer <- project(jfer, "EPSG:4326")

jfer


plot(jfer)


plotRGB(jfer)


getwd()

setwd("C:/Users/tomas/OneDrive/Documentos/R/data/capas_rasters/dem_islas")


isla <- rast("DEM Isla de pascua 4m.tif")

isla


isla <- project(isla, "EPSG:4326")

isla


plot(isla)


plotRGB(isla)



NO ALCANCE A TERMINARLO