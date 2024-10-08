# Taller 1 
# Fecha: 25 de agosto
# Integrantes:
# Antonio Urquiaga
# Alejandra Perez

# Vectores

#1.-Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 10.

# vector numerico con 10 elementos

V1 <- 1:10

# vector logico con 10 elementos

v2 <- rep(TRUE,10)

# vector tipo caracter

v3 <- c('a','c','o','t','9','i','e','p','n','a')

# vector de tipo complejo

v4 <- c(1+2i,1i,9-3i,4+4i,8-6i,1-9i,3+12i,2i,1i,1+3i)
class(v4)
length(v4)

#2.-Sumar 2 vectores de tipo entero y longitud 5

#vector tipo numerico entero 

#1ra forma

v5 <- c(1L,2L,3L,4L,5L)

#2da forma 

v6 <- 5:1
v6 - as.integer(v6)
class(v6)
length(v6)

#Suma de vectores

v7=v6+v5

#3.-Escriba un programa en R para encontrar la suma, la media y el producto de un vector de 10 elementos.


vv3 <- 1:10
#Suma
sum(vv3)
sum(1:10)
#Promedio
mean(vv3)
#Promedio
sum(vv3) / length(vv3)
#Producto
prod(vv3)

#4.-Calcular la suma, la media y el producto de un vector con 10 elementos y que tenga 3 valores NA, ignore elementos como NA o NaN.

vector1 <- c(1,2,3,NA,5,10,NA,9,10,NA)

#Suma
sum(vector1, na.rm=TRUE)
#media
mean(vector1, na.rm=TRUE)
#producto
prod(vector1, na.rm=TRUE)


#5.-Ordenar un vector con ocho elementos en orden ascendente y descendente.

vector2<-c(4,5,2,3,7,1,3,9,6)

#ascendente

sort(vector2)

#decrecente

sort(vector2,decreasing=TRUE)

#6.-Probar si el vector [1, 2, 5, 25, 35, 32] dado contiene el elemento 5 específico.

vector3<-c(1,2,5,25,35,32)
vector3==5


#7.-Encontrar el segundo valor más alto en un vector numérico dado que contiene 10 elementos.

vector4<-c(3,10,4,25,21,16,9,14,19,5)
B<-sort(vector4,decreasing=TRUE)
B[2]

#8.-Encontrar el enésimo valor más alto en un vector numérico dado que contiene 10 elementos.

n<-6
vector5<-c(5,4,10,32,23,16,18,2,27,7)
Bn<-sort(vector5,decreasing=TRUE)
Bn[n]
