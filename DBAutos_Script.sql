
-------------------------Crear base de datos-----------------------
CREATE DATABASE BI_DBAutos2;
go

USE BI_DBAutos2;
go

----------------------------Tablas---------------------------
CREATE TABLE tblAuto(
strPlaca_AU VARCHAR(50) PRIMARY KEY  NOT NULL,   
strMarca_AU VARCHAR(50)  NOT NULL, 
strModelo_AU VARCHAR(50)  NOT NULL,
fltPrecio_AU Float  NOT NULL,
);

CREATE TABLE tblCliente(
strDocumento_CL VARCHAR(50)  NOT NULL primary key,  
strNombre_CL VARCHAR(50)  NOT NULL,  
strDireccion_CL VARCHAR(50)  NOT NULL, 
strTelefono_CL VARCHAR(50)  NOT NULL,
strCiudad_CL VARCHAR(50)  NOT NULL, 
CodigoCliente int identity not null,
);

CREATE TABLE tblRevision(
intCod_revision_RV Int Identity  PRIMARY KEY NOT NULL, 
strPlaca_AU VARCHAR(50)  NOT NULL, 
dateFecha_revision_RV Date NOT NULL
);

CREATE TABLE tblDetalle_revision(
intId_Detalle_revision_DRV INT IDENTITY  PRIMARY KEY NOT NULL, 
intCod_revision_RV Int NOT NULL,  
IdServicio int not null,
Aprobacion bit not null,
);

CREATE TABLE tblFactura(
intCod_facturaFAC INT IDENTITY  PRIMARY KEY NOT NULL,  
Cliente varchar(50)  NOT NULL,  
dateFecha_compraFAC Date NOT NULL,
total float not null
);

CREATE TABLE tblFactura_detalle(
idFactura_detalle INT IDENTITY  PRIMARY KEY NOT NULL,  
intCod_facturaFAC INT NOT NULL,   
strPlaca_AU VARCHAR(50)  NOT NULL,
total float not null
);

CREATE TABLE tblServicios(
IdServicio int identity primary key not null,
Descripcion varchar(30) not null,
)
Go
----------------------------------------------------------Relaciones


ALTER TABLE tblRevision ADD FOREIGN KEY (strPlaca_AU) REFERENCES tblAuto (strPlaca_AU);
ALTER TABLE tblDetalle_revision ADD FOREIGN KEY (intCod_revision_RV) REFERENCES tblRevision (intCod_revision_RV);
ALTER TABLE tblDetalle_revision ADD FOREIGN KEY (IdServicio) REFERENCES tblServicios (IdServicio);
ALTER TABLE tblFactura ADD FOREIGN KEY (Cliente) REFERENCES tblCliente (strDocumento_CL);
ALTER TABLE tblFactura_detalle ADD FOREIGN KEY (intCod_facturaFAC) REFERENCES tblFactura (intCod_facturaFAC);
ALTER TABLE tblFactura_detalle ADD FOREIGN KEY (strPlaca_AU) REFERENCES tblAuto (strPlaca_AU);
go

---------------------------------------------------------Registro
INSERT INTO tblAuto VALUES ('123','RENAULT','1998',8900000)
INSERT INTO tblAuto VALUES ('113','RENAULT','1998',8900000)
INSERT INTO tblAuto VALUES ('124','CHEVROLET','2000',12500000)
INSERT INTO tblAuto VALUES ('125','BMW','2014',25000000)
INSERT INTO tblAuto VALUES ('126','MERCEDEZ BENZ','2017',36000050)
INSERT INTO tblAuto VALUES ('127','SEAT','1999',24000000)
INSERT INTO tblAuto VALUES ('128','VOLSWAGUEN','2015',89000000)
go

INSERT INTO tblServicios VALUES ('Cambio de frenos')
INSERT INTO tblServicios VALUES ('Cambio de llantas')
INSERT INTO tblServicios VALUES ('Cambio de Aceite')
INSERT INTO tblServicios VALUES ('Revision general')
INSERT INTO tblServicios VALUES ('Cambio de filtros')
go

INSERT INTO tblCliente VALUES ('125478','ESTEBAN LOPEZ','CALLE 54 # 38-13','2135669','MEDELLIN')
INSERT INTO tblCliente VALUES ('257896','EIDER MONTOYA','CALLE 49 # 50-12','2189554','CALI')
INSERT INTO tblCliente VALUES ('325897','JOSE MUÑOZ','CALLE 32 # 28-15','2154897','BOGOTA')
INSERT INTO tblCliente VALUES ('458724','WILLIAM BELTRAN','CALLE 44 # 39-13','2198754','MANIZALES')
INSERT INTO tblCliente VALUES ('568794','CAMILO ZULUAGA','CALLE 13 # 28-11','2165445','POPAYAN')
INSERT INTO tblCliente VALUES ('187568','MARIANA ESTRADA','CALLE 64 # 39-23','2173695','MEDELLIN')
go

