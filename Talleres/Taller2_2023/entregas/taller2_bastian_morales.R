# Bastian Morales

##TALLER2##

#1  Escriba un programa en R para crear un data.frame vacío.

df <- data.frame()
class(df)
df

#2 Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.

v1 <- letters[1:5]
v2 <- month.abb[1:5]
v3 <- c(TRUE, FALSE, FALSE, TRUE,TRUE)
v4 <- 1:5

df2 <- data.frame(letras=v1, meses=v2,logico=v3,numeros=v4)
df2

str(df2)

#3 Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.

df2$meses

df2[ ,'meses']

df2[ ,2]

#4 Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.

df <- iris[1:5,1:5] #crear un data.frame con sub-muestra del data.frame iris con las 5 filas y 5 columnas.
df[c(3,5),c(1,3)]

#5 Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.


df$Species
df[,'Species']
df[,5]

df[-c(2,5),] # para eliminar filas 2 y 5

#6 Escriba un programa en R para agregar una nueva columna en un marco de datos determinado.

iris$nueva_variable <- 1:10
names(iris)
str(iris)

#segunda forma

cbind(iris,nueva_variable=1:150)
names(iris)
str(iris)

#7 Escriba un programa en R para ordenar un data.frame dado por varias columnas.

c1 <- c(3,5,2,6)
c2 <- c('A','B','C','D')
df <- data.frame(c1,c2)

do <- order(df$c1, df$c2)
dor <- df[do,]
print(dor)

#8 Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.

# Crear dos data.frames de ejemplo
df1 <- data.frame(ID = c(1, 2, 3, 4),
                  Nombre = c("Juan", "Maria", "Pedro", "Luis"))

df2 <- data.frame(ID = c(2, 3, 5, 6),
                  Edad = c(30, 25, 40, 35))

# Unión interna 

ui <- merge(df1, df2, by = "ID", all = FALSE)
ui

# Unión externa 

ue <- merge(df1, df2, by = "ID", all = TRUE)
ue

# Unión izquierda
uiz <- merge(df1, df2, by = "ID", all.x = TRUE)
uiz

# Unión derecha
ud <- merge(df1, df2, by = "ID", all.y = TRUE)
ud

#9 Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.

f1 <- c(1,2,NA,4)
f2 <- c(NA,6,9,12)

df <- data.frame(f1,f2)
df[is.na(df)]<- 3
print(df)


#10 Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.

cn <- c('normal','multiplo')
colnames(df) <- cn
print(df)

#11 Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff) 

ID <- c(1,2,3,4,5)
NOMBRE <- c('A','B','C','D','E')

df1 <- data.frame(ID, NOMBRE)


ID <- c(2,4,6)
NOMBRE <- c('E','F','A')

df2 <- data.frame(ID,NOMBRE)

ra <- setdiff(df1$NOMBRE,df2$NOMBRE)
ra


#12 Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
df1
df2

i <- intersect(df1$NOMBRE,df2$NOMBRE)
i

#13 Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)

df1 <- data.frame(N= c(1, 2, 3, 4, 5),
                  Nombre = c("Bastian", "Isidora", "Carlos", "Ana", "Elena"))

df2 <- data.frame(N = c(3, 4, 5, 6, 7),
                  Nombre = c("Carlos", "Ana", "Lettice", "Pedro", "Laura"))

# Encontrar elementos únicos que son comunes a ambos data.frames
ec <- union(df1$Nombre, df2$Nombre)

eu <- function(vec) {
  conteo <- table(vec)
  unicos <- names(conteo[conteo == 1])
  return(unicos)
}

# Encontrar elementos únicos en la lista combinada
edf <- eu(ec)
edf


#14 Escriba un programa R para contar el número de valores NA en una columna de data.frames.

f1 <- c(NA,2,NA,4)
f2 <- c(NA,6,9,12)

df <- data.frame(f1,f2)

ca <- df$f1
sum(is.na(ca))

#15 Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated) 

v1 <- c("A", "B", "C", "A", "D")
v2 <- c(1, 2, 3, 1, 4)

df <- data.frame(Vector1 = v1, Vector2 = v2)

