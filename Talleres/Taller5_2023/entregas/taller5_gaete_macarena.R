install.packages("terra")
library("terra")
#1
r <- rast()
r <-rast(xmin=-70.6667,xmax=-69.6667,ymin=-33.5,ymax=-32.5)
r
resolucion
res(r)
valorpixeles
values(r)
#2 
r <-rast(xmin=-70.6667,xmax=-69.6667,ymin=-33.5,ymax=-32.5,nrows=10,ncols=5)
dim(r)
res(r)
r
ncell(r)
ext(r)
values(r)<-1:50
values(r)
plot(r)
text(r)
#3
e <-rast(xmin=350000,xmax=450000,ymin=6400000,ymax=6500000,ncols=10,nrows=10,crs="EPSG:32719")
e
values(e)<-100:1
plot(e)
text(e)
#4
f <-rast(ncols=3,nrows=3,nlyrs=3)
f
values(f) <- 1:27
plot(f)
plot(f[[1]]);text(f[[1]])
plot(f[[2]]);text(f[[2]])
plot(f[[3]]);text(f[[3]])
#5
f_sum1 <- f[[1]]+f[[2]]+f[[3]]
f_sum1
plot(f_sum1)
text(f_sum1)
#6
jj <-sqrt(f_sum1)
plot(jj)
text(jj)
#guardar raster

writeRaster(jj,"r_sqrt.tif")