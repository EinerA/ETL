CREATE DATABASE DBSupermercadobiFINAL;
go
USE DBSupermercadobiFINAL;
go

-----------------------------------------------------------Tablas
CREATE TABLE tblTipoTelefono(
strId_TipTEL NVARCHAR(255) PRIMARY KEY  NOT NULL,   
strDescripcion_TipTEL NVARCHAR(255)  NOT NULL,  
);

CREATE TABLE tblTipo_EMP(
strId_TE NVARCHAR(255) PRIMARY KEY  NOT NULL,   
strDescripcion_TE NVARCHAR(255)  NOT NULL,  
);

CREATE TABLE tblEmplead(  
idEmpleado_EMP INT IDENTITY PRIMARY KEY NOT NULL,
strDocEmpleado_EMP NVARCHAR(255)   NOT NULL,  
strNombre_EMP NVARCHAR(255) NOT NULL,  
strApellido_EMP NVARCHAR(255)  NOT NULL, 
strEstado_EMP NVARCHAR(255)  NOT NULL, 
strUsuario_EMP NVARCHAR(255)  NOT NULL, 
strContrasena_EMP NVARCHAR(255)  NOT NULL, 
strIdTE_EMP NVARCHAR(255)   NOT NULL,   
);

CREATE TABLE tblCliente(
idCliente INT IDENTITY   PRIMARY KEY NOT NULL,
strDocumento_CL NVARCHAR(255)  NOT NULL,  
strNombre_CL NVARCHAR(255)  NOT NULL,  
strApellido_CL NVARCHAR(255)  NOT NULL, 
);

CREATE TABLE tblProveedor(
idProveedor INT IDENTITY   PRIMARY KEY NOT NULL,
strNIT_PROV NVARCHAR(255)   NOT NULL,
strRazonSocial_PROV NVARCHAR(255)  NOT NULL
);


CREATE TABLE tblTelefonoCliente(
idTelefono_TELCli INT IDENTITY  PRIMARY KEY NOT NULL,  
strNumero_TELCli NVARCHAR(255)  NOT NULL,  
strIdTIPTEL_TELCli NVARCHAR(255)   NOT NULL,   
intDocumentoCL_TELCli INT   NOT NULL, 
);

CREATE TABLE tblTelefonoPROV(
idTelefono_TELPROV INT IDENTITY  PRIMARY KEY NOT NULL,  
strNumero_TELPROV NVARCHAR(255)  NOT NULL,  
strIdTIPTEL_TELPROV NVARCHAR(255)   NOT NULL,   
intNIT_TELPROV int   NOT NULL, 
);

CREATE TABLE tblTelefonoEMP(
idTelefono_TELEMP INT IDENTITY  PRIMARY KEY NOT NULL,  
strNumero_TELEMP NVARCHAR(255)  NOT NULL,  
strIdTIPTEL_TELEMP NVARCHAR(255)   NOT NULL,   
IdEmpleadoEMP_TELEMP int NOT NULL,   
);


CREATE TABLE tblProductos(  
strIDProducto_PCTO INT IDENTITY PRIMARY KEY  NOT NULL,  
fltPrecCompra_PCTO REAL NOT NULL,  
fltPrecVenta_PCTO REAL NOT NULL,  
intCantida_PCTO INT NOT NULL,
intCantidaMIN_PCTO INT NOT NULL,
strDescripcion_PCTO NVARCHAR(255)  NOT NULL,  
);

CREATE TABLE tblProducto_Proveedor(
intNITPROV_PP int  NOT NULL,  
strIDProductoPCTO_PP INT  NOT NULL,  
PRIMARY KEY  (intNITPROV_PP,strIDProductoPCTO_PP)
);

CREATE TABLE tblFecha_Factura(
strIDFecha_FF NVARCHAR(255)  PRIMARY KEY NOT NULL,
dtFecha_FF DATE NOT NULL,
);

CREATE TABLE tblTipo_Pago(
strTipoPago_TP NVARCHAR(255)  PRIMARY KEY NOT NULL,
strDescripcion_TP NVARCHAR(255)  NOT NULL,  
);


