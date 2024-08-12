#TALLER1: Integrantes: Constanza Araya, Giseth Martinez
#LO BASICO
#Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.
x<-20:50
x
x1<-20:60
mean(x1)
x2<-51:91
sum(x2)

#2Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
n<-rnorm(200)
hist(n)

#3Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
l <- list(1:4, matrix(ncol = 2, nrow =2, byrow = TRUE), sum(x))
l

#4Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
m<- matrix(1:20, nrow= 5, ncol=4)
m
m1<- matrix(1:9, nrow= 3, ncol=3, byrow = TRUE)
colnames(m1)<-c("a","b","c")
rownames(m1)<-c("a","b","c")
m1
m2<-matrix(1:4, nrow= 2, ncol=2, byrow = FALSE)
colnames(m2)<-c("a","b")
rownames(m2)<-c("a","b")
m2

#5Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
id<-1:5
Genero<-c("F","M","F","M","F")
Edad<-c(19,20,21,22,23)
Rut<-c(212381594,197005041,209970708,195666131,206367654)
Direccion<-c("Puerto Antofagasta 8396","morro de arica 123","laguna sur 511", "lovalledor131", "puerto mont542")
Profesion<-c("ingeniero","agricultor","constructor","bailarina","cartero")
df<-data.frame(id,Genero,Edad,Rut,Direccion,Profesion)
df

#VECTORES
#1Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.
n<-1:6
n2<-c(1,7,3,7,9,5)

#vector logicos

l<-c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2<-rep(TRUE,6)
l3<-rep(TRUE,2)
l4<-c(l3,TRUE,FALSE,TRUE)
l4
length(l4)

#vectores caracter

c1<-c("abcd","bcd","cef","ghi","jkl")
c2<-c("abcd", "bcd", "cef")
c3<-c("ghi", "jkl", "mno")
c4<- c(c2,c3)
identical(c1,c4)

#2Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
f<-c(1L,2L,3L)
f1<-c(4L,5L,6L)
f+f1

#3Escriba un programa en R para encontrar la suma, la media y el producto de un vector.
v<-1:5
sum(v)
prod(v)
mean(v)

#4Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.

v<-c(Na,1:10)
sum(v,na.rm=FALSE)
sum(v)

mean(v,na.rm=TRUE)
prod(v,na.rm=TRUE)

##5Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.
x <- c(34,47,25,14)
order(x)
order(x,decreasing=TRUE)

##6Escriba un programa R para probar si un vector dado contiene un elemento específico.
v<-c(1,2,3,NA,5,6,7,8)
is.na(v)
v==3

#7Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
f<-1:60 #no siempre funciona
max(f-1)
f1<-c(9,2,8,24,345,12,65,74)#(seq funcion para crear un vector numerico con una secuencia)
vector_ordenado_dec<-sort(f1,decreasing=TRUE) #vector_ordenado_dec ordenar los valores)
vector_ordenado_dec[2]

#8Escriba un programa en R para encontrar el enésimo(8vo) valor más alto en un vector dado.
vector_ordenado_dec<- sort(f1,decreasing = TRUE)
vector_ordenado_dec[8]

##9Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.
v1<-iris$Sepal.Length
v1<-iris[,1]
v1<-iris[,"Sepal.Length"]

v2<-iris$Sepal.Width
v2<-iris[,2]
v2<-iris["Sepal.Width"]

v3<-iris$Species
v3<-iris[,"Species"]

class(v1)
class(v2)
class(v3)

##10Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.
x <- c(1, 5)
y <- c(4, 0)
x %in% y
x <- c(4, 5)
y <- c(4, 0)
x %in% y

#11Escriba un programa en R para invertir el orden del vector dado.
x<-1:10
rev(x)

#15Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
v<-seq(6,25,3)
length(v)
dim(v)

#16Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.
i<-1
v[1]>10

#17Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
j<-1:5
j
j_suma3<-j+3
j_suma3

#18Escriba un programa en R para crear un vector usando el operador : y la función seq().
seq(from=0, to=1, length.out=11)

#FACTORES

#1Escriba un programa R para encontrar los niveles de factor de un vector dado.
class(iris$Species)
levels(iris$Species)
f<-factor(c("a","a","b","b","c","c"), levels = c("a","b","c"))
levels(f)
data.frame(medicion1=1:6,f)

#2Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(f)[1]<-levels(iris$Species)[1]
f

#3Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
m<-factor(month.name)
f<-factor(month.name, levels = month.name)
levels(f)

#4Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).
set.seed(123)#valores aleatorias reproducibles
let<-sample(letters,5)
letf<-factor(let)
levels(letf)

#5Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
grupos<-factor(c("G1","G1","G2","G2"))
altura<-c(1.67,1.65,1.68,1.57)
pesos<-c(56,62,68,54)
df<-data.frame(pesos,altura,grupos)
str(df) #entrega la estructura

#MATRICES

#1Escriba un programa en R para crear una matriz en blanco.
m1<-matrix(ncol=2,nrow = 2)
m1

#2Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.
m3<- matrix(1:10,ncol=2,nrow= 5)
m3
m4<- matrix(1:10,2,5)
m4

v1<- seq(5,100,5)
m5<- matrix(1:10,5,2)
m5

#3Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
matriz2<-matrix(1:4,nrow=2,ncol=2)
colnames(matriz2)<-c("columna","columna")
rownames(matriz2)<-c("fila","fila")
matriz2

#4Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.
a<-matrix(1:6,nrow=2,ncol=3)
a
b<-matrix(c(10,8,5,12,3,5), ncol = 3, byrow = TRUE)
b
a+b
a-b
a*b
a/b

#5Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
cor(mtcars)

#6Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
B <- matrix(c(10, 8,5, 12,3,5), ncol = 3, byrow = TRUE)

max(B)
min(B)

#7Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
A<-matrix(1:6,nrow = 2,ncol = 3)
A
B<-matrix(1:12,nrow = 4,ncol = 3)
B
rbind(A,B)