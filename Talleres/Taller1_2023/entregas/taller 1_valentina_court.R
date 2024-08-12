#TALLER 1
#Integrantes: Camila Urrutia; Valentina Court
#Fecha: 01-09-2023

##LO BASICO
#1. Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.n 

v16 <- seq(20,50)
o <- seq(20, 60)
mean(o)
o2 <- seq(51, 91)
sum(o2)

#5. Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria

d <- rnorm(1000, mean = 0, sd = 1)
hist(d, freq = FALSE)
curve(dnorm(x, mean(d), sd(d)), col = 2, lty = 2, lwd = 2, add =t)
d

#6. Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

e <- c(45, 12, 56, 14, 16)
f <- c("auto", "bici")
g <- matrix(1:12, ncol = 4)
 mi_lista <- list(e,f,g)
mi_lista


#7. Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.

matrix(1:20, nrow = 5, ncol = 4) #matriz de 5x4
mat <- matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE) #matriz de 3x3

rownames(mat) <- c("x", "y", "z")

colnames(mat) <- c("x", "y", "z")
print(mat)
matri <- matrix(1:4, nrow = 2, ncol = 2, byrow = FALSE) #matriz de 2x2


rownames(matri) <- c("p","f")
colnames(matri) <- c("p","f")
matri

#10. Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.

e <- 1:5
nombres <- c("Pedro", "Juan", "Mateo", "Emma", "Mariana" )
genero <- c("m", "m", "m", "f", "f")
rut <- c("12.345.678-9", "22.333.444-5", "12.123.456-7", "19.282.376-5", "23.435.675-9")
direccion <- c("av. pedro montt 54", "manquehue sur 4566", "hamburgo 654", "victor rae 8798", "av. ossa 222")
profesion <- c("escritor", "pintor", "profesor", "doctor", "abogado")
df <- data.frame(e, genero, rut, direccion, profesion)
df

##VECTORES
#1. Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.
#vectores numericos 
n <- 1:6
n2 <- c(1,7,3,7,9,5)

l <- c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE)
l2 <- rep(TRUE,6)
l3 <- rep(TRUE,2)
l4 <- c(l3, TRUE, FALSE, TRUE)
l4
# complejos 

c(1i,2+1i,1i,1i)

#vectores carcater 

c1 <- c("abcd", "bcd", "cef", "ghi", "jkl","mno")
c2 <- c("abcd", "bcd", "cef")
c3 <- c("ghi", "jkl", "mno")

c4 <- c(c2,c3)

identical(c1,c4)
identical(c1,c4)


#2. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3

j <- c(1,2,3)
j1 <- c(4,5,6)
j + j1


#4. Escriba un programa de R para encontrar la suma, la media y el producto de un vector

v <- 1:5
v <- rnorm(10)
v <- 60:100
v <- seq(5,100,10)
sum(v)
mean(v)
prod(v)

#7. Escriba un pograma en R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN

v <- c(NA, 1:10)
sum(v, na.rm = FALSE)
sum(v)

mean(v,na.rm = TRUE)
prod(v,na.rm = TRUE)

#8. Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.

v <- c(5,4,2,1,8,90,45)
sort(v)
sort(v,decreasing = TRUE)

#9. Escriba un programa R para probar si un vector dado contiene un elemento específico.

v == 4

#10. Escriba un programa R para encontrar el segundo valor más alto en un vector dado.

sort(v,decreasing = TRUE)[2]

#11. Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.

sort(v,decreasing = TRUE)[4]

#12.Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector

iris$Sepal.Length
v1 <- iris$Sepal.Length

#13. Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.

a <- c(1,50,20)
b <- 1:10
a
b
setdiff(a,b)

#14. Escriba un programa en R para invertir el orden del vector dado.

rev(b)


#15.Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.

p <- seq(6,25,3)
length (p)
dim (p)

#16. Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.

i <- 1
p[i]
i > 10

#17.Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.

v <- 1:5
v
v_suma3 <- v + 3
v_suma3

#18. Escriba un programa en R para crear un vector usando el operador : y la función seq().

w <- seq(1:10)
w
##Factores

#1. Escriba un programa R para encontrar los niveles de factor de un vector dado.

h <- iris$Species
class(h)
levels(h)

#2. Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.

levels(f)[1] <- levels(iris$Species)[1]
f

#3. Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.

factor(month.name)
m <- factor(month.name, levels = month.name)
levels(m)

#4. Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

set.seed(123)
let <- sample(letters,5)
letf <- factor(let)
levels(letf)

#5. Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.

grupos <- factor(c("g1","g1", "g2","g2"))
altura <- c(167,165,163,168)
pesos <- c(65,67,68,69)
df <- data.frame(pesos, altura, grupos)
str (df)

##Matrices 
#1. Escriba un programa en R para crear una matriz en blanco.

m1 <- matrix(ncol = 2, nrow = 2)
m2 <- matrix(c(" "," "," "," "),ncol=2,nrow=2)
m1
m2

#2. Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

m3 <- matrix(1:10,ncol = 2,nrow = 5)
m4 <- matrix(1:10, 2, 5)
m3
m4


#3. Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.

n<-1
class(n)

o<-matrix(n,nrow = 2,ncol=2)
rownames(o)<-c("A","B")
colnames(o)<-c("1","2")
o


#4. Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

p<-matrix(1:6,nrow = 2,ncol = 3,byrow = FALSE)
q<-matrix(c(10,20,30,40,50,60),nrow = 2, ncol = 3,byrow = FALSE)
p
q
p*2
p+q
q-p
q/p
p*q

#5. Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.

library(corrplot)
str(mtcars)
?`corrplot-package`

correlacion<- cor(mtcars)
corrplot(correlacion,method = "circle")

#6. Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.

my_data <- data.frame(
  "ID"= c(1, 2, 3, 4, 5, 6),
  "Name"=c("John", "Doe", "Mary", "Smith", "Mike", "Brown"),
  "Age"= c(21, 22, 20, 21, 19, 20)
)
r<-c(1, 2, 3, 4, 5, 6)
s<-c("John", "Doe", "Mary", "Smith","","")
t<-c(21, 22, 20, 19,21,20)
u<-matrix(c(r,s,t),nrow = 6,ncol = 3,byrow = FALSE)
rownames(u)<-c("ID","Name","Age")
colnames(u)<-c("ID","Name","Age")
u
my_vector <- c(21,22,20,19,21,20)
which.max(my_vector)
which.min(my_vector)

#7. Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.

v<-matrix(1:4,nrow = 2,ncol = 2,byrow = TRUE)
w<-matrix(1:4,nrow = 2,ncol = 2,byrow = FALSE)
v
w
rbind(w,v,deparse.level = 1)


