CREATE DATABASE dbEDUCANDO_BI
go	
USE dbEDUCANDO_BI
go
--------- AREA ALMACEN
CREATE TABLE tblBIEN(
idtID INT IDENTITY PRIMARY KEY,
strNOMBRE VARCHAR(10) NOT NULL,
strUNIDAD_MEDIDIA VARCHAR(20),
fltVALOR_COSTO REAL NOT NULL,
fltVALOR_VENTA REAL NOT NULL
);

CREATE TABLE tblPROVEEDOR(
strNIT VARCHAR(20) NOT NULL PRIMARY KEY,
strNOMBRE VARCHAR(20) NOT NULL,
);

CREATE TABLE tblENTRADA_ALMACEN(
idtNRO INT IDENTITY PRIMARY KEY,
strFECHA VARCHAR(20) NOT NULL,
strPROVEEDOR VARCHAR(20) NOT NULL,
intTOTAL_BIENES INT NOT NULL,
fltVALOR_TOTAL REAL NOT NULL,
intORDEN_COMPRA_FK INT NOT NULL,
);

CREATE TABLE tblDETALLE_ENTRADA_ALMACEN(
idtID INT IDENTITY PRIMARY KEY,
intBIEN_FK INT NOT NULL,
fltCANTIDAD_ENTREGADA REAL NOT NULL,
intNRO_ENTRADA_FK INT NOT NULL,
);

CREATE TABLE tblAREA(
idtID INT IDENTITY PRIMARY KEY,
strNOMBRE VARCHAR(50) NOT NULL
);

CREATE TABLE tblSALIDA_ALMACEN(
idtNRO INT IDENTITY PRIMARY KEY,
intEMPLEADO INT NOT NULL,
strFECHA_SALIDA DATE NOT NULL,
strFECHA_ENTREGA DATE NOT NULL,
intAREA_FK INT NOT NULL
);

CREATE TABLE tblDETALLE_SALIDA_ALMACEN(
idtID INT IDENTITY PRIMARY KEY,
intBIEN_FK INT NOT NULL,
fltCANTIDAD_ENTREGADA REAL NOT NULL,
intNRO_SALIDA_FK INT
);

--------- AREA COMPRAS

CREATE TABLE tblSOLICITUD_COMPRAS(
idtNRO INT IDENTITY PRIMARY KEY,
strFECHA DATE NOT NULL,
strEMPLEADO VARCHAR(30) NOT NULL,
intAREA_FK INT NOT NULL,
intCENTRO_COSTOS_FK INT NOT NULL,
strID_EMPLEADO_FK VARCHAR(30),
bitAPROBAD_Area bit,
bitAPROBAD_Dir bit
);

CREATE TABLE tblDETALLE_SOLICITUD_COMPRAS(
idtID INT IDENTITY PRIMARY KEY,
intBIEN_FK INT NOT NULL,
intCANTIDAD INT NOT NULL,
fltVALOR_UNITARIO REAL NOT NULL,
fltVALOR_TOTAL REAL NOT NULL,
intNRO_SOLICTUD_COMPRAS_FK INT NOT NULL
);

CREATE TABLE tblORDEN_COMPRA(
idtNRO_ORDEN INT IDENTITY PRIMARY KEY,
strFECHA DATE NOT NULL,
intNRO_SOLICITUD_FK INT NOT NULL,
strPROVEEDOR VARCHAR(20) NOT NULL,
fltSUBTOTAL REAL NOT NULL,
fltDCTO REAL NOT NULL,
fltTOTAL REAL NOT NULL
);

CREATE TABLE tblDETALLE_ORDEN_COMPRA(
idtID INT IDENTITY PRIMARY KEY,
intCANTIDAD_SOLICITADA INT NOT NULL,
fltVALOR_UNITARIO REAL NOT NULL,
fltVALOR_TOTAL REAL NOT NULL,
intNRO_ORDEN_FK INT NOT NULL,
intBIEN_FK INT NOT NULL,
);

