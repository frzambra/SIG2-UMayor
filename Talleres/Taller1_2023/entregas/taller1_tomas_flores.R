#SIG AVANZADO-TALLER 1-TOMÁS FLORES.

##1 LO BÁSICO.

print(paste("la secuencia, media y suma de los números corresponde a:"))
#1.1 secuencia de números del 20 al 50.

20:50

#1.2 Media de los números del 20 al 60.

mean(20:60)

#1.3 Suma de los números del 51 al 91.

sum(51:91)

#5 Curva de campana de una distribución normal aleatoria.

print(paste("La curva de camapana de distribución aleatoria normal corresponde a:"))
a <-  rnorm (1e5, mean =100, sd=10)
mean(a)
sd(a)

?rnorm 
length(a)
hist(a)

#6 Lista de elementos usando vectores, matrices, funciones (imprimir contenido de la lista).

print(paste("La lista de elementos corresponde a:"))
b <- list(
  vector = c(1,2,3,4,5),
  matriz = matrix(1:12, nrow = 3),
  función = function(x) x^2)
b

#7 Crear matrices 

#7.1 Matriz de 5x4.   
c <- matrix(NA, nrow=5, ncol=4, byrow=TRUE)
c

#7.2 Matriz de 3x3 con etiquetas ordenada por filas. 
d <- matrix(1:9, nrow =3, ncol=3, byrow=TRUE)
d

#7.3 Matriz de 2x2 con etiquetas ordenada por columnas.
e <- matrix(1:4, nrow =2, ncol= 2)
e

#10 DATA FRAME 5 empleados.
f <- data.frame( 
  género = c("femenino","masculino","masculino","femenino","femenino"), 
  edad = c (20, 30, 40,50,60),
  rut = c ("12345678-9","22345678-9","33345678-9","44445678-9","55555678-9"),
  dirección = c ("calle 1", "calle 2", "calle 3", "calle 4", "calle 5"),
  profesión = c ("topográfa","ingeniero", "doctor","abogada","bióloga"))
f
resumen <- summary(e)
resumen


##2 VECTORES.

#1 Vector númericos, complejos, lógicos y de caracteres de longitud 6.

print(paste("Los vectores de tipo númerico, complejo, lógico y de caracteres son:"))
g <- "númerico"
g <- c(1,2,3,4,5,6)
g

h <-"complejos"
h <- c(1+1i,2+2i,3+3i,4+4i,5+5i,6+6i)
h

i <- "lógicos"
i <- c(TRUE,FALSE,FALSE,TRUE,TRUE,FALSE) 
i

j <- "caracteres"
j <- c("satOri","hémera","gema","odes","sentinel","landsat")
j

#2 Suma de dos vectores de tipo entero (longitud 3).

k <- c(2,4,6)
l <- c(2,4,6)
suma <- k + l
print(paste("La suma de ambos vectores es:"))

#4 Suma, media y producto de un vector.

print(paste("La suma, media y producto de un vector corresponden a:"))
m <- c(2,2,2)
#Suma.
sum(m)
#Media.
mean(m)
#Producto.
prod(m)

#7 Suma, media y producto de un vector (ignore elementos NA).

print(paste("La suma, media y producto de un vector ignorando elementos NA corresponde a:"))
n <- c(NA, 2, 2, NA, 1, NA)
ñ <- n[!is.na(n)&!is.na(n)]
#Suma.
sum(ñ)
#Media.
mean(ñ)
#Producto.
prod(ñ)

#8 Ordenar un vector en orden ascendente y descendente.

print(paste("El orden de los vectores de manera ascendente y descendente corresponde a:"))
o <- c(20,10,40,30,80,60)
print(paste("Los ordenes corresponden a:"))
#Ascendente.
sort(o)
#Descendente.
sort(o,decreasing = TRUE)

#9 Vector dado contiene un elemento específico.

p <- c(1,2,3,4,5,6)
# Elemento buscado.
q <- 4
#Verificar si contiene elemento.
r <- q %in% p
print(paste("El vector dado contiene el elemento específico:", r))

#10 Segundo valor más alto dentro de un vector dado.

