# 1. (5pts) Cree los siguientes objetos de tipo vector
exVec1 <- c( -10, -17,17, -28, 21)
exVec2 <- c(13, -26, -48, 16, 34)
exVec3 <- seq(-5,5,0.5)
# 2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado <-c(exVec1,exVec2)
exVec_resultado
# 3. (5pts) Usando indexación con paréntesis cuadrado:
# devuelva el 3er elemento del vector exVec1
# devuelva todo menos el 2do y 3er elemento en exVec2
exVec1[3]
exVec1[c(1,4,5)]
# 4. (15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultado)
#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)
#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
m <- mean(exVec2,na.rm = T)
#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
d <-sum(exVec2)
e <-length(exVec2)
na.omit(exVec2)
q <- d/e
# (3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
q == m
# 5. (10pts) Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2)
#RESPUESTA: la formula rnorm genera cierto numero de observaciones con distribución normal, en la operacion se suman dos vectores, uno con una longitud de 6 observaciones y el otro con una de 2 observaciones,
# 6. (10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

logicos <- c(TRUE,FALSE,TRUE)
logicos
integer <- c(4L,23L,5L)
integer
double <- c(1.3,3.2,4.2)
double
character <- c("hola","adios")
character
complex <- c(pi, exp(1))
complex
raw <- raw(3L)
raw
listas <- list(logicos,integer,double)
listas
# 7. (10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
mm <-matrix(1:9,3,3)
df <- mtcars
list1 <-list(logicos,mm,df)
list1
# 8. (15 pts) Muestre tres formas de indexar la primera columna del data.frame mtcars
mtcars[,1]
mtcars$mpg
mtcars[1]
# 9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
  m[,1,drop=FALSE]
  
  # Respuesta: La diferencia es que con el drop como True, se devuelve como un vector, mientras que con el drop en False, se devuelve como un dataframe 
  
  # 10. (10pts) Haga una union por por columna de las matrices m1 y m2.
  m1 <- matrix(1:sample(seq(9,18,3),1),3)
  m2 <- matrix(1:sample(seq(9,18,3),1),3)
  m1
  m2
  cbind(m1,m2)
  
  
  
  # 11. (24pts) Respecto del data.frame iris que vienen incorporados en R, realice lo siguiente:
  # (6pts) Cree un nuevo data.frame de nombre iris2 que tenga las columnas Species, Petal.Width y Sepal.Length. Hágalo de dos maneras diferentes.
iris

iris21<- iris["Species"]
iris22 <- iris[,4,drop=FALSE]
iris22
iris23 <-iris["Sepal.Length"]
iris2 <-cbind(iris21,iris22,iris23)
iris2
iris21 <- iris$"Species"
iris22 <- iris$Petal.Length
iris23 <- iris$Sepal.Length
iris2 <-data.frame(iris21,iris22,iris23)
iris2
#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
nueva_col <- 1:150
cbind(iris2,nueva_col)
#(6pts) Cree un nuevo data.frame iris3 en el que estén solo las filas 27, 143, 148, 138, 125. Hágalo de dos maneras diferentes.
iris3 <- iris[c(27,143,148,138,125),]


#(6pts) Cree un nuevo data.frame iris4 en el que estén las filas que cumplen la condición Sepal.Lenght mayores o iguales que 6
iris4 <-iris[iris$Sepal.Length>=6,]
iris4
# 12. (10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
numeros <-1:5
caracteres <- letters [1:5]
logicos <-c(T,T,T,F,F)
data.frame(numeros,caracteres,logicos)

# 13. (25pts) Para los siguientes ejercicios utilice el data.frame iris

#Use funciones para mostrar:

# (5pts) la estructura del set de datos
summary(iris)
#(5pts) el número de columnas y de filas del set de datos
dim(iris)
#(5pts) el nombre de las columnas del set de datos
names(iris)
#(5pts) el encabezado del set de datos
head(iris)
#(5pts) los últimos seis elementos del set de datos
tail(iris)
# 14. (15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#RESPUESTA: a diferencia de los dataframes, los archivos sf contienen archivos de tipo vectoriales, de geometria.

#2 Parte 2: Manejo de archivos
#Datos: Descargue los archivos desde este link
install.packages("sf")
library("sf")
install.packages("tibble")
library("tibble")
# 1. (50pts) Con el archivo que se encuentra en formato CSV :
# (10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data <-read_sf("data/datos_ema_254.csv")
data
data <-print(data,n=25)
#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
summary(data)
#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

data1 <-mean(data[4],na.rm = F)
mean(data$humed_rel_promedio)
data
data1 <-print(data,n=30)
a <- 65.1
b <-55.7
c <- 46.7
d <- a+b+c
e <-d/3
dat1a<- data[data$humed_rel_promedio > e,]
dat1a
data1[14]


#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.




# 2. (80pts) Con el archivo que se encuentra en formato Geopackage:
# (10pts) Cargue el archivo en R y asígnelo al objeto geo.
geo <-read_sf("data/region_Los Ríos.gpkg")
geo
#(10pts) ¿Qué clase de objeto es geo?
class(geo)
# (10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
geom <-geo$geom
class(geom)
length(geom)
#tiene 13 geometrias y tiene geometria de tipo punto
#(10pts) ¿Cuántas variables y observaciones tiene geo?
dim(geo)
#tiene 13 observaciones y 7 variables

# (20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
plot(geo[4])
#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
geo$institucion== "INIA"
geo1 <- geo[c(6,7,8,9,10,12,13),]
geo1
