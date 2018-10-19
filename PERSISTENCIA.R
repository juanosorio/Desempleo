library(dplyr)
library(reshape2)
library(ChainLadder)
source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.r')
source('C:/Users/Public/Documents/R/DINAMICA TO DATA FRAME.r')

x<-dbGetQuery(con,
"
WITH A AS (
SELECT DISTINCT
DATE_PART('YEAR',FEC_VIG_POL)AS ANO_VIG, 
DATE_PART('MONTH',FEC_VIG_POL) MES_VIG,
CASE
WHEN TIPO_END='      AT ' THEN DATE_PART('YEAR',FECHA_EQUIPO)
END AS ANO_CANC,
CASE
WHEN TIPO_END='      AT ' THEN DATE_PART('MONTH',FECHA_EQUIPO)
END AS MES_CANC,
NUMERO_POLIZA,
NIT_ASEGURADO,
TIPO_END
FROM PL_TOTAL
WHERE LINEA_CRED='CREDIEXPRESS' --AND FEC_VIG_POL >= '2017-03-01'AND FEC_VIG_POL < '2017-04-01'  --AND FECHA_EQUIPO < '2017-01-01'
AND (NUMERO_POLIZA-FLOOR(NUMERO_POLIZA/100)*100)=1 
)
,
B AS ( 
SELECT  *,
row_number() over(
partition by numero_poliza, nit_asegurado
order by numero_poliza, nit_asegurado) as num_mov
FROM  A
WHERE ANO_CANC > 0 OR TIPO_END='         '
)
,
C AS (
SELECT DISTINCT NUMERO_POLIZA, NIT_ASEGURADO, 1 AS CUENTA
FROM B
)
,

D AS (
SELECT B.*
FROM C LEFT JOIN B ON 
C.NUMERO_POLIZA=B.NUMERO_POLIZA AND
C.NIT_ASEGURADO=B.NIT_ASEGURADO AND
C.CUENTA=B.NUM_MOV
)
,

E AS (
SELECT DISTINCT ANO_VIG, MES_VIG, MAX(ANO_CANC) AS ANO_CANC, MAX(MES_CANC) AS MES_CANC, NUMERO_POLIZA, NIT_ASEGURADO
FROM A
WHERE  TIPO_END='      AT '
GROUP BY ANO_VIG, MES_VIG, ANO_CANC, NUMERO_POLIZA, NIT_ASEGURADO
)
,

F AS (
SELECT D.ANO_VIG, D.MES_VIG,D.NUMERO_POLIZA,D.NIT_ASEGURADO, E.ANO_CANC, E.MES_CANC
FROM D LEFT JOIN E ON 
D.NUMERO_POLIZA=E.NUMERO_POLIZA AND
D.NIT_ASEGURADO=E.NIT_ASEGURADO)


SELECT*,
CASE
WHEN ANO_CANC IS NULL THEN NULL 
WHEN NUMERO_POLIZA > 0 AND MES_CANC IS NOT NULL THEN (ANO_CANC-ANO_VIG)*12+(MES_CANC-MES_VIG)
END AS LAG
FROM F
ORDER BY ANO_VIG, MES_VIG, NUMERO_POLIZA, NIT_ASEGURADO
;

")



#armar un triangulo con las los nuevos negocios por cohorte a partir de la consulta de sql

rm(x1,x2,x3,x4)
x1<-summarise(group_by(x,ano_vig,mes_vig),n())
x1<-as.data.frame(x1)
x4<-matrix(ncol = 4)
x4<-as.data.frame(x4)
names(x4)<-c('ano_vig','mes_vig','vigentes','lag')

for(i in 1:(max(x$lag)+1)){
  x2<-cbind(x1,rep(i-1,nrow(x1)))
  names(x2)<-c('ano_vig','mes_vig','vigentes','lag')
  x4<-rbind(x4,x2)
}


#convertirlo en triagulo 
x4<-x4[-1,]
x4<-cbind(x4,x4$ano_vig*100+x4$mes_vig)
names(x4)<-c('ano_vig','mes_vig','vigentes','lag','origin')
x5<-as.triangle(x4, origin = "origin", dev = "lag", "vigentes")


rm(x1,x2,x4)

# volver cuadrado el triangulo

#x5<-x5[((nrow(x5)-ncol(x5)+1):nrow(x5)),]
x5<-x5[22:65,1:44]
x5<-as.data.frame(x5)

#QUITAR LA PARTE INFERIOR DEL TRIANGULO y dejarlo cuadrado porque el for tiene un error
k<-1
for(i in 1:(nrow(x5)-1)){
  for(j in 1:(nrow(x5)-1)){
    x5[nrow(x5)+1-i,j+k]<-NA
  }
  k<-k+1
}

x5<-x5[1:nrow(x5),1:nrow(x5)]

#armar el triangilo de cancelaciones

y<-summarise(group_by(x,ano_vig,mes_vig,lag),n())
y$origin<-y$ano_vig*100+y$mes_vig
y<-as.triangle(y, origin = "origin", dev = "lag", "n()")
#y<-dcast(x,origin~lag, length)
##########y<-y[((nrow(x5)-ncol(x5)+1):nrow(x5)),]
y<-y[22:65,2:45]

n<-nrow(y)
k=0
for(j in 1:(n-2)){
  for(i in 1:(n-j)){
    if(n-i-k>=1){
      if(is.na(y[(n-i-k),(i+1)])==TRUE){
        y[(n-i-k),(i+1)]<-0
      }
    }
  }
  k<-k+1
}

y[1:7,1]<-0
y[9:14,1]<-0


y1<-incr2cum(y)
y1<-y1[,]

y2<-x5-y1

n <- nrow(y2)
f <- sapply(1:(n-1),
            function(i){
              sum(y2[c(1:(n-i)),i+1])/sum(y2[c(1:(n-i)),i])
            }
)
f





#FALTA RESTAR UN TRIANGULO DEL OTRO RECORDAR MANEJAR LAS MISMAS DIMENCIONES DE LAS MATRICES
colnames(y)