s <- c(100,500,300,200,400,600)
#Segundo valor más alto
t <- max(s[s!=max(s)])
print(paste("El segundo valor más alto es:", t))

#11 Enésimo valor más alto dentro de un vector dado.

u <- c(200,300,100,400,120,500)
#Valor de v.
v <- 4
#Enésimo más alto.
w <- sort(u,decreasing = TRUE)
x <- w[v]
print(paste("El enésimo valor más alto es:", x))

#12 Convertir columnas dadas de un data frame a un vector. PREGUNTAR PROFE POR EL ERROR 

y <- data.frame(
  comuna = c("Providencia", "Las condes", "Santiago", "Huechuraba"),
  habitantes = c(1000,600,1300,1500), 
  bebés = c(190,80,300,200))
#Habitantes a vector.

z <- y$habitantes

#13 Vector dado que no está en otro vector. **********

a1<- c(1,50,100) 
a2 <- 1:10
a1 
a2
setdiff(a1,a2)

#14 Invertir el orden del vector dado.

b1 <- c(1,2,3,4,5,6)
rev(b1)

#15 Encuentre la longitud y dimensión del vector.

c1 <- c(1,2,3,4,5,6)
c2 <- matrix(c1)
length(c1)
dim(c2)

#16 Probar si el valor del elemento de un vector dado es mayor que 10 o no. (Devuelve TRUE o FALSE)

d1 <- c(6,19,4,32,2,190)
d2 <- d1>10 
d2

#17 Sumar 3 a cada elemento en un vector dado (imprimir vector original y nuevo)

e1 <- 1:15
e1
e2 <- e1+3
e2

#18 Crear un vector usando el operador : y la función seq().

#:
f1 <- 1:10
f1
#Seq
f2 <-seq(1:10)
f2


##3 FACTORS.

#1 Encontrar niveles de factor de un vector dado.

g1<-iris$Species 
class(g1)
levels(g1)
g2 <-factor(c("a","a","c","c","e","b"), levels = c("a","b","c"))
levels(g2)

g3 <- data.frame(medicion1= 1:6,g2) 
g3

#2 Cambiar el primer nivel de un factor con otro nivel de un factor dado.

levels(g2)[1] <- levels(iris$Species)[1]
g2

#3 Factor ordenado a partir de datos que consisten en los nombres de los meses.

factor(month.name)
h1 <- factor(month.name,levels = month.name)
levels(h1)

#4 Extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).

set.seed(123)
i1 <-sample(letters,5)
i2 <-factor(i1)
levels(i2)

#5 Factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.

grupos <- factor(c("g1","g2","g1","g2")) 
alturas <- c(1.81,1.55,1.63,1.69)
pesos<- c(85,64,75,65)
j1<-data.frame(pesos,alturas,grupos)
str(j1)


##4 MATRICES.

#1 Matriz en blanco.

k1 <- matrix(2,2)
k1

#2 Matriz tomando como entrada un vector dado de números (mostrar matriz).

l1 <-matrix(1:10,ncol=2, nrow = 5) 
l1

#3 Matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila (mostrar matriz).

cor(mtcars)

#4 Matriz de 2x3 (suma, resta, multiplicación y división de las matrices).

m1 <- matrix(c(1,2,3,4,5,6), 2,3)
m2 <- matrix(c(6,5,4,3,2,1), 2,3)
m1
m2
#Suma
m3 <-m1+m2
m3
#Resta
m4 <-m1-m2
m4
#Multiplicación
m5 <-m1*m2
m5
#División
m6 <-m1/m2
m6

#5 Matriz de correlación a partir de un data.frame del mismo tipo de datos. ***

n1 <- data.frame(
  Año = c(10, 15, 20, 25, 30, 35),
  dia = c(2,4,6,8,10,12),
  hora = c(1, 2, 3, 4, 5, 6)
)
#Matriz de correlación

n2 <- cor(n1)
n2

#6 índice de fila y columna de valor máximo y mínimo en una matriz dada.

ñ1 <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)

