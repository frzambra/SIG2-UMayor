
#taller 1
#integrantes   #Diego Montero
               #Carlo Muñoz
#fecha 01-09-2023

#Lo Basico
#1 escriba un programa en R para crear una secuencia del 20 al 50 y encuentre la media de los numeros del 20 al 60 y la suma de los numeros del 51 al 91

x <- 20:50
x

x1 <- 20:60
x1
mean(x1)
mean(20:60)

x2 <- 51:91
x2
sum(x2)
sum(51:91)

#5 escriba un programa en R para crear una curva de campana de una distribucion normal aleatoria

n <- rnorm(1000)
mean(n)
sd(n)

?rnorm
length(n)

hist(n)

#6 Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

b <- list(vector =c(1,2,3,4,5),matriz = matrix(1:12,nrow = 3),funcion = function(x)x^2)
b

#7 Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
c <- matrix(NA,nrow = 5,ncol = 4,byrow = TRUE)
c
#7.2
d <- matrix(1:9,nrow = 3,ncol = 3,byrow = TRUE)
d

#7.3
e <- matrix(1:4,nrow= 2,ncol= 2)
e

#10 Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos
Genero = c('M','F','M','F','M')
Edad = c(20,35,50,55,40)
Rut = c('12345674-8','20111676-8','20296367-8','23892837-8','19928937.8')
Direccion = c('calle2020','avda1','pasaje2','mirador102','pionono9')
Profesion = c('abogado','contadora','ingeniero','diseñadora','profesor')

empleados <- data.frame(Genero = c('M','F','M','F','M'),
                        Edad = c(20,35,50,55,40),
                        Rut = c('12345674-8','20111676-8','20296367-8','23892837-8','19928937.8'),
                        Direccion = c('calle2020','avda1','pasaje2','mirador102','pionono9'),
                        Profesion = c('abogado','contadora','ingeniero','diseñadora','profesor'))
print(empleados, row.names = FALSE)
summary(empleados)

#vectores
#1 Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.

#vectores numericos
n <- 1:6
n2 <-c(1,7,3,7,9,5)

#vectores logicos

l<- c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2<- rep(TRUE,6)
l3<- rep(TRUE,3)
l4<- c(l3,TRUE,FALSE,TRUE)
l4

#vectores complejos

c(1i,2+1i,1i,-1i,3+2i,4-2i)

#vectores caracter

c1 <- c("abcd","bcd","cef","ghi","jkl","mno")
c2 <- c("abcd","bcd","cef")
c3 <- c("ghi","jkl","mno")

c4 <- c(c2,c3)
identical(c1)

#2 escriba un programa en R para sumar dos vectores de tipo entero y longitud 3

j <- c(1L,2L,3L)
j1 <- c(4L,5L,6L)
j+j1

#4 escriba un programa en R para encontrar la suma, la media y el producto de un vector

v <- 1:5
sum(v)
mean (v)
prod (v)



#7 escriba un programa R para encontrar la suma, la media y el producto de un vector, ingore elementos como NA o NaN

v <- c(NA,1:10)
sum(v,na.rm = TRUE)
mean (v,na.rm = TRUE)
prod (v,na.rm = TRUE)


#8 escriba un programa en R para ordenar un vector en orden ascendente y descendente

v <- c(5,4,2,1,8,9,90,45)
sort(v)
sort(v,decreasing = TRUE)
order(v)
v[c(4,3,2,1,5,7,6)]
v[order(v)]



#9 escriba un programa R para probar si un vector dado contiene un elemento especifico
v <- 1:10
v == 4
c(4,6,20)%in% v


#10 obtener el segundo valor mas alto
#11 Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado

f <-seq(1,100,10)

sort(f,decreasing = TRUE)[2]
sort(f,decreasing = TRUE)[5]
vector_ordenado_dec <- sort(f,decreasing = TRUE)
vector_ordenado_dec[2]

#12 escriba un programa en R para convertir las columnas dadas de un data.frame en un vector

iris$Sepal.Length
iris[,1]
iris[,'Sepal.Length']

v1 <- iris$Sepal.Length
v1

