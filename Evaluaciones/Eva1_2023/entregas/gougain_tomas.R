#1. (5pts) Cree los siguientes objetos de tipo vector

exVec1<- c(-45, 3, 7, -39, 36)
exVec1
exVec2<- c(-46, -27, -22, -48, -21)
exVec2
exVec3<- seq(-5,5, by=0.5)
exVec3

#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- as.numeric(rbind(exVec1, exVec2))
exVec_resultado

#3. (5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
#devuelva todo menos el 2do y 3er elemento en exVec2
exVec1[3]
exVec2[c(1,2,5)]

#4. (15pts) Use funciones u operadores de relación para:

#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)
length(exVec2)
length(exVec3)

#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
mean(exVec2)
prom_exvec2_funcion_mean <- mean(exVec2)

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
prom_exvec2<- sum(exVec2)/length(exVec2)
prom_exvec2

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
prom_exvec2_funcion_mean==prom_exvec2
prom_exvec2_funcion_mean
prom_exvec2

#5. (10pts) Explique que hace la siguiente operación e indique ¿por qué?

rnorm(6) + rnorm(2)

#6. (10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.

#Existen 5 tipo de vectores en R; Numeric que contiene números reales, Integer que contiene números enteros, logical que contiene números lógicos, Character que contiene palabras o caracterers y por último el complex que contiene números complejos.

#7. 10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
list(e1<-matrix(1:9,nrow = 3,ncol = 3),
     e2<-str(mtcars),
     e3<- list(TRUE,2,3,4,5))

#8. (15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality

df1<- airquality
df1

#forma 1
df1[,'Ozone']

#forma 2
df1$Ozone

#forma 3
df1[,1]

#9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#Respuesta: la función drop sirve para eliminar una fila o columna y devuelve el resultado, en este caso al colocar los números en la columna y escribir el valor lógico FALSE, esta negando la columna por lo que la elimina y la acomoda como una fila.

#10.(10pts) Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#11. (24pts) Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:

#(6pts) Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes.
str(USArrests)
#Forma 1
v5<- USArrests[,1]
v5
v6<- USArrests[,3]
v6
v7<- USArrests[,4]
v7
USArrests2<- data.frame(Murder=v5,UrbanPop=v6,Rape=v7  )
USArrests2
#forma 2
v9<- USArrests$Murder
v10<- USArrests$UrbanPop
v11<- USArrests$Rape
USArrests2.2<- data.frame(Murder=v9,UrbanPop=v10,Rape=v11  )
USArrests2.2

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
USArrests$nueva_columna <- 1:50
USArrests

#(6pts) Cree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.
USArrests[c()]

#(6pts) Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a8
  
#12.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
v112<- (1:5)
v212<- c('a','b','c','d','e')
v312<- c(TRUE,FALSE,FALSE,FALSE,TRUE)
df4 <- data.frame(Numericos=v112, Caracteres=v212, logicos=v312)
df4

#13. (25pts) Para los siguientes ejercicios utilice el data.frame USArrests

#Use funciones para mostrar:
  
  #(5pts) la estructura del set de datos
str(USArrests)

#(5pts) el número de columnas y de filas del set de datos
dim(USArrests)

#(5pts) el nombre de las columnas del set de datos
colnames(USArrests)

#(5pts) el encabezado del set de datos
head(USArrests)

#(5pts) los últimos seis elementos del set de datos
tail(USArrests)

#14 (15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#Respuesta:  Data.Frame y sf son estructuras de datos diferentes, mientras que sf es para datos espaciales y data.frame para datos tabulares.

#Manejo de archivos

#(50pts) Con el archivo que se encuentra en formato CSV :

#(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
read.csv('D:/Descargas/Data_evaluación/datos_ema_49.csv')
data_info<- read.csv('D:/Descargas/Data_evaluación/datos_ema_49.csv')
#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
str(data_info)

#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
mean(data_info$humed_rel_promedio)




#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.

#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

#2. (80pts) Con el archivo que se encuentra en formato Geopackage:
#(10pts) Cargue el archivo en R y asígnelo al objeto geo.
read_sf()
#(10pts) ¿Qué clase de objeto es geo?
 # (10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
#(10pts) ¿Cuántas variables y observaciones tiene geo?
 # (20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.