# Índice del valor máximo
ñ2 <- which.max(ñ1)
ñ2
# Índice del valor mínimo
ñ3 <- which.min(ñ2)
ñ3
# Convertir el índice en fila y columna
ñ4 <- (ñ2 - 1) %/% ncol(ñ1) + 1
ñ5 <- (ñ2 - 1) %% ncol(ñ1) + 1
ñ6 <- (ñ3 - 1) %/% ncol(ñ1) + 1
columna_minimo <- (ñ3 - 1) %% ncol(ñ1) + 1
ñ1

#7 Concatenar dos matrices dadas por la misma columna pero diferentes filas

#Sin concatenar
cat("u3:\n")
u3
cat("u4:\n")
u4
#Concatenada
u3 <- matrix(5:6, ncol = 1)
u4 <- matrix(7:8, ncol = 1)
u5<- cbind(u3, u4) 
u5

#TERMINAR MATRICES

##5 DATA.FRAME

#1 Data frame vacío 

o1 <-data.frame()
o1

#2 Data.frame a partir de 4 vectores dados.

  nombre <- c("Elisa","Loreto","Miguel","javier")
  ciudad <- c("Santiago","Valparaíso","Rancagua","Osorno")
  edad <- c(14,34,45,23)
  peso <- c(85,77,69,93)
p1 <-data.frame(Nombre = nombre, Ciudad = ciudad, Edad = edad, Peso = peso)
p1

#3 Extraer una columna específica de un data.frame usando el nombre de la columna.

q1 <-data.frame(
  año <-c(10,20,30,40,50,60),
  mes <-c(01,02,03,04,05,06),
  hora <-c(13,14,15,16,17,18))
q2 <- q1$mes
q2

#4 Extraer filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

r1 <-data.frame(
  nombre =c("Jorge","Andres","Matias","Juan","Sergio"),
  edad =c(20,24,27,28,30),
  Empresa =c("Enel","Copec","Shell","Apple","Lenovo"))
  
r2 <- r1[c(3,5), c(1,3)]
r2

#5 Eliminar las columnas por nombre de un data.frame dado.

s1 <-data.frame(
  año =c(10,20,30,40,50,60),
  mes =c(01,02,03,04,05,06),
  hora =c(13,14,15,16,17,18))
s1 <-s1[,!names(s1) %in% "año"]
s1

#6 Uniones internas, externas, izquierdas y derechas a partir de dos data.frames dados.

#Unón interna.

t1 <-data.frame(edad = c(20,30,40,50),
                Sexo = c("Masculino","Femenino","Masculino","Masculino"))

t2 <-data.frame(edad = c(15,25,35,45),
                comuna = c("Santiago","Pudahuel","Maipu","La reina"))
t3 <-merge(t1, t2, by ="edad")
t3

#Unión externa.

t4 <-data.frame(edad = c(20,30,40,50),
                Sexo = c("Masculino","Femenino","Masculino","Masculino"))

t5 <-data.frame(edad = c(15,25,35,45),
                comuna = c("Santiago","Pudahuel","Maipu","La reina"))
t6 <-merge(t4, t5, by ="edad", all = TRUE) 
t6

#Unión izquierda.

t7 <-data.frame(edad = c(20,30,40,50),
                Sexo = c("Masculino","Femenino","Masculino","Masculino"))

t8 <-data.frame(edad = c(15,25,35,45),
                comuna = c("Santiago","Pudahuel","Maipu","La reina"))

t9 <-merge(t7, t8, by = "edad", all.x = TRUE)
t9

#Unión derecha.

t10  <-data.frame(edad = c(20,30,40,50),
                Sexo = c("Masculino","Femenino","Masculino","Masculino"))

t11 <-data.frame(edad = c(15,25,35,45),
                comuna = c("Santiago","Pudahuel","Maipu","La reina"))
t12 <-merge(t10, t11, by ="edad", all.y = TRUE)
t12

#7 Reemplazar los valores de NA con 3 en un data.frame dado.

u1 <- data.frame(A = c(NA,6,9,3),
                 B = c(NA,9,9,NA),
                 C = c(6,NA,6,9))

u1[is.na(u1)] <- 3
u1

#8 Contar el número de valores NA en una columna de data.frames

v1 <- data.frame(A = c(NA,6,9,3),
                 B = c(NA,9,9,NA),
                 C = c(6,NA,6,9))
v2 <- sum(is.na(v1$B))
v2