v2 <- iris$Sepal.Width
v2 <- iris[,2]
v2 <- iris[,'Sepal.Width']

v3 <-iris$Species
v3 <- iris[,'Species']
v3
class(v1)
class(v2)
class(v3)

#13 escriba un programa R para encontrar los elementos de un vector dado que no estan en otro vector

v1 <- c(1,50,100)
v2 <- 1:10
v1
v2

setdiff(v1,v2)

#14 escriba un programa en R opara invenrtit el orden dado

name=c (1,3,7,10)
rev(name)
#15 escriba un programa en R para crear un vector y encuentre la longitud y la dimension del vector

v <- seq(6,25,3)
length(v)
dim(v)

#16 escriba un programa en R opara probar si el vaor del elemento de un vector dado es mayor que 10 no devuelve TRUe o false

i <- 1
v[i] > 10

#17 escriba un programa en R para sumar 3 a cada elemento en un vector dado imprime el vector original y el nuevo

v <- 1:5
v
v_suma3 <- v + 3
v_suma3

#18 Escriba un programa en R para crear un vector usando el operador : y la función seq().

vector <- 1:20
vector

vector_seq <- seq(1,20,1)
vector_seq


#factors. 1 escriba un programa en R para encontrar los niveles de factor de un vector dado

class(iris$Species)
levels(iris$Species)

f <- factor(c('D1','D1','D2','D2','D3','D3'),levels =c('D1','D2','D3'))
f
levels(f)

data.frame(medicion1=1:6,f)  

#2 factors, escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado


levels(f)[1] <- levels(iris$Species)[1]
f

#3 escriba un programa en R para cerar un factor ordenado a partir de datos que consisten en los nombres de los mese

m <- month.name
m
f1 <- factor(month.name,ordered = TRUE)
levels(f1)
f <- factor(month.name,levels = month.name)
levels(f)

#4 factors. escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribucion base R)

set.seed(123)
let <- sample(letters,5)
letf <- factor(let)
let
letf

#5 escriba un programa en R para crear un factor correspondiente al conjunto de datos la altura de las mujeres, que contenga la altura el peso de una muestra de mujeres

grupos <- factor(c('G1','G1','G2','G2'))
altura <- c(1.67,1.65,1.68,1.57)
pesos <- c(56,62,68,54)
df <- data.frame(pesos,altura,grupos)
str(df)

#matrices
#1 escriba un programa en R para crear una matriz en blanco
m1 <- matrix(ncol=2,nrow=2)
m2 <- matrix(c('','','',''),ncol=2,nrow=2)
m1
m2

# 2 escriba un programa en R para crear una matriz tomando como entrada un vector dado de numeros. muestre la matriz

m3 <- matrix(1:10,ncol=2,nrow=5)
m4 <- matrix(1:10,2,5)
m3
m4
v1 <- seq(5,100,5)

m5 <- matrix(v1,5)
m5

#3 Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
v_matriz <- c(1,2,3,4,5,6,7,8)

nombre_fila <- c('fila1','fila2','fila3','fila4')
nombre_columna <- c('columna1','columna2','columna3','columna4')

m6 <- matrix(v_matriz,ncol = length(nombre_columna),
             nrow =length(nombre_fila),
             dimnames = list(nombre_fila,nombre_columna))
m6

#4 Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

matriz_23 <- matrix(1:6,nrow = 2,ncol=3)
matriz_23
matriz_24 <- matrix(7:12,nrow=2,ncol=3)
matriz_24

#suma
suma <- matriz_23 + matriz_24
suma
#resta
resta <- matriz_23 - matriz_24
resta
#multiplicacion
mult <- matriz_23 * matriz_24
mult
#divison
div <- matriz_23 / matriz_24
div

#5 escriba un programa en R para crear una matriz de correlacion a partir de un data frame del mismo tipo de dato

cor(mtcars)

#6 Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.

m7 <- matrix(1:20,nrow=5)
m7
fila_maximo <- which.max( )

#7 Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.

matriz1 <- matrix(1:8,nrow = 4)
matriz2 <- matrix(7:14,nrow = 4)
matriz1
matriz2
matriz1_2 <- rbind(matriz1,matriz2)
matriz1_2
