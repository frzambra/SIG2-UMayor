#CAMILA URRUTIA  /  20.615.832-8  /   06/10/2023
#PRUEBA CATEDRA I
#tipo 2

#1. (5pts) Cree los siguientes objetos de tipo vector
#exVec1 con los números: 4, -45, -4, -31, -32.  exVec2 con los números: 21, 4, 17, 43, 12. exVec3 con la sequencia -5 a 5 cada 0.5 (ej, -5.0, -4.5, -4.0, y así hasta 5.0)

exVec1 <- c(4, -45, -4, -31, -32)
exVec2 <- c(21, 4, 17, 43, 12)
exVec3 <- seq(-5.0,5.0,0.5)
exVec3

#2. (5pts) Junte los vectores exVec1 con exVec2 y guardelos en un nuevo vector llamado exVec_resultado (usando una sóla linea). Muestre el resultado.

exVec_resultado <- exVec1 + exVec2
exVec_resultado


#3.(5pts) Usando indexación con paréntesis cuadrado:
     #a. devuelva el 3er elemento del vector exVec1
     #b. devuelva todo menos el 2do y 3er elemento en exVec2
#a.
exVec1[3]
#b.
exVec2[2]
exVec2[3]
exvec2_2_3<- exVec2[c(1,4,5)]
exvec2_2_3
exVec2


#4. (15pts) Use funciones u operadores de relación para:
     #a. (3pts) mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
     #b. (3pts) determinar la suma de elementos en el vector exVec1.
     #c. (3pts) determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento             na.rm de la función mean)
     #d. (3pts) calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
    #e. (3pts) muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos

#a.
length(exVec1)
length(exVec2)
length(exVec3)
length(exvec2_2_3)
length(exVec_resultado)

#b.
sum(exVec1)

#c.
?help(na.rm)
?mean
mean(exVec2)

#d.
sum(exVec2)
length(exVec2)
exvec2_prom <- na.omit(sum(exVec2)/length(exVec2)) 
exvec2_prom

#e.
prom_exvec2<- mean(exVec2)
exvec2_prom

prom_exvec2[!(prom_exvec2 %in% exvec2_prom)]

#5.(10pts) Explique que hace la siguiente operación e indique ¿por qué?

a<-rnorm(6)
b<-rnorm(2)
a
b
a+b
#la operacion rnorm() genera números pseudoaleatorios normales, en el valor destinado como 'a' se imprimieron 6  observaciones y en el 'b' solo 2, por ende cuando se ejecuta la suma de vectores, al b<a se repiten los valores en bucle hasta que se cumplan el total de observaciones.

#6. (10pts) Cuáles son los tipos de vectores en R, de un ejemplo de cada caso.)

vec_2 <- vector("numeric",5)
vec_3 <-vector("complex",5)
vec_4 <-vector('logical',5)
vec_5 <-vector("character",6)
vec_2
vec_3
vec_4
vec_5
#hay vector de tipo numerico, complejo, logico y caracter. las listas tambien son un tipo de vectores

#7. (10pts) De un ejemplo de una lista que contenga como primer elemento un vector lógico, como segundo una matriz 3x3, y como tercer el data.frame mtcars

matriz_1 <-matrix(data=NA,nrow = 3,ncol = 3)
df_1<- data.frame(mtcars)
df_1
vec_1<- c(1:10)
lista_1 <-list(vec_1,matriz_1,df_1)
lista_1

#8. (15 pts) Muestre tres formas de indexar la primera columna del data.frame USArrests
USArrests
USArrests[,1] #1era
USArrests$Murder #2da
length(USArrests$Murder)
USArrests$Murder[1:50]#3era


#9. (10 pts) Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
      
          #m <- matrix(1:9,3)
    #codigo 1
            #m[,1]

    #codigo 2
            #m[,1,drop = FALSE]

m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

m

#en el codigo 1 se esta llamando a traves de la indexacion a la primera columna de observaciones y lo arroja como vector, en cambio en el codigo 2 tambien muestra el primera columna de elementos pero los conserva el formato de matriz.


#10. (10pts) Haga una union por por columna de las matrices m1 y m2.
   #m1 <- matrix(1:sample(seq(9,18,3),1),3)
   #m2 <- matrix(1:sample(seq(9,18,3),1),3)

matriz_2 <- matrix(1:sample(seq(9,18,3),1),3)
matriz_3 <- matrix(1:sample(seq(9,18,3),1),3)
matriz_2
matriz_3
rbind(matriz_2,matriz_3)

