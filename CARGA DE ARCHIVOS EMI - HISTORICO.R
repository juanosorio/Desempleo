source('C:/Users/Public/Documents/R/CONEXIONES/CONEXION LocalHost.r')
fichero<-dir('C:/Users/Public/Documents/DESEMPLEO/EMI/REPROCESO')

fichero<-dir('C:/Users/Public/Documents/DESEMPLEO/EMI/REPROCESO')

fichero<-'501_201806_0303350130062018EMI.txt'
fichero[1]
x<-substr(fichero,1,10)

# x<-vector()
# for(i in 1:length(fichero)){
#   
# }



#a�o<-2018

# for(i in 1:length(fichero)){
  # i<-1
  dbGetQuery(con, paste(
    "
    DROP TABLE IF EXISTS EMI",x[i],"_B, EMI",x[i],";
      CREATE TABLE EMI",x[i],"_B(
    UC CHARACTER (958)
    );
    
    COPY EMI",x[i],"_B
    FROM 'C:/Users/Public/Documents/DESEMPLEO/EMI/REPROCESO/",fichero[i],"'
    (ENCODING 'latin1');
    
    
    SELECT
    CAST(SUBSTRING(UC FROM		1	FOR	1	) AS	TEXT	)	AS	TIPO_TRASACCION 	,
    CAST(SUBSTRING(UC FROM		2	FOR	20	) AS	TEXT	)	AS	NUMERO_CREDITO	,
    CAST(SUBSTRING(UC FROM		23	FOR	8	) AS	TEXT	)	AS	FEC_INI_POL	,
    CAST(SUBSTRING(UC FROM		31	FOR	8	) AS	TEXT	)	AS	FEC_DESEMBOLSO	,
    CAST(SUBSTRING(UC FROM		39	FOR	12	) AS	TEXT	)	AS	MONTO_PRESTAMO	,
    CAST(SUBSTRING(UC FROM		51	FOR	3	) AS	TEXT	)	AS	DURACION_PRESTAMO	,
    CAST(SUBSTRING(UC FROM		54	FOR	4	) AS	TEXT	)	AS	TASA_INT	,
    CAST(SUBSTRING(UC FROM		58	FOR	3	) AS	TEXT	)	AS	PUNTAJE_CRED	,
    CAST(SUBSTRING(UC FROM		61	FOR	3	) AS	TEXT	)	AS	PORC_ENDEUDAMIENTO	,
    CAST(SUBSTRING(UC FROM		64	FOR	12	) AS	TEXT	)	AS	AFORO	,
    CAST(SUBSTRING(UC FROM		76	FOR	12	) AS	TEXT	)	AS	PRIMA_TOTAL	,
    CAST(SUBSTRING(UC FROM		88	FOR	12	) AS	TEXT	)	AS	IVA	,
    CAST(SUBSTRING(UC FROM		100	FOR	12	) AS	TEXT	)	AS	MENSUALIDAD_PREST	,
    CAST(SUBSTRING(UC FROM		112	FOR	12	) AS	TEXT	)	AS	OTRO	,
    CAST(SUBSTRING(UC FROM		124	FOR	40	) AS	TEXT	)	AS	NOMBRE	,
    CAST(SUBSTRING(UC FROM		164	FOR	40	) AS	TEXT	)	AS	PRIM_APELLIDO	,
    CAST(SUBSTRING(UC FROM		204	FOR	40	) AS	TEXT	)	AS	SEG_APELLIDO	,
    CAST(SUBSTRING(UC FROM		244	FOR	8	) AS	TEXT	)	AS	FEC_NAC	,
    CAST(SUBSTRING(UC FROM		252	FOR	70	) AS	TEXT	)	AS	DIRECCION	,
    CAST(SUBSTRING(UC FROM		322	FOR	40	) AS	TEXT	)	AS	BARRIO	,
    CAST(SUBSTRING(UC FROM		362	FOR	40	) AS	TEXT	)	AS	CIUDAD	,
    CAST(SUBSTRING(UC FROM		402	FOR	40	) AS	TEXT	)	AS	DEPARTAMENTO	,
    CAST(SUBSTRING(UC FROM		442	FOR	5	) AS	TEXT	)	AS	COD_POSTAL	,
    CAST(SUBSTRING(UC FROM		447	FOR	1	) AS	TEXT	)	AS	SEXO	,
    CAST(SUBSTRING(UC FROM		448	FOR	3	) AS	TEXT	)	AS	DURACION_POLIZA	,
    CAST(SUBSTRING(UC FROM		451	FOR	10	) AS	TEXT	)	AS	CELULAR	,
    CAST(SUBSTRING(UC FROM		461	FOR	10	) AS	TEXT	)	AS	TELEFONO_CASA	,
    CAST(SUBSTRING(UC FROM		471	FOR	10	) AS	TEXT	)	AS	TELEFONO_OF	,
    CAST(SUBSTRING(UC FROM		481	FOR	2	) AS	TEXT	)	AS	TIPO_EMPLEADO	,
    CAST(SUBSTRING(UC FROM		483	FOR	2	) AS	TEXT	)	AS	TIPO_CONTRATO	,
    CAST(SUBSTRING(UC FROM		485	FOR	40	) AS	TEXT	)	AS	OCUPACION	,
    CAST(SUBSTRING(UC FROM		525	FOR	40	) AS	TEXT	)	AS	NOMBRE_EMPLEADOR	,
    CAST(SUBSTRING(UC FROM		565	FOR	16	) AS	TEXT	)	AS	CEDULA 	,
    CAST(SUBSTRING(UC FROM		581	FOR	2	) AS	TEXT	)	AS	TIPO_DOC	,
    CAST(SUBSTRING(UC FROM		583	FOR	5	) AS	TEXT	)	AS	COD_PROD	,
    CAST(SUBSTRING(UC FROM		588	FOR	5	) AS	TEXT	)	AS	SUBPRODUCTO	,
    CAST(SUBSTRING(UC FROM		593	FOR	3	) AS	TEXT	)	AS	OPCION	,
    CAST(SUBSTRING(UC FROM		596	FOR	3	) AS	TEXT	)	AS	ALTERNATIVA	,
    CAST(SUBSTRING(UC FROM		599	FOR	13	) AS	TEXT	)	AS	POLIZA	,
    CAST(SUBSTRING(UC FROM		612	FOR	3	) AS	TEXT	)	AS	RAMO	,
    CAST(SUBSTRING(UC FROM		615	FOR	3	) AS	TEXT	)	AS	PRUDUCTO_BOLIVAR	,
    CAST(SUBSTRING(UC FROM		618	FOR	1	) AS	TEXT	)	AS	NUMERO_ASEGURADOS	,
    CAST(SUBSTRING(UC FROM		619	FOR	40	) AS	TEXT	)	AS	NOMBRE1	,
    CAST(SUBSTRING(UC FROM		659	FOR	40	) AS	TEXT	)	AS	APELLIDO1	,
    CAST(SUBSTRING(UC FROM		699	FOR	40	) AS	TEXT	)	AS	APELLIDO2	,
    CAST(SUBSTRING(UC FROM		739	FOR	8	) AS	TEXT	)	AS	FECNAC1	,
    CAST(SUBSTRING(UC FROM		747	FOR	70	) AS	TEXT	)	AS	DIRECCION1	,
    CAST(SUBSTRING(UC FROM		817	FOR	40	) AS	TEXT	)	AS	BARRIO1	,
    CAST(SUBSTRING(UC FROM		857	FOR	40	) AS	TEXT	)	AS	CUIDAD1	,
    CAST(SUBSTRING(UC FROM		897	FOR	40	) AS	TEXT	)	AS	DEPARTAMENTO1	,
    CAST(SUBSTRING(UC FROM		937	FOR	5	) AS	TEXT	)	AS	COD_POSTAL1	,
    CAST(SUBSTRING(UC FROM		942	FOR	1	) AS	TEXT	)	AS	SEXO1	,
    CAST(SUBSTRING(UC FROM		943	FOR	4	) AS	TEXT	)	AS	COD_OFICINA_DAV	,
    CAST(SUBSTRING(UC FROM		947	FOR	30	) AS	TEXT	)	AS	PRIMA_TOTAL_VIDA	
    
    INTO EMI",x[i],"
    FROM EMI",x[i],"_B;
    
    DROP TABLE IF EXISTS EMI",x[i],"_B;
    
    insert into emi
    select ",substr(fichero[i], 5, 10),", *, cast(cedula as bigint) as N_ID--, cast(poliza as bigint) as num_pol
    from EMI",x[i],";

    drop table if exists emi_",x[i],";

    ",sep=""))
# }



