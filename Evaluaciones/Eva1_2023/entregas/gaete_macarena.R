#(5pts) Cree los siguientes objetos de tipo vector
#exVec1 con los números: -34, 16, 38, -19, -40
exVec1 = c(-34,16,38,-19,-40)
#exVec2 con los números: -38, 34, 37, -27, -3
exVec2 = c(-38,34,37,-27,-3)
#exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)
exVec3 = seq(-5,5,0.5)

#(5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.
exVec_resultado = c(exVec1,exVec2)
exVec_resultado

#(5pts) Usando indexación con paréntesis cuadrado:
#devuelva el 3er elemento del vector exVec1
exVec3 [3]
#devuelva todo menos el 2do y 3er elemento en exVec2
x= c(exVec2[1],exVec2[4],exVec2[5])
x

#preguntar


#(15pts) Use funciones u operadores de relación para:
#(3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
length(exVec1)

length(exVec2)

length(exVec3)

length(exVec_resultado)

length(x)


#preguntar

#(3pts) determinar la suma de elementos en el vector exVec1.
sum(exVec1)

#(3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
o=mean(exVec2,na.rm = TRUE)
o

#(3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
y= na.omit(sum(exVec2))
z= na.omit(length(exVec2))
n=y/z
n

#(3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
o == n

#(10pts) Explique que hace la siguiente operación e indique ¿por qué? (rnorm(6) + rnorm(2))
#suma dos vectores de distribución normal el primero con más elementos que el segundo, sin embargo, los suma igualmente pues se recicla el segundo vector para realizar la operación




#(10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.
# por una parte están los vectores atómicos (integer,character,logical,double,complex,raw)
vinteger= c(1, 2, 3, 4)
vinteger

vcharacter= c('a', 'b', 'c')
vcharacter

vlogical=c(TRUE, FALSE, TRUE)
vlogical

vdouble= c(1.1,1.2,1.3,1.4)
vdouble

vcomplex= c(1i,2i,3i,4i)
vcomplex

vraw= seq(1,10,2)
vraw

# y por otra las listas
list(vinteger,vcharacter,vlogical,vdouble,vcomplex,vraw)

#(10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars
t= matrix(1:9,3,3)
list(vlogical,t,mtcars)


#(15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests

USArrests[1]

USArrests['Murder']

USArrests$Murder


#(10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m. 
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#con el codigo 1 se eliminaron las dimensiones de la matriz , con el  codigo 2 no se eliminaron, pues drop es FALSE


#(10pts) Haga una union por por columna de las matrices m1 y m2.
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#(24pts) Respecto del data.frame airquality que vienen incorporados en R, realice lo siguiente:
#(6pts) Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Ozone, Temp y Month. Hágalo de dos maneras diferentes.

#Forma 1




#forma 2
airquality
airquality$Solar.R= NULL
airquality$Wind= NULL
airquality$Day= NULL
airquality2_2 = airquality
airquality2_2


#(6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.

cbind(airquality,enumeracion = 1:153)


#(6pts) Cree un nuevo data.frame airquality3 en el que estén solo las filas 111, 90, 41, 87, 23. Hágalo de dos maneras diferentes.

#(6pts) Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200

#(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.
a= c(1,2,3,4,5)
b= c('a','b','c','d','e')
c= c(TRUE,TRUE,TRUE,TRUE,TRUE)
data.frame(a,b,c)

#(25pts) Para los siguientes ejercicios utilice el data.frame airquality Use funciones para mostrar:
#(5pts) la estructura del set de datos
str(airquality)

#(5pts) el número de columnas y de filas del set de datos
ncol(airquality)
nrow(airquality)

#(5pts) el nombre de las columnas del set de datos
colnames(airquality)

#(5pts) el encabezado del set de datos


#(5pts) los últimos seis elementos del set de datos
sort(airquality$Ozone, decreasing = TRUE)
sort(airquality$Temp, decreasing = TRUE)
sort(airquality$Month,decreasing = TRUE)


#(15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?











