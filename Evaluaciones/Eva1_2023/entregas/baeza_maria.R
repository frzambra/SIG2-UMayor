#Parte 1: Estructuras y manipulación de datos en R
#1.(5pts) Cree los siguientes objetos de tipo vector
#exVec1 con los números: -3, 45, 41, 31, -40
exVec1<-c(-3,45,41,31,-40)
exVec1
#exVec2 con los números: 44, NA, -30, 39, 22
exVec2<-c(44,NA,-30,39,22)
exVec2
#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)
exVec3<-seq(-5,5,0.5)
exVec3
#2.(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado<-c(exVec1,exVec2)
exVec_resultado

#3.5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
exVec1[3]
#devuelva todo menos el 2do y 3er elemento en exVec2
exVec2[1]
exVec2[4]
exVec2[5]

#4.(15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultado)
#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)
#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
?mean
mean(exVec2,na.rm=TRUE)
#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
sum(exVec2,na.omit(NA))
length(exVec2)

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos


#5.(10pts) Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6)+rnorm(2)
rnorm(6)
rnorm(2)
rnorm(6)+rnorm(2)
?rnorm
rnorm es una distribución normal estandarizada, 
#6.(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
Vectores atómicos:logicos, interger, double,character, complex y raw.
#logico
c(TRUE,FALSE,TRUE)
#numerico que pueden ser double e interger
c(1,2,3,4)
#caracter
c('a','b','c')

Vectores lista: recursivos, pueden contener otras listas, permite mezclar diferentes tipos de datos.
l<-list(c(1,3,5),'b',TRUE)
l

#7.(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
listita<-list(c(TRUE,TRUE,FALSE),matrix(ncol=3,nrow = 3),data.frame(mtcars))
listita
#8.(15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality
dt-data.frame(airquality)
dt[1]
data.frame<-which(airquality)
#9.(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

la diferencia radica en que se imprime el primero como una fila y el segundo como una columna, esto dado que la función drop=false hace que la matrix cambie la dirección.

#10.(10pts) Haga una union por por columna de las matrices m1 y m2
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
m1
m2
m3<-cbind(m1,m2)
m3

#11.(24pts) Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
  #(6pts) Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Wind, Month y Solar.R. Hágalo de dos maneras diferentes.
dt1<-data.frame(airquality)
dt1
dt2<-data.frame(airquality2; )
#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

#(6pts) Cree un nuevo data.frame airquality3 en el que estén solo las filas 56, 29, 31, 27, 147. Hágalo de dos maneras diferentes.

#(6pts) Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200

#12.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

#13.(25pts) Para los siguientes ejercicios utilice el data.frame airquality

#Use funciones para mostrar:
#(5pts) la estructura del set de datos

#(5pts) el número de columnas y de filas del set de datos

#(5pts) el nombre de las columnas del set de datos

#(5pts) el encabezado del set de datos

#(5pts) los últimos seis elementos del set de datos

#14.(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#2 Parte 2: Manejo de archivos
#Datos: Descargue los archivos desde este link

#(50pts) Con el archivo que se encuentra en formato CSV :

 # (10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data<- read.csv2('datos_ema_203.csv')
data
#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data)
#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.

#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.
#(80pts) Con el archivo que se encuentra en formato Geopackage:
  #(10pts) Cargue el archivo en R y asígnelo al objeto geo.
geo<-install.packages('region_Los Lagos.gpkg')
geo
#(10pts) ¿Qué clase de objeto es geo?

 # (10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
#(10pts) ¿Cuántas variables y observaciones tiene geo?
#  (20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
