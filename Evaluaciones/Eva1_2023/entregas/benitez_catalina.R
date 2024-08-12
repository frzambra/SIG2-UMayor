#               EVALUACIÓN 1

#     PARTE 1: Estructura y manipulación de datos en R

#1-.(5pts) Cree los siguientes objetos de tipo vector:

exVec1 <- c(-10,-17,17,-28,21)
exVec2 <- c(13,-26,-48,16,34)
exVec3 <- seq(from=-5,to=5,by=0.5)




#2-.(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

(exVec_resultadoo <- c(exVec1,exVec2))




#3-.(5pts) Usando indexación con paréntesis cuadrado:}

    #devuelva el 3er elemento del vector exVec1
exVec1[3]

    #devuelva todo menos el 2do y 3er elemento en exVec2
exVec2[-c(2,3)]




#4-.(15pts) Use funciones u operadores de relación para:
   
    #(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultadoo)

    #(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

    #(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
mean(exVec2,na.rm=TRUE)

    #(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
na.omit(sum(exVec2)/length(exVec2))

    #(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

calculo1 <- mean(exVec2,na.rm=TRUE) #Cálculo del punto 3
calculo2 <- na.omit(sum(exVec2)/length(exVec2)) #Cálculo del punto 4
calculo1 == calculo2




#5-.(10pts) Explique que hace la siguiente operación e indique ¿por qué?

rnorm(6) + rnorm(2)

#rnorm es una función que genera valores aleatorios dentro de una distribución normal estandarizada. El primer argumento de aquella función es "n" o el número de observaciones (valores aleatorios) a los que se les desea asignar una distribución normal. Por lo tanto, al escribir "rnorm(6)" y "rnorm(2)", se está indicando que se desean distribuir 6 observaciones y 2 observaciones, respectivamente. Ahora bien, al escribir "rnorm(6) + rnorm(2)", se indica que se sumen las observaciones contenidas dentro de cada distribución. La suma se realiza elemento a elemento, sin embargo, las expresiones no tienen la misma cantidad de obervaciones. Lo que ocurre finalmente es que la distribución normal con la menor cantidad de observaciones (es decir, "rnorm(2)") se recicla o bien se repite de modo que abarque la cantidad de observaciones de "rnorm(6)", debido a que R tiene la característica de reciclar vectores. Esto es:

#el elemento 1 de "rnorm(6)" se suma con el elemento 1 de "rnorm(2)"
#el elemento 2 de "rnorm(6)" se suma con el elemento 2 de "rnorm(2)"
#el elemento 3 de "rnorm(6)" se suma con el elemento 1 de "rnorm(2)"
#el elemento 4 de "rnorm(6)" se suma con el elemento 2 de "rnorm(2)"
#el elemento 5 de "rnorm(6)" se suma con el elemento 1 de "rnorm(2)"
#el elemento 6 de "rnorm(6)" se suma con el elemento 2 de "rnorm(2)"


#6-.(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#Los vectores se clasifican en dos grandes categorías: Vectores atómicos (o también Vectores homogéneos) y Vectores heterogéneos.

#Por un lado, los vectores atómicos se caracterizan por contener elementos de la misma clase. Los vectores atómicos con los que hemos trabajado en clase son los siguientes:

vec1 <- c(1.0,2.1,3.5,4.0)  #Vector numeric, de tipo double
class(vec1)
typeof(vec1)

vec2 <- c(1L,2L,3L,4L) #Vector numeric, de tipo integer
class(vec2)
typeof(vec2)

vec3 <- c(TRUE,FALSE,FALSE,TRUE) #Vector logical
class(vec3)

vec4 <- c("Chile","Argentina","España") #Vector character
class(vec4)

vec5 <- c(1i+20,3i-9,8i-2) #Vector complex
class(vec5)

#Por otro lado, los vectores heterogéneos se caracterizan por la capacidad de contener elementos de distinta clase. Un vector con esa cualidad es la lista:

#Lista
lis6 <- list(vec1,vec2,vec3,vec4,vec5)
class(lis6)
class(lis6[[1]])
class(lis6[[2]])
class(lis6[[3]])
class(lis6[[4]])
class(lis6[[5]])
#Contiene elementos de diferente clase

#7-.(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

#Creación de vector lógico y matriz 3x3
v7 <- c(TRUE,FALSE,TRUE)
m7 <- matrix(1:9,nrow=3,ncol=3)

#Creación de lista
(lis7 <- list(v7,m7,mtcars))


#8-.(15 pts) Muestre tres formas de indexar la primera columna del data.frame mtcars

#Forma 1
mtcars[,1]

#Forma 2
mtcars[,'mpg']

#Forma 3
mtcars$mpg

#NOTA: En las tres formas no se mantiene la estructura de data.frame


#9-.(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
?drop

