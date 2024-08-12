      #Uso Avanzado de de teconologías de Información Geográfica
                        #EVALUACIÓN 1: TALLERES

#1-. (2pt) Cargue en R el archivo metadata_estaciones_agrometAPI.csv y asignelo al objeto data_info.

#Verificar la ruta del directorio de trabajo
getwd() #Tiene que ser una ruta de una carpeta que contenga la carpeta data, en donde se encuentrn los archivos de trabajo.

#Asignar el archivo metadata_estaciones_agrometAPI.csv al objeto data_info
data_info <- read.csv2('data/metadata_estaciones_agrometAPI.csv')



#2-. (2pt) Cuál es el nombre de las columnas de data_info

class(data_info) #Es un data.frame
names(data_info) #Los nombres de las columnas del data.frame



#3-. (2pt) Seleccione de data_info la estación que se le asigno en el campus virtual. Indique el nombre, comuna, región, latitud y longitud de la estación.

#Asignar el número del ema que corresponde al objeto id
id <- 24

#Forma 1

#Asignar un data frame con valores lógicos, donde TRUE es cuando la variable de ema es igual al id
log <- data_info$ema == id

#obtener la información de toda la fila cuyo valor de ema sea igual al del id
(ema_info <- data_info[log,])

#Forma 2

#Asignar un data frame con valores lógicos, donde TRUE es cuando la variable de ema es igual al id
log <- data_info$ema %in% id

#obtener la información de toda la fila cuyo valor de ema sea igual al del id
(ema_info <- data_info[log,])


#4-. (2pt) Cargar en R el archivo ‘.csv’ correspondiente a los datos climáticos y asignelo al objeto data. Debe elegir el archivo correspondiente al código de la estación de acuerdo a lo que se indica en el campus virtual Evaluaciones/Evaluación 1 talleres. Nota: Para los siguientes ejercicios debe seguir trabajando con estos datos.

#Asignar el archivo 24.csv al objeto data
data <- read.csv2('data/24.csv')



#5-. (2pt) Genere un resumen de la estructura de datos del objeto data, en el que se debe poder identificar la clase de objeto, la cantidad de variables y observaciones; y la clase de objeto de cada variable.

#Obtener información básica del objeto data
str(data) #Para obtener un resumen de la estructura de data y saber qué clases de variables tiene

#dim(data) #Para saber sólo la dimensión del data.frame
#nrow(data) #Para saber sólo el número de filas
#ncol(data) #Para saber sólo el número de columnas
#head(data) #Para mostrar sólo las primeras 6 observaciones (o filas)
#tail(data) #Para mostrar sólo las últimas 6 observaciones (o filas)



#6-. (2pt) Haga un resumen estadístico de todas las variables que contiene data.
summary(data) #Entrega un resumen estadístico
#plot(density(na.omit(data$temp_promedio_aire))) #ejemplo de gráfico



#7-. (3pt) Indique entre que rango de fechas se encuentran las observaciones del objeto data.
range(data$fecha_hora)
# class(data$fecha_hora) #Es una columna de clase character

#INTENTO de Transformar la columna character en una de clase fecha y hora
#as.POSIXct(data$fecha_hora,"%y-%m-%d %HH:%MM")



#8-. (4pt) Cree un objeto data_temp en el que se guarde un subconjunto de el objeto data que contenga las variables de fecha_hora,temp_promedio_aire, temp_minima, temp_maxima.
data_temp <- data[,c(2,3,9,10)] #Forma 1, que utiliza los índices
data_temp <- data[,c("fecha_hora","temp_promedio_aire","temp_minima","temp_maxima")] #Forma 2, que utiliza los nombres



#9-. (4pt) Cree un objeto data_temp_enero en el que se guarde un subconjunto del objeto data_temp, que debe contener todas las observaciones del mes de enero 2021.}
#Seleccionar sólo el texto "año-mes" de la cadena de texto de fecha_hora y asignarlo al objeto fecha
fecha <- substr(x=data_temp$fecha_hora,start=1,stop=7)

#unir el objeto fecha como una columna adicional a data_temp
data_temp2 <- cbind(data_temp,fecha)

#Asignar la fecha deseada al objeto enero
enero <- "2021-01"

#Preguntar qué valores de la columna fecha son iguales a enero y asignar el resultado al objeto log2
log2 <- data_temp2$fecha == enero

#Indexar las filas que cumplan condición de que su fecha sea "2021-01"
(data_temp_enero <- data_temp2[log2,])
View(data_temp_enero)


#La forma resumida de hacer todos los pasos anteriores
data_temp_enero2 <- data_temp[fecha=="2021-01",]
View(data_temp_enero2) #Genera el mismo resultado, pero sin tener que crear una nueva columna


 
#10-. (2pt) Cuál es la temperatura promedio, máxima y mínima del mes de enero 2021.
#Calcular todos los valores de una sola vez
summary(data_temp_enero)
#Temperatura promedio = 22.50
#Temperatura máxima = 35.90
#Temperatura mínima = 9.20

#Una forma de hacerlo más preciso
mean(data_temp_enero2$temp_promedio_aire,na.rm=TRUE) #Devuelve 22.49786
max(data_temp_enero2$temp_maxima,na.rm=TRUE) #Devuelve 35.9
min(data_temp_enero2$temp_minima,na.rm=TRUE) #Devuelve 9.2



#11-. (5pt) Cree una matriz de correlación entre las variables de temperatura del objeto data_temp. No considere los valores NA en el cálculo.
cor(data_temp2[,2:4],use="complete.obs") 