CREATE TABLE tblEMPLEADO(
strCOD_EMP VARCHAR(30) PRIMARY KEY NOT NULL,
strNOMBRES VARCHAR(30) NOT NULL,
strAPELLIDO VARCHAR(30) NOT NULL,
intCARGO_FK INT NOT NULL,
);

CREATE TABLE tblTIPO_EMPLEADO(
idtIDCargo INT IDENTITY PRIMARY KEY NOT NULL,
strDESCRIPCION VARCHAR(30) NOT NULL,
);

CREATE TABLE tblCENTRO_COSTOS(
idtID INT IDENTITY PRIMARY KEY NOT NULL,
strDESCRIPCION VARCHAR(50) NOT NULL,
fltRUBRO FLOAT NOT NULL
);

CREATE TABLE tblCOMPRA(
idtNRO INT IDENTITY PRIMARY KEY NOT NULL,
strFECHA DATE NOT NULL,
intORDEN_COMPRA_FK INT NOT NULL,
strPROVEEDOR VARCHAR(20) NOT NULL,
fltSUBTOTAL REAL NOT NULL,
fltDSTO REAL NOT NULL,
fltTOTAL REAL NOT NULL,
strNIT_PROVEEDORFK VARCHAR(20)
);

CREATE TABLE tblDETALLE_COMPRA(
idtID INT IDENTITY PRIMARY KEY,
intCANTIDAD_SOLICITADA INT NOT NULL,
fltVALOR_UNITARIO REAL NOT NULL,
fltVALOR_TOTAL REAL NOT NULL,
intNRO_COMPRA_FK INT NOT NULL,
intBIEN_FK INT NOT NULL,
);
go


-------------------------------------------------------RELACIONES

----AREA ALMACEN
ALTER TABLE tblEMPLEADO ADD FOREIGN KEY (intCARGO_FK) REFERENCES tblTIPO_EMPLEADO (idtIDCargo);
ALTER TABLE tblSOLICITUD_COMPRAS ADD FOREIGN KEY (intCENTRO_COSTOS_FK) REFERENCES tblCENTRO_COSTOS (idtID);
ALTER TABLE tblSOLICITUD_COMPRAS ADD FOREIGN KEY (intAREA_FK) REFERENCES tblAREA (idtID);
ALTER TABLE tblDETALLE_SOLICITUD_COMPRAS ADD FOREIGN KEY (intNRO_SOLICTUD_COMPRAS_FK) REFERENCES tblSOLICITUD_COMPRAS (idtNRO);
ALTER TABLE tblDETALLE_SOLICITUD_COMPRAS ADD FOREIGN KEY (intBIEN_FK) REFERENCES tblBIEN (idtID);
ALTER TABLE tblORDEN_COMPRA ADD FOREIGN KEY (intNRO_SOLICITUD_FK) REFERENCES tblSOLICITUD_COMPRAS (idtNRO);
ALTER TABLE tblCOMPRA ADD FOREIGN KEY (strNIT_PROVEEDORFK) REFERENCES tblPROVEEDOR(strNIT);
ALTER TABLE tblSOLICITUD_COMPRAS ADD FOREIGN KEY (strID_EMPLEADO_FK) REFERENCES tblEMPLEADO(strCOD_EMP);
ALTER TABLE tblDETALLE_ORDEN_COMPRA ADD FOREIGN KEY (intNRO_ORDEN_FK) REFERENCES tblORDEN_COMPRA (idtNRO_ORDEN);
ALTER TABLE tblDETALLE_ORDEN_COMPRA ADD FOREIGN KEY (intBIEN_FK) REFERENCES tblBIEN (idtID);
ALTER TABLE tblCOMPRA ADD FOREIGN KEY (intORDEN_COMPRA_FK) REFERENCES tblORDEN_COMPRA (idtNRO_ORDEN);
ALTER TABLE tblDETALLE_COMPRA ADD FOREIGN KEY (intNRO_COMPRA_FK) REFERENCES tblCOMPRA (idtNRO);
ALTER TABLE tblDETALLE_COMPRA ADD FOREIGN KEY (intBIEN_FK) REFERENCES tblBIEN (idtID);
ALTER TABLE tblENTRADA_ALMACEN ADD FOREIGN KEY (intORDEN_COMPRA_FK) REFERENCES tblCOMPRA (idtNRO);
ALTER TABLE tblENTRADA_ALMACEN ADD FOREIGN KEY (strPROVEEDOR) REFERENCES tblPROVEEDOR (strNIT);
ALTER TABLE tblDETALLE_ENTRADA_ALMACEN ADD FOREIGN KEY (intNRO_ENTRADA_FK) REFERENCES tblENTRADA_ALMACEN (idtNRO);
ALTER TABLE tblDETALLE_ENTRADA_ALMACEN ADD FOREIGN KEY (intBIEN_FK) REFERENCES tblBIEN (idtID);
ALTER TABLE tblDETALLE_SALIDA_ALMACEN ADD FOREIGN KEY (intNRO_SALIDA_FK) REFERENCES tblSALIDA_ALMACEN (idtNRO);
ALTER TABLE tblDETALLE_SALIDA_ALMACEN ADD FOREIGN KEY (intBIEN_FK) REFERENCES tblBIEN (idtID);
ALTER TABLE tblSALIDA_ALMACEN ADD FOREIGN KEY (intAREA_FK) REFERENCES tblAREA (idtID);
GO