CREATE TABLE tblFactura(  
intNumFactura_FCT INT IDENTITY  PRIMARY KEY  NOT NULL,  
fltTotalVenta_FCT REAL, 
strIDFechaFF_FCT DATE NOT NULL,
IDEmpleadoEMP_FCT INT  NOT NULL,  
strTipoPagoTP_FCT NVARCHAR(255)  NOT NULL,
intDocumentoCL_FCT int  NOT NULL,  
strEstadoEMP_FCT NVARCHAR(255)  NOT NULL,
);

CREATE TABLE tblDetalle_Factura(  
intIDDetalleFactura_DF INT IDENTITY PRIMARY KEY  NOT NULL,  
intCantida_DF INT NOT NULL,
fltSubTotal_DF REAL NOT NULL,  
fltTotal_DF REAL NOT NULL,  
intNumFacturaFCT_DF INT  NOT NULL,  
strIDProductoPCTO_DF INT   NOT NULL,  
);



--ALTER TABLE tblFactura ADD FOREIGN KEY (strIDFechaFF_FCT) REFERENCES tblFecha_Factura (strIDFecha_FF);  -- NO EJECUTAR

ALTER TABLE tblFactura ADD FOREIGN KEY (IDEmpleadoEMP_FCT) REFERENCES tblEmplead (idEmpleado_EMP);
ALTER TABLE tblFactura ADD FOREIGN KEY (strTipoPagoTP_FCT) REFERENCES tblTipo_Pago (strTipoPago_TP);
ALTER TABLE tblFactura ADD FOREIGN KEY (intDocumentoCL_FCT) REFERENCES tblCliente (idCliente);----
ALTER TABLE tblEmplead ADD FOREIGN KEY (strIdTE_EMP) REFERENCES tblTipo_EMP (strId_TE);
ALTER TABLE tblTelefonoCliente ADD FOREIGN KEY (intDocumentoCL_TELCli) REFERENCES tblCliente (idCliente);
ALTER TABLE tblTelefonoCliente ADD FOREIGN KEY (strIdTIPTEL_TELCli) REFERENCES tblTipoTelefono (strId_TipTEL);
ALTER TABLE tblTelefonoEMP ADD FOREIGN KEY (strIdTIPTEL_TELEMP) REFERENCES tblTipoTelefono (strId_TipTEL);
ALTER TABLE tblTelefonoEMP ADD FOREIGN KEY (IdEmpleadoEMP_TELEMP) REFERENCES tblEmplead (idEmpleado_EMP);
ALTER TABLE tblTelefonoPROV ADD FOREIGN KEY (strIdTIPTEL_TELPROV) REFERENCES tblTipoTelefono (strId_TipTEL);
ALTER TABLE tblTelefonoPROV ADD FOREIGN KEY (intNIT_TELPROV ) REFERENCES tblProveedor (idProveedor);
ALTER TABLE tblProducto_Proveedor ADD FOREIGN KEY (intNITPROV_PP ) REFERENCES tblProveedor (idProveedor);
ALTER TABLE tblProducto_Proveedor ADD FOREIGN KEY (strIDProductoPCTO_PP ) REFERENCES tblProductos (strIDProducto_PCTO);
ALTER TABLE tblDetalle_Factura ADD FOREIGN KEY (strIDProductoPCTO_DF ) REFERENCES tblProductos (strIDProducto_PCTO);
ALTER TABLE tblDetalle_Factura ADD FOREIGN KEY (intNumFacturaFCT_DF ) REFERENCES tblFactura (intNumFactura_FCT);


-------------------- inserciones iniciales
---------- tipo empleado
--INSERT INTO tblTipo_EMP VALUES('0','ADMINISTRADOR');
--GO

--INSERT INTO tblTipo_EMP VALUES('1','OPERADOR');
--GO
------------ tipo telefono
--INSERT INTO tblTipoTelefono VALUES('0','CELULAR');
--GO

--INSERT INTO tblTipoTelefono VALUES('1','FIJO');
--GO


--------- productos
--INSERT INTO tblProductos VALUES ('1','0','0','0','0',' SELECCIONE UN OPCION');
--go

-------- tipo pago
--INSERT INTO tblTipo_Pago VALUES ('1',' SELECCIONE UN OPCION');
--go

--INSERT INTO tblTipo_Pago VALUES ('2','Contado');
--go

--INSERT INTO tblTipo_Pago VALUES ('3','Credito');
--go

