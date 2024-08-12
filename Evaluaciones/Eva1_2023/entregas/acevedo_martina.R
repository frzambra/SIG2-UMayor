#1- Cree los siguientes objetos de tipo vector
exVec1 con los números: -45, 3, 7, -39, 36
exVec2 con los números: -46, -27, -22, -48, -21
exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)

exVec1 <- c(-45, 3, 7, -39, 36)
exVec2 <- c(-46, -27, -22, -48, -21)
exVec3 <- seq(-5, 5, by = 0.5)
#se generan los mismos vectores y se utiliza la funcion by para indicar desde donde hasta donde

#2-(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado <- c(exVec1, exVec2)

#3-(5pts) Usando indexación con paréntesis cuadrado: devuelva el 3er elemento del vector exVec1 devuelva todo menos el 2do y 3er elemento en exVec2

tercer_elemento_exVec1 <- exVec1[3]
sin_segundo_tercero_exVec2 <- exVec2[-c(2, 3)]

#4-(15pts) Use funciones u operadores de relación para:

#-(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
suma_exVec1 <- sum(exVec1)
suma_exVec2<-sum(exVec2)
suma_exVec3<-sum(exVec3)

#-(3pts) determinar la suma de elementos en el vector exVec1.
suma_exVec1 <- sum(exVec1)

#-(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
promedio_exVec2 <- mean(exVec2, na.rm = TRUE)

#-(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
suma_exVec2<-sum(exVec2)
length_exVec2<-length(exVec2)
na.omit_exVec2<-na.omit(exVec2)

#en una sola linea añadiendo todas las funciones
promexVec2_funciones <- sum(exVec2, na.rm = TRUE) / length(na.omit(exVec2))

#-(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
promedio_exVec2 <- mean(exVec2, na.rm = TRUE)
promexVec2_funciones <- sum(exVec2, na.rm = TRUE) / length(na.omit(exVec2))
promedio_exVec2 == promexVec2_funciones

#5-(10pts) Explique que hace la siguiente operación e indique ¿por qué? rnorm(6) + rnorm(2)
?rnorm
rnorm(6)+rnorm(2)
#La operación genera dos vectores de números aleatorios ya que cambian los valores cada vez que se corre la funcion, son distribuidos normalmente respecto de los numeros que se contengan, y luego realiza una operación de suma entre funciones. Pero como el largo de los vectores no es igual se ocupan los mas similares para realizar la suma y sacar una distribucion normal.

#6-(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#existen los de tipo integer, osea numeros enteros
j <-c(1L,2L,3L,4L,5L,6L)
k <-c(1L,3L,5L,7L,9L,11L,13L)

#los de tipo numerico
z<-c(1.3, pi, exp(1))
t<-c(sin(pi/4), log(45), tan(pi/3))

#de tipo logico, solo acepta valores de este tipo
m<-c(TRUE,FALSE,FALSE,TRUE)
p<-c(T,F,F,T,T,T,F)

#de tipo character
x<-c("Juan", "Ana", "José")
y<-c("12", "casa", "pi")

#de tipo complejo, contiene números complejos. 
l<-c(1 + 2i, 3 - 4i, 5 + 6i)

#7-(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

lista_1 <- list(vector_logico = c(F, T, T),matriz_3x3 = matrix(1:6, nrow = 3),data_frame_mtcars = mtcars)

#8-(15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality

airquality
#la primera columna de airquality es ozone por inde indexamos esa columna
airquality$Ozone
airquality[["Ozone"]]
airquality[, "Ozone"]

#9-(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#las diferencias son que el codigo 1 nos entrega un vector y el codigo 2 nos entrega solo la columna [,1] de una matriz.

#10-(10pts) Haga una union por columna de las matrices m1 y m2.
#para la union de columnas podemos ocupar la columna cbind
?cbind
cbind(0, matrix(1, nrow = 0, ncol = 4)) 
dim(cbind(0, matrix(1, nrow = 2, ncol = 0))) 







#11-(24pts) Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes.

USArrests2<-data.frame( 'Murder','UrbanPoP','Rape')

#de otra forma
USArrest2 <- USArrests[, c("Murder", "UrbanPop", "Rape")]

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
USArrest2$nueva_col <- 1:nrow(USArrest2)

#(6pts) Cree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.

USArrest3<-
  


#(6pts) Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a8

#(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.







#Utilizando el sed de datos USArrests
# Estructura del set de datos:
str(USArrests)

#Número de columnas y filas del set de datos:
ncol(USArrests)  
nrow(USArrests)  

#Nombre de las columnas del set de datos:
colnames(USArrests)

#Encabezado del set de datos:
head(USArrests)

#Los últimos seis elementos del set de datos:
tail(USArrests, 6)

#6- La diferencia entre un objeto de clase `data.frame` y uno de clase `sf` es que se ocupan para distintas ocasiones y tienen distintas funciomes, el data frame almacena filas y columnas con datos y sf se utiliza con datos geoespaciales osea contiene informacion espacial como imagenes, poligonos, uniones entre puntos etc.por lo que data frame contiene datos y sf es solo para datos geoespaciales.

#2 Parte 2: Manejo de archivos
#Datos: Descargue los archivos desde este link

#(50pts) Con el archivo que se encuentra en formato CSV :
#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data <- read.csv("datos_ema_49.csv")

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

prom_hum <- mean(data$humed_rel_promedio)
mayor_promhum <- prom_hum[, c("fecha_hora", "humed_rel_promedio", "veloc_max_viento")]

(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento

data2<- mayor_promhum[, c("fecha_hora", "humed_rel_promedio", "veloc_max_viento")]

(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

write.csv(nuevo_data, file = "datos_ema_49.csv", row.names = FALSE, fileEncoding = "latin1")

(80pts) Con el archivo que se encuentra en formato Geopackage:
(10pts) Cargue el archivo en R y asígnelo al objeto geo.
install.packages(geo)
install.packages("region_Atacama.gpkg")
geo <-st_read("region_Atacama.gpk")

(10pts) ¿Qué clase de objeto es geo?
class(geo)

(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.

(10pts) ¿Cuántas variables y observaciones tiene geo?
st_geometry_type(geo)
nrow(geo) 

(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
library(tmap)

tm_shape(geo) +tm_borders() +tm_fill("comuna") +tm_legend(position = c("left", "bottom"))

(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
estaciones_INIA <- geo[geo$institucion == "INIA", ]


