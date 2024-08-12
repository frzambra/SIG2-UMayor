#Parte 1 
#1.
(exVec1 <- c(-3, 45, 41, 31, -40))
(exVec2 <- c(44, NA, -30, 39, 22))
(exVec3 <- seq(-5, 5, by = 0.5))

#2.
(exVec_resultado <- c(exVec1, exVec2))

#3.
(tercer_elemento <- exVec1[3])
(exVec2_sin_2do_3er <- exVec2[-c(2, 3)])

#4. 
#mostrar la cantidad de elementos de cada uno de los vectores creados arriba.
(number_elements_exVec1 <- length(exVec1))
(number_elements_exVec2 <- length(exVec2))
(number_elements_exVec3 <- length(exVec3))

#determinar la suma de elementos en el vector exVec1.
(suma_exVec1 <- sum(exVec1))

#determinar el promedio del vector exVec2 usando la función mean (nota: revisar el argumento na.rm de la función mean)
(promedio_exVec2 <- mean(exVec2, na.rm = TRUE))

#calcular el promedio de el vector exVec2 ahora utilizando las funciones sum, length, y na.omit
(promedio_exVec2_calculado <- sum(na.omit(exVec2)) / length(na.omit(exVec2)))

#muestre que los calculos del punto 3 y 4 son los mismos equivalentes/identicos
(identicos_equivalentes <- identical(promedio_exVec2, promedio_exVec2_calculado))

#5.Explique que hace la siguiente operación e indique ¿por qué?
rnorm(6) + rnorm(2)

#Respuesta: 
#La operación `rnorm(6) + rnorm(2)` en R genera dos conjuntos de números aleatorios y luego realiza una suma elemento por elemento de los dos conjuntos. Aquí está el desglose de lo que hace:
#`rnorm(6)` genera un vector de 6 números aleatorios distribuidos normalmente con una media de 0 y una desviación estándar de 1. (distribuicion normal estandar)
#`rnorm(2)` genera otro vector de 2 números aleatorios distribuidos normalmente con una media de 0 y una desviación estándar de 1.
#Luego, se realiza la suma elemento por elemento de los dos vectores resultantes. Siempre que sumes dos vectores en R, se sumarán elemento por elemento. Por ejemplo, el primer elemento del primer vector se suma al primer elemento del segundo vector, el segundo elemento se suma al segundo elemento y así sucesivamente.
#La razón por la que se obtiene una suma de estos vectores es que `rnorm(6)` y `rnorm(2)` generan números aleatorios diferentes en cada ejecución, por lo que obtendrás una suma diferente cada vez que ejecutes esta operación. 
#En resumen, esta operación produce una combinación de números aleatorios que siguen una distribución normal estándar, y la suma de estos números será aleatoria debido a la generación aleatoria de los datos de entrada.


#6. Cuáles son los tipos de vectores en R, de un ejemplo de cada caso
#vector numerico
(vector_numeric0 <- c(1, 2, 3.5, -4, 0))

#Vector entero
(vector_entero <- as.integer(c(1, 2, 3, 4, 5)))

#Vector cracter
(vector_caracter <- c("manzana", "banana", "pera", "uva"))

#Vector logico
(vector_logico <- c(TRUE, FALSE, TRUE, TRUE, FALSE))

#vector factores
(vector_factor <- factor(c("rojo", "verde", "azul", "rojo", "verde")))

#Vector complejo
(vector_complejo <- c(1 + 2i, 3 - 4i, 0 + 1i))

#Vector fecha
(vector_fecha <- as.Date(c("2023-01-15", "2023-02-20", "2023-03-25")))

#Vector hora
(vector_hora <- as.POSIXct(c("2023-01-15 10:30:00", "2023-01-15 15:45:00")))


#7. 
(vector_logico <- c(TRUE, FALSE, TRUE, TRUE, FALSE))
(matriz_3x3 <- matrix(1:9, nrow = 3))
(data(mtcars))
(impresora <-list(vector_logico = vector_logico,matriz_3x3 = matriz_3x3,mtcars = mtcars))

#8. 
(forma1_columna1 <- airquality$Ozon)
(forma2_columna2 <- airquality[, 1])
(forma3_columna3 <- airquality[["Ozone"]])

#9.Señale cuál es la diferencia en el resultado de los dos códigos que se aplican a la matriz m.
m <- matrix(1:9,3)

#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]

