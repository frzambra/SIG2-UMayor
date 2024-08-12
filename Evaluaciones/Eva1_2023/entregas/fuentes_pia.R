##Pia Fuentes
##PARTE 1

#1.(5pts) Cree los siguientes objetos de tipo vector
 #1.1 exVec1 con los números: -10, -17, 17, -28, 21
 #1.2 exVec2 con los números: 13, -26, -48, 16, 34
 #1.3 exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)

exVec1 <- c(-10, -17, 17, -28, 21)
exVec2 <- c(13, -26, -48, 16, 34)
exVec3 <- seq(from=-5, to=5, by=0.5)

#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado2 <- c(exVec1, exVec2)
exVec_resultado2

#3. (5pts) Usando indexación con paréntesis cuadrado:
  
 #3.1 devuelva el 3er elemento del vector exVec1
exVec1[3]

 #3.2  devuelva todo menos el 2do y 3er elemento en exVec2
exVec2[c(1,4,5)]

#4. (15pts) Use funciones u operadores de relación para:
 #4.1 (3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)

 #4.2 (3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

 #4.3 (3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
promedio1 <- mean(exVec2)
?mean
mean(exVec2, na.rm=TRUE) #mismo resultado.

 #4.4 (3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
pro_f <- sum(exVec2)/length(exVec2)
promedio2 <- na.omit(pro_f)
promedio2
?na.omit

 #4.5 (3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
identical(promedio1, promedio2)

#5. (10pts) Explique que hace la siguiente operación e indique ¿por qué?
  x <- rnorm(6) + rnorm(2)
x
?rnorm
    #Respuesta: La siguiente operación "rnorm(6) + rnorm(2)" en primer lugar genera valores aleatorios con la función "rnorm" según el argumento indicado para el número de observaciones. Luego, con el signo "+" indica la suma de estos valores generados, pero como el número de cantidad de elementos (length) es distinto 'R' utiliza el "reciclaje de vectores", es decir, el vector de longitud pequeña (rnorm(2)) se repetirá siempre que la operación se complete en el vector más largo (rnorm(6)).

#6. (10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#RESPUESTA: Se podría decir que hay 4 clases de vectores que se pueden utilizar en R, en el aula solo se vieron 3 pero se hace mención a todos los que hay, estos son: Numeric, Character, Logical y Complex. Cabe mencionar que dentro de los vectores de tipo "Numeric" es posible encontrar datos de clase 'integer' o 'double'. A continuación se muestra un ejemplo de cada tipo. 

n <- 1:5 #Vector tipo númerico.
class(n)

c <- 'país' #Vector tipo character
class(c)

l<-c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE) #Vector tipo logical
class(l)

c <- c(1i,2+1i,1i) #Vector tipo comlex
class(c)

#7. (10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

lista <- list(Vector_logico=3>10, Matriz=matrix(data=1:9, ncol=3), data_frame=mtcars)
lista

#8. (15 pts) Muestre tres formas de indexar la primera columna del data.frame mtcars

mtcars[,1]
mtcars$mpg
mtcars[,'mpg']

#9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)
m
#codigo 1
a <- m[,1]
class(a)

#codigo 2
a2<- m[,1,drop = FALSE]
class(a2)

#RESPUESTA: En el "código 1" se indexa la columna 1 simplificandose a un vector numerico (puede comprobarse con la función "class()"). Sin embargo, en el caso del "código 2" aunque también se realiza una indexación respecto a la columna 1 se mantiene la clase del objeto original con el agumento 'drop=FALSE' (si se aplica la función 'class()' dará como resultado "matrix"). En conclusión, aunque en ambos códigos se esta realizando una indexación de la columna 1, en la primera opción se obtiene un vector númerico al ser simplificado mientras que en la segunda opción se hereda la clase del objeto origional (en este caso, matriz). 

#10. (10pts) Haga una union por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
cbind(m1,m2) #unión por columnas. Al principio cada matriz tiene 3 columnas, pero al unirlas por las columnas da un total de 6. 

