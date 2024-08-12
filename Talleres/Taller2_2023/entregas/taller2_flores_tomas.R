##3.1 DATA.FRAME

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

#6 Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.
l1 <- data.frame(Ciudad = c("Santiago", "Buenos aires", "Florencia"),
                    Habitantes = c(1000, 3000, 4000))

l2 <- c("Chile", "Argentina", "Italia")
l3 <- cbind(l1, l2)

colnames(l3)[3] <- "Naciones"

l3

#7 Ordenar un data.frame dado por varias columnas

j1  <-data.frame(
  año =c(10,20,30,40,50,60),
  mes =c(01,02,03,04,05,06),
  hora =c(13,14,15,16,17,18))
j2 <- order(j1$año, j1$mes, j1$hora)
j3 <-j1[j2, ]
j3

#8 Uniones internas, externas, izquierdas y derechas a partir de dos data.frames dados.

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

#9 Reemplazar los valores de NA con 3 en un data.frame dado.

u1 <- data.frame(A = c(NA,6,9,3),
                 B = c(NA,9,9,NA),
                 C = c(6,NA,6,9))

u1[is.na(u1)] <- 3
u1

#10 cambiar más de un nombre de columna de un data.frame dado.

i1 <-data.frame(
  edad = c(10,20,30),
  kg = c (35, 65, 85))
i1$años <- i1$edad
i1$peso <- i1$kg
i1 <- i1 [, c("años", "peso")]
i1

#11 Data.frame para encontrar filas en el primer data.frame que no están en el segundo (setdiff)

o1 <- data.frame(
    año = c(1, 2, 3, 4, 5),
    mes = c("Septimbre", "Octubre", "Noviembre", "Diciembre", "Marzo")
  )

o2 <- data.frame(
  año = c(1, 5, 6),
  mes = c("Septiembre", "Noviembre", "Octubre")
)

o3 <- setdiff(o1, o2)
o3

#12 Elementos que están presentes

q1 <- data.frame(
  año = c(1, 2, 3, 4, 5),
  mes = c("Septimbre", "Octubre", "Noviembre", "Diciembre", "Marzo"))
q2 <- data.frame(
  año = c(1, 5, 6),
  mes = c("Septiembre", "Noviembre", "Octubre"))
q3 <- intersect(q1$año, q2$año)
q3

#13 Elementos que vienen solo una vez y comunes en ambos (union)

k1 <- data.frame(
  año = c(1,2, 3, 4, 5),
  mes = c("Septimbre", "Octubre", "Noviembre", "Diciembre", "Marzo"))
k2 <- data.frame(
  año = c(1,5, 6),
  mes = c("Septiembre", "Noviembre", "Octubre"))
#Elementos comunes en ambos data.frames
k3 <- intersect(q1$año, q2$año)
k3
#Unión
k4 <- union(q1$año, q2$año)
#Frecuencia 
k5 <- table(k4)
#Elemento que aparecen 1 vez
k6 <- names(k5[k5 == 1)
#elementos comunes que aparecen solo una vez
k7 <- intersect(k3,k6)
k7

#14 Contar el número de valores NA en un data.frame

v1 <- data.frame(A = c(NA,6,9,3),
                 B = c(NA,9,9,NA),
                 C = c(6,NA,6,9))
v2 <- sum(is.na(v1$B))
v2

#15 Data.frame utilizando dos vectores dados mostrando los elementos duplicados y las filas únicas de dicho data.frame.

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

#16 Conjunto de datos (incorporado) airquality. (Eliminar variables "Solar.R" y "Wind" y mostrar data.frame)

data("airquality")
x1 <- airquality[,!(names(airquality) %in% c("Solar.R", "Wind"))]
x1

#17conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. 

data(airquality)

if (is.data.frame(airquality)) {
  print("airquality es un marco de datos.")
} else {
  print("airquality no es un marco de datos.")}

airquality_ordenado <- airquality[order(airquality$Month, airquality$Day), ]

head(airquality_ordenado)


#3.1 LISTAS

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

#11 Crear una secuencia de letras mayúsculas comenzando desde "E"

#  secuencia de letras mayúsculas
letras <- LETTERS
# letras desde "E" hasta "Z"
s <- letras[5:26]
(s)

#12 Asignar nuevos nombres a,b y c a los elementos de una lista dada.

h10 <- list(1,"ab",2)
names(h10) <- c("a","b","c")
h10

#13 Longitud de los dos primeros vectores de una lista dada.

i10 <- list (
  vec1 = c (1,2,3,4),
  vec2 = c ("avion","auto","barco"))
#Longitud
i11 <- length(i10[[1]])
i11
i12 <- length(i10[[2]])
i12

#14 elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

# Definir las dos listas
m1 <- c(10, 20, 30, 40, 50)
m2 <- c(31, 20, 51, 50, 71)

m4 <- setdiff(m1, m2)
m4

#TALLER 2 FINALIZADO

