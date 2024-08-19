#Taller 1
#Integrantes: Andoni Targarona, Tomás Gougain

#1. LO BASICO

#1) Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.

#secuencia
x<-20:50
x

#media
x1<-20:60
mean(x1)

#suma
x2<-51:91
sum(x2)

#2) Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria.

n<-rnorm(1000)
n
length(n)

#histograma
hist(n)

#3) Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

v<-(1:10)
a<-matrix(v)
f<-sqrt(169)
list(v,a,f)

#4) Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.

#matriz de 5x4
matrix(1:20,nrow = 5,ncol = 4)

#matriz de 3x3
matriz2 <- matrix(1:9,nrow=3,ncol=3,byrow=TRUE)
rownames(matriz2)<-c('x','y','z')
colnames(matriz2)<-c('x','y','z')

print(matriz2)

#matriz de 2x2
matriz3 <- matrix(1:4,nrow=2,ncol=2,byrow=FALSE)
rownames(matriz3)<-c('x','y')
colnames(matriz3)<-c('x','y')

print(matriz3)

#5) Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.

#cantidad de empleados
id <- 1:5

#nombres
nombres <- c('Paula','Valentina','Tomas','Camila','Carlo')

#genero
genero <- c('F','F','M','F','M')

#rut
rut<-c('12.361.445-3','17.212.967-2','21.039.666-k','20.351.519-1','22.452.676-3')

#direccion
direccion<-c('Avenida Cordillera Sur 123, Santiago, Región Metropolitana','Calle Huemul 456, Concepción, Región del Biobío','Pasaje Lago Azul 789, Puerto Montt, Región de Los Lagos','Camino Alerce Milenario 101, Valdivia, Región de Los Ríos','Calle Viñedo Rojo 234, La Serena, Región de Coquimbo')

#profesion
profesion<-c('Promotora','Biologa marina','Boxeador','Tarotista','Gendarme')


df <- data.frame(id,nombres,genero,rut,direccion,profesion)
df

#2. VECTORES

#1) Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.

#vectores numéricos
n<- 1:6
n2<-c(1,7,3,7,9,5)

#vectores lógicos
l<-c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE)
l2<-rep(TRUE,6)
l3<-rep(TRUE,2)
l4<-c(l3,TRUE,FALSE,TRUE)

#complejos
c(1i,2+1i,1i,-1i,3+2i,4-2i)

#vectores caracter
c1<-c('abcd','bcd','cef','ghi','jkl','mno')
c2<-c('abcd','bcd','cef')
c3<-c('ghi','jkl','mno')
c4<-c(c2,c3)
c4

#2) Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.

a<-c(1L,2L,3L)
a1<-c(4L,5L,6L)
a+a1

#3) Escriba un programa en R para encontrar la suma, la media y el producto de un vector.

b<-c(6L,7L,8L)

#suma
sum(b)

#media
mean(b)

#producto
prod(b)

#4) Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.

#vector
v<-c(NA,1:10)

#suma
sum(v,na.rm=TRUE)

#promedio
mean(v,na.rm=TRUE)

#producto
prod(v,na.rm=TRUE)

matrix(nrow=3,ncol=3)

#5) Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.

#orden ascendente
vector1<-c(1,5,7,3,8)
sort(vector1,decreasing = FALSE)

#orden descendente
vector2<-c(3,5,7,8,6,2)
sort(vector2,decreasing = TRUE)

#6) Escriba un programa R para probar si un vector dado contiene un elemento específico.

#vector
vector<-(c(1,2,3,4,5,5,5,6,3,4))

#contiene el elemento
vector==5

#7)Escriba un programa R para encontrar el segundo valor más alto en un vector dado. 

#vector
v1<-c(1,5,6,3,7,35,75,50)

#segundo valor mas alto
sort(v1,decreasing = TRUE)[2]

#8) Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.

#vector
v1<-c(1,5,6,3,7,35,75,50)

#enesimo valor
sort(v1,decreasing = TRUE)[5]
sort(v1,decreasing = TRUE)[3]

#9) Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.

id <- 1:5
nombres <- c('Paula','Valentina','Tomas','Camila','Carlo')
genero <- c('F','F','M','F','M')
rut<-c('12.361.445-3','17.212.967-2','21.039.666-k','20.351.519-1','22.452.676-3')
direccion<-c('Avenida Cordillera Sur 123, Santiago, Región Metropolitana','Calle Huemul 456, Concepción, Región del Biobío','Pasaje Lago Azul 789, Puerto Montt, Región de Los Lagos','Camino Alerce Milenario 101, Valdivia, Región de Los Ríos','Calle Viñedo Rojo 234, La Serena, Región de Coquimbo')
profesion<-c('Promotora','Biologa marina','Boxeador','Tarotista','Gendarme')
df <- data.frame(id,nombres,genero,rut,direccion,profesion)
df