#11.(24pts) Respecto del data.frame mtcars que vienen incorporados en R, realice lo siguiente:
     #a. (6pts) Cree un nuevo data.frame de nombre mtcars2 que tenga las columnas drat, qsec y carb. Hágalo de dos maneras diferentes.
     #b. (6pts) Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
     #c. (6pts) Cree un nuevo data.frame mtcars3 en el que estén solo las filas 18, 12, 14, 10, 2. Hágalo de dos maneras diferentes.
     #d. (6pts) Cree un nuevo data.frame mtcars4 en el que estén las filas que cumplen la condición mpg menores a 21

#a.
mtcars2 <-data.frame(mtcars [,c(5,7,11)]) #1era vez
mtcars2
mtcars2_2 <-data.frame(mtcars$drat,mtcars$qsec,mtcars$carb)#2da vez
mtcars2_2

#b.
??insert
str(mtcars2)
mtcars2$nueva_col <- 1:32
mtcars2

#c. 
mtcars3 <-data.frame(mtcars[c(18,12,14,10,2),]) # 1era vez
mtcars3
mtcars3_2 <-data.frame(mtcars = 'Fiat 128','Merc 450SE','Merc 450SLC','Merc 280','Mazda RX4 Wag' #2da vez
mtcars3_2

#d.
mtcars4 <- data.frame(mtcars$mpg<21)
mtcars4

#12.(10pts) De un ejemplo de un vector numérico, caracter y lógico. Cada vector debe contener 5 elementos. Luego con los tres vectores cree un data.frame que tenga tres columnas numeros, caracteres y logicos; en donde se almacene cada vector creado.

vec_2 <- vector("numeric",5)
vec_4 <-vector('logical',5)
vec_5 <-vector("character",5)
vec_2
vec_4
vec_5
df_2 <- data.frame(vec_2,vec_4,vec_5)
df_2


#13. (25pts) Para los siguientes ejercicios utilice el data.frame mtcars
 # Use funciones para mostrar:
    #a. (5pts) la estructura del set de datos
    #b. (5pts) el número de columnas y de filas del set de datos
    #c. (5pts) el nombre de las columnas del set de datos
    #d. (5pts) el encabezado del set de datos
    #e. (5pts) los últimos seis elementos del set de datos

#a. 
str(mtcars)

#b. 
dim(mtcars)

#c.
names(mtcars)

#d.
head(mtcars)

#e.

mtcars_ult6<- data.frame(mtcars [26:32,])
mtcars_ult6
mtcars

#14. (15pts) ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?

#los objetos de clase sf son un tipo de de data.frame solo que estre sus variables tiene una que es 'geom_' la cual es la geometria de cada observacion.

#PARTE 2
#1. (50pts) Con el archivo que se encuentra en formato CSV :
  #a. (10pts) Cargue el archivo en formato CSV en R y asignelo al objeto data
  #b. (10pts) De un resumen de la estructura de los datos de data (clase, variables, observaciones).
  #c. (10pts) Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
  #d. (10pts) Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
  #e. (10pts) Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.

#a. 
install.packages("readr")

data<- datos_ema_126
data
read_csv(data)
read_csv2(data)
read_tsv(data)

#b. 
summary(data)

#c.
mean(data$humed_rel_promedio)
prom_data_hum<- data.frame(mean(data$humed_rel_promedio)<data$humed_rel_promedio)

prom_data_hum  

#d.
df_data<- data.frame(data$fecha_hora,data$humed_rel_promedio,prom_data_hum,data$veloc_max_viento)
df_data

#e.
?save 
write.csv(df_data, file = "datos_21.csv", row.names = FALSE) # guarda un archivo csv
data_21 <- read.table(file = "datos_21.csv", header = TRUE, sep = ",")

#2. (80pts) Con el archivo que se encuentra en formato Geopackage:
  #a. (10pts) Cargue el archivo en R y asígnelo al objeto geo.
  #b. (10pts) ¿Qué clase de objeto es geo?
  #c. (10pts) Indique el tipo de geometría y la cantidad de geometrias que tiene geo.
  #d. (10pts) ¿Cuántas variables y observaciones tiene geo?
  #e. (20pts) Haga un mapa en donde se muestre la variación de la variable comuna.
  #f. (20pts) Seleccione todas las estaciones que pertenecen a la institución INIA.
?library
