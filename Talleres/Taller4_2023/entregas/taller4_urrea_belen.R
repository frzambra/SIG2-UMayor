############################ Taller 4 #############################################
#Instalar paquete sf 
install.packages('sf')
library(sf)
NC <- st_read(system.file("shape/nc.shp",package="sf")) 

# 1  Cree un objeto sfg de tipo punto de dos, tres y cuatro dimensiones. Utilicé las coordenadas de latitud -36.25 y longitud -72.65 una elevación de 200 metros y una direccción de 90°. Revise la estructura del objeto creado utilizando la función str (latitud coordenada y , longitud coordenada x)

OBJG1 <- st_point(c(-72.65, -36.25 ))
OBJG2 <- st_point(c(-72.65, -36.25, 200), "XYM")
OBJG3 <- st_point(c(-72.65, -36.25,200, 90), "XYZM")


# 2 Utilice las siguientes coordenadas para crear los siguientes tipos de objetos sfg: MULTIPOINT      LINESTRING

df <- data.frame( latitud = c(-33.38991,-33.38959,-33.38929,-33.38893),
                  longitud = c(-70.63500,-70.63468,-70.63435,-70.63396))

#MULTIPOINT
Punto <- st_multipoint(c(df, "XY")
                       
  #LINESTRING
                       Convert <- data.matrix(df, rownames.force = NA)
                       df
                       
                       Linea <- st_linestring(df)
                       plots(Linea)
                       
                       # 3  Utilice las siguientes coordenadas para crear un objeto sfg de tipo MULTILINESTRING que contenga dos lineas. Verifique que la clase y geometría del objeto es la correspondiente y haga un plot de cada objeto.
                       
                       df <- data.frame(
                         linea = c(rep('linea_1',4),rep('linea_2',4)),
                         latitud = c(-33.38991,-33.38959,-33.38929,-33.38893,
                                     -33.38943,-33.38911,-33.38883,-33.38846),
                         longitud = c(-70.63500,-70.63468,-70.63435,-70.63396,
                                      -70.63566,-70.63531,-70.63500,-70.63461))
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
                       
  ################################################# TRABAJO CON CAPAS ############################
                       
# 10 Cargue las capas vectoriales que debe descargar de la sección datos. Para cada una de las capas, indique
             #tipo de geometría
             #cantidad de variables y observaciones
        #sistema de referencia de coordenadas y código EPSG
    #Habia un error para leer el archivo, por lo que se instalo el paquete tibble
            install.packages('tibble')
      capa1 <- read_sf('Aire_-_Shapefile/bdide_OWD_Aire_planes_prevencion_descontaminacion.shp')
                       
                       
                       #LEER LOS archivos que estan dentro de esta carpeta y asignarle el shapefile 
                       files <- list.files('Aire_-_Shapefile', pattern = 'shp$', full.names = TRUE)
                       
                       
                       capa1 <- read_sf(files[1])
                       capa2 <- read_sf(files[2])
                       
                       #Tipo de geometria 
                       class(capa2$geometry)
                       class(capa1$geometry)
                       #Otra forma de consultar por la geometria 
                       lapply(l_sf\(x) class(st_geomtery(x))) 
                       
                       #Variables y observaciones 
                       print(capa1)
                       print(capa2)
                       
                       #SRC de las capas (al indexarlo, te guarda el codigo epsg por separado)
                       st_crs(capa1)$epsg
                       st_crs(capa2)$epsg
                       
                       # 11 Transforme el sistema de referencia de coordenadas (SRC) de cada una de las capas al que corresponde al código EPSG:4326.
                       
                       st_crs(capa1)$epsg
                       st_crs(capa2)$epsg
                       
                       Capa1_4326 <- st_transform(capa1,4326)
                       Capa2_4326 <- st_transform(capa2,4326)
                       
# 12 Para la capa biodi_snaspe_2021 seleccione las áreas protegidas ubicadas en la región Metropolitan. Muestre el data.frame para las geometrias seleccionadas, para ellas seleccione las columnas de categoria y nom_unidad. Guarde el resultado en un archivo .csv llamado areas_protegidad_RM.csv. Guárdelo con configuración latina.
                       
    capa1 <- read_sf('Aire_-_Shapefile/bdide_OWD_Aire_planes_prevencion_descontaminacion.shp')
  #LEER LOS archivos que estan dentro de esta carpeta y asignarle el shapefile 
  files <- list.files('Aire_-_Shapefile', pattern = 'shp$', full.names = TRUE)
   capa1 <- read_sf(files[1])
  capa2 <- read_sf(files[2])
                       
      CBio <- st_read('Biodiversidad_-_Shapefile/biodi_snaspe_2021.shp')
  CBio <- read_sf('Biodiversidad_-_Shapefile/biodi_snaspe_2021.shp')
   files2 <- list.files('Biodiversidad_-_Shapefile', pattern = 'shp$', full.names = TRUE)
            files2
    
                       
                   
    CBio <- read_sf(files2[5])
                       
                       # 13 Guarde la capa resultante anterior en el disco en formato geopackage con el nombre areas_protegidad_RM.gpkg.
                       funcion rait_sf 