insert into tblBIEN values('mouse','und',30000,50000)
insert into tblBIEN values('computador','und',630000,850000)
insert into tblBIEN values('impresora','und',330000,550000)
insert into tblBIEN values('teclado','und',50000,90000)
insert into tblBIEN values('cargador','und',10000,30000)
insert into tblBIEN values('procesador','und',110000,150000)

insert into tblPROVEEDOR values('10001','proveedor11')
insert into tblPROVEEDOR values('10002','proveedor12')
insert into tblPROVEEDOR values('10003','proveedor13')
insert into tblPROVEEDOR values('10004','proveedor14')
insert into tblPROVEEDOR values('10005','proveedor15')

insert into tblCENTRO_COSTOS values('comprarealizada de sillas',5000000)
insert into tblCENTRO_COSTOS values('comprarealizada colchon',8000000)
insert into tblCENTRO_COSTOS values('comprarealizada zapatos',380000)
insert into tblCENTRO_COSTOS values('comprarealizada computador',80000)
insert into tblCENTRO_COSTOS values('comprarealizada camisas',90009)

insert into tblTIPO_EMPLEADO values('jefe de area')
insert into tblTIPO_EMPLEADO values('Director Admin')
insert into tblTIPO_EMPLEADO values('abogado')
insert into tblTIPO_EMPLEADO values('administrador')
insert into tblTIPO_EMPLEADO values('archivista')

insert into tblEMPLEADO values('123','ramiro','garzon',1)
insert into tblEMPLEADO values('124','carlos','alean',2)
insert into tblEMPLEADO values('125','sara','gomez',2)
insert into tblEMPLEADO values('126','manuela','martinez',3)
insert into tblEMPLEADO values('127','camilo','sepulveda',4)
insert into tblEMPLEADO values('128','camila','serna',1)
insert into tblEMPLEADO values('129','silvio','alean',1)

insert into tblAREA values('compra')
insert into tblAREA values('servicio al cliente')
insert into tblAREA values('administrativa')
insert into tblAREA values('inquitudes')
insert into tblAREA values('gastos')

