#Evaluacion 1, tipo 5 Tomás Flores

#1. Cree los siguientes objetos de tipo vector.
exVec1 = c(-34, 16, 38, -19, -40) 
exVec1 

exVec2 = c(-38, 34, 37, -27, -3)
exVec2 

exVec3 = seq(-5, 5, by=0.5)
exVec3 


#2.Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec1 = c(-34, 16, 38, -19, -40) 
exVec2 = c(-38, 34, 37, -27, -3)

exVec_resultado = as.numeric(rbind(exVec1, exVec2))
exVec_resultado


#3. Usando indexación con paréntesis cuadrado devuelva el 3er elemento del vector exVec1. devuelva todo menos el 2do y 3er elemento en exVec2

#tercer elemento vec1
exVec1[3]

#excluir segundo y tercer elemento vec2 
exVec2[c(-2,-3)]


#4. Use funciones u operadores de relación para:

#mostrar la cantidad de elementos de cada uno de los vectores creados arriba.

#vector 1
length(exVec1)

#vector 2
length(exVec2)

#vector 3
length(exVec3)

#vector resultado
length(exVec_resultado)

#determinar la suma de elementos en el vector
sum(exVec1)

#determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
promv2 <- mean(exVec2)
promv2

#calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
promedio <- na.omit(exVec2)
division <- sum(promedio)/length(promedio)
division

#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
promv2==division


#5. Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2) #la funcion rnorm sirve para generar valores aleatorios que siguen una distribucion normal. en este caso se le está pidiendo que sume los 6 valores aleatorios del primer rnorm, con los 2 valores aleatorios del segundo rnorm


#6.Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#integer, conformado por numeros enteros.
nenteros <- c(1,2,3,4,5)
nenteros

#numeric, conformado por numeros reales.
nreales <- c(8, pi, 0.2, 3, 6)
nreales

#logical, conformado por caracteres logicos.
vlogicos <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
vlogicos

#character, conformado por caracteres.
caracteres <- c("r", "python", "java", "c", "swift")
caracteres

#complex, conformado por numeros complejos.
ncomplejos <- c(1+1i,2+2i,3+3i,4+4i,5+5i)
ncomplejos


#7.De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
ej<- list(
  vector = c(TRUE, FALSE, FALSE, TRUE, FALSE),
  matriz = matrix(1:9, nrow = 3),
  data.frame(mtcars))
ej 


#8.Muestre tres formas de indexar la primera columna del data.frame USArrests.

#forma 1
USArrests$Murder       ####revisar si me queda tiempo 

#forma 2
USArrests [c(1)]

#forma 3
USArrests [c("Murder")]


#9.Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
#La diferencia entre los resultados se diferencia en que el codigo 1, nos entrega resultados sin mantener el orden, mientras que drop = FALSE, nos mantiene el orden del objeto, sin embargo el resultado numerico es el mismo.


#10.Haga una union por columna de las matrices m1 y m2.

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m1
m2 <- matrix(1:sample(seq(9,18,3),1),3)
m2

#union de matrices por columnas
cbind(m1,m2)


#11.Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
airquality

#Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Ozone, Temp y Month. Hágalo de dos maneras diferentes.

airquality2 <- aiquality [c(1,4,5)]
airquality2

#PARTE 2

#1.Con el archivo que se encuentra en formato CSV:

#Cargue el archivo en formato CSV en R y asignelo al objeto data
getwd()

data<- read.csv2("datos_ema_309.csv")
data

#De un resumen de la estructura de los datos de data (clase, variables, observaciones).

#clase
class(data)

#variable
typeof(data)

#observaciones (Filas)
nrow(data)

#Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

a <- data$"humed_rel_promedio"
b <- median(a)

d <-subset(data, a >= b)
d
plot(d[1:100,"humed_rel_promedio"])

#2(10pts) Cargue el archivo en R y asígnelo al objeto geo.

install.packages(geo)

#### ME FALTO TIEMPO #####





