------ EMPLEADOS
--INSERT INTO tblEmplead VALUES ('1','BYTE','SAB','ACTIVO','BYTE-SAB','123',1);

---------clientes
--INSERT INTO tblCliente VALUES ('0','NO ASIGNADO','NO ASIGNADO');
--------PROVEEDORES
--INSERT INTO tblProveedor VALUES ('1',' SELECCIONE UN OPCION');
--go



-------------------------------- Procedimientos almacenados
------------------TIPO DE TELEFONO
--CREATE  PROCEDURE USP_LlenarComboTipoTel
--as
--	begin
--		select  strId_TipTEL as Clave, strDescripcion_TipTEL as Dato
--		from tblTipoTelefono
--		order by Dato
--	end 
--go

------------------------Empleado-----------
--CREATE PROCEDURE USP_login_Empleado    -----EXEC USP_login_Empleado 'JBL','123' select * from tblEmplead
--@Usuario varchar(100),
--@Contrasena varchar(100)
--AS
--	BEGIN
--		IF EXISTS (SELECT * FROM  tblEmplead WHERE strUsuario_EMP = @Usuario and strContrasena_EMP=@Contrasena and strEstado_EMP='Activo')
--		BEGIN
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--		IF EXISTS(SELECT * FROM  tblEmplead WHERE strUsuario_EMP = @Usuario and  strEstado_EMP='Activo')
--		BEGIN
--			SELECT 'CONTRASENA' AS Rpta
--			RETURN
--		END
--		ELSE
--		BEGIN
--			SELECT 'NOACTIVO' AS Rpta
--			RETURN

--		END
--END
--go

--CREATE  PROCEDURE USP_LlenarComboTipoEmp --exec USP_LlenarComboTipoEmp
--as
--	begin
--		select  strId_TE as Clave, strDescripcion_TE as Dato
--		from tblTipo_EMP
--		order by Dato
--	end 
--go

--CREATE PROCEDURE USP_Grabar_Empleado    ----- select * from tblEmplead
--@Cedula varchar(10),
--@Nombre varchar(50),
--@Apellido varchar(50),
--@Estado varchar(10),
--@Usuario varchar(100),
--@Contrasena varchar(100),
--@TipoEmpleado varchar(50)

--AS
--	BEGIN
--		IF EXISTS (SELECT * FROM  tblEmplead WHERE strDocEmpleado_EMP = @Cedula)
--		BEGIN
--			SELECT -21 AS Rpta
--			RETURN
--		END

--		ELSE
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblEmplead VALUES(@Cedula,@Nombre,@Apellido,@Estado,@Usuario,@Contrasena,@TipoEmpleado);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go

--CREATE PROCEDURE USP_Grabar_TelEmpleado   ---- exec  USP_Grabar_TelCliente 7,'3333443','1' select * from tblTelefonoCliente
--@IdEmpleado varchar(10),
--@TelEmp varchar(10),
--@TipoTelEmp varchar(10)
--AS
--BEGIN
--	IF EXISTS (SELECT * FROM  tblTelefonoEMP WHERE IdEmpleadoEMP_TELEMP = @IdEmpleado AND strNumero_TELEMP =@TelEmp)
--		BEGIN
--			SELECT -22 AS Rpta
--			RETURN
--		END
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblTelefonoEMP VALUES(@TelEmp,@TipoTelEmp,@IdEmpleado);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go

--CREATE PROCEDURE USP_BuscarEmpleado --- exec USP_BuscarEmpleado '4'  select * from tblEmplead
--@IdDocEmp varchar(10)
--AS
--    BEGIN
--	SELECT P.strDocEmpleado_EMP, p.strNombre_EMP,p.strApellido_EMP,p.strEstado_EMP,p.strUsuario_EMP,p.strContrasena_EMP,TiPO.strDescripcion_TE, p.idEmpleado_EMP,  TP.idTelefono_TELEMP as Clave, TP.strNumero_TELEMP as Dato, TP.strIdTIPTEL_TELEMP
--		FROM tblEmplead P inner join tblTelefonoEMP TP
--		on  P.idEmpleado_EMP = TP.IdEmpleadoEMP_TELEMP
--		 inner join tblTipo_EMP TiPO
--		on  P.strIdTE_EMP = TiPO.strId_TE
--		WHERE P.strDocEmpleado_EMP = @IdDocEmp