insert into tblSOLICITUD_COMPRAS values('2016-10-11','carlos',1,1,'123',1,1)
insert into tblSOLICITUD_COMPRAS values('2017-12-22','silvio',1,3,'129',0,1)
insert into tblSOLICITUD_COMPRAS values('2017-12-04','silvio',2,2,'129',1,0)
insert into tblSOLICITUD_COMPRAS values('2014-11-03','carlos',4,1,'124',1,0)
insert into tblSOLICITUD_COMPRAS values('2014-10-12','manuela',2,4,'126',1,0)
insert into tblSOLICITUD_COMPRAS values('2015-10-13','silvio',2,4,'129',1,0)
insert into tblSOLICITUD_COMPRAS values('2017-08-22','camilo',2,1,'127',1,0)
insert into tblSOLICITUD_COMPRAS values('2017-10-22','camilo',2,1,'127',1,0)
insert into tblSOLICITUD_COMPRAS values('2017-09-22','camilo',2,1,'127',1,0)
insert into tblSOLICITUD_COMPRAS values('2017-10-04','camilo',2,1,'127',1,0)

insert into tblORDEN_COMPRA values('2016-10-22',2,'10001',6000,5,5500)
insert into tblORDEN_COMPRA values('2017-10-22',1,'10002',16000,5,5500)
insert into tblORDEN_COMPRA values('2016-10-22',3,'10001',4000,5,7500)
insert into tblORDEN_COMPRA values('2015-10-22',4,'10003',5000,5,7500)
insert into tblORDEN_COMPRA values('2016-10-22',5,'10004',6000,5,5500)

insert into tblCOMPRA values('2016-10-22',5,'PROVEDOOR14',6000,5,5500,'10004')
insert into tblCOMPRA values('2016-10-22',2,'PROVEDOOR12',6000,5,5500,'10002')
insert into tblCOMPRA values('2016-10-22',3,'PROVEDOOR13',6000,5,5500,'10003')
insert into tblCOMPRA values('2016-10-22',4,'PROVEDOOR14',6000,5,5500,'10004')
insert into tblCOMPRA values('2016-10-22',5,'PROVEDOOR15',6000,5,5500,'10005')
insert into tblCOMPRA values('2016-10-22',5,'PROVEDOOR16',6000,5,5500,'10006')

insert into tblENTRADA_ALMACEN values('2016-10-22','10004',14,7000000,1)
insert into tblENTRADA_ALMACEN values('2016-10-22','10002',14,7000000,2)
insert into tblENTRADA_ALMACEN values('2016-10-22','10002',14,7000000,3)
insert into tblENTRADA_ALMACEN values('2016-10-22','10003',14,7000000,4)
insert into tblENTRADA_ALMACEN values('2016-10-22','10004',14,7000000,3)
insert into tblENTRADA_ALMACEN values('2016-10-22','10005',14,7000000,1)

insert into tblDETALLE_ENTRADA_ALMACEN values(1,66,1)
insert into tblDETALLE_ENTRADA_ALMACEN values(2,66,2)
insert into tblDETALLE_ENTRADA_ALMACEN values(2,66,4)
insert into tblDETALLE_ENTRADA_ALMACEN values(3,66,2)
insert into tblDETALLE_ENTRADA_ALMACEN values(4,66,3)
insert into tblDETALLE_ENTRADA_ALMACEN values(2,66,3)

insert into tblSALIDA_ALMACEN values('123','2016-01-15','2017-01-22',1)
insert into tblSALIDA_ALMACEN values('123','2016-01-17','2017-01-22',2)
insert into tblSALIDA_ALMACEN values('124','2016-01-13','2017-01-22',3)
insert into tblSALIDA_ALMACEN values('125','2016-01-13','2016-01-22',3)
insert into tblSALIDA_ALMACEN values('126','2016-01-12','2014-01-22',2)
insert into tblSALIDA_ALMACEN values('123','2016-01-16','2017-10-03',1)
insert into tblSALIDA_ALMACEN values('123','2016-01-16','2016-07-22',1)
insert into tblSALIDA_ALMACEN values('122','2016-01-16','2015-08-22',4)
insert into tblSALIDA_ALMACEN values('124','2016-01-16','2014-09-22',4)
insert into tblSALIDA_ALMACEN values('121','2016-01-16','2012-05-22',5)
insert into tblSALIDA_ALMACEN values('125','2016-01-16','2013-01-22',2)
insert into tblSALIDA_ALMACEN values('121','2016-01-16','2011-01-22',4)
insert into tblSALIDA_ALMACEN values('123','2016-01-16','2011-01-21',3)
insert into tblSALIDA_ALMACEN values('124','2016-01-16','2013-01-24',4)
insert into tblSALIDA_ALMACEN values('125','2016-01-16','2015-01-24',3)

