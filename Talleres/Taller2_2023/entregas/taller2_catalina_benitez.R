#           Uso Avanzado de Sistemas de Información Geográfica
#                     Taller 2: Ejercicios R base

#       A. DATA.FRAMES

#1a-. Escriba un programa en R para crear un data.frame vacío.
(Aa_dtfr <- data.frame()) #Resulta un data.frame vacío
 
#2b-. Escriba un programa en R para crear un data.frame a partir de cuatro vectores dados.
#Crear 4 vectores, todos de 6 elementos
Ab_vec1 <- letters[10:15] #Vector numérico
Ab_vec2 <- month.abb[10:15] #Vector de carácteres
Ab_vec3 <- c("amarillo","rojo","azul","verde","gris","rosado") #Vector de carácteres
Ab_vec4 <- 10:15 #Vector numérico
#Crear data.frame a partir de los 4 vectores
Ab_dtfr <- data.frame(Letras=Ab_vec1,
                      Meses=Ab_vec2,
                      Colores=Ab_vec3,
                      Números=Ab_vec4) 
str(Ab_dtfr) #Resulta un data.frame de 4 variables con 6 observaciones cada una

#3c-. Escriba un programa R para extraer una columna específica de un data.frame usando el nombre de la columna.
Ac_col <- Ab_dtfr[["Colores"]] #Se indexa la columna o variable "Colores"
class(Ac_col) #Resulta un vector de tipo character

#4d-. Escriba un programa en R para extraer las filas 3 y 5 con las columnas 1 y 3 de un data.frame dado.
Ad_rscs <- Ab_dtfr[c(3,5),c(1,3)] #Se indexa según las indicaciones
str(Ad_rscs) #Resulta un data.frame con la información de las columnas 1 y 3 y sus respectivas observaciones 3 y 5

#5e-. Escriba un programa en R para eliminar la(s) columna(s) por nombre de un data.frame dado.
Ab_dtfr$Números <- NULL #Eliminar la columna de nombre Números
str(Ab_dtfr) #El data frame original ahora tiene 3 variables
Ab_dtfr[,"Números"] <- NULL #Otra manera de hacer lo mismo, pero con esta forma se pueden eliminar más de una columna a la vez

#6f-. Escriba un programa en R para agregar una nueva columna en un data.frame determinado.
#Agregar nueva variable o columna de nombre Años
Ab_dtfr$Años <- c(1990,2000,2003,2019,2022,2023) 
str(Ab_dtfr) #El data frame original ahora tiene 4 variables

#7g-. Escriba un programa en R para ordenar un data.frame dado por varias columnas.
#Insertar una semilla para que se puedan replicar las funciones aleatorias
set.seed(999)
#Crear un data.frame con elementos aleatorios y con sus columnas de nombre "A", "B", "C" y "D"
(Ag_dtfr <- data.frame(A=sample(x = letters, size = 4),
                       B=sample(x = letters, size = 4),
                       C=sample(x = letters, size = 4),
                       D=sample(x = letters, size = 4)))
#reubicar las columnas en orden decreciente, es decir, "D", "C", "B" y "A" respectivamente
(Ag_ordenado <- Ag_dtfr[sort(colnames(Ag_dtfr),decreasing = TRUE)])

#8h-. Escriba un programa en R para crear uniones (fusiones) internas, externas, izquierdas y derechas a partir de dos data.frames dados.
#Crear 2 data.frames
(Ah_dtfr1 <- data.frame(Día=c(1,2,3),
                        Hoja=c(6,4,3)))
(Ah_dtfr2 <- data.frame(Día=c(2,3,4),
                        Tallo=c(12,13,15)))
#Unión por la izquierda
(Ah_izq <- merge(Ah_dtfr1,Ah_dtfr2,by="Día",all.x=TRUE))
#Unión por la derecha
(Ah_der <- merge(Ah_dtfr1,Ah_dtfr2,by="Día",all.y = TRUE))
#Unión interna
(Ah_ext <- merge(Ah_dtfr1,Ah_dtfr2,by="Día",all=FALSE))
#Unión externa
(Ah_int <- merge(Ah_dtfr1,Ah_dtfr2,by="Día",all=TRUE))

#9i-. Escriba un programa R para reemplazar los valores de NA con 3 en un data.frame dado.
#Crear 3 vectores, todos de 5 elementos
Ai_vec1 <- c(9,17,19,22,24)
Ai_vec2 <- 11:15
Ai_vec3 <- c(NA,17,22,NA,NA)
#Crear data.frame a partir de los 3 vectores
(Ai_dtfr <- data.frame(Registro_1=Ai_vec1,Registro_2=Ai_vec2,Registro_3=Ai_vec3)) #Resulta un data.frame de 3 variables con 5 observaciones cada una. En la última columna 3 de sus valores son NA
Ai_dtfr[is.na.data.frame(Ai_dtfr)] <- 3 #Se asigna el valor 3 para que reemplace los valores NA del data.frame
Ai_dtfr

