#           Uso Avanzado de Sistemas de Información Geográfica
#                     Taller 1: Ejercicios R base

#       A. LO BÁSICO

#a-.Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.
(Aa_sec <- c(20:50))
(Aa_med <- mean(20:60))
(Aa_sum <- sum(51:91))

#b-.Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria.
Ab_dis <- rnorm(n=10000,mean=100,sd = 10)
(Ab_his <- hist(Ab_dis))

#c-. Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.
Ac_vec1 <- c(9,19,24)
Ac_vec2 <- c("cerdo, mapache, oso")
Ac_mat1 <- matrix(1:20,nrow=5,ncol=4)
Ac_colors <- c("rojo","azul","morado","rosa","rojo","verde","azul","gris","morado","celeste","rojo","azul")
Ac_mat2 <- matrix(Ac_colors,nrow=4,ncol=3)
(Ac_lis <- list(Números=Ac_vec1,Animales=Ac_vec2,M_Números=Ac_mat1,M_Colores=Ac_mat2,funcion1=args,funcion2=which))

#d-. Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.
(Ad_mat1 <- matrix(data=1:20,nrow = 5,ncol=4))

Ad_mat2 <- matrix(data=1:9,nrow=3,ncol=3,byrow=TRUE)
rownames(Ad_mat2) <- c("row1","row2","row3")
colnames(Ad_mat2) <- c("col1","col2","col3")
Ad_mat2

Ad_mat3 <- matrix(data=1:4,nrow=2,ncol=2,byrow=FALSE)
rownames(Ad_mat3) <- c("1","2")
colnames(Ad_mat3) <- c("A","B")
Ad_mat3

#e-. Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.
Ae_gene <- c("Masculino","Masculino","Femenino","Femenino","Femenino")
Ae_edad <- c(42,37,36,41,30)
Ae_rut <- c(134410772,141574356,139793551,137664093,145505147)
Ae_dire <- c("San Francisto 456","Luis de la Torre 31","Río bueno 42","San Pablo 1440","Maipu 560")
Ae_prof <- c("Gerente general","Contador auditor","Ingeniería industrial","Técnico de operaciones logísticas","Gerente de operación")
(Ae_dtfr <- data.frame(Género=Ae_gene,Edad=Ae_edad,Rut=Ae_rut,Dirección=Ae_dire,Profesión=Ae_prof))
summary.data.frame(Ae_dtfr)


#       B. VECTORES

#a.- Escriba un programa en R para crear un vector de un tipo y una longitud específicos. Cree vectores de tipos numéricos, complejos, lógicos y de caracteres de longitud 6.
Ba_vec1 <- 10:5
Ba_vec2 <- c(10,20,30,40,50,60)
Ba_vec3 <- c(1i,3-2i,10+4i,6i,11i,7-3i)
Ba_vec4 <- c(14i,2+2i,5-3i,9i,20-5i,6i)
Ba_vec5 <- c(TRUE,TRUE,FALSE,TRUE,FALSE,FALSE)
Ba_vec6 <- c(FALSE,FALSE,TRUE,FALSE,TRUE,TRUE)
Ba_vec7 <- c("Mapache","Oso","Jirafa","Cerdo","Conejo","Perro")
Ba_vec8 <- rep(x = "Dandelion",times=6)
length(Ba_vec1)
length(Ba_vec2)
length(Ba_vec3)
length(Ba_vec4)
length(Ba_vec5)
length(Ba_vec6)
length(Ba_vec7)
length(Ba_vec8)

# b-. Escriba un programa en R para sumar dos vectores de tipo entero y longitud 3.
Bb_vec1 <- c(4L,7L,16L)
Bb_vec2 <- c(8L,10L,2L)
(Bb_suma <- Bb_vec1 + Bb_vec2)

# c-. Escriba un programa en R para encontrar la suma, la media y el producto de un vector.
Bc_vec <- 1:20
(Bc_sum <- sum(Bc_vec))
(Bc_med <- mean(Bc_vec))
(Bc_pro <- prod(Bc_vec))