--	END
--GO

--CREATE PROCEDURE USP_BuscarEmpleado2 --- exec USP_BuscarEmpleado2 '4'  select * from tblEmplead
--@IdDocEmp varchar(10)
--AS
-- BEGIN
--     SELECT P.strDocEmpleado_EMP, p.strNombre_EMP,p.strApellido_EMP,p.strEstado_EMP,p.strUsuario_EMP,p.strContrasena_EMP,TiPO.strDescripcion_TE, p.idEmpleado_EMP 
--				FROM tblEmplead P inner join tblTipo_EMP TiPO
--				on  P.strIdTE_EMP = TiPO.strId_TE
--				WHERE  P.strDocEmpleado_EMP = @IdDocEmp
--			    END
--GO

--CREATE PROCEDURE USP_GridEmpleados  --- EXEC USP_GridEmpleados
--as
--	begin
--		select p.strDocEmpleado_EMP Documento,p.strNombre_EMP+' '+ p.strApellido_EMP as Nombre, p.strEstado_EMP estado,p.strUsuario_EMP Usuario
--		from tblEmplead p
--		ORDER BY P.strNombre_EMP
--	end
--go

--CREATE PROCEDURE USP_GridEmpleadoTel   ---- exec  USP_GridClientesTel '14' select * from tblTelefonoCliente
--@IdEmpleado varchar(10)
--AS
--BEGIN
--	IF not EXISTS (SELECT idTelefono_TELEMP as Tipo, strNumero_TELEMP as Numero  FROM  tblTelefonoEMP WHERE IdEmpleadoEMP_TELEMP = @IdEmpleado )
--		BEGIN
--			SELECT 'Sin Telefonos' AS Rpta
--			RETURN
--		END
--		BEGIN
--			BEGIN TRANSACTION tx
--				SELECT TT.strDescripcion_TipTEL as Tipo, strNumero_TELEMP as Numero  
--				FROM  tblTelefonoEMP Tl inner join tblTipoTelefono TT
--				on  TT.strId_TipTEL = TL.strIdTIPTEL_TELEMP
--			    WHERE IdEmpleadoEMP_TELEMP  = @IdEmpleado
--			COMMIT TRANSACTION tx		
--			RETURN
--		ENd
--END
--go

--CREATE PROCEDURE USP_Empleado_Modificar   ---  EXEC USP_Empleado_Modificar '2','12','EINER','ALEAN','ACTIVO','EINER123C','CARA','0','-1','NO','NO';
--	@idttEmpleado int,
--	@Cedula varchar(10),
--	@Nombre varchar(50),
--	@Apellido varchar(50),
--	@Estado varchar(10),
--	@Usuario varchar(100),
--	@Contrasena varchar(100),
--	@TipoEmpleado varchar(50),
--	@TelaModificar varchar(10),
--    @TelProvee varchar(10),
--    @TipoTelProvee varchar(10)
	
--AS
--BEGIN
--	begin transaction tx
--			update tblEmplead
--			set strDocEmpleado_EMP=@Cedula,strNombre_EMP=@Nombre,strApellido_EMP=@Apellido,strEstado_EMP=@Estado,strUsuario_EMP=@Usuario,strContrasena_EMP=@Contrasena,strIdTE_EMP=@TipoEmpleado
--			where idEmpleado_EMP=@idttEmpleado

--			update tblTelefonoEMP
--			set strIdTIPTEL_TELEMP=@TipoTelProvee,strNumero_TELEMP=@TelProvee
--			where  IdEmpleadoEMP_TELEMP = @idttEmpleado and idTelefono_TELEMP=@TelaModificar 

			
--			if(@@ERROR > 0)
--			begin
--				rollback transaction tx
--				select 3 as Rpta
--				return
--			end
--			commit transaction tx
--			select @Cedula as Rpta
--			return
--END
--GO

----------------------Cliente--------------------
--CREATE PROCEDURE USP_Grabar_Cliente   -------- exec USP_Grabar_Cliente '123','carmelo','valencia'; select * from tblCliente
--@Cedula varchar(10),
--@Nombre varchar(50),
--@Apellido varchar(50)
--AS
--	BEGIN
--		IF EXISTS (SELECT * FROM  tblCliente WHERE strDocumento_CL = @Cedula)
--		BEGIN
--			SELECT -1 AS Rpta
--			RETURN
--		END