insert into tblDETALLE_SALIDA_ALMACEN values(1,2,1)
insert into tblDETALLE_SALIDA_ALMACEN values(2,42,3)
insert into tblDETALLE_SALIDA_ALMACEN values(2,23,4)
insert into tblDETALLE_SALIDA_ALMACEN values(3,22,3)
insert into tblDETALLE_SALIDA_ALMACEN values(2,21,1)
insert into tblDETALLE_SALIDA_ALMACEN values(2,21,3)
insert into tblDETALLE_SALIDA_ALMACEN values(3,21,4)
insert into tblDETALLE_SALIDA_ALMACEN values(2,21,5)
insert into tblDETALLE_SALIDA_ALMACEN values(4,21,2)
insert into tblDETALLE_SALIDA_ALMACEN values(4,21,7)
insert into tblDETALLE_SALIDA_ALMACEN values(2,21,8)
insert into tblDETALLE_SALIDA_ALMACEN values(3,23,9)
insert into tblDETALLE_SALIDA_ALMACEN values(4,27,10)
insert into tblDETALLE_SALIDA_ALMACEN values(5,28,9)
insert into tblDETALLE_SALIDA_ALMACEN values(4,22,9)

insert into tblDETALLE_SOLICITUD_COMPRAS values(2,41,1500,6000,1)
insert into tblDETALLE_SOLICITUD_COMPRAS values(1,51,1200,6000,3)
insert into tblDETALLE_SOLICITUD_COMPRAS values(2,21,1300,6000,4)
insert into tblDETALLE_SOLICITUD_COMPRAS values(3,21,15500,6000,3)
insert into tblDETALLE_SOLICITUD_COMPRAS values(4,31,41500,6000,1)

insert into tblDETALLE_ORDEN_COMPRA values(3,67880,80000,1,3)
insert into tblDETALLE_ORDEN_COMPRA values(2,37880,80000,2,1)
insert into tblDETALLE_ORDEN_COMPRA values(2,67880,80000,2,1)
insert into tblDETALLE_ORDEN_COMPRA values(1,57880,80000,4,3)
insert into tblDETALLE_ORDEN_COMPRA values(4,47880,80000,3,2)

insert into tblDETALLE_COMPRA values(55,58988,890000,1,1)
insert into tblDETALLE_COMPRA values(55,48988,960000,2,1)
insert into tblDETALLE_COMPRA values(52,58988,60000,1,3)
insert into tblDETALLE_COMPRA values(11,778988,90000,1,5)
insert into tblDETALLE_COMPRA values(1,688,84000,4,2)
insert into tblDETALLE_COMPRA values(5,88988,80000,4,1)

-----------------------------------------------------------------------Consultas


----Presentar los Proveedores que han entregado pedidos al Almacén
select [strNOMBRE] AS NOMBRE
from [dbo].[tblPROVEEDOR] inner join [dbo].[tblCOMPRA]
on [dbo].[tblPROVEEDOR].strNIT = [dbo].[tblCOMPRA].strNIT_PROVEEDORFK inner join [dbo].[tblENTRADA_ALMACEN]
on [dbo].[tblCOMPRA].idtNRO = [dbo].[tblENTRADA_ALMACEN].intORDEN_COMPRA_FK

--Clasificar los pedidos por Área de solicitud de compra 

select [strNOMBRE] AS Nombre, [intAREA_FK] AS Area
from [dbo].[tblAREA] inner join [dbo].[tblSOLICITUD_COMPRAS]
on [dbo].[tblAREA].idtID = [dbo].[tblSOLICITUD_COMPRAS].intAREA_FK
ORDER BY [strNOMBRE]