# d-. Escriba un programa R para encontrar la suma, la media y el producto de un vector, ignore elementos como NA o NaN.
Bd_vec <- c(NA,1,33,17,NA,25,22)
(Bd_sum <- sum(Bd_vec,na.rm=TRUE))
(Bd_med <- mean(Bd_vec,na.rm=TRUE))
(Bd_prod <- prod(Bd_vec,na.rm=TRUE))

# e-. Escriba un programa en R para ordenar un Vector en orden ascendente y descendente.
Be_vec <- c(9,24,19,2,30,22)
(Be_vec_cre <- sort(Be_vec,decreasing = FALSE))
(Be_vec_dec <- sort(Be_vec,decreasing=TRUE))

# f-. Escriba un programa R para probar si un vector dado contiene un elemento específico.
Be_vec == 19 #En caso de que se busque obtener un vector lógico como salida
19 %in% Be_vec #En caso de que se busque obtener una sola respuesta lógica

# g-. Escriba un programa R para encontrar el segundo valor más alto en un vector dado.
Bg_vec <- c(23,56,3,96,12,45)
(Bg_vec_dec <- sort(Bg_vec,decreasing=TRUE))
Bg_vec_dec[2]

# h-. Escriba un programa en R para encontrar el enésimo valor más alto en un vector dado.
Bh_vec <- 1:100
Bh_vec_dec <- sort(Bh_vec,decreasing=TRUE)
Bh_vec_dec[1] #Primer valor más alto
Bh_vec_dec[2] #segundo valor más alto
Bh_vec_dec[3] #tercer valor más alto

# i-. Escriba un programa en R para convertir la(s) columna(s) dada(s) de un data.frame en un vector.
(Bi_v1 <- Ae_dtfr[,1])
(Bi_v2 <- Ae_dtfr[,2])
(Bi_v3 <- Ae_dtfr[,3])
(Bi_v4 <- Ae_dtfr[,4])
(Bi_v5 <- Ae_dtfr[,5])

# j-. Escriba un programa R para encontrar los elementos de un vector dado que no están en otro vector dado.
Bj_vec1 <- c(2,9,19,22,24,30)
Bj_vec2 <- c(4,7,9,17,21,22)
setdiff(Bj_vec1,Bj_vec2) #Para encontrar qué elementos de Bj_vec1 no están en Bj_vec1
setdiff(Bj_vec2,Bj_vec1) #Para encontrar qué elementos de Bj_vec2 no están en Bj_vec1

# k-. Escriba un programa en R para invertir el orden del vector dado.
Bk_vec <- 1:50
(bk_vec_rev <- rev(Bk_vec))

# l-. Escriba un programa en R para crear un vector y encuentre la longitud y la dimensión del vector.
Bl_vec <- c(9,19,24,30)
(Bl_lon <- length(Bl_vec))
(Bl_dim <- dim(Bl_vec))

# m-. Escriba un programa R para probar si el valor del elemento de un vector dado es mayor que 10 o no. Devuelve TRUE o FALSE
Bm_vec <- 5:35
Bm_valor <- Bm_vec[3] #En este caso, se extrae el tercer valor
Bm_valor > 10

# n-. Escriba un programa en R para sumar 3 a cada elemento en un vector dado. Imprime el vector original y el nuevo.
(Bn_vec <- 1:20)
(Bn_suma <- Bn_vec+3)

# o-. Escriba un programa en R para crear un vector usando el operador : y la función seq().
Bo_vec1 <- 1:100
Bo_vec2 <- seq(from=0,to=100,by=10)
  
  
#       C. FACTORS

# a-. Escriba un programa R para encontrar los niveles de factor de un vector dado.
(Ca_colores <- factor(
  c("azul","rojo","amarillo","rojo","verde","amarillo","azul",
    levels=c("azul","rojo","amarillo","verde"))))
(Ca_niveles <- levels(Ca_colores))

