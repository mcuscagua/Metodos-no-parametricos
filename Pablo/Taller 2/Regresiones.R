
library(readxl)
db = read_excel("C:/Users/Pablo Saldarriaga/Google Drive/EAFIT/09. Noveno Semestre/T�cnicas Estad�sticas Robustas y no Param�tricas/Taller 2/base.xlsx")
setwd("C:/Users/Pablo Saldarriaga/Google Drive/EAFIT/09. Noveno Semestre/T�cnicas Estad�sticas Robustas y no Param�tricas/Taller 2")


#Punto 3 del taller - Smirnov-Kolmogorov
Y = db[,12]
X = db[,-12]
X = X[,-c(1:4)]

y = as.matrix(Y)


sk = c(-1)

for (i in 1:dim(X)[2]){
  print(i)
  x = as.matrix(X[,i])
  resultado = ks.test(y,x)
  sk = c(sk,resultado$p.value)
}
sk = sk[-1]
write.csv(sk,"Kolmogorov-smirnov.csv")




#install.packages("KernSmooth")
library(MASS)

#Punto 5 del taller Regresi�n Robusta

#Regresion Normal
ols = lm('barcelona12 ~ alava5 + 	albacete6 + 	alicante7 + 	almeria8 + 	avila9 + 	badajoz10 + 	
         baleares11 + 	burgos13 + 	caceres14 + 	cadiz15 + 	castellon16 + 	ceuta17 + 	
         cordoba18 + 	coru�a19 + 	creal20 + 	cuenca21 + 	gerona22 + 	granada23 + 	
         guadalajara24 + 	guipuzcoa25 + 	huelva26 + 	huesca27 + 	jaen28 + 	leon29 + 	
         rioja30 + 	lugo31 + 	lleida32 + 	madrid33 + 	malaga34 + 	melilla35 + 	murcia36 + 	
         orense37 + 	asturias38 + 	palencia39 + 	laspalmas40 + 	navarra41 + 	pontevedra42 + 	
         salamanca43 + 	tenerife44 + 	cantabria45 + 	segovia46 + 	sevilla47 + 	soria48 + 	
         tarragona49 + 	teruel50 + 	toledo51 + 	valladolid52 + 	valencia53 + 	vizcaya54 + 	
         zamora55 + 	zaragoza56', db)

summary(ols)

#Regresion robusta
robusta = rlm(formula = barcelona12 ~ alava5 + 	albacete6 + 	alicante7 + 	almeria8 + 	avila9 + 	badajoz10 + 	
         baleares11 + 	burgos13 + 	caceres14 + 	cadiz15 + 	castellon16 + 	ceuta17 + 	
         cordoba18 + 	coru�a19 + 	creal20 + 	cuenca21 + 	gerona22 + 	granada23 + 	
         guadalajara24 + 	guipuzcoa25 + 	huelva26 + 	huesca27 + 	jaen28 + 	leon29 + 	
         rioja30 + 	lugo31 + 	lleida32 + 	madrid33 + 	malaga34 + 	melilla35 + 	murcia36 + 	
         orense37 + 	asturias38 + 	palencia39 + 	laspalmas40 + 	navarra41 + 	pontevedra42 + 	
         salamanca43 + 	tenerife44 + 	cantabria45 + 	segovia46 + 	sevilla47 + 	soria48 + 	
         tarragona49 + 	teruel50 + 	toledo51 + 	valladolid52 + 	valencia53 + 	vizcaya54 + 	
         zamora55 + 	zaragoza56, data = db)

summary(robusta)


for (i in 1:dim(X)[2]){
  print(i)
  x = as.matrix(X[,i])
  robusta = rlm(y ~x)
  print(summary(robusta))
}

