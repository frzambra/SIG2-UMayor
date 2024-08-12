#Taller 1
#Integrantes: Pia Fuentes.

##LO BÁSICO
#1.Escriba un programa en R para crear una secuencia de números del 20 al 50 y encuentre la media de los números del 20 al 60 y la suma de los números del 51 al 91.

x<-20:50

x1<-20:60
mean(x1) #calcula el promedio
mean(20:60)#dentro del argumento defino el vector, hace lo mismo que arriba.

x2<-51:91
sum(x2) #para sumar
sum(51:91)

#2. Escriba un programa en R para crear una curva de campana de una distribución normal aleatoria
n<- rnorm(1000)#crear valores aleatorios, "randomnorm", longitud del vector 1000 (1000 eventos)
hist(n) #generar histograma

n2<-rnorm(1e5,mean=100,sd=10)
hist(n2)

#3.Escriba un programa R para crear una lista de elementos usando vectores, matrices y funciones. Imprime el contenido de la lista.

list(c(1:5), matrix(data=8, ncol=4, nrow=2),sqrt(8))

#4.Escriba un programa en R para crear una matriz de 5 x 4, una matriz de 3 x 3 con etiquetas y rellene la matriz por filas y una matriz de 2 x 2 con etiquetas y rellene la matriz por columnas.

matrix(1:20, ncol=4, nrow=5) #matrix 5x4

m2<-matrix(data=1:9, ncol=3, nrow=3, byrow=TRUE) #verificar si a,b y c son etiquetas
rownames(m2)<-c('a','b', 'c')
colnames(m2)<-c('a', 'b', 'c')
m2

m3<-matrix(1:4, ncol=2, nrow=2)
rownames(m3)<-c('a','b')
m3

#5.Escriba un programa R para crear un data.frame que contenga detalles (genero, edad, rut, dirección, profesión) de 5 empleados y muestre un resumen de los datos.

genero<-c('F','F','F', 'M','M')
edad<-c('20','25','19','15','50')
rut<-c('1','2','3','4','5') #me marca error si escribo un rut

dirección<-c('Quilicura', 'Maipú', 'Casablanca', 'Maipu', 'Pudahuel')
profesión<-c('Ing', 'Médico', 'Profesor', 'Médico', 'Dentista')
data.frame(genero,edad,rut,dirección,profesión)