--		ELSE
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblCliente VALUES(@Cedula,@Nombre,@Apellido);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go
--CREATE PROCEDURE USP_Grabar_TelCliente   ---- exec  USP_Grabar_TelCliente 7,'3333443','1' select * from tblTelefonoCliente
--@IdCliente varchar(10),
--@TelCli varchar(10),
--@TipoTelCli varchar(10)
--AS
--BEGIN
--	IF EXISTS (SELECT * FROM  tblTelefonoCliente WHERE intDocumentoCL_TELCli = @IdCliente AND strNumero_TELCli =@TelCli)
--		BEGIN
--			SELECT -2 AS Rpta
--			RETURN
--		END
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblTelefonoCliente VALUES(@TelCli,@TipoTelCli,@IdCliente);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go
--CREATE PROCEDURE USP_BuscarClient --exec USP_BuscarClient '11' select * from tblCliente
--@IdDocCli varchar(10)
--AS
--	BEGIN
--		SELECT P.strDocumento_CL, p.strNombre_CL,p.strApellido_CL, p.idCliente , TP.idTelefono_TELCli as Clave, TP.strNumero_TELCli as Dato, TP.strIdTIPTEL_TELCli
--		FROM tblCliente P inner join tblTelefonoCliente TP
--		on  P.idCliente = TP.intDocumentoCL_TELCli
--		WHERE P.strDocumento_CL = @IdDocCli
--	END
--GO
--CREATE PROCEDURE USP_BuscarClient2 --exec USP_BuscarClient2 '12' select * from tblCliente
--@IdDocCli varchar(10)
--AS
--	BEGIN
--		SELECT P.strDocumento_CL, p.strNombre_CL,p.strApellido_CL, p.idCliente 
--		FROM tblCliente P 
--		WHERE P.strDocumento_CL = @IdDocCli
--	END
--GO
--CREATE PROCEDURE USP_Client_Modificar   ---  exec  USP_Client_Modificar  11,'1123','SilvioAlfeeee','jeje','-1','300','1';
--	@idttProv int,
--	@Cedula varchar(10),
--	@Nombre varchar(50),
--	@Apellido varchar(50),
--	@TelaModificar varchar(10),
--    @TelProvee varchar(10),
--    @TipoTelProvee varchar(10)
	
--AS
--BEGIN
--	begin transaction tx
--			update tblCliente
--			set strDocumento_CL=@Cedula,strNombre_CL=@Nombre,strApellido_CL=@Apellido
--			where idCliente=@idttProv

--			update tblTelefonoCliente
--			set strIdTIPTEL_TELCli=@TipoTelProvee,strNumero_TELCli=@TelProvee
--			where intDocumentoCL_TELCli = @idttProv and idTelefono_TELCli=@TelaModificar 

			
--			if(@@ERROR > 0)
--			begin
--				rollback transaction tx
--				select 3 as Rpta
--				return
--			end
--			commit transaction tx
--			select @Cedula as Rpta
--			return
--END
--GO

--CREATE PROCEDURE USP_GridClientes  --- EXEC USP_GridClientes
--as
--	begin
--		select p.strDocumento_CL Documento,p.strNombre_CL Nombre,p.strApellido_CL Apellido
--		from tblCliente p
--		ORDER BY P.strNombre_CL
--	end
--go

--CREATE PROCEDURE USP_GridClientesTel   ---- exec  USP_GridClientesTel '14' select * from tblTelefonoCliente
--@IdCliente varchar(10)
--AS
--BEGIN
--	IF not EXISTS (SELECT idTelefono_TELCli as Tipo, strNumero_TELCli as Numero  FROM  tblTelefonoCliente WHERE intDocumentoCL_TELCli = @IdCliente )
--		BEGIN
--			SELECT 'Sin Telefonos' AS Rpta
--			RETURN
--		END
--		BEGIN
--			BEGIN TRANSACTION tx
--				SELECT TT.strDescripcion_TipTEL as Tipo, strNumero_TELCli as Numero  
--				FROM  tblTelefonoCliente Tl inner join tblTipoTelefono TT
--				on  TT.strId_TipTEL = TL.strIdTIPTEL_TELCli
--			    WHERE intDocumentoCL_TELCli = @IdCliente
--			COMMIT TRANSACTION tx		
--			RETURN
--		ENd
--END
--go

