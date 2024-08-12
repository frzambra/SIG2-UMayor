#prueba
#diego Montero

#1
exVec1 <-c(4, -45, -4, -31, -32)
exVec1

exVec2 <-c(21, 4, 17, 43, 12)
exVec2
  
exVec3 <-seq(-5,5,0.5)
exVec3

#2.junte los vectores exvec1 y exvec2
exvec_resultado = exVec1 + exVec2
exvec_resultado

#3. 3er elemento de exvec1
exVec1[3]

#4. 
#4.1


#4.2
sum(exVec1)

#4.3
mean(exVec2)

#4.4
sum(exVec2)
length(exVec2)
na.omit(exVec2)
exVec2 <-na.omit(exVec2)
mean(exVec2)

#5.
  
rnorm(6)
rnorm(2)
rnorm(6) + rnorm(2)
#esta sumando dos distribuciones normales 


#6. complex, logical, numeric, character

#7.
list()

#8.

#9.
m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#en el primero me esta entregando la fila 1, mientras que el codigo 2 arroja la columna 1 
#debido a que deja los otros como falso

#10.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m1
m2 <- matrix(1:sample(seq(9,18,3),1),3)
m2

rbind(m1,m2)

#11.

#12.

#13.

mtcars
structure(mtcars)
nrow(mtcars)
ncol(mtcars)
colnames(mtcars)
head(mtcars)

#14.
#el sf esta formado por un data frame es un archivo vectorial simple feature para los archivos gpkg










#parte 2

data <-read.csv2("datos_ema_126.csv")
data
data.class(data)
data.matrix(data)

#geopkg
install.packages('sf')
library(sf)

geo <- read_sf("region_Coquimbo.gpkg")
geo
#