dup <- df[duplicated(df), ] # Encontrar elementos duplicados
dup

un <- df[!duplicated(df), ] # Encontrar filas únicas
un

#16 Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.

data(airquality)
airquality

# Eliminar las variables 'Solar.R' y 'Wind'
airq <- airquality[, !(names(airquality) %in% c('Solar.R', 'Wind'))]
airq

#17 Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)

data(airquality)

# Comprobar si es un marco de datos
if (is.data.frame(airquality)) {
  print("El objeto airquality es un marco de datos.")
} else {
  print("El objeto airquality no es un marco de datos.")
}

# Ordenar el marco de datos por la primera y segunda columna
airquality <- airquality[order(airquality$Month, airquality$Day), ]
airquality


#listas#

#1 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.

v <- c(1, 2, 3)

m <- matrix(4:11, nrow = 2)

sgl<- list("a", "b", "c")

# Crear la lista principal que contiene los elementos anteriores
milista <- list(MiVector = v,
                 MiMatriz = m,
                 MiSegundaLista = sgl)
milista

#2 Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.

primer_elemento <- milista$MiVector # Acceder al primer elemento de la lista (vector)
primer_elemento

# Acceder al segundo elemento de la lista (matriz)
segundo_elemento <- milista$MiMatriz
segundo_elemento

#3 Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.


ne <- "NuevoElemento"
milista <- c(milista, ne)
milista

#4 Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.

lista_anidada <- list(
  elemento1 = c("a", "b", "c"),
  elemento2 = list(1, 2, 3),
  elemento3 = matrix(4:11, nrow = 2)
)

segundo_elemento <- lista_anidada[[2]][[2]]
segundo_elemento

#5 Escriba un programa R para fusionar dos listas dadas en una lista.
l1 <- list(a = 1,b = 2,c = 3)
l2 <- list(d = 4, e = 5, f = 6)

lf <- c(l1, l2)
lf

#6 Escriba un programa en R para convertir una lista dada en vector.

l1 <- list(a = 1,b = 2,c = 3)
vector <-unlist(l1)
vector

#7 Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.

Nombre <- c("Bastian", "Isidora", "Alonso")
Edad <- c(22, 20, 21)

df1 <- data.frame(Nombre=Nombre,Edad=Edad)
df1

Ciudad <-  c("Santiago", "Peñalolen", "PH")
Población <-  c(8537673, 39776830, 2695598)

df2 <- data.frame(Ciudad = Ciudad, Población =  Población )
df2

ldf <- list(df1, df2)
ldf
      
# Acceder a cada data.frame de la lista por su índice
primer <- ldf[[1]]
segundo <- ldf[[2]]
primer
segundo

#8 Escriba un programa R para contar el número de objetos en una lista dada.

l1 <- list(1, "a", TRUE, c(2, 3, 4))

ndo <- length(l1)
ndo

#9 Escriba un programa en R para convertir una matriz dada en una lista.

m <- matrix(1:6, nrow = 2)

l <-  as.list(m)
l

#10 Escriba un programa R para asignar NULL a un elemento de lista dado.

l1 <- list(a = 1,b = "a", c = TRUE, d = c(2, 3, 4))
l1[["b"]] <- NULL
l1

#11 Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.

lm <- letters


lsec <- lm

# Crear la lista con las letras
s <- list(letras = letras_secuencia)

# Mostrar la lista
print(s)

#12 Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.


milista <- list(uno = 1, dos = 2, tres = 3)

# Asignar nuevos nombres a los elementos de la lista
n <- c("a", "b", "c")
names(milista) <- n
milista
n

#13 Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.

milista <- list(vec1 = c(1, 2, 3, 4, 5), vec2 = c("a", "b", "c"))

# Obtener la longitud de los dos primeros vectores
l1 <- length(milista[[1]])
l2 <- length(milista[[2]])
l1
l2

#14 Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)

l1 <- list(a = 1, b = 2, c = 3, d = 4)
l2 <- list(c = 3, d = 4, e = 5, f = 6)

# Encontrar elementos en lista1 que no están en lista2
e <- setdiff(names(l1), names(l2))
e