#11. (24pts) Respecto del data.frame iris que vienen incorporados en R, realice lo siguiente:
iris

 #11.1 (6pts) Cree un nuevo data.frame de nombre iris2 que tenga las columnas Species, Petal.Width y Sepal.Length. Hágalo de dos maneras diferentes.
iris2 <- iris [c(5,4,1)] #forma 1.
iris2

iris2.2 <- subset.data.frame(iris, select= c(Species, Petal.Width, Sepal.Length)) #forma 2.
iris2.2
?subset.data.frame

identical(iris2, iris2.2)

 #11.2 (6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
str(iris) #150 filas
iris$nueva_col <- 1:150
iris

 #11.3 (6pts) Cree un nuevo data.frame iris3 en el que estén solo las filas 27, 143, 148, 138, 125. Hágalo de dos maneras diferentes.
iris3 <- iris[c(27,143,148,138,125),]
iris3

a <- iris[27,]
b <- iris[143,]
c <- iris[148,]
d <- iris[138,]
e <- iris [125,]
iris3.2 <- c(a,b,c,d,e)
iris3.2


 #11.4 (6pts) Cree un nuevo data.frame iris4 en el que estén las filas que cumplen la condición Sepal.Lenght mayores o iguales que 6


condicion <- iris$Sepal.Length >= 6
iris4 <- iris[iris$Sepal.Length >= 6,]
iris4
  
#12. (10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

vn <- 1:5
vc <- c('a', 'b', 'c', 'd', 'e')
vl<-rep(TRUE,5)

data.frame(Numeros=vn, Caracteres=vc, Logicos=vl)

#13. (25pts) Para los siguientes ejercicios utilice el data.frame iris Use funciones para mostrar:
  iris
 #13.1 (5pts) la estructura del set de datos
str(iris)

 #13.2 (5pts) el número de columnas y de filas del set de datos
str(iris) #indica 150 obs y 6 variables.
ncol(iris)
nrow(iris)

 #13.3 (5pts) el nombre de las columnas del set de datos
colnames(iris)

 #13.4 (5pts) el encabezado del set de datos
head(iris)

 #13.5 (5pts) los últimos seis elementos del set de datos
tail(iris)

#14. ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#RESPUESTA: Un "data.frame" es una estructura de dato que puede almacenar columnas con diferentes tipos de datos, mientras que "sf" es para trabajar con datos espaciales vectoriales. 'sf' contiene una tabla (dataframe) con atributos y geometría. 

##PARTE 2.

#1. (50pts) Con el archivo que se encuentra en formato CSV :

 #1.1 (10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data <- read.csv('datos/datos_ema_254.csv')
data

 #1.2 (10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)


 #1.3 (10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
summary(data) #promedio de la columna humed_rel_prom es 55.83

h <- data$humed_rel_promedio #primera forma
dta_pro <- data[h>55.83, 'humed_rel_promedio']
dta_pro


h2 <- data$humed_rel_promedio>55.83 #segunda forma
h2
resultado <- data[14, 'humed_rel_promedio']
resultado

 #1.410pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.


 #1.5 (10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.



#2. (80pts) Con el archivo que se encuentra en formato Geopackage:

#2.1 (10pts) Cargue el archivo en R y asígnelo al objeto geo.
install.packages('sf')
library(sf)

geo <- st_read('datos/region_Los Ríos.gpkg')
geo

#2.2 (10pts) ¿Qué clase de objeto es geo?
class(geo) #es un obejto sf.

#2.3 (10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
str(geo) #tiene geometría point y la cantidad (length) es 13.

#2.4 (10pts) ¿Cuántas variables y observaciones tiene geo?
str(geo) #tiene 13 observaciones y 7 variables.

#2.5 (20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
comuna <- geo[, 4]
comuna
plot(comuna$geom)

geo$comuna
plot(geo$comuna)
#2.6 (20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
 g <- geo$institucion=='INIA'
 geo[geo$institucion == 'INIA', ]


