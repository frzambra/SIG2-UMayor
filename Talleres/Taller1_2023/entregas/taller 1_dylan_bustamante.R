#taller1:
#integrante: Dylan Bustamante
#fecha: 01-09-2023

#l LO BASICO

# 1. Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.

x <-20:50

x1 <- 20:60
mean (x1)
mean(20:60)



x2 <- 51:91
sum(x2)
sum(51:91)

# 2. crea curva de campana de una distribución aleatoria 


n <- rnorm(100000,mean = 100,sd=10)
mean(n)
sd(n)



n<- rnorm(1000)
length(n)     


hist(n)


# 3. Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

# creo la lista
lista <- list()

# Agregar elementos a la lista
lista$vector <- c(20, 40, 60, 80, 100)
lista$matriz <- matrix(2:400, nrow = 4)
lista$funcion <- function(x) {return(x * 2)}


# 4. Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.

#  matriz de 5x4 
matriz_5x4 <- matrix(10:100, nrow = 5, ncol = 4, byrow = TRUE)
rownames(matriz_5x4) <- c("1", "2", "3", "4", "5")
colnames(matriz_3x3) <- c("D","F","G","H")

# matriz de 3x3 
matriz_3x3 <- matrix(3:21, nrow = 3, ncol = 3)
rownames(matriz_3x3) <- c("F1", "F2", "F3")
colnames(matriz_3x3) <- c("A", "B", "C")

# matriz de 2x2 
matriz_2x2 <- matrix(20:40, nrow = 2)
colnames(matriz_2x2) <- c("Col1", "Col2")
rownames(matriz_2x2) <- c("FilaA", "FilaB")


# 5. Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.

empleados <- data.frame
Genero <- c("Masculino", "Femenino", "Masculino", "Femenino", "Masculino")
Edad <- c (44,39, 30, 35, 38)
Rut <- c("13345678-9", "15123432-1", "18456789-0", "17654321-3", "16567890-2")
Direccion <- c("Calle 321", "Calle 999", "Calle 38", " Calle 21", "Calle 789")
Profesion <- c("Ingeniero", "cirujano", "Médico", "maquilladora", "Abogado"))
 


#VECTORES
#1.Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.



#vectores numéricos 
n<- 1:6
n2 <- c(1,7,3,7,9,5)
n3 <- seq(8,200,length.out=6)


#vectores logicos 

l <- c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2 <- rep(TRUE,6)
l3 <-rep(TRUE,2)
l4 <- c(13,TRUE,FALSE,TRUE)
l4



# vectores complejos

c(1i,2+1i,1i,-1i,3+2i,4-2i)


#vectores caracter 


c1 <- c("abcd","bcd","cef","ghi","jkl","mno")
c2 <- c("abcd","bcd","cef")
c3<- c("ghi","jkl","mno")

c4<- c(c2,c3)
identical(c1,c4)

# 2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
#L para que el vector sea entero

j <- c(1L,2L,3L)
j1 <-c(4L,5L,6L)
j+j1



# 3. Escriba un programa en R para encontrar la suma, la media y el producto de un vector.

x <- rnorm(10)
x <- c(1,5,6,8,15,22,37)
x <- 60:100
x<- seq(5,100,10)

sum(x)
mean(x)
prod(x)





# 4. Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
#NA.rm remueva los NA del vector

x<- c(NA,1:10)
sum(x,na.rm=TRUE)


sum(x,na.rm=TRUE)
mean(x,na.rm=TRUE)
prod(x,na.rm=TRUE)


# 8. Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.

v <- c(5,4,2,1,8,90,45)

# sort para ordenar los valores de forma creciente o decreciente
sort(v)
sort(v,decreasing = TRUE)


## order para ordenar las posiciones de forma creciente o decreciente 
order(v)
v[c(4,3,2,1,5,7,6)]
v[order(v)]
v[order(v,decreasing = TRUE)]


# 9. Escriba un programa R para probar si un vector dado contiene un elemento específico.


v<- 1:10
v
v== 4
#%n% esta función pregunta si 4 esta en v? 

