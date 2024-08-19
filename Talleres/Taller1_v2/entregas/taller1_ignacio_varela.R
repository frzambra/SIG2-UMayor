#taller1 Uso Avanzado de Sistemas de Información Geográfica
#integrantes:
# Ignacio Varela
# Joshep Lueiza 


                 # LO BASICO
# 1. Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.
s<- c(20:50)
s
# 2. Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
n<- rnorm(1000)
n <- rnorm(1e5,mean=100, sd=10)
n
length(n)
mean (n)
hist(n)


# 3. Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
a<- c(1,2,3)  #vector
a
matriz_test <- matrix(c(1,2,3,4), nrow= 4, ncol=2)   #matriz
matriz_test



# 4. Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
# Crear una matriz de 5x4 y llenarla por filas
matriz_5x4 <- matrix(1:10, nrow = 5, ncol = 4, byrow = TRUE)  #filaxcolumna 
matriz_5x4
#TRUE= SE RELLENA DE FORMA VERTICAL FALSE= SE RELLENA DE FORMA HORIZONTAL

# Crear una matriz de 3x3 con etiquetas
matriz_3x3 <- matrix(letters[1:9], nrow = 3, ncol = 3, byrow = TRUE)
matriz_3x3

# Crear una matriz de 2x2 con etiquetas y llenarla por columnas
matriz_2x2 <- matrix(letters[10:13], nrow = 2, ncol = 2, byrow = FALSE)
matriz_2x2

# 5. Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.

veterinaria <- data.frame(
  Genero = c("Masculino", "Femenino", "Masculino", "Femenino", "Masculino"),
  Edad = c(4, 6, 7, 6, 10),
  RAZA = c("pastor alemán", "pastor alemán", "Border Collie", "Border Collie", "Border Collie"),
  Colordepelo = c("Negro", "Blanco", "Negro", "Negro", "Gris")
  
)

View(veterinaria)
                          #VECTORES

#VECTORES


#1 Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.

#VECTORES NUMERICOS

n <- 1:6 
n2 <- c(1,7,3,7,9,5)
n2

# vectores logicos 

l<- c(TRUE,FALSE,TRUE)
l2<- rep(TRUE,6)
l2

P <- c(1L, 2L, 3L)
P
p2 <- c(3L, 5L, 6L)
p2
sum(P+p2)
P+p2


#2 Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
v1 <- rep(1:6, each = 3)
v2 <- rep(1:6, each = 3)
resultado<- v1+v2
resultado

#4. 4 Escriba un programa en R para encontrar la suma, la media y el producto de un vector.

sum(n2)
mean(n2)
prod(n2)

#7 7. Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
v<- c(NA,1:10)
sum(v)
mean(v)
prod(v)

#8Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.

v<-c(5,7,9,2,6,90)
sort(v)
sort(v,decreasing=TRUE)

#uso de order()
order(v)

v2<-1:5
v2
v2[5:1]
order(v, decreasing=TRUE)

#2.9 Escriba un programa R para probar si un vector dado contiene un elemento específico.

v==5
v=="Z"

c(9,8,91)%in% v

#2.10 Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
t<- seq(1,100,10)
sort(t,decreasing=TRUE)
sort(t,decreasing=TRUE)[2]

vector_ordenado_dec <-sort(t,decreasing=TRUE)
vector_ordenado_dec[2]

#2.11 Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.
sort(t,decreasing=TRUE)[10]


#2.12 Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.

head(iris)

v1<-iris[,1]
v1

v3<- iris[,"Species"]
class(v1)
class(t)
class(v3)

#2.13 Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.

v9<-c(1,9,66,110)
v3<- 1:10
setdiff(v9,v3)

#2.14Escriba un programa en R para invertir el orden del vector dado.

rev(v9)

#2.15 Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.

length(v9)
dim(v9)

#2.16 Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.
i<-1
v9[i]>9


#2.17 Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.

v<- 1:5
v
v_suma3 <- v+3
v_suma3

#2.18 Escriba un programa en R para crear un vector usando el operador : y la función seq().

v7<- seq(0,100,5)
v7
v8 <- 1:99
v8


              #FACTORES

#3.1 Escriba un programa R para encontrar los niveles de factor de un vector dado.

class(iris$Species)
levels(iris$Species)

f <- factor(c('a','a','b','b','c','c'))
levels=c('a','b','c')

#3.2 Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.

levels(f)[1] <- levels(iris&species)[1]
f

#3.3 Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.


m<- month.name
f<- factor(month.name,levels=month.name)
levels(f)

#3.4 Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

set.seed(123)
let<-sample(letters,5)
letf<- factor(let)
letf

#3.5 Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.

grupos <- factor(c('G1','G1','G2','G3'))
altura<- c(167,165,166,157)
pesos<- c(56,66,77,43)

df<- data.frame(pesos,altura,grupos)
str(df)

class(df$pesos)
class(df$altura)
class(df$grupos)
7

          #MATRICES
#4.1 Escriba un programa en R para crear una matriz en blanco.

m1<- matrix(ncol=2,nrow = 2)
m1

#4.2 Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

m3<- matrix(1:10,ncol=2,nrow=5)
m3

m4<- matrix(1:10,2,5)
m4

v1 <- seq(5,100,5)

m5<- matrix(v1,5)
m5

#4.3 Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
nombrefila <- c("FAMILIA1", "FAMILIA2", "FAMILIA3", "FAMILIA4")
nombrecolumna <- c("Cantidad", "Cantidad", "Cantidad", "Cantidad")

matrizx <- c(4, 6, 8, 10)


matriz_4x4 <- matrix(matrizx, nrow = length(nombrefila), ncol = length(nombrecolumna))


colnames(matriz_4x4) <- nombrecolumna
rownames(matriz_4x4) <- nombrefila

View(matriz_4x4)

#4.4 Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

matrizone <- matrix(1:6, nrow = 2, ncol = 3)
View(matrizone)
View(matriztwo)
matriztwo <- matrix(1:3, nrow = 2, ncol = 3)

suma <- matrizone+matriztwo
resta <-matrizone-matriztwo
division <- matrizone/matriztwo

suma
resta
division
#4.5 Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
dataframem <- data.frame(
  Edad = c(25, 30, 35, 40),
  peso = c(90, 85, 70, 95),
  calorias = c(1800, 1200, 2000, 1500)
)
matrizdata <- cor(dataframem)
View(matrizdata)

#4.6 Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
matrizz <- matrix(1:10, nrow = 2, byrow = TRUE)
View(matrizz)


indmax <-which(matrizz == max(matrizz), arr.ind = TRUE)
indmin <- which(matrizz == min(matrizz), arr.ind = TRUE)
View(matrizz)
View(indmax)
View(indmin)
#4.7 Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.


matriz1 <- matrix(1:6, nrow = 6) #filas
matriz2 <- matrix(7:12, nrow = 6)

matriz_conca<- rbind(matriz1, matriz2)
View(matriz1)
View(matriz2)
View(matriz_conca)