#9 Data.frame utilizando dos vectores dados mostrando los elementos duplicados y las filas únicas de dicho data.frame.

w1 <- c("Jorge","Mateo","Simón","Javier")
w2 <- c("Fuenzalida","Torrealba","Medel","Javier")

w3 <- data.frame(nombre =w1, apellido = w2)
w3

#Elementos duplicados

w4 <- w3[duplicated(w3),]
w4

#Filas únicas.

w5 <- w3[!duplicated(w3), ]
w5

#10 Conjunto de datos (incorporado) airquality. (Eliminar variables "Solar.R" y "Wid" y mostrar data.frame)

data("airquality")
x1 <- airquality[,!(names(airquality) %in% c("Solar.R", "Wind"))]
x1


## LISTAS 

#1 Lista con un vector, matriz y lista que asigne nombres a los elementos de la lista.

y1 <- c(1,2,3)
y2 <- matrix(5:10, nrow = 2)
y3 <- list(a = "queso", b = "betarraga", c = "eneldo")
y4 <- list(vector = y1, matriz = y2, lista = y3)
names(y4) <- c("Vector","Matriz","Lista")
y4

#2  Lista con un vector, matriz y lista que asigne nombres a los elementos de la lista (acceder al primer y segundo elemento de la lista).

z1 <- c(1,2,3)
z2 <- matrix(5:10, nrow = 2)
z3 <- list(a = "queso", b = "betarraga", c = "eneldo")
z4 <- list(vector = z1, matriz = z2, lista = z3)
names(z4) <- c("vector",",matriz","lista")
z4
#Primer elemento.
z5 <-z4[[1]]
z5
#Segundo elemento.
z6 <- z3$vector
z6

#3 Lista con un vector, matriz y una lista (agregar un elemento al final de la lista).

a10 <- c(1,2,3)
a11 <- matrix(5:10, nrow = 2)
a12 <- list(a = "queso", b = "betarraga", c = "eneldo")
a13 <- list(vector = a10, matriz = a11, lista = a12)
names(a13) <- c("vector",",matriz","lista")
a13
a14 <-"tomillo"
a15<- c(a13, a14)
a15

#4 Seleccionar el segundo elemento de una lista anidad determinada.

b10 <- list(
  A = "Elemento 1",
  B = list( 
  C = "Elemento 1 lista 2",
  D = "Elemento 2 lista 2"),
  E = "Elemento 2"
)
b10
b11 <- b10[[2]] 
b11

#5 Fusionar dos listas dadas en una lista

c10 <- list(a = 1, b = 2)
c11 <- list(c = 4, d = 3) 
c12 <- c(c10, c11)
c12

#6 Lista dada a vector.

d10 <- list(a = 1, b = 2, c = 3)
d11 <- unlist(d10)
d11

#7 Lista de data.frames (acceder a cada uno de los data.frames de la lista).

z10 <- data.frame(rol = 1:3, Municipalidad = c("Santiago", "Rengo", "Petorca"))
z11 <- data.frame(rol = 4:6, Municipalidad = c("San miguel", "Talca", "Curacaví"))
z12 <- list(Df1 =z10, Df2 = z11)
z13 <- z12$Df1
z13
z14 <- z12$Df2
z14



#8 Contar el número de objetos en una lista dada.

e10 <- list(1,"ab",2,"cd",3,"as")
e11 <-length(e10) 
e11

#9 Convertir una matriz dada a una lista.

f10 <- matrix(2:6, nrow = 5)
f11 <- as.list(f10) 
f11

#10 Asignar Null a un elemento de lista dado.

g10 <- list(A =1,B = 2, C = 3,"as")
g10$A <- NULL
g10

#11 Asignar nuevos nombres a,b y c a los elementos de una lista dada.

h10 <- list(1,"ab",2)
names(h10) <- c("a","b","c")
h10

#12 Longitud de los dos primeros vectores de una lista dada.

i10 <- list (
  vec1 = c (1,2,3,4),
  vec2 = c ("avion","auto","barco"))
#Longitud
i11 <- length(i10[[1]])
i11
i12 <- length(i10[[2]])
i12

#TRABAJO FINALIZADO!