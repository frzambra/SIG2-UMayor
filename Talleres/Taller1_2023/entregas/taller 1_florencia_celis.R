#taller 1
#integrantes: Jonathan Hernandez y Florencia Celis 

#lo basico
#1.Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.
x <- 20:50
x
x1 <-20:60
mean(x1)
mean(20:60)

x2 <- 51:61
sum(x2)
sum(51:61)

#2.Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
n <- rnorm(1000)
length(n)
hist(n)

#3.Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
t<- c(2,4,6,8,10)
t

t2<- matrix(1:9,ncol = 3,nrow = 3)
t2

t3 <- length(t)

mi_lista <- list(vector = t, matriz = t2,funcion = t3 )
mi_lista
#4.Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
x<- matrix(1:20, ncol = 5,nrow = 4)
x
x2<- matrix(letters[1:9], ncol = 3,nrow = 3, byrow = TRUE)
x2
filaetiquetas <- c("Fila1", "Fila2", "Fila3")
columnaetiquetas <- c("Columna1", "Columna2", "Columna3")
rownames(x2) <- filaetiquetas
colnames(x2) <- columnaetiquetas

x3<- matrix(letters[1:4],ncol = 2,nrow = 2, byrow = FALSE)
x3
etiquetascolumnas2 <- c("Columna1", "Columna2")
etiquetasfilas2 <- c("Fila1", "Fila2")
colnames(x3) <- etiquetascolumnas2
rownames(x3) <- etiquetasfilas2

#5.Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
Empleados<- data.frame(genero = c('masculino', 'masculino', 'femenino', 'masculino', 'femenino'), edad= c(20,25,28,30,50),rut = c ("12345678-9","98765432-1","56789012-3","34567890-1", "23456789-0"), Direccion = c("Calle 123", "Ciudad B", "Calle 456", "Avenida ABC", "Calle 789"),
Profesion = c("Ingeniero", "Médico", "Abogado", "Profesor", "Contador") )
print(Empleados)


#2.vectores 
#1 Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.

#vectores numericos 
n <-1:6
n2 <- c(1,7,3,7,9,5)

#vectores logicos 
l <- c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2 <- rep(TRUE,6)
l3 <- rep(TRUE,2)
l4 <- c(l3,TRUE,FALSE,TRUE)

#vectores caracteres 
c1 <- c('abcd', 'bcd','cef','ghi','jkl','mno')
c2 <- c('abcd','bcd', 'cef')
c3 <- c('ghi', 'jkl','mno')
c4 <- c(c2,c3)
identical(c1,c4)

#2.Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
f <- c(1,2,3)
f2 <- c(4,5,6)
f+f2
sum(f+f2)

#3.Escriba un programa en R para encontrar la suma, la media y el producto de un vector.
a <- c(5,8,9)
mean(a)
sum(a)
prod(a)

v <- 60:100
v<- rnorm(10)
v <-C(5,8,9)
v <- seq(5,100,10)
sum(v)
mean(v)
prod(v)

#4.Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
m <- c(NA,1:10)
sum(m,na.rm = TRUE)
mean(m,na.rm = TRUE)
prod(m,na.rm = TRUE)

#5.Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.
c<- 1:10 
c
rev(c)

v<- c(1,5,3,7)
sort(v)
sort(v,decreasing = TRUE)
order(v)
##posicion de un elemento de un vector y sort solo lo ordena decreciente o creciente 

#6.Escriba un programa R para probar si un vector dado contiene un elemento específico.
v
v==4
v<- 1:10
v==4
4%in% v  ## pregunta si 4 esta contenido dentro de v 
6 %in% v

#7.Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
o <- c(5,4,2,1,8,90,45)
sort(o)
max(o-45)
sort (o, decreasing = TRUE) [2]

#8. Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.
o<- c(5,4,2,1,8,90,45)
sort(o)
max(o)

#9.Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.

o1 <- iris$Sepal.Length
o1<- iris[,1]
o1<- iris[ ,'Sepal.Length']
o1

o2 <- iris$Sepal.Width
o2
o3 <- iris$Species
o3
iris

#10. Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.
v1<- c (1,5,10,22)
v2<- 1:10
v1
v2
v1 %in% v2
setdiff(v1,v2)
#11.Escriba un programa en R para invertir el orden del vector dado.
FF<- 1:22
FF
rev(FF)
#12.Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
f1<- c(8,4,3,20)
length(f1)
dim(f1)
#13.Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.
f2<- 3
f1[f2]>10
#14.Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
f3 <- 1:5
f3
f3_suma3 <- f3+3
f3_suma3
#15.Escriba un programa en R para crear un vector usando el operador : y la función seq().
f4<- 10:100
f4
seq(10, 100)

#3.Factors

#1. Escriba un programa R para encontrar los niveles de factor de un vector dado.
class(iris$Species)
levels(iris$Species)
f1<- c('a','a','a','b','b','b','c')
f2 <- factor(f1,levels=c('a','b','c'))
f2
levels(f2)
#2.Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(f1)[1] <- levels(f2)[1]
f1
#3.Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
factor(month.name)
#4.Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).
let <- sample(letters,10)
letf <- factor(let)
let
levels(letf)
#5.Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
grupos <- factor(c('g1','g1','g2','g2'))
altura <- c(1.67,1.65,1.68,1.57)
pesos <- c(56,62,68,54)

df <- data.frame(pesos,altura,grupos)
str(df)
class(df$pesos)
length(df$pesos)

#4.matrices 

#1. Escriba un programa en R para crear una matriz en blanco.
m1 <- matrix(ncol = 2,nrow = 2)
m1
#2. Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.
m3<- matrix(1:10, ncol = 2,nrow = 5)
m3

#3 Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.

m4 <- matrix(1:9,ncol = 3,nrow = 3)
row.names(m4) <-c('x','y','z')
colnames(m4) <- c('a','b','c')
m4

#4 Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

m1 <- matrix(1:6,ncol = 2,nrow = 3)
m2 <- matrix(2:7,ncol = 2,nrow = 3)

msuma <- m1+m2
mresta <- m1-m2
mdive <- m1/m2
mmult <- m1*m2

#5.Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos. 
matrizcorrelacion<- cor(m1) 
matrizcorrelacion 

#6.Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
pp<- matrix(1:9,ncol = 3,nrow = 3)
pp

indicemax <- which(pp == max(pp), arr.ind = TRUE) 
indicemax  
indicemin <- which(pp == min(pp), arr.ind = TRUE)
indicemin

#7.Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
matriz9 <- matrix(78:81, nrow = 2)
matriz9
matriz22 <- matrix(33:38, nrow = 3)
matriz22
matrizconcatenada <- rbind(matriz9, matriz22)
matrizconcatenada
