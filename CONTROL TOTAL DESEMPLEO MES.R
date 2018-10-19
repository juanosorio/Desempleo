source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.r')

# PARAMETROS
###########################################
###########################################
PERFIL.500 <- 'PL0303301102018.TXT'  ###
PERFIL.501 <- '.TXT'  ###
PERFIL.506 <- '.TXT'  ###
                                        ###
#no olvide corregir el erchivo de RNPN  ###
# cambiar [,] por [.]                   ###
RPND.VIRGEN <- 'SOP03024092018.csv'     ###
                                        ###
P500 <- "P500201809"                    ###
P501 <- "P501201809"                    ###
P506 <- "P506201809"                    ###
                                        ###
FECHA_EQUIPO_INF <- "01-09-2018"        ###
FECHA_EQUIPO_SUP <- "01-10-2018"        ###
                                        ###
FECHA_CIERRE_ANT <- "31-08-2018"        ###
FECHA_CIERRE_ACT <- "31-09-2018"        ###
                                        ###
RPND <- "RPND201809"                    ###
SOP0 <-"SOP03024092018"                 ###
                                        ###
año.mes<-"201809"                       ###
###########################################
###########################################
                                        ###
#RECAUDO                                ###
PRI500_TXT<-"0303350031012017PRI"       ###
PRI501_TXT<-"0303350131012017PRI"       ###
CAN500_TXT<-"0303350031012017CAN"       ###
CAN501_TXT<-"0303350131012017CAN"       ###
FECHA     <-201806                      ###
###########################################


source('C:/Users/Public/Documents/DESEMPLEO/R/carga_500.R')
#source('C:/Users/Public/Documents/DESEMPLEO/R/carga_501.R')
#source('C:/Users/Public/Documents/DESEMPLEO/R/carga_506.R')
source('C:/Users/Public/Documents/DESEMPLEO/R/CONTROL DESEMPLEO v2.R')
source('C:/Users/Public/Documents/DESEMPLEO/R/RPND - csv.R')
source('C:/Users/Public/Documents/DESEMPLEO/R/ACTIVO_REASEGURO V2.R')
# 
 source('C:/Users/Public/Documents/DESEMPLEO/R/SINIESTROS PARA PYG.R')

source('C:/Users/Public/Documents/DESEMPLEO/R/RECAUDO PRI CAN v2.R')



dbGetQuery(
  con,paste(
    "

INSERT INTO HIST_POL_DESEM
SELECT RAM,NUMERO_POLIZA AS NUM_POL, LINEA_CRED AS PRODUCTO
FROM ",P500,";

INSERT INTO HIST_POL_DESEM
SELECT RAM, NUMERO_POLIZA AS NUM_POL, LINEA_CRED AS PRODUCTO
FROM ",P501,";

SELECT DISTINCT *
  INTO HIST_POL_DESEM_1
FROM HIST_POL_DESEM;

DROP TABLE IF EXISTS HIST_POL_DESEM;

SELECT*
  INTO HIST_POL_DESEM
FROM HIST_POL_DESEM_1;

DROP TABLE IF EXISTS HIST_POL_DESEM_1;

"
    ,sep=""))



