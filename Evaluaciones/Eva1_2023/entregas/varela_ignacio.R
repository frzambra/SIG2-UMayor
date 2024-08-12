#(5pts) Cree los siguientes objetos de tipo vector
exVec1 <- c(-3, 45, 41, 31, -40)
exVec1
exVec2 <- c(44, NA, -30, 39, 22)
exVec2
exVec3 <- c(-5.0, -4.5, -4.0, -3.5, -3.0)
exVec3

#2 (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado <- c(exVec1, exVec2)
exVec_resultado


#3(5pts) Usando indexación con paréntesis cuadrado:
tercer <- exVec1[3]
tercer

todos <- exVec1[2,1]
todos


#4 (15pts) Use funciones u operadores de relación para:

length(exVec1)
length(exVec2)
length(exVec3)

mean(exVec2)

sum(exVec2, na.rm = TRUE)

forma1 <- sum(exVec2, na.rm = TRUE)
forma1

mean(forma1)

forma2 <- le


#punto 5
#nos entrega una distribucion aleatoria, una con 6 valores y la otra con 2 valores

#punto6
#los ventores pueden ser logicos, reciclable
# logico, caracter y numerico

#punto7
LOGIC<- a == 2
which(a==2)

b <- c(1:6)
matrix(nrow = b, ncol = 3)


vector <- c(3, 6, 9)
vector


#punto7
mi_matriz <- matrix(1:9, nrow = 3, ncol=3)
mi_matriz

vectorlogico <- a == c(1:3)
a

c<- data.frame(mtcars)

lista2 <- list("A", "B", "C")
lista2
mi_lista_principal <- list(vectorlogicoo = vectorlogico, matriz = mi_matriz, datamtcars = c)


mi_lista_principal


#punto8
a <- data.frame(airquality)
names(a)
#forma1
columnauno <- a[, 1]
columnauno
#forma2


#punto9
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE] # en este caso lamatriz se rellena verticalmente, a comparacion de un drop= TRUE, en donde se rellena horizontalmente.


#punto10

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m1
primeracoluma <- m1[,1]  #primera columna

m2 <- matrix(1:sample(seq(9,18,3),1),3)
m2
primeracolumaa <- m2[,1] # primera columna


union_interna <- merge(primeracoluma, primeracolumaa)
union_interna

#punto11
airquality2 <- airquality[, c("Wind", "Month", "Solar.R")]

# Verificar la estructura de airquality2
str(airquality2)


#  Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Wind, Month y Solar.R. Hágalo de dos maneras diferentes.
data(airquality)
airquality2 <- data.frame(
  Wind = airquality$Wind,
  Month = airquality$Month,
  Solar.R = airquality$Solar.R
)

# Agregar una nueva columna "nueva_col" con valores de 1 hasta el número de filas
airquality2$nueva_col <- 1:nrow(airquality2)
airquality2$nueva_co

data(airquality)

#Cree un nuevo data.frame airquality3 en el que estén solo las filas 56, 29, 31, 27, 147. Hágalo de dos maneras diferentes.
filas_seleccionadas <- c(56, 29, 31, 27, 147)
airquality3 <- subset(airquality, rownames(airquality) %in% filas_seleccionadas)

str(airquality3)




airquality2 <- data.frame(
  Wind = airquality2$Wind,
  Month = airquality2$Ozone,
  SolarR= airquality2$Solar.R
)
airquality2  #153

airquality4 <- airquality[airquality$Solar.R > 200, ]

#  airquality4
str(airquality4)

#punto12

vectornumero <- c(1,2,3,4,5)
vectorcaracter <- c('juan','pedro','diego','pedro','agus')
vectorlogico <- c(TRUE,TRUE,FALSE,FALSE,FALSE)

data <- data.frame(
  numeros =vectornumero,
  caracteres = vectorcaracter,
  logicos = vectorlogico
)
data

#punto13
a <- data.frame(airquality)
a
summary(a)
dim(a)  #NUMERO DE FILAS Y COLUMNAS
ncol(a)
nrow(a)
names(a) #nombre de las columnas
tail(a) #ultimo 6 datos
head(a) # encabezado
plot(a)
str(a)

#punto 14
#La diferencia radica que en el elemento dataframe no tiene una listacolumna de geometria, osea que solamente cuenta con datos en el eje x e y, en cambio tener una lista columna en donde esta la geometria indica que la observación esta en punto del espacio.

install.packages('sf')
install.packages('tibble')

library(sf)

data <- read_sf('data/datos_ema_203.csv')
data <- read.csv2('data/datos_ema_203.csv') # 
data <- st_read('data/datos_ema_203.csv')  #nos entrega los valores geometricos
summary(data) #resumen

objetoa <- data$humed_rel_promedio
objetoa
summary(objetoa)


hum <- data$humed_rel_promedio
hum

hum <- as.numeric(hum)
media_hum <- mean(hum, na.rm = TRUE)
media_hum




obsm <- datos[data$humed_rel_promedio > media_hum, ]
obsm  #observaciones mayores al promedio

#Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

data$fecha_hora
data$humed_rel_promedio
data$veloc_max_viento

write.csv(result, file = "datos_ema_203.csv", fileEncoding = "latin1")


#14.2

geo <- read_sf('data/region_Los Lagos.gpkg')
geo
#su clase
class(geo)

#cant de geometria
cantidad_geometrias <- length(geo)
cantidad_geometrias 

summary(geo)
#variables y dimensiones
dimensiones <- dim(geo)
num_observaciones <- dimensiones[1]
num_variables <- dimensiones[2]
num_observaciones
num_variable

#Haga un mapa en donde se muestre la variación de la variable comuna