# b-. Escriba un programa R para cambiar el primer nivel de un factor con otro nivel de un factor dado.
levels(Ca_colores)[1] <- levels(iris$Species)[1]
levels(Ca_colores)

# c-. Escriba un programa en R para crear un factor ordenado a partir de datos que consisten en los nombres de los meses.
Cc_meses <- month.name
(Cc_fac <- factor(Cc_meses,levels=Cc_meses))
(Cc_fac2 <- factor(Cc_meses,ordered=TRUE))

# d-. Escriba un programa R para extraer los cinco niveles de factor creados a partir de una muestra aleatoria de las letters (parte de la distribución base R).
set.seed(123)
Cd_letras <- sample(letters,5)
Cd_fac <- factor(Cd_letras)
levels(Cd_fac)

# e-. Escriba un programa en R para crear un factor correspondiente al conjunto de datos de la altura de las mujeres, que contenga la altura y el peso de una muestra de mujeres.
Ce_grupo <- factor(c("G1","G2","G1","G2"))
Ce_altura <- c(1.67,1.55,1.63,1.70)
Ce_peso <- c(55,61,62,65)
Ce_dtfr <- data.frame(Ce_grupo,Ce_altura,Ce_peso)
str(Ce_dtfr)


#       D. MATRICES

# a-. Escriba un programa en R para crear una matriz en blanco.
Da_mat <- matrix(data=NA,nrow=5,ncol=5)

# b-. Escriba un programa en R para crear una matriz tomando como entrada un vector dado de números. Muestre la matriz.
Db_vec <- 1:20
(Db_mat <- matrix(Db_vec,nrow=4,ncol=5)) #NOTA: si la matriz es de menor cantidad de elementos que el vector, se asignan los primeros elementos

# c-. Escriba un programa en R para crear una matriz que tome un vector dado de números como entrada y defina los nombres de columna y fila. Muestre la matriz.
Dc_mat <- matrix(Db_vec,nrow=5,ncol=4,byrow = TRUE)
rownames(Dc_mat) <- c(1,2,3,4,5)
colnames(Dc_mat) <- c("A","B","C","D")
Dc_mat

# d-. Escriba un programa en R para crear dos matrices de 2x3, luego sume, reste, multiplique y divida las matrices.
Dd_mat1 <- matrix(data=5:10,nrow=2,ncol=3)
Dd_mat2 <- matrix(data=15:20,nrow=2,ncol=3)
(Dd_sum <- Dd_mat1+Dd_mat2)
(Dd_res <- Dd_mat1-Dd_mat2)
(Dd_mul <- Dd_mat1*Dd_mat2)
(Dd_div <- Dd_mat1/Dd_mat2)

# h-. Escriba un programa en R para crear una matriz de correlación a partir de un data.frame del mismo tipo de datos.
Dh_dtfr <- data.frame(S1=c(1,2,3,4,5),S2=c(34,56,76,78,90),S3=c(11,12,26,34,35),S4=c(45,46,49,55,60),S5=c(90,95,96,97,100))
(Dh_cor <- cor(Dh_dtfr))

# i-. Escriba un programa R para encontrar el índice de fila y columna de valor máximo y mínimo en una matriz dada.
Di_vec <- c(8,3,45,23,33,12,64,30,2,3,56,41,49,32,53,12,11,9,5,60)
(Di_mat <- matrix(data=Di_vec,nrow=4,ncol=5))

(Di_max <- max(Di_mat))
(Di_log_max <- Di_mat == Di_max)
(Di_rowcol_max <- which(Di_log_max,arr.ind = TRUE))

(Di_min <-min(Di_mat))
(Di_log_min <- Di_mat == Di_min)
(Di_rowcol_min <- which(Di_log_min,arr.ind=TRUE))

# j-. Escriba un programa R para concatenar dos matrices dadas de la misma columna pero filas diferentes.
Dj_mat1 <- matrix(data=12:1,nrow=3,ncol=4)
Dj_mat2 <- matrix(data=21:40,nrow=5,ncol=4)
(Dj_union <- rbind(Dj_mat1,Dj_mat2))