--Presentar la relación entre la factura, la orden de compra y los registros de entrada de almacéN
SELECT [dbo].[tblCOMPRA].[idtNRO] AS IDFACTURA,[dbo].[tblENTRADA_ALMACEN].idtNRO AS IDENTRADA_ALMACEN,[dbo].[tblORDEN_COMPRA].idtNRO_ORDEN AS  ORDEN_COMPRA
FROM [dbo].[tblCOMPRA] INNER JOIN  [tblENTRADA_ALMACEN]
ON [dbo].[tblCOMPRA].idtNRO = [tblENTRADA_ALMACEN].intORDEN_COMPRA_FK INNER JOIN [dbo].[tblORDEN_COMPRA]
ON [dbo].[tblCOMPRA] .intORDEN_COMPRA_FK = [dbo].[tblORDEN_COMPRA].idtNRO_ORDEN


---Presentar las ordenes de Salida de Almacén relacionadas, clasificadas por área y ordenadas por fecha de entrega 
SELECT [idtNRO] AS Numero,[strNOMBRE] AS Nombre,[strFECHA_ENTREGA] AS Fecha_Entrega
FROM [dbo].[tblSALIDA_ALMACEN] INNER JOIN [dbo].[tblAREA]
ON [dbo].[tblSALIDA_ALMACEN].intAREA_FK = [dbo].[tblAREA].idtID
ORDER BY [strNOMBRE],[strFECHA_ENTREGA]

---presentar la distribución de todos los bienes de la empresa clasificadas por área ordenados por fecha de entrega. 
SELECT [dbo].[tblBIEN].strNOMBRE  AS NombreBien, [dbo].[tblAREA].[strNOMBRE] AS NombreArea,[strFECHA_ENTREGA] AS Fecha_Entrega
FROM [dbo].[tblAREA] INNER JOIN  [dbo].[tblSALIDA_ALMACEN] 
ON [dbo].[tblAREA].idtID = [dbo].[tblSALIDA_ALMACEN].intAREA_FK  INNER JOIN [dbo].[tblDETALLE_SALIDA_ALMACEN]
ON [dbo].[tblSALIDA_ALMACEN].idtNRO = [dbo].[tblDETALLE_SALIDA_ALMACEN].intNRO_SALIDA_FK INNER JOIN [dbo].[tblBIEN]
ON [dbo].[tblDETALLE_SALIDA_ALMACEN].intBIEN_FK = [dbo].[tblBIEN].idtID
ORDER BY  [dbo].[tblAREA].[strNOMBRE],[strFECHA_ENTREGA]


------Presentar el Rubro total, y Rubro total por área de las órdenes de compra que han sido entregadas a los solicitantes por parte del almacén en el último mes
SELECT SUM(CC.fltRUBRO) AS TOTAL_RUBRO  --- PENDIENTE
FROM tblCENTRO_COSTOS CC

SELECT SUM(OC.fltTOTAL) AS TOTAL_RUBRO_AREA
FROM tblORDEN_COMPRA OC INNER JOIN tblSOLICITUD_COMPRAS SC
ON OC.intNRO_SOLICITUD_FK = SC.idtNRO
INNER JOIN tblCENTRO_COSTOS CCS
ON SC.intCENTRO_COSTOS_FK = CCS.idtID
INNER JOIN tblAREA A 
ON SC.intAREA_FK = A.idtID
WHERE OC.strFECHA BETWEEN '2015-10-01' and '2015-10-31'

-----Presentar todas las ordenes solicitadas hace más de 20 días que han sido aprobadas por el Jefe de Área 
-----y están pendientes de aprobación del director financiero.
 SELECT [idtNRO] AS Numero,[bitAPROBAD_Area]  AS AprobadoArea,[bitAPROBAD_Dir] AS AprobadoDirector,[strFECHA] AS Fecha
 FROM [dbo].[tblSOLICITUD_COMPRAS]
 WHERE ([strFECHA] <= DATEADD(day,-20, GETDATE()) )AND (bitAPROBAD_Area=1) AND (bitAPROBAD_Dir=0) 
 ORDER BY [strFECHA]