----CREATE PROCEDURE USP_BuscarClientMod --exec USP_BuscarClientMod '11' select * from tblProveedor
----@IdProv varchar(10)
----AS
----	BEGIN
----		SELECT P.strDocumento_CL, p.strNombre_CL, p.strApellido_CL, TP.idTelefono_TELCli as Clave, TP.strNumero_TELCli as Dato, TP.strIdTIPTEL_TELCli, p.idCliente 
----		FROM tblCliente P inner join tblTelefonoCliente TP
----		on  P.idCliente = TP.intDocumentoCL_TELCli
----		WHERE P.strDocumento_CL = @IdProV
----	END
----GO

----------------- PROVEEDOR --- modificar
--CREATE PROCEDURE USP_Grabar_TelProvedor
--@NIT varchar(10),
--@TelProvee varchar(10),
--@TipoTelProvee varchar(10)
--AS
--BEGIN
--	IF EXISTS (SELECT * FROM  tblTelefonoPROV WHERE intNIT_TELPROV = @NIT AND strNumero_TELPROV =@TelProvee)
--		BEGIN
--			SELECT -2 AS Rpta
--			RETURN
--		END
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblTelefonoPROV VALUES(@TelProvee,@TipoTelProvee,@NIT);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go

--CREATE PROCEDURE USP_Grabar_Provedor
--@NIT varchar(10),
--@Razon_Social varchar(50)
--AS
--	BEGIN
--		IF EXISTS (SELECT * FROM  tblProveedor WHERE strNIT_PROV = @NIT)
--		BEGIN
--			SELECT -1 AS Rpta
--			RETURN
--		END

--		ELSE
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblProveedor VALUES(@NIT,@Razon_Social);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--		END
--END
--go

--CREATE PROCEDURE USP_BuscarProveedor --exec USP_BuscarProveedor '11' select * from tblProveedor
--@IdProv varchar(10)
--AS
--	BEGIN
--		SELECT P.strNIT_PROV, p.strRazonSocial_PROV, p.idProveedor , TP.idTelefono_TELPROV as Clave, TP.strNumero_TELPROV as Dato, TP.strIdTIPTEL_TELPROV
--		FROM tblProveedor P inner join tblTelefonoPROV TP
--		on  P.idProveedor = TP.intNIT_TELPROV
--		WHERE P.strNIT_PROV = @IdProV
--	END
--GO
--CREATE PROCEDURE USP_BuscarProveedor2 --exec USP_BuscarProveedor '11' select * from tblProveedor
--@IdProv varchar(10)
--AS
--	BEGIN
--		SELECT P.strNIT_PROV, p.strRazonSocial_PROV, p.idProveedor 
--		FROM tblProveedor P
--		WHERE P.strNIT_PROV = @IdProV
--	END
--GO

--CREATE PROCEDURE USP_GridAlertasProveedor  --- EXEC USP_GridAlertasProveedor
--as
--	begin
--		select p.strNIT_PROV NIT,p.strRazonSocial_PROV "RAZON SOCIAL"
--		from tblProveedor p
--	end
--go

--CREATE PROCEDURE USP_Prov_Modificar   ---  exec  USP_Prov_Modificar  15,'1123','SilvioAlfeeee','No','300','1';
--	@idttProv int,
--	@NIT varchar(10),
--	@Razon_Social varchar(50),
--	@TelaModificar varchar(10),
--    @TelProvee varchar(10),
--    @TipoTelProvee varchar(10)
	
--AS
--BEGIN
--	begin transaction tx
--			update tblProveedor
--			set strNIT_PROV=@NIT,strRazonSocial_PROV=@Razon_Social
--			where idProveedor=@idttProv

--			update tblTelefonoPROV
--			set strIdTIPTEL_TELPROV=@TipoTelProvee,strNumero_TELPROV=@TelProvee
--			where intNIT_TELPROV = @idttProv and idTelefono_TELPROV=@TelaModificar 

			
--			if(@@ERROR > 0)
--			begin
--				rollback transaction tx
--				select 3 as Rpta
--				return
--			end
--			commit transaction tx
--			select @NIT as Rpta
--			return
--END
--GO



