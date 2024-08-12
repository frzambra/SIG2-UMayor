#1
exVec1 <- c(4,-45,-4,-31,-32)
exVec2 <- c(21,4,17,43,12)
exVec3 <- seq(from=-5,to=5,by=0.5)
#2
exVec_resultado <- c(exVec1,exVec2)
exVec_resultado
#3

elemento <- exVec1[3]
elemento
elemento_2 <- c(exVec2[1],exVec2[4:5])
elemento_2

#4

# 4.1

length(exVec1)
length(exVec2)
length(exVec3)

# 4.2

sum(exVec1)

# 4.3

promedio <- mean(exVec2)

#4.4

resultado <- sum(exVec2)
resultado2 <- length(exVec2)
resultado3 <- resultado/resultado2

#4.5
promedio
resultado3

#5 crea distribuciones normal aleatorias y las suma 

#6 existe vectores de tipo numerico, complejo, logicos y de caracter

x<- vector("numerico",2)
x

c<- vector("complex",3)
c

i<- vector("logical",4)
i

chr<- vector("character",5)
chr

#7

l <- list(e1 = c(TRUE,FALSE,TRUE,TRUE,FALSE,FALSE),e2 = matrix(1:6,3), e3 = data.frame(mtcars))
l
#8

dfmtcars[c(1:32),1]

dfmtcars$mpg

#9 
m <- matrix(1:9,3)

#codigo 1 
m[,1]

#codigo 2 el drop evita la simplificacion del resultado a un vector. En su lugar mantienen la estructura por lo que esta indexando uma columna
m[,1,drop = FALSE]
#10

m1 <- matrix(1:sample(seq(9,18,3),1),3)
m2 <- matrix(1:sample(seq(9,18,3),1),3)

cbind(m1,m2)

#11

#11.1
dtra1 <- mtcars$drat
qsec1 <- mtcars$qsec
carb1 <- mtcars$carb
mtcars2 <-data.frame( dtra= dtra1, qsec = qsec1, carb = carb1)
mtcars2

mtcars22 <-mtcars[c(1:32),c(5,7,11)]
mtcars22
#11.2

mtcars2$nueva_col <- 1:32
mtcars2

#11.3

mtcars3<- mtcars[c(2,10,12,14,18),]
mtcars3

#11.4

#12
v1 <- 1:5
v2 <- c('a','b','c','d','e')
v3 <- c(TRUE,TRUE,FALSE,TRUE,FALSE)

df <- data.frame(numeros =v1, caracteres = v2, logicos = v3)
df

#13

#13.1
str(mtcars)

#13.2
ncol(mtcars)
nrow(mtcars)

#13.3

coldnames(mtcars)

#14  sf contiene al menos una geometría que incluye uno o más puntos, líneas o polígonos, un CRS y dataframe estructuras de datos de dos dimensiones que pueden contener datos de diferentes tipos, por lo tanto, son heterogéneas.



#Parte 2

#1

data <- read.csv2('data/datos_ema_126.csv')

#2

str(data)

#3

posicion_mayores_prom<-data$humed_rel_promedio>mean(data$humed_rel_promedio)

obs_mayores_prom<-data[posicion_mayores_prom,]
obs_mayores_prom

#4

obs_mayores_prom2<-data[posicion_mayores_prom,c("humed_rel_promedio", "fecha_hora","veloc_max_viento")]
obs_mayores_prom2