#convertir
v1<-df$profesion
v1
#corroborar 
is.vector(v1)
class(v1)

#10) Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.

v<-c(1,5,10)
v2<-1:10
v
v2

setdiff(v,v2)

#11) Escriba un programa en R para invertir el orden del vector dado.

x<-1:10
rev(x)

#12) Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.

v<-seq(6,25,3)
length(v)
dim(v)

#13) Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE.

v
v[3]>10

#14) Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.

v<-1:5
v
v_suma3<-v+3
v_suma3

#15) Escriba un programa en R para crear un vector usando el operador : y la función seq().

v1<-seq(1:50)
v1

#3. FACTORS

#1) Escriba un programa R para encontrar los niveles de factor de un vector dado.

#vector
vector<-c(1,5,5,5,5,6,7,8,8,8,9)

#factor
f<-as.factor(vector)
f

#comprobar
is.factor(f)

#2) Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.

v<-c(5,5,6,4,8,3,2,2,2,2,5,6,4,4)
f<-as.factor(v)
f

v1<-c(1,1,1,2,2,2,3,3,3,4,4,4)
f1<-as.factor(v1)
f1

levels(f)[1]<-levels(f1)[1]
f
f1

#3) Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.

f<-factor(month.name,levels = month.name)
levels(f)

#4) Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

let<-sample(letters,5)
let
left<-factor(let)
left

#5) Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.

grupos<- factor(c('G1', 'G1','G2','G2'))
altura<- c(1.67, 1.65, 1.68,1.57)
pesos <- c(56,62,68,54)

df<- data.frame(pesos,altura,grupos)
str(df)

#estructura
str(df1)

#3. MATRICES

#1) Escriba un programa en R para crear una matriz en blanco.

m1<-matrix(ncol=2,nrow=2)
m1

#2) Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.

m2<-matrix(1:10,ncol=2,nrow=5)
m2

v1<-seq(5,100,5)

m3<-matrix(v1,5)
m3

#3) Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.

#vector
v<-(1:10)

#matriz
matriz<-matrix(v,nrow=2,ncol=5) 
rownames(matriz)<-c("Fila 1","Fila 2")
colnames(matriz)<-c("Columna 1", "Columna 2","Columna 3", "Columna 4", "Columna 5")
matriz

#4) Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.

#matrices
m1<-matrix(1:6,ncol=3,nrow=2)  
m1

m2<-matrix(1:3,ncol=3,nrow=2)
m2

#suma
m1+m2

#resta
m1-m2

#multiplicacion
m1*m2

#division
m1/m2

#5) Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.

#data frame
edad<-c(20,30,40,50,60) 
ingresos<-c(10000,42000,43000,69000,20000)
gastos<-c(2000,3400,1500,5000,4200)

df2<-data.frame(edad,ingresos,gastos)
df2

#matriz de correlación
matriz_correlacion <- cor(df2)
matriz_correlacion

#6) Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.

#matriz
matriz <- matrix(c(2, 5, 7, 9, 4, 1, 6, 8, 3), nrow = 3, ncol = 3)

#encontrar el índice del valor máximo
indice_max <- which(matriz == max(matriz), arr.ind = TRUE)
fila_max <- indice_max[1]
columna_max <- indice_max[2]

#encontrar el índice del valor mínimo
indice_min <- which(matriz == min(matriz), arr.ind = TRUE)
fila_min <- indice_min[1]
columna_min <- indice_min[2]

#mostrar resultados
cat("Valor máximo:", max(matriz), "\n")
cat("Fila y columna del valor máximo:", fila_max, ",", columna_max, "\n")
cat("Valor mínimo:", min(matriz), "\n")
cat("Fila y columna del valor mínimo:", fila_min, ",", columna_min, "\n")

#7) Escriba un programa R para conectar dos matrices dadas de la misma columna pero filas diferentes.

m1<-matrix(1:6,nrow=2,ncol=3)
m2<-matrix(7:12,nrow=2,ncol=3)

m1
m2

#combinar
matriz_combinada<-rbind(m1,m2);cbind(m1,m2)
matriz_combinada

#---------FIN---------

