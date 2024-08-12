#1
exVec1 <- c( -10, -17, 17, -28, 21)
exVec2 <- c(13, -26, -48, 16, 34)
exVec3 <- c(-5, -4.5, -4, -3.5, -3, -2.5, -2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5)

#2
exVec_resultado <- c("exVec1", "exVec2")

#3
exVec1 [3]
exVec2 [1-3] [2-4]

#4
sum <- sum(exVec2)
length<- length(exVec2)
prom_exVec2 <- sum/length
resultado <- na.omit(prom_exVec2)

#5
rnorm(6) + rnorm(2) #crea valores aleatorios en una distribucion normal, con un promedio de 1 y una desviacion estandar de 0, por lo cual ahora mismo esta sumando ambas desviaciaciones estandar

#6
[] #indexacion
() #funcion
#discretos (datos vectoriales), continuos (datos raster)
#sp y sf, sp es mas anticuado que el sf, por ello se ha usado mas que el sf pero el sf es mejor que el sp (ambos trabajan de tipos espaciales vectoriales)
#7

#8
data.frame(mtcars[1])
data.frame(mtcars[,1])
data.frame(mtcars[,1 , drop = TRUE])

#9
m <- matrix(1:9,3)
m
#codigo 1
m[,1]

#codigo 2
m[,1,drop = FALSE]
#Al poner FALSE en la funcion drop hace que en vez de tomar la columna tome la fila, ya que por defecto esta funcion viene en TRUE por lo cual al dejar la funcion en FALSE toma la fila


#10 
m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)
m3 <- m1+m2
m3
?sample
x <- 1:12
sample(x)
sample(x, replace= TRUE)

#11
Species <- iris$Species
Petal.Width <- iris$Petal.Width
Sepal.Length <- iris$Sepal.Length
iris2 <- data.frame(Species, Petal.Width, Sepal.Length)
iris3 <- iris[c("27", "143", "148", "138", "125"),]
iris3 <- iris[c(27, 143, 148, 138, 125),]
iris4 <-iris[c(Sepal.Length(max(6)),]

#12
read.csv("data/datos_ema_126.csv")
data <- read.csv ("data/datos_ema_126.csv")



vectornumero <- c(1,2,3,4,5)
vectorcaracter <- c('bastian','jose','diego','martin','nacho')
vectorlogico <- c(FALSE,TRUE,FALSE,FALSE,FALSE)

data <- data.frame(
  numeros =vectornumero,
  caracteres = vectorcaracter,
  logicos = vectorlogico
)
data

#14
install.packages("sf")
install.packages("tibble")
library(sf)
data <- read_sf("data/datos_ema_254.csv")

#Parte 2
dim(data)
length(data)
class(data$humed_rel_promedio)
class(data$fecha_hora)
class(data$veloc_max_viento)
str(data)
head(data)
tail(data)
nrow(data)
ncol(data)

summary(data)

temp_promedio <- data$humed_rel_promedio
temp_promedio[14]
velocidad_max <- data$veloc_max_viento
fecha_hora <- data$fecha_hora
datos_21.csv <- data.frame(velocidad_max, temp_promedio,fecha_hora)
write.csv(datos_21.csv)