-- ----------------------------------------------------------------------------------------------------
----------------Producto
--CREATE PROCEDURE USP_Grabar_Producto
--@Codigo varchar(30),
--@PrecioC real,
--@PrecioV real,
--@cantidad int,
--@cantMinima int,
--@descripcion varchar(200)

--AS
--	BEGIN
--		IF EXISTS (SELECT * FROM  tblProductos WHERE strIDProducto_PCTO = @Codigo)
--		BEGIN
--			SELECT -1 AS Rpta
--			RETURN
--		END

--		ELSE
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblProductos VALUES(@Codigo,@PrecioC,@PrecioV,@cantidad,@cantMinima,@descripcion);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @Codigo AS Rpta
--			RETURN
--		END
--END
--go


--CREATE PROCEDURE USP_AlertasProc
--as
--	begin
--		select p.strIDProducto_PCTO as Clave, p.strDescripcion_PCTO as Dato
--		from tblProductos p
--		where p.intCantida_PCTO <= p.intCantidaMIN_PCTO
--		order by Dato
--	end
--go

----EXEC USP_AlertasProc

--CREATE	 PROCEDURE USP_GridAlertasProc
--as
--	begin
--		select p.strIDProducto_PCTO Codigo,p.strDescripcion_PCTO Descripcion, p.fltPrecCompra_PCTO PrecioCompra, p.fltPrecVenta_PCTO PrecioVenta, p.intCantida_PCTO Cantidad, p.intCantidaMIN_PCTO CantidadMinima
--		from tblProductos p
--		where p.intCantida_PCTO <= p.intCantidaMIN_PCTO
--	end
--go
---- exec USP_GridAlertasProc

--CREATE PROCEDURE USP_BuscarProducto
--@IdProc varchar(30)
--AS
--	BEGIN
--		SELECT P.strIDProducto_PCTO Codigo, p.strDescripcion_PCTO Nombre, p.intCantida_PCTO Cantidad, p.intCantidaMIN_PCTO CantidadMinima, p.fltPrecVenta_PCTO PrecioVenta, p.fltPrecCompra_PCTO PrecioCompra
--		FROM tblProductos P
--		WHERE P.strIDProducto_PCTO = @IdProc
--	END
--GO
----- exec USP_BuscarProducto '2'

--CREATE PROCEDURE USP_BuscarDatosInventario -- busca la cantidad de productos en stock. esto es para el ingresi a inventario
--@IdProc varchar(30)
--AS
--	BEGIN
--		SELECT P.intCantida_PCTO
--		FROM tblProductos P 
--		WHERE P.strIDProducto_PCTO = @IdProc
--	END
--GO
----EXEC USP_BuscarDatosInventario '2'

--CREATE PROCEDURE USP_Modificas_Producto
--@Codigo varchar(30),
--@PrecioC real,
--@PrecioV real,
--@cantidad int,
--@cantMinima int,
--@descripcion varchar(200)
--AS
--	BEGIN
--		begin transaction tx
--			update tblProductos
--			set fltPrecCompra_PCTO = @PrecioC,fltPrecVenta_PCTO = @PrecioV, intCantida_PCTO = @cantidad, intCantidaMIN_PCTO = @cantMinima, strDescripcion_PCTO = @descripcion
--			where strIDProducto_PCTO = @Codigo
		
--			if(@@ERROR > 0)
--			begin
--				rollback transaction tx
--				select 0 as Rpta
--				return
--			end
--			commit transaction tx
--			select  @Codigo as Rpta
--			return
--	END
--GO

----CREATE PROCEDURE USP_GuardarCantidadInventario --terminar
----@IdProc varchar(30),
----@cantidad int
----AS
----	BEGIN
----		DECLARE @CANT_INT INT
----		DECLARE @RESULT INT
----		SET @CANT_INT = (SELECT P.intCantida_PCTO FROM tblProductos P WHERE P.strIDProducto_PCTO = @IdProc)
----		SET @RESULT = @CANT_INT + @cantidad

----	END
----GO

------ tipo pago