#La diferencia es que al utilizar el código 1 no se mantiene la estructura de matriz, sino que el resultado es un vector integer. Mientras que al utilizar el código 2 sí se mantiene la estructura de matriz, debido a que incluye el argumento "drop = FALSE". Este argumento se puede utilizar para eliminar las dimensiones de una matriz. Por lo tanto, al asignarle el valor "FALSE", se indica todo lo contrario; que no se desea eliminar la estructura de matriz.

#10-.(10pts) Haga una union por por columna de las matrices m1 y m2.

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
#Unión por columna:
cbind(m1,m2)


#11-.(24pts) Respecto del data.frame iris que vienen incorporados en R, realice lo siguiente:

    #(6pts) Cree un nuevo data.frame de nombre iris2 que tenga las columnas Species, Petal.Width y Sepal.Length. Hágalo de dos maneras diferentes.

#Forma 1
(iris2 <- data.frame(iris$Species,iris$Petal.Width,iris$Sepal.Length))

#Forma 2
(iris2 <- data.frame(iris[,c(5,4,1)]))

    #(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

iris$nueva_col <- seq(from=1,to=nrow(iris),by=1)

    #(6pts) Cree un nuevo data.frame iris3 en el que estén solo las filas 27, 143, 148, 138, 125. Hágalo de dos maneras diferentes.

#Forma 1
(iris3 <- iris[c(27,143,148,138,125),])

#Forma 2

(iris3 <- iris[c(which(iris$nueva_col==27),
                which(iris$nueva_col==143),
                which(iris$nueva_col==148),
                which(iris$nueva_col==138),
                which(iris$nueva_col==125)),])

    #(6pts) Cree un nuevo data.frame iris4 en el que estén las filas que cumplen la condición Sepal.Lenght mayores o iguales que 6

(iris4 <- iris[which(iris$Sepal.Length>=6),])




#12-.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

#Creación de vectores
rut <- c(212350826,201193347,214568645,221234567,204567652)
nombre <- c("Catalina Benítez","Belén Urrea","Catalina Silva", "Pía Fuentes", "Krishna Contreras")
egresado <- c(TRUE,TRUE,FALSE,TRUE,FALSE)

#Creación de data.frame
(informacion <- data.frame(rut,nombre,egresado))




#13-.(25pts) Para los siguientes ejercicios utilice el data.frame iris. Use funciones para mostrar:

iris$nueva_col <- NULL #Para regresar iris a su forma por defecto

    #(5pts) la estructura del set de datos
str(iris)

    #(5pts) el número de columnas y de filas del set de datos
ncol(iris) #Número de columnas
nrow(iris) #Número de filas

    #(5pts) el nombre de las columnas del set de datos
colnames(iris)

    #(5pts) el encabezado del set de datos
head(iris)

    #(5pts) los últimos seis elementos del set de datos
tail(iris)




#14-.(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#Si bien ambos se pueden utilizar para tabular información geoespacial, un data.frame no es la mejor estructura para ello ya que no puede contener coordenadas ni trabajar con tipos de datos geoespaciales como puntos, líneas, polígonos, entre otros. En cambio, sf es una clase de objeto que se compone, de hecho, por un data.frame y además una lista. En él se pueden almacenar atributos de objetos espaciales, dentro del data.frame, y además se le puede asignar un tipo de geometría, dentro de la lista.





#     PARTE 1: Manejo de archivos

#1-.(50pts) Con el archivo que se encuentra en formato CSV :

    #(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
getwd() #Asegurar que el directorio sea el que contenga la carpeta data_4
data <- read.csv("data_4/datos_ema_254.csv")

    #(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)

    #(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
promedio <- mean(data$humed_rel_promedio,na.rm=TRUE)
(mayor_prom <- data[which(data$humed_rel_promedio > promedio),])

    #(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
(data_seleccion <- mayor_prom[,c("fecha_hora","humed_rel_promedio","veloc_max_viento")])

    #(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.
write.csv2(data_seleccion,"data_4/datos_21.csv")




#2-.(80pts) Con el archivo que se encuentra en formato Geopackage:
    #(10pts) Cargue el archivo en R y asígnelo al objeto geo.
library(sf)

geo <- st_read("data_4/region_Los Ríos.gpkg")

    #(10pts) ¿Qué clase de objeto es geo?
class(geo) #Es un objeto de clase Simple Feature o sf

    #(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
class(geo$geom) #Es de geometría  POINT, con un total de 13 geometrías

    #(10pts) ¿Cuántas variables y observaciones tiene geo?
str(geo) #Tiene 7 variables y 13 observaciones

    #(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
plot(geo[,"comuna"])

    #(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
geo[which(geo$institucion=="INIA"),]
plot(geo[which(geo$institucion=="INIA"),"comuna"])