#Respuesta:
#La diferencia entre los dos códigos esta en el tipo de objeto que se obtiene como resultado:
#1. En el código 1 (m[,1]), se obtiene un vector numérico. 
#2. En el código 2 (m[,1,drop = FALSE]), se obtiene una matriz de una sola columna. 
#Entonces, la diferencia está en el tipo de objeto resultante. El código 1 produce un vector numérico, mientras que el código 2 produce una matriz de una sola columna.

#como imprimir la diferencia
# Código 1
numeric <- m[,1]
class(numeric)

# Código 2
matrix <- m[,1,drop = FALSE]
class(matrix) 


#10. 
(m1 <- matrix(1:sample(seq(9, 18, 3), 1), 3))
(m2 <- matrix(1:sample(seq(9, 18, 3), 1), 3))
(unir_matriz <- cbind(m1, m2))

#11.
# Cree un nuevo data.frame de nombre airquality2 que tenga las columnas Wind, Month y Solar.R. Hágalo de dos maneras diferentes.
#forma 1
airquality2 <- airquality[c("Wind", "Month", "Solar.R")]
#Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
airquality2$nueva_col <- 1:nrow(airquality2)
#forma 2
airquality2 <- airquality[, c("Wind", "Month", "Solar.R")]
#Agregue una nueva columna “nueva_col” la que debe contener los valores de 1 hasta el número de filas del data.frame.
airquality2$nueva_col <- 1:nrow(airquality2)

#Cree un nuevo data.frame airquality3 en el que estén solo las filas 56, 29, 31, 27, 147. Hágalo de dos maneras diferentes.
#forma 1
(airquality3 <- airquality[c(56, 29, 31, 27, 147), ])
#forma 2
(indices_filas <- c(56, 29, 31, 27, 147))
(airquality3 <- airquality[indices_filas, ])

#Cree un nuevo data.frame airquality4 en el que estén las filas que cumplen la condición Solar.R mayores a 200
(airquality4 <- airquality[airquality$Solar.R > 200, ])


#12. 
(vector_numerico <- c(1.5, 2.7, 3.2, 4.9, 5.1))
(vector_caracteres <- c("Manzana", "Banana", "Pera", "Uva", "Naranja"))
(vector_logico <- c(TRUE, FALSE, TRUE, TRUE, FALSE))
(df <- data.frame(numeros = vector_numerico,caracteres = vector_caracteres,logicos = vector_logico))

#13.
(airquality)

#estructura set de dato
str(airquality)

#numero de columnas y filas set de dato
ncol(airquality) #columnas
nrow(airquality) #fila

#nombres de columnas set de dato
colnames(airquality)

#Encabezado set de dato (primeras 6 filas)
head(airquality) 

#los últimos seis elementos del set de datos (ultimas 6 filas)
tail(airquality) 

#14. ¿Cuál es la diferencia entre un objeto de clase data.frame y uno de clase sf?
#Respuesta:
#la principal diferencia entre un objeto de clase (data.frame) y uno de clase (sf) radica en su propósito y estructura interna. Mientras que los (data.frame) se utilizan para datos tabulares no espaciales, los objetos (sf) son específicos para representar datos geoespaciales y espaciales, lo que los hace ideales para análisis y visualización de datos en un contexto geográfico.


#Parte 2 
getwd()

#Archivo formato CSV

#Cargue el archivo en formato CSV en R y asignelo al objeto data(

data <- read.csv2("datos_ema_203.csv", sep =",", header = TRUE)

#De un resumen de la estructura de los datos de data (clase, variables, observaciones).
class(data)
(num_variables <- ncol(data))
(nombres_variables <- colnames(data))
(num_observaciones <- nrow(data))

#Seleccione las observaciones que son mayores al promedio de la humedad relativa promedio.
data$humed_rel_promedio <- as.numeric(data$humed_rel_promedio)
data$humed_rel_promedio

#Con el set de datos resultado anterior, seleccione las variables de fecha_hora, humed_rel_promedio, veloc_max_viento.
(data$veloc_max_viento <- as.numeric(data$veloc_max_viento))
(data$fecha_hora <- as.POSIXct(data$fecha_hora))
data$humed_rel_promedio

#Con el data.frame resultante de las operaciones anteriores guardelo en un archivo con formato CSV (“datos_21.csv”) con configuración latina.






#Archivo formato Geopackage
getwd()
#Cargue el archivo en R y asígnelo al objeto geo.
library(sf)
?read_sf
geo <- read_sf("region_los Lagos.gpkg")

#¿Qué clase de objeto es geo?
















