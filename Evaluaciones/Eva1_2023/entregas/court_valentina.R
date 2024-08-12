
#valentina court 
#Parte 1: Estructura y manipulacion de datos en R

#1.(5pts) Cree los siguientes objetos de tipo vector

exVec1<- c(-45,3,7,-39,36)
exVec2<-c(-46,-27,-22,-48,-21)
exVec3<- seq(from=-5,to=5,by=0.5)

#2.(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

 exVec_resultado<-c(rbind(exVec1,exVec2))
 exVec_resultado
 
 #3.(5pts) Usando indexación con paréntesis cuadrado:
 #devuelva el 3er elemento del vector exVec1
 #devuelva todo menos el 2do y 3er elemento en exVec2
 
 exVec1[3]
exVec2[ ] 

#4.(15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.

length(exVec1)
length(exVec2)
length(exVec3)
length(exVec_resultado)

#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
mean(exVec2)

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit

x<-sum(exVec2)/length(exVec2)

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

mean(exVec2)==x

#5.(10pts) Explique que hace la siguiente operación e indique ¿por qué?) "rnorm(6) + rnorm(2)"

#Lo que hace la funcion de "rnorm" es arrojar valores aleatorios normales en este caso 6 valores (siempre diferentes) + 2 valores (siempre diferentes) y la suma es para sumar los elementos arrojados, en el caso que utilice set.seed, estos valores aleatorios salen una vez y luego se van repitiendo hasta quitar la semilla o cambiarla. 

#6.(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
#Entero:
a6<-6L

#numerico:
b6<--90

#logico: 
c6<-mean(exVec2)==x

#caracter: 
d6<-"hola"  

#complejos:un ejemplo de complejos son las ecuaciones que vienen con numeros imaginarios "5*3x+6x"
#datos derivados: valores faltantes "NA", los valores de fecha y hora "2023-08-18" y las de factor "as.factor(n)" 


#7.(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
m7<-matrix(1:9,nrow = 3,ncol = 3)
l7<-list(c6,m7,data.frame(mtcars))

#8.(15 pts) Muestre tres formas de indexar la primera columna del data.frame airquality
data.frame(airquality$Ozone)
print(data.frame(airquality[,1]))
data.frame(airquality[,1])

#9.(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#10.(10pts) Haga una union por por columna de las matrices m1 y m2.

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#11.(24pts) Respecto del data.frame USArrests que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre USArrest2 que tenga las columnas Murder, UrbanPop y Rape. Hágalo de dos maneras diferentes

data.frame(USArrests)
USArrest2<- USArrests$Assault 

#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.



#(6pts) Cree un nuevo data.frame USArrest3 en el que estén solo las filas 40, 21, 9, 8, 24. Hágalo de dos maneras diferentes.



#(6pts) Cree un nuevo data.frame USArrest4 en el que estén las filas que cumplen la condición Murder menor o igual a8
  


#12.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

a12<-c(-8,-2,3,5,30)
b12<-c("mateo","pedro","juan","diego","lucas")
c12<-c(TRUE,FALSE,TRUE,TRUE,FALSE)
df12<- data.frame(a12=a12,b12=b12,c12=c12)

#13.(25pts) Para los siguientes ejercicios utilice el data.frame USArrests. Use funciones para mostrar:
  
# (5pts) la estructura del set de datos
str(USArrests)
#(5pts) el número de columnas y de filas del set de datos
dim(USArrests)
#(5pts) el nombre de las columnas del set de datos
names(USArrests)
#(5pts) el encabezado del set de datos
head(USArrests)
#(5pts) los últimos seis elementos del set de datos
tail(USArrests)
#(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#el data frame es una hoja de datos que se compone de filas (sujetos) y columnas (variables) y sf crea clases nuevas que nacen de las clases originales de R, esta compuesto de una geometria, que esta almacenada en una lista y los atributos que estan almacenados en un data frame.

#parte 2: Manejo de archivos 
#1.(50pts) Con el archivo que se encuentra en formato CSV :
  #(10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
data<-read.csv2("data/datos_ema_49.csv/")

#(10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).



#(10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.



#(10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.




#(10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

#2.(80pts) Con el archivo que se encuentra en formato Geopackage:
  #(10pts) Cargue el archivo en R y asígnelo al objeto geo.

#(10pts) ¿Qué clase de objeto es geo?
  #(10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
#(10pts) ¿Cuántas variables y observaciones tiene geo?
  #(20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
#(20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