INSERT INTO tblFactura VALUES ('125478','2017/02/12',89000000)
INSERT INTO tblFactura VALUES ('125478','2017/03/12',89000000)
INSERT INTO tblFactura VALUES ('257896','2016/03/11',12500000)
INSERT INTO tblFactura VALUES ('325897','2017/12/12',25000000)
INSERT INTO tblFactura VALUES ('458724','2016/09/22',36000050)
INSERT INTO tblFactura VALUES ('568794','2017/11/16',24000000)
INSERT INTO tblFactura VALUES ('187568','2016/05/14',89000000)
INSERT INTO tblFactura VALUES ('125478','2016/05/24',89000000)
INSERT INTO tblFactura VALUES ('568794','2016/05/31',89000000)
go

INSERT INTO tblFactura_detalle VALUES (1,'123',89000000)
INSERT INTO tblFactura_detalle VALUES (1,'123',89000000)
INSERT INTO tblFactura_detalle VALUES (2,'124',12500000)
INSERT INTO tblFactura_detalle VALUES (2,'123',12500000)
INSERT INTO tblFactura_detalle VALUES (3,'125',25000000)
INSERT INTO tblFactura_detalle VALUES (4,'126',36000050)
INSERT INTO tblFactura_detalle VALUES (5,'127',24000000)
INSERT INTO tblFactura_detalle VALUES (6,'128',89000000)
INSERT INTO tblFactura_detalle VALUES (7,'128',89000000)
INSERT INTO tblFactura_detalle VALUES (8,'128',89000000)
go

INSERT INTO tblRevision VALUES ('123','2017/02/8')
INSERT INTO tblRevision VALUES ('123','2017/03/8')
INSERT INTO tblRevision VALUES ('123','2017/04/8')
INSERT INTO tblRevision VALUES ('123','2017/05/8')
INSERT INTO tblRevision VALUES ('123','2017/06/8')
INSERT INTO tblRevision VALUES ('124','2017/11/24')
INSERT INTO tblRevision VALUES ('125','2017/09/04')
INSERT INTO tblRevision VALUES ('126','2016/02/13')
INSERT INTO tblRevision VALUES ('127','2016/07/22')
INSERT INTO tblRevision VALUES ('128','2017/12/16')
go

INSERT INTO tblDetalle_revision VALUES (1,1,1)
INSERT INTO tblDetalle_revision VALUES (2,2,0)
INSERT INTO tblDetalle_revision VALUES (3,3,1)
INSERT INTO tblDetalle_revision VALUES (4,4,0)
INSERT INTO tblDetalle_revision VALUES (5,5,1)
INSERT INTO tblDetalle_revision VALUES (6,5,0)
go


SELECT f.dateFecha_compraFAC as Fecha, f.intCod_facturaFAC NroFactura
FROM tblFactura f
where f.dateFecha_compraFAC between '2016/05/01' and '2016/05/31'---revisiones hechas entre  '2016/05/01'  y '2016/05/31'

SELECT  COUNT(R.intCod_revision_RV) CANTIDAD_REVISIONES
FROM tblAuto A INNER JOIN tblRevision R
ON A.strPlaca_AU = R.strPlaca_AU
WHERE R.dateFecha_revision_RV between '2017/01/01' AND '2017/12/31' AND R.strPlaca_AU = '123' --- revisiones   hechas entre '2017/01/01' AND '2017/12/31'  de la placa 123


SELECT  COUNT(R.strPlaca_AU) Cambio_filtro_2016_2017
FROM tblAuto A INNER JOIN tblRevision R
ON A.strPlaca_AU = R.strPlaca_AU
INNER JOIN tblDetalle_revision D
ON R.intCod_revision_RV = D.intCod_revision_RV
WHERE D.IdServicio = 3 OR D.IdServicio = 5 AND R.dateFecha_revision_RV BETWEEN '2016/01/01' AND '2017/12/31' ---carros que han tenido cambio de filtro o aceite en 2016 y 2017


SELECT COUNT(R.intCod_revision_RV) REVICIONES_2017
FROM tblRevision R
WHERE R.dateFecha_revision_RV  between '2017/01/01' AND '2017/12/31' --- revisiones en el año 2017

SELECT COUNT(FD.idFactura_detalle)
FROM tblCliente C INNER JOIN tblFactura F
ON C.strDocumento_CL = F.Cliente
INNER JOIN tblFactura_detalle FD
ON F.intCod_facturaFAC = FD.intCod_facturaFAC -- numero de revisiones 