--CREATE  PROCEDURE USP_LlenarComboTipoPago
--as
--	begin
--		select  tp.strTipoPago_TP as Clave, tp.strDescripcion_TP as Dato
--		from tblTipo_Pago tp
--		order by Dato
--	end 
--go

---- exec USP_LlenarComboTipoPago;

---- GRABAR FACTURA ENCABEZADO
--CREATE PROCEDURE USP_Grabar_FACTURA_ENCABEZADO
--@TotalVentas real
--AS
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblFactura (fltTotalVenta_FCT,strIDFechaFF_FCT,IDEmpleadoEMP_FCT,strTipoPagoTP_FCT,intDocumentoCL_FCT,strEstadoEMP_FCT) VALUES(@TotalVentas,GETDATE(),'1','2','1','PAGADO');
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @@IDENTITY AS Rpta
--			RETURN
--END
--GO
----exec USP_Grabar_FACTURA_ENCABEZADO;

--CREATE PROCEDURE USP_Grabar_FACTURA_DETALLE
--@cantidad int,
--@NroFactura int,
--@Producto varchar(30),
--@subtotal real,
--@total real
--AS
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblDetalle_Factura(intCantida_DF,intNumFacturaFCT_DF,strIDProductoPCTO_DF,fltSubTotal_DF,fltTotal_DF) VALUES(@cantidad,@NroFactura,@Producto,@subtotal,@total);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @NroFactura AS Rpta
--			RETURN
--END
--GO

--CREATE PROCEDURE RESTA
--@Producto varchar(30),
--@cantidad int
--AS
--	BEGIN
--		DECLARE @CANT_INT INT
--		DECLARE @RESULT INT
--		SET @CANT_INT = (SELECT P.intCantida_PCTO FROM tblProductos P WHERE P.strIDProducto_PCTO = @Producto)
--		SET @RESULT = @CANT_INT - @cantidad
		
--		IF(@CANT_INT < @cantidad)
--		BEGIN
--			select -1 as Rpta
--			return
--		END
	
--		ELSE
--		BEGIN
--			BEGIN TRANSACTION TX
--				UPDATE tblProductos
--				SET intCantida_PCTO = @RESULT
--				WHERE strIDProducto_PCTO = @Producto
			
--				if(@@ERROR > 0)
--				begin
--					rollback transaction tx
--					select 0 as Rpta
--					return
--				end

--				commit transaction tx
--				select  1 as Rpta
--				return
--		END
--	END
--GO

----EXEC RESTA '2',100;

--CREATE PROCEDURE USP_Suma_Inventario
--@Producto varchar(30),
--@total int
--AS
--	BEGIN
--		BEGIN TRANSACTION TX
--				UPDATE tblProductos
--				SET intCantida_PCTO = @total
--				WHERE strIDProducto_PCTO = @Producto
			
--				if(@@ERROR > 0)
--				begin
--					rollback transaction tx
--					select 0 as Rpta
--					return
--				end

--				commit transaction tx
--				select  1 as Rpta
--				return
--	END
--GO
----exec USP_Suma_Inventario '2',120;

--CREATE PROCEDURE USP_ComboProveedores
--AS
--	BEGIN
--		SELECT  P.idProveedor as Clave, P.strRazonSocial_PROV as Dato
--		from tblProveedor P
--		order by Dato
--	END
--GO
----EXEC USP_ComboProveedores

--CREATE PROCEDURE USP_Grabar_Producto_Proveedor
--@producto varchar(30),
--@nit int
--AS
--		BEGIN
--			BEGIN TRANSACTION tx
--				INSERT INTO tblProducto_Proveedor VALUES(@nit,@producto);
--				IF(@@ERROR > 0)
--				BEGIN
--					ROLLBACK TRANSACTION tx
--					SELECT 0 AS Rpta
--					RETURN
--				END
--			COMMIT TRANSACTION tx
--			SELECT @producto AS Rpta
--			RETURN
--END
--GO
----exec USP_Grabar_Producto_Proveedor '3',3




--SELECT * FROM tblProducto_Proveedor
--SELECT * FROM tblProductos
			
--select * from tblFactura
--select * from tblDetalle_Factura
--select * from tblProveedor
--select * from tblFactura


--delete tblDetalle_Factura
--delete tblFactura