#Taller 1 (30.08.23)
#Integrantes : Belén Urrea 

################################## 1 B A S I C O ######################################## 
#Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.

20:50
x <- 20:60
mean(x)
sum(51:91)

#5 Escriba un programa Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
help(rnorm)

n <- rnorm(1000, mean = 100, sd = 10)
hist(n)

#6 Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

l <- list(1:4, matrix(ncol = 2, nrow =2, byrow = TRUE), sum(x))
l

#7 Escriba un programa en R para crear una matriz de 5 x 4 (filasXcolumnas), una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.

m <- matrix(ncol = 4, nrow =5, byrow = TRUE)
m
m2 <- matrix(letters, ncol = 3, nrow = 3)
m2
m3 <- matrix(letters, ncol = 2, nrow = 2, byrow = TRUE)
m3

#10. Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
gen <- c("Femenino", "Masculino", "Femenino", "Masculino", "Femenino")
gen
edad <- c(22, 23, 25, 27, 29)
edad
rut <- c("20.358.677-9", "16.525.375-2","18.494.629-0", "19.994.327-8", "13.311.122-0")
rut

dir <- c("Francisco Cortes 146", "Aves del Paraiso 69", "Av. Pajaritos 9922", "Las madreselvas 960", "Ing. Pedro Gallo 555")
prof <- c("Cantante", "Profesor", "Pintora", "Ingeniero Comercial", "Informatica")
df <- data.frame(gen, edad, rut, dir, prof)
df







########################### V E C T O R E S #################################
#1 Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.
cn <- c(1,2,3,4,5,6)
c1 <- c('abcd', 'bcd','cef', 'ghi', 'jkl', 'mno')
clo <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)

# 2 Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
j <- c(1, 2, 3)
j1 <- c(4,5,6)
  
  sum(j, j1)

#4 Escriba un programa en R para encontrar la suma, la media y el producto de un vector.
v <- 1:5  
  sum(v)
  mean(v)
  prod(v)


#7 Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.

v <- c(NA, 1:10)
sum(v,na.rm = TRUE)
mean(v, na.rm = TRUE)
prod(v, na.rm = TRUE)

#8 Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.
Vector_ordenar <- c(9, 20, 29, 19, 21)
Vector_ordenar2 <- sort(Vector_ordenar, decreasing = TRUE)
Vector_ordenar2

Vector_ordenar3 <- sort(Vector_ordenar, decreasing = FALSE)
Vector_ordenar3

#9Escriba un programa R para probar si un vector dado contiene un elemento específico.
Vector_ordenar == 9

#10.Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
#Hay dos formas de hacerlo, una mas complicada y otra mas corta y facil, que seria el segundo ejemplo del ejercicio. 
Vector_ordenar
t <- max(Vector_ordenar[Vector_ordenar!= max(Vector_ordenar)])
t

f <-  seq(1,100,10)
f
sort(f, decreasing = TRUE)
sort(f, decreasing = TRUE)[2]


#11.Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.
f <-  seq(1,100,10)
sort(f, decreasing = TRUE)[5]


#12. Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.
#Un data frame que ya está en el programa, el cual se puede extraer de estas tres formas
head(iris)
V1 <- iris$Sepal.Length
V1

V1 <- iris[ ,1]
V1 <- iris[, 'Sepal.length']



#13.Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.
B01 <- c(2,9,19,22,24,30)
B02 <- c(4,7,9,17,21,22)

setdiff(B01, B02)
setdiff(B02, B01)
#La funcion setdiff te ayuda a encontrar que elementos del vector B01 no se encuentran en el vector B02 y viceversa....


#14. Escriba un programa en R para invertir el orden del vector dado.
y <- 1:20
rev(y)

#15.Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
Y2 <- seq(6,25,3)
length(Y2)
dim(Y2)

#Los vectores no tienen dimension!!!!

 
#16.Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no.Devuelve TRUE o FALSE.
U <- 3
v[U] > 10


#17 Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
O <- 1:5
O
O_suma3 <- O + 3
O_suma3


#18 Escriba un programa en R para crear un vector usando el operador : y la función seq().
Operador_1 <- 1:100
Operador_2 <- seq(10:90)
Operador_1
Operador_2




############################ F A C T O R E S #############################
#1Escriba programa R para encontrar los niveles de factor de un vector dado. 
iris

f1 <- iris$Species
f1

class(iris$Species)
levels(iris$Species)

class(f1)
levels(f1)

   
Fesp<- factor(c('a', 'a', 'b', 'b', 'c', 'c') , 
              levels = c('a', 'b', 'c'))
Fesp
levels(Fesp)
Desp <- data.frame(medicion1= 1:6, Fesp)
Desp


#2Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(Fesp)[1] <- levels(iris$Species)[1]
Fesp


#3Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
MO <- month.name
FO <- factor(month.name, levels = month.name)
levels(FO)
 
#4Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

set.seed(123)

let <- sample(letters, 5)
letf <- factor(let)
letf
levels(letf)


#5. Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
grupos <-  factor(c('G1', 'G1', 'G2', 'G3'))
altura <- c(167, 165, 168,157)
pesos <- c(56,62,68,54)

Dgirl <- data.frame(grupos, altura, pesos)
Dgirl
str(Dgirl)









############################# M A T R I C E S ###############################
#Escriba un programa en R para crear una matriz en blanco.
mblanc <- matrix(ncol = 2, nrow = 2, byrow= FALSE)
mblanc

#2.Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.
M <- c(10:15)
MA <- matrix(M, ncol = 2, nrow = 3, byrow = FALSE)
MA

#Ej 2 
Vej <- seq(5, 100,5)


#3.Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
F <- c(15:20)
F
FC <- matrix(F,ncol = 2, nrow = 3, byrow = TRUE)
rownames(FC) <- c("Fila 1", "Fila 2", "Fila 3") 
colnames(FC) <- c("Columna 1", "Columna 2") 
FC

#4.Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.
M2_3 <- matrix(1:6, ncol=3, nrow = 2, byrow = TRUE)
M2_3

M3_2 <- matrix(6:11, ncol=3, nrow = 2, byrow = TRUE)
M3_2
sum(M2_3, M3_2)

M2_3 + M3_2
M2_3 - M3_2
M2_3 * M3_2
M2_3 / M3_2

#5. Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
#se usa mtcars ya que es una matriz del mismo tipo de dato...despues solo queda aplicar la funcion de correlacion
cor(mtcars)


#6. Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
MT <- matrix(1:6, ncol=2, nrow = 3, byrow = TRUE)
MT

MT2 <- matrix(6:11, ncol=2, nrow = 3, byrow = TRUE)
MT2


DI_VEC <- c(9,7,6,10,20,21,27,30,32,25)
Di_mat <- matrix(data = DI_VEC, nrow = 4, ncol = 5)


Di_mat_max <- max(Di_mat)

Di_log_max <- Di_mat == Di_mat_max
Di_rowcol_max <- which(Di_log_max,arr.ind= TRUE)

Di_mat_min <- min(Di_mat)
Di_log_min <- Di_mat== Di_mat_min
Di_rowcol_min <- which(Di_log_min, arr.ind = TRUE)




#7.Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
M01 <- c(1:6)
M01
M1 <- matrix(M01, ncol = 3, nrow = 2, byrow = TRUE)
M1

M02 <- C(6:11)
M2 <- matrix(M02, ncol = 3, nrow = 4, byrow = TRUE)
M2

rbind(M1, M2)