4 %in% v 

c(4,6,23) %in% v

c ("a","ñ") %in% letters


# 10.Escriba un programa R para encontrar el segundo valor más alto en un vector dado.


v <- c(5,4,2,1,8,90,45)
v
# == operador logico de comparacion igual 
# != operador lógico para comparación distinto de


# seq  es una función que permite crear un vector numerico con una secuencia, (desde,hasta,cada cuanto) por ejemplo (10,100,1)

# 11 Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.

f<- c (9,2,8,3,345,24)
vector_ordenado_dec <- sort( f,decreasing = TRUE)
vector_ordenado_dec [2]
vector_ordenado_dec[5]

segundo_valor_mas_alto <- vector_ordenado_dec[2]
segundo_valor_mas_alto





#12. Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.

head(iris)
# $ sirve para hacer indexación también 
# 3 formas de hacer indexación en data.frame

v1 <- iris$Sepal.Length
v1 <- iris[,1]
v1 <- iris[,"Sepal.Length"
v1

v2 <- iris$Sepal.Width
v2 <- iris[,2]
v2 <- iris[,"Sepal.Width"]


v3 <- iris$Species
v3 <- iris [,"Species"]

class(v1)
class(v2)
class(v3)


# 13. Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.


v1<- c(1,50,100)
v2<- 1:10

v1

v2


setdiff(v1,v2)




# 14. Escriba un programa en R para invertir el orden del vector dado.

x <- 1:10
rev(x)


# 15. Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.

v <- seq (6,25,3)
length(v)
dim(v)


# 16. Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.

i <- 1
v [i] > 10
i

# 17. Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.

v<- 1:5
v
v_suma3 <- v + 3
v_suma3



# 18. Escriba un programa en R para crear un vector usando el operador : y la función seq().


v<- 1:10

x <- seq(1,100,5)


#1 FACTOR Escriba un programa R para encontrar los niveles de factor de un vector dado.

f1 <- iris$Species
class(f1)

class(iris$Species)

levels(iris$Species)


f <- factor (c("a","a","b","b","c","c"), levels = c("a","b","C")


levels(f)

d<- data.frame()

# 2. Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado. 


levels(f)[1] <- levels(iris$Species)[1]
f

# 3. Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.


m <- month.name
f1<- factor(month.name,ordered = month.name)
levels(f1)


f <- factor(month.name,levels = month-name)
levels(f)



# 4Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

letters
#eligiendo 10 de forma aleatoria y asignando a let

#set.seed setea una semilla 

#funcion sample tomay elige valores de forma aleatoria 

set.seed(123)
let <- sample(letters,5)

letf <- factor(let)
levels(letf)

let

letf



# 5 Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.


grupos <- factor(c("G1","G1","G2","G2"))
altura <- c (1.67,1.65,1.68,1.57)
pesos <- c(56,62,68,54)

#str muestra toda la estructura del data.frame 

df <- data.frame( pesos,altura,grupos)
str(df)


class(df$pesos)
length(df$pesos)
class(df$pesos)


# 1. MATRICES Escriba un programa en R para crear una matriz en blanco.

m1 <- matrix(ncol=2,nrow=2)
m2 <- matrix(c(" "," "," "," "),ncol=2,nrow=2)
m1
m2


# 2. Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

# 3. ncol y nrow te aisgna las filas y columnas para ordenarlo

m3 <- matrix(1:10,ncol=2, nrow=5)
m3
m4 <- matrix(1:10,2,5) 
m4

v1 <- seq(5,100,5)
v1

m5 <- matrix(v1,5)
m5


matrix ( 1:10,3,3)


# 4. Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

  

# matrices de 2x3
matriz1 <- matrix(1:6, nrow = 2)
matriz2 <- matrix(7:12, nrow = 2)
matriz1
matriz2


# Operaciones, suma, resta,mult,div.

suma <- matriz1 + matriz2
resta <- matriz1 - matriz2
multiplicacion <- matriz1 * matriz2
division <- matriz1 / matriz2




