#10j-. Escriba un programa R para cambiar más de un nombre de columna de un data.frame dado.
#Usar el data.frame del ejercicio anterior
colnames(Ai_dtfr) <- c("Muestra_1","Muestra_2","Muestra_3")
names(Ai_dtfr) #Nombres reemplazados

#11k-. Escriba un programa R para comparar dos data.frame para encontrar las filas en el primer data.frame que no están presentes en el segundo data.frame. (ver ?setdiff)
#Crear 5 vectores numéricos, todos de 3 elementos
Ak_vec1 <- c(1,2,3)
Ak_vec2 <- c(4,5,6)
Ak_vec3 <- c(10,20,30)
Ak_vec4 <- c(11,44,77)
Ak_vec5 <- c(3,2,1)
#Crear 2 data.frames de 4 variables (columnas), a partir de los vectores anteriores
(Ak_dtfr1 <- data.frame(A=Ak_vec1,
                        B=Ak_vec2,
                        C=Ak_vec3,
                        D=Ak_vec4,
                        row.names = c("1","2","3"))) #Crear data.frame 1
(Ak_dtfr2 <- data.frame(W=Ak_vec2,
                        X=Ak_vec3,
                        Y=Ak_vec4,
                        Z=Ak_vec5,
                        row.names=c("7","8","9"))) #Crear data.frame 2
setdiff(Ak_dtfr1,Ak_dtfr2)

#12l-. Escriba un programa en R para encontrar elementos que estén presentes en dos data.frames dados. (ver ?intersect)
#Insertar una semilla para que se puedan replicar las funciones aleatorias
set.seed(240)
#Crear 2 data.frames con elementos aleatorios
(Al_d1 <- data.frame(A=sample(x = letters,size = 4),
                     B=sample(x = letters,size = 4),
                     C=sample(x = letters,size = 4),
                     D=sample(x = letters,size = 4)))
(Al_d2 <- data.frame(W=sample(x = letters,size = 4),
                     X=sample(x = letters,size = 4),
                     Y=sample(x = letters,size = 4),
                     Z=sample(x = letters,size = 4)))
#Realizar una intersección para encontrar los elementos que se repiten
(Al_interseccion <- intersect(c(Al_d1$A,
                                Al_d1$B,
                                Al_d1$C,
                                Al_d1$D),
                              c(Al_d2$W,
                                Al_d2$X,
                                Al_d2$Y,
                                Al_d2$Z)))
#Resulta un vector de tipo character que contiene los elementos repetidos de ambos data.frames

#13m-. Escriba un programa en R para encontrar elementos que vienen solo una vez y que son comunes a ambos data.frames dados. (ver ?union)
#Se reutilizarán los data.frames del ejercicio anterior
(Am_union <-  union(c(Al_d1$A,
                      Al_d1$B,
                      Al_d1$C,
                      Al_d1$D),
                    c(Al_d2$W,
                      Al_d2$X,
                      Al_d2$Y,
                      Al_d2$Z)))
#Resulta un vector de tipo character que contiene los elementos únicos de cada data.frame

#14n-. Escriba un programa R para contar el número de valores NA en una columna de data.frames.
#Crear 3 vectores numéricos, todos de 6 elementos y que contengan NA
An_vec1 <- c(1,2,NA,4,NA,NA)
An_vec2 <- c(10,NA,14,16,NA,20)
An_vec3 <- c(NA,18,27,NA,NA,NA)
#Crear data.frame a partir de los vectores dados
An_dtfr <- data.frame(Sec1=An_vec1,Sec2=An_vec2,Sec3=An_vec3)
#Preguntar por la cantidad de valores NA de la columna 1
sum(is.na.data.frame(x = An_dtfr[1]))
#Preguntar por la cantidad de valores NA de la columna 2
sum(is.na.data.frame(x = An_dtfr[2]))
#Preguntar por la cantidad de valores NA de la columna 3
sum(is.na.data.frame(x = An_dtfr[3]))

 #15o-. Escriba un programa en R para crear un data.frame utilizando dos vectores dados y muestre los elementos duplicados y las filas únicas de dicho data.frame. (ver ?duplicated)
#Crear dos vectores de carácteres, todos de 3 elementos
Ao_vec1 <- c("Dream","Hope","Love")
Ao_vec2 <- c("Sweet","Salty","Tasty")
#Crear data.frame a partir de los vectores anteriores; uno de ellos duplicado
(Ao_dtfr <- data.frame(A=Ao_vec1,B=Ao_vec2,C=Ao_vec1,D=Ao_vec1))
duplicated.data.frame(Ao_dtfr)




#16p-. Escriba un programa en R para llamar al conjunto de datos (incorporado) airquality. Elimine las variables ‘Solar.R’ y ‘Wind’ y muestre el data.frame.
airquality
airquality$Solar.R <- NULL
airquality$Wind <- NULL
airquality

#17q-. Escriba un programa R para llamar al conjunto de datos (integrado) airquality. ¿Comprueba si es un marco de datos o no? Ordene todo el marco de datos por la primera y segunda columna. (ver ?order)




#       B. LISTAS

#1a-. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista.
#Crear vectores y matriz que se utilizarán para crear las listas
Ba_vec <- 10:20
Ba_mat <- matrix(data=1:16,ncol=4,nrow=4)
Ba_log <- Ba_vec < 15
Ba_cha <- c("Chile","España","Argentina")
#Crear la lista 1, con nombres para cada elemento
Ba_lis1 <- list(Lógico=Ba_log,Países=Ba_cha)
#Crear la lista 2, con nombres para cada elemento
(Ba_lis2 <- list(Números=Ba_vec,Matriz=Ba_mat,Lista1=Ba_lis1)) #Contiene un vector, una matriz y una lista, cada uno con sus respectivos nombres

#2b-. Escriba un programa en R para crear una lista que contenga un vector, una matriz y una lista y asigne nombres a los elementos de la lista. Accede al primer y segundo elemento de la lista.
#Crear vectores y matriz que se utilizarán para crear las listas
Bb_vec <- c(40,60,20,80)
Bb_mat <- matrix(data=1:9,ncol=3,nrow=3)
Bb_log <- c(TRUE,FALSE,TRUE,FALSE,FALSE)
Bb_cha <- c("Amarillo","Azul","Verde","Celeste")
#Crear la lista 1, con nombres para cada elemento
Bb_lis1 <- list(Lógico=Bb_log,Colores=Bb_cha)
#Crear la lista 2, con nombres para cada elemento
(Bb_lis2 <- list(Números=Bb_vec,Matriz=Bb_mat,Lista1=Bb_lis1))
Bb_lis2[1] #Acceder al primer elemento de la lista 2
Bb_lis2[2] #Acceder al segundo elemento de la lista 2

#3c-. Escriba un programa R para crear una lista que contenga un vector, una matriz y una lista y agregue un elemento al final de la lista.
#Crear una lista que contiene un vector, una matriz y una lista
Bc_lis <- list(c("Santiago","Pucón","Algarrobo"),
               matrix(data=1:12,nrow=4,ncol=3),
               list(c(1,3,7,8),c(TRUE,FALSE))) 
#Agregar un el elemento al final de la lista
(Bc_lis <- c(Bc_lis,"Pimiento"))

#4d-. Escriba un programa en R para seleccionar el segundo elemento de una lista anidada determinada.
#Acceder al segundo elemento de la lista Ba_lis1 contenida en la lista Ba_lis2
Ba_lis2[[3]][2]

#5e-. Escriba un programa R para fusionar dos listas dadas en una lista.
#Crear una lista que contiene los elementos de Ba_lis2 y Bb_lis2
Be_lis <- c(Ba_lis2,Bb_lis2) 
Be_lis #Resulta una lista de 6 elementos

#6f-. Escriba un programa en R para convertir una lista dada en vector.
(Bf_vec1 <- Ba_lis1[1])
(Bf_vec2 <- Ba_lis1[2])

#7g-. Escriba un programa en R para crear una lista de data.frames y acceda a cada uno de esos data.frames de la lista.
#Crear una lista a partir de 3 data.frames de ejercicios anteriores
Bg_lis <- list(Ab_dtfr,Ag_dtfr,Ai_dtfr)
Bg_lis[[1]] #Acceder al elemento 1: Ab_dtfr
Bg_lis[[2]] #Acceder al elemento 2: Ag_dtfr
Bg_lis[[3]] #Acceder al elemento 3: Ai_dtfr

#8h-. Escriba un programa R para contar el número de objetos en una lista dada.
length(Bg_lis)

#9i-. Escriba un programa en R para convertir una matriz dada en una lista.
#Crear matriz
Bi_mat <- matrix(data=1:9,nrow=3,ncol=3)
(Bi_lis <- list(Bi_mat))

#10j-. Escriba un programa R para asignar NULL a un elemento de lista dado.
Be_lis$Matriz <- NULL
Be_lis

#11k-. Escriba un programa R para crear una lista llamada s que contenga una secuencia de 15 letras mayúsculas, comenzando desde ‘E’.
(s <- list(LETTERS[5:19]))

#12l-. Escriba un programa R para asignar nuevos nombres “a”, “b” y “c” a los elementos de una lista dada.
(Bl_lis <- list(a=Ab_dtfr,b=Ag_dtfr,c=Ai_dtfr))

#13m-. Escriba un programa en R para obtener la longitud de los dos primeros vectores de una lista dada.
#Crear 2 vectores numéricos
Bm_vec1 <- 1:14
Bm_vec2 <- 3:20
#Crear una lista a partir de los 2 vectores
Bm_lis <- list(Bm_vec1,Bm_vec2)
length(Bm_lis[[1]])
length(Bm_lis[[2]])

#14n-. Escriba un programa R para encontrar todos los elementos de una lista dada que no están en otra lista dada. (ver ?setdiff)
setdiff(Ba_lis2,Be_lis)




