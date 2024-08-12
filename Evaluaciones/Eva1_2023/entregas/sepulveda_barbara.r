#integrante:Barbara sepulveda
#prueba parcial 1


#1.-Cree los siguientes objetos de tipo vector
#exVec1 con los números: 4, -45, -4, -31, -32
#exVec2 con los números: 21, 4, 17, 43, 12
#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)


exVec1 <- c(4,-45,-4,-31,-32)
exVec2 <- c(21,4,17,43,12)
exVec3 <- seq(from=-5,to=5,by=0.5)           


#2.-Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- c(exVec1,exVec2)
exVec_resultado

#3.- Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2
exVec1
exVec1[3]
exVec2
exVec2[c(-2,-3)]


#4.-Use funciones u operadores de relación para:
#mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)

#determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)

res1 <- mean(exVec2,na.rm = TRUE)


#calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

b <- na.omit(exVec2)
res2 <- sum(b)/length(b)

#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
res1 == res2
identical(res1,res2)
#5.-Explique que hace la siguiente operación e indique ¿por qué? 
rnorm(6) + rnorm(2)
# rnorm es una funion la cual genera valores aleatorios acorde a los parámetros indicados,es estandarizada,de distribucion normal, en este caso

#6.-cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#Vector numérico:Los vectores numéricos contienen números reales o enteros. Pueden ser creados utilizando la función c() (concatenate) o generados mediante secuencias.ejemplo:
v <- c(1, 2, 3, 4, 5)

#Vector de caracteres:Los vectores de caracteres contienen cadenas de texto. Puedes crearlos utilizando comillas simples o dobles. Aquí tienes un ejemplo:
nombres <- c("claudia", "barbara", "constanza", "trinidad")

#Vector lógico:Los vectores lógicos contienen valores TRUE o FALSE, que se utilizan comúnmente para realizar operaciones lógicas. Aquí tienes un ejemplo:
condiciones <- c(TRUE, FALSE, TRUE, FALSE, TRUE)

#Vector integer:
Este es el modo de representar los números enteros en R
#Vector double:

#Vector complex:Los vectores complejos contienen números complejos. Puedes crearlos utilizando la función complex(). Aquí tienes un ejemplo:

complejos <- complex(real = c(1, 2, 3), imaginary = c(4, 5, 6))




#7.-De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

vector_logico <- c(TRUE, FALSE, TRUE, FALSE, TRUE)


matriz <- matrix(1:9, nrow = 3)


mi_lista <- list(vector_logico, matriz, mtcars)


mi_lista

#8.-Muestre tres formas de indexar la primera columna del data.frame USArrests

#9.-Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]


#10.-Haga una union por por columna de las matrices m1 y m2
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
rbind(m1,m2)

#11.-Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:
#Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.
#forma1

#Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
mtcars2$nueva_col <- 1:nrow(mtcars2)
#Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.

mtcars3 <- mtcars[c(10, 12, 20, 1, 2),]

#Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21

#12.-De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

#13.-Para los siguientes ejercicios utilice el data.frame mtcars
#Use funciones para mostrar: 
#la estructura del set de datos 
str(mtcars)
#el número de columnas y de filas del set de datos
ncol(mtcars)
#el nombre de las columnas del set de datos
colnames(mtcars)
#el encabezado del set de datos
head(mtcars)
#los últimos seis elementos del set de datos
tail(mtcars)

#PARTE 2

#1.-Con el archivo que se encuentra en formato CSV :
#Cargue el archivo en formato CSV en R y asignelo al objeto data
read.csv("data/datos_ema_126.csv")
data <- read.csv ("data/datos_ema_126.csv")

#De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)
#Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
data$humed_rel_promedio
mean(data$hum)
#Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

#Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.



