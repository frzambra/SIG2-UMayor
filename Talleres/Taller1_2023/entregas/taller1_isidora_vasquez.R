# Taller 1
#Integrantes: 
#Gaete Alonso
#Vásquez Isidora 
#Fecha: 25-08

##Lo básico
#1.Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.
x <-20:50
x

x1 <- 20:60
mean(x1)

x2 <-(51:61)
sum(x2)

#5.Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
n <- rnorm (1e5,mean = 100,sd=10)
n <- rnorm(1000)
n
length(n)
hist(n)

#6.Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
vectorr<-c(1:6)
vectorr

matrizz<-matrix(1:6, nrow=2)
matrizz

Cantidad<-length(vectorr)

lista<-list( vectorr,matrizz,Cantidad)
lista

#7.Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
j<- matrix(1:20, ncol = 5,nrow = 4)
j

j2<- matrix(letters[1:9], ncol = 3,nrow = 3, byrow = TRUE)
j2
filaetiquetas <- c("Fila1", "Fila2", "Fila3")
columnaetiquetas <- c("Columna1", "Columna2", "Columna3")
rownames(j2) <- filaetiquetas
colnames(j2) <- columnaetiquetas

j3<- matrix(letters[1:4],ncol = 2,nrow = 2, byrow = FALSE)
j3
etiquetascolumnas2 <- c("Columna1", "Columna2")
etiquetasfilas2 <- c("Fila1", "Fila2")
colnames(j3) <- etiquetascolumnas2
rownames(j3) <- etiquetasfilas2

#10.Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
Empleados<- data.frame(genero = c('masculino', 'masculino', 'femenino', 'masculino', 'femenino'), 
                       edad= c(24,56,78,92,10),
                       rut = c ("21186667-5","20810095-5","7429129-5","13077219-6", "11838018-5"), 
                       Direccion = c("Pasaje 19", "Las violetas", "La cascada", "Pasaje G", "Manuel Montt"),
                       Profesion = c("Ingeniera", "Diseñador", "Arquitecto", "Profesor", "Tecnologa medica") )
Empleados


##VECTORES
#1-Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.
p<-1:6
p
length(p)
class(p)

q<-c(1i, 2+1i, 3+1i, 4+1i, 5+1i, 6+1i)
q
length(q)

w<-c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
w
length(w)

z<-c("a", "b", "c" ,"d", "e", "f")
z
length(z)

#2-Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
ñ<- c(1L,2L,3L)
ñ
length(ñ)
class(ñ)
f<- c(4L,5L,6L)
length(f)
(ñ+f)->k 
k
class(k)

#4-Escriba un programa en R para encontrar la suma, la media y el producto de un vector.
mean(k)
sum(k)
prod(k)

#7-Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
k<- c(NA,(ñ+f))
k
sum(k,na.rm=TRUE)
mean(k,na.rm=TRUE)
prod(k,na.rm=TRUE)

#8-Escriba un programa en R para ordenar un Vector en orden ascendente y descendente. 
vector1<- c(5, 2, 9, 1, 7)
sort(vector1)
sort(vector1,decreasing = TRUE )

#9-Escriba un programa R para probar si un vector dado contiene un elemento específico.
vector1==2
7%in% vector1
15 %in%vector1

#10-Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
vector1<- c(5, 2, 9, 1, 7)
sort(vector1,decreasing = TRUE )[2]

#11-Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.
vector2<- c(11,20,17,7,8,47,12,4,9,80)
sort(vector2,decreasing = TRUE )[10]

#12-Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.
vector3<- iris[,1]
vector3

#13-Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.
vector1
vector2
setdiff(vector1,vector2)
setdiff(vector2,vector1)

#14-Escriba un programa en R para invertir el orden del vector dado.
p
rev(p)

#15-Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
h<-23:56
h
length(h)
dim(h)

#16-Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.
ñ > 10

#17-Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
ñ
l<-c(3,3,3)
ñ+l

#18-Escriba un programa en R para crear un vector usando el operador : y la función seq().
c<-47:89
c
b<-seq(from=2,to=100,by=5)
b


##FACTORES
#1-Escriba un programa R para encontrar los niveles de factor de un vector dado.
factor1 <- c('a','a','b','c','c','c')
factor2<- factor(factor1,levels = c('a','b','c')) 
factor2
levels(factor2)


class(iris$Species)
levels(iris$Species)

#2-Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(factor2)[1]<-levels(iris$Species)[1]
factor2

#3-Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
factornames<- c(month.name)
factornames2<- factor(factornames,levels=factornames, ordered = TRUE)
factornames2

#4-Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).
set.seed(123)
let<-sample(letters,5)
let<-factor(let)
let
levels(let)

#5-Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
grupos<-factor(c("G1","G1","G2","G3"))
altura<-c(163,165,168,157)
pesos<-c(56,62,68,54)

df<-data.frame(grupos,altura,pesos)
df
str(df)

#MATRICES
#1.Escriba un programa en R para crear una matriz en blanco.
matriz1<-matrix(ncol=2,nrow = 2)
matriz1

#2.Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

matriz2<-matrix(1:10,ncol=2,nrow=5)
matriz2

#3.Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
matriz3<-matrix(vector2, ncol=2,nrow=5)
matriz3
rownames(matriz3)<-c("A","B","C","D","E")
colnames(matriz3)<-c("AA","BB")

#4.Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.
matriz4 <- matrix(21:26,ncol=3, nrow = 2)
matriz5 <- matrix(12:7,ncol=3, nrow = 2)
matriz4
matriz5
Sumamatriz <- matriz4+matriz5
Sumamatriz

restamatriz<- matriz4-matriz5
restamatriz

multiplicacionmatriz<- matriz4*matriz5
multiplicacionmatriz

divisionmatriz<- matriz4/matriz5
divisionmatriz

#5.Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
matrizcorrelacion<- cor(matriz3)
matrizcorrelacion

#6.Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
matriz3
indicemax <- which(matriz3 == max(matriz3), arr.ind = TRUE)
indicemax

indicemin <- which(matriz3 == min(matriz3), arr.ind = TRUE)
indicemin

#7.Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
matriz7 <- matrix(78:81, nrow = 2)
matriz7
matriz8 <- matrix(33:38, nrow = 3)
matriz8
matrizconcatenada <- rbind(matriz7, matriz8)
matrizconcatenada

##DATAFRAME
#1.Escriba un programa en R para crear un data.frame vacío.
#2.Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
#3.Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
#4.Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
#5.Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
#6.Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
#7.Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
#8.EsCriba un programa R para contar el número de valores NA en una columna de data.frames.
#9.Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame.
#10.Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.



##LISTA
#1.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
#2.Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
#3.Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.
#4.Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
#5.Escriba un programa R para fusionar dos listas dadas en una lista.
#6-Escriba un programa en R para convertir una lista dada en vector.
#7.Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
#8.Escriba un programa R para contar el número de objetos en una lista dada.
#9.Escriba un programa en R para convertir una matriz dada en una lista.
#10.Escriba un programa R para asignar NULL a un elemento de lista dado.
#11.Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
#12.Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.