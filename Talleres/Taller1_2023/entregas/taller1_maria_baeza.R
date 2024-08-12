#lo básico

#1.Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.

x <-20:50

x1 <- 20:60
mean (x1)
mean(20:60)
x2 <- 51:91
sum(x2)
sum(51:91)

#5.Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria

n <- rnorm(100000,mean = 100,sd=10)
mean(n)
sd(n)

n<- rnorm(1000)
length(n)

hist(n)

#6.Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
v<-c(1,2,3,4,5)
m<-matrix(1:9,nrow=3)
f<-function(x){return(x*2)}
l<-list(vector=v,matrix=m,funcion=f)
l
#7. Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
ma <- matrix(1:20, nrow = 5, ncol = 4)
ma
maet <- matrix(1:9, nrow = 3, byrow = TRUE, dimnames = list(c("Fila1", "Fila2", "Fila3"), c("Col1", "Col2", "Col3")))
maet
macol<- matrix(1:4, nrow = 2, byrow = FALSE, dimnames = list(c("FilaA", "FilaB"), c("ColX", "ColY")))
macol
#10. Escriba un programa R para crear un `data.frame` que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
empleados <- data.frame(
  Genero = c("Hombre", "Mujer", "Hombre", "Mujer", "Mujer"),
  Edad = c(30, 25, 35, 28, 33),
  Rut = c("12345678-9", "98765432-1", "56789012-3", "34567890-1", "23456789-0"),
  Direccion = c("Enerto Pinto #1253", "Avenida Libertad #1456", "Calle El Periodista #7892", "Avenida D #101", "Calle E #222"),
  Profesion = c("Ingeniero", "Doctora", "Veterinario", "Abogada", "Profesora")
)
empleados
summary(empleados)
#Vectores
#1.Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.

#vectores numéricos
n<- 1:6
n2 <- c(1,7,3,7,9,5)
n3 <- seq(8,200,length.out=6)

#vectores lógicos

l <- c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2 <- rep(TRUE,6)
l3 <-rep(TRUE,2)
l4 <- c(13,TRUE,FALSE,TRUE)
l4

#vectores complejos

c(1i,2+1i,1i,-1i,3+2i,4-2i)

#vectores caracteres

c1 <- c("abcd","bcd","cef","ghi","jkl","mno")
c2 <- c("abcd","bcd","cef")
c3<- c("ghi","jkl","mno")

c4<- c(c2,c3)
identical(c1,c4)

#2.Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
#L para que el vector sea entero

j <- c(1L,2L,3L)
j1 <-c(4L,5L,6L)
j+j1

#4.Escriba un programa en R para encontrar la suma, la media y el producto de un vector.

x <- rnorm(10)
x <- c(1,5,6,8,15,22,37)
x <- 60:100
x<- seq(5,100,10)

sum(x)
mean(x)
prod(x)

#7.Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
#NA.rm remueva los NA del vector

x<- c(NA,1:10)
sum(x,na.rm=TRUE)

sum(x,na.rm=TRUE)
mean(x,na.rm=TRUE)
prod(x,na.rm=TRUE)

#8.Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.

v <- c(5,4,2,1,8,90,45)

sort(v)
sort(v,decreasing = TRUE)

order(v)
v[c(4,3,2,1,5,7,6)]
v[order(v)]
v[order(v,decreasing = TRUE)]

#9. Escriba un programa R para probar si un vector dado contiene un elemento específico.

v<- 1:10
v
v== 4
#%n% esta función pregunta si 4 esta en v?

4 %in% v

c(4,6,23) %in% v

c ("a","ñ") %in% letters

#10.Escriba un programa R para encontrar el segundo valor más alto en un vector dado.

v <- c(5,4,2,1,8,90,45)

#11.Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.

f<-seq(1,100,10)

vector_ordenado_dec <-sort(f,decreasing=TRUE)
vector_ordenado_dec[2]
vector_ordenado_dec[5]
f
segundo_valor_mas_alto<-vector_ordenado_dec[2]
segundo_valor_mas_alto

#12. Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.

v1<-iris$Sepal.Length
v1<-iris[,1]
v1<-iris[,"Sepal.Length"]

v2<-iris$Sepal.Width
v2<-iris[,2]
v2<-iris[,"Sepal.Width"]

v3<-iris$Sepal.Length
v3<-iris[,"Species"]

class(v1)
class(v2)
class(v3)

#13.Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.

v1<-c(50,100)
v2<-1:10
v1
v2

setdiff(v1,v2)
#14.Escriba un programa en R para invertir el orden del vector dado.

x<-1:10
rev(x)

#15.Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
v<-seq(6,25,3)
length(v)
dim(v)

#16.Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.
i<-1
v[i]>10

#17.Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
v<-1:5
v
v_suma3<-v+3
v_suma3

v<-c(1,2,3,4,5)
v<-1:1000
v<- seq(1,100,5)

#18.Escriba un programa en R para crear un vector usando el operador : y la función seq().
# Crear un vector del 1 al 10 usando la función seq()
m1<- seq(from = 1, to = 10, by = 1)
cat("Vector creado con la función seq(): ", m1, "\n")

#factores

#1.Escriba un programa R para encontrar los niveles de factor de un vector dado.
f1<-iris$Species
class(iris$Species)
levels(iris$Species)
class(f1)
levels(f1)

f<-factor(
  c('a','a','b','b','c','c'),
  levels=c('a','b','c')
)
#2.Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(f)[1]<-levels(iris$Species)[1]
f

#3.Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
m<-month.name
f<-factor(month.name,levels=month.name)
levels(f)
f1<-factor(month.name,ordered=TRUE)
levels(f1)

#4.Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).
set.seed(123)
rnorm(3)
let<-sample(letters,5)
letf<-factor(let)
levels(letf)

#5.Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
grupos<-factor(c('g1','g1','g2','g2'))
altura<-c(1.67,1.65,1.68,1.57)
pesos<-c(56,62,68,54)

df<-data.frame(pesos,altura,grupos)
str(df)

class(df$pesos)
length(df$pesos)
class(df$grupos)


#Matrices

#1.Escriba un programa en R para crear una matriz en blanco.
m1<-matrix(ncol=2,nrow=2)
m2<-matrix(c('','','',''),ncol=2,nrow=2)
m1
m2

#2.Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

m3<-matrix(1:10,ncol=2,nrow=5)
m4<-matrix(1:10,2,5)
m3
m4

v1<-seq(5,100,5)
v1
m5<-matrix(v1,5)
m5

matrix(1:10,3,3)

#3.scriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
# Crear un vector de números
j<- c(1, 2, 3, 4, 5)
j1<- c("Fila1", "Fila2")
j2 <- c("Columna1", "Columna2", "Columna3", "Columna4", "Columna5")
t<- matrix(j,nrow = length(j1), ncol = length(j2))
rownames(t) <- j1
colnames(t) <- j2
cat("Matriz creada:\n")
print(t)

#4.Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.
# Crear dos matrices de 2x3
b1<- matrix(1:6, nrow = 2)
b2<- matrix(7:12, nrow = 2)

d<- b1 + b2
d1 <- b1 - b2
d2 <- b1* b2
d3<- b1 / b2

b1
b2
d
d1
d2
d3
#5.Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
# Crear un data.frame de ejemplo
w<- data.frame(A = c(1, 2, 3, 4, 5),B = c(2, 3, 4, 5, 6),C = c(3, 4, 5, 6, 7))
w1<- cor(w)
print(w1)
#6.Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
r <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3, ncol = 3)
r1 <- which(r == max(r), arr.ind = TRUE)

# Encontrar el índice del valor mínimo
r2 <- which(r == min(r), arr.ind = TRUE)
r
r1
r2


#7.Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
z1 <- matrix(1:3, nrow = 3)
z2 <- matrix(4:6, nrow = 3)

rbind(z1, z2)

