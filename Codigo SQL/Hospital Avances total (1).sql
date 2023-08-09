CREATE DATABASE Hospital
USE Hospital
		-- Tabla Persona --
Alter authorization on database::[Hospital] to [sa]
CREATE TABLE Persona(
	Id_Persona INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Id_Sueldo INT NOT NULL,
	Nombre VARCHAR(50) NOT NULL,
	A_Paterno VARCHAR(50) NOT NULL,
	A_Materno VARCHAR(50) NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Sexo BIT NOT NULL,
	Telefono VARCHAR(50) NOT NULL,
	Nacionalidad VARCHAR(50) NOT NULL,
	Fecha_De_Nacimiento DATETIME NOT NULL,
)
   ALTER TABLE Persona ADD FOREIGN KEY (Id_Sueldo) references Sueldo(Id_Sueldo)
   ON DELETE CASCADE ON UPDATE CASCADE

SELECT * FROM Persona

		-- Tabla sueldo --

CREATE TABLE Sueldo(
	Id_Sueldo INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Cantidad MONEY NOT NULL,
)
SELECT * FROM Sueldo

		-- Tabla Turno --

CREATE TABLE Turno(
	Id_Turno INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Horario VARCHAR(50) NOT NULL,
)
SELECT * FROM Turno

		-- Tabla Especialidad --

CREATE TABLE Especialidad(
	Id_Esp INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Disponibilidad VARCHAR(50) NOT NULL,
	Id_departamento int not null,
)
   ALTER TABLE Especialidad ADD FOREIGN KEY (Id_departamento) references Departamento(Id_departamento)
   ON DELETE CASCADE ON UPDATE CASCADE

SELECT * FROM Especialidad

		-- Tabla Paciente --
	
CREATE TABLE Paciente(
	NSS VARCHAR(50) NOT NULL PRIMARY KEY,
	Id_Persona INT NOT NULL,
	Id_Expediente INT NOT NULL,
	Estatus VARCHAR(50) NOT NULL,
	Contraseña VARCHAR(50) NOT NULL,
	Id_Enfermera INT NOT NULL,
)
 ALTER TABLE Paciente ADD FOREIGN KEY (Id_Persona) references Persona(Id_Persona)
 ON DELETE CASCADE ON UPDATE CASCADE
  ALTER TABLE Paciente ADD FOREIGN KEY (Id_Expediente) references Expediente(Id_Expediente)
 ON DELETE CASCADE ON UPDATE CASCADE
 ALTER TABLE Paciente ADD FOREIGN KEY (Id_Enfermera) references Enfermera(Id_Enfermera)
 ON DELETE CASCADE ON UPDATE CASCADE

SELECT * FROM Paciente

		-- Tabla Citas --

CREATE TABLE Cita(
	Id_Cita INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Id_Recepcionista INT NOT NULL,
	Num_ext VARCHAR(50) NOT NULL,
	Cedula VARCHAR(50) NOT NULL,
	NSS VARCHAR(50) NOT NULL,
	Estatus VARCHAR(50) NOT NULL,
	Fecha_Cita DATETIME NOT NULL,
	Hora_Cita  TIME NOT NULL,
)
   ALTER TABLE Cita ADD FOREIGN KEY (Id_Recepcionista) references Recepcionista(Id_Recepcionista)
   ON DELETE CASCADE ON UPDATE CASCADE
   ALTER TABLE Cita ADD FOREIGN KEY (Num_ext) references Consultorio(Num_ext)
   ON DELETE CASCADE ON UPDATE CASCADE
   ALTER TABLE Cita ADD FOREIGN KEY (Cedula) references Doctor(Cedula)
   ON DELETE CASCADE ON UPDATE CASCADE
   ALTER TABLE Cita ADD FOREIGN KEY (NSS) references Paciente(NSS)
   ON DELETE CASCADE ON UPDATE CASCADE

SELECT * FROM Cita

		-- Tabla Recepcionista --

CREATE TABLE Recepcionista(
	Id_Recepcionista INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Id_Persona INT NOT NULL,
	Id_Turno INT NOT NULL,
	Contraseña VARCHAR(50) NOT NULL,
)
   ALTER TABLE Recepcionista ADD FOREIGN KEY (Id_Persona) references Persona(Id_Persona)
   ALTER TABLE Recepcionista ADD FOREIGN KEY (Id_Turno) references Turno(Id_Turno)
   ALTER TABLE Recepcionista ADD Id_Sueldo INT NOT NULL;
   ALTER TABLE Recepcionista ADD FOREIGN KEY (Id_Sueldo) references Sueldo(Id_Sueldo)

SELECT * FROM Recepcionista

		-- Tabla Consultorio --

CREATE TABLE Consultorio(
		Num_ext VARCHAR(50) NOT NULL PRIMARY KEY,
		Id_Esp INT NOT NULL,
		Estatus VARCHAR(50) NOT NULL,
)
   ALTER TABLE Consultorio ADD FOREIGN KEY (Id_Esp) references Especialidad(Id_Esp)


SELECT * FROM Consultorio

		-- Tabla Enfermera --

CREATE TABLE Enfermera(
		Id_Enfermera INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Id_Persona INT NOT NULL,
		Id_Turno INT NOT NULL,
		Contraseña VARCHAR(50) NOT NULL,
)
   ALTER TABLE Enfermera ADD FOREIGN KEY (Id_Persona) references Persona(Id_Persona)
   ALTER TABLE Enfermera ADD FOREIGN KEY (Id_Turno) references Turno(Id_Turno)
   ALTER TABLE Enfermera ADD Id_Sueldo INT NOT NULL;
   ALTER TABLE Enfermera ADD FOREIGN KEY (Id_Sueldo) references Sueldo(Id_Sueldo)


SELECT * FROM Enfermera

		-- Tabla Doctor --
ALTER TABLE Doctor ALTER COLUMN Num_ext VARCHAR(50);
CREATE TABLE Doctor(
		Cedula VARCHAR(50) NOT NULL PRIMARY KEY,
		Id_Persona INT NOT NULL,
		Id_Esp INT NOT NULL,
		Num_ext INT NOT NULL,
		Id_Turno INT NOT NULL,
		Contraseña VARCHAR(50) NOT NULL,
		Tiempo_de_experiencia VARCHAR(50) NOT NULL,
)
   ALTER TABLE Doctor ADD FOREIGN KEY (Id_Persona) references Persona(Id_Persona)
   ALTER TABLE Doctor ADD FOREIGN KEY (Id_Esp) references Especialidad(Id_Esp)
   ALTER TABLE Doctor ADD FOREIGN KEY (Num_ext) references Consultorio(Num_ext)
   ALTER TABLE Doctor ADD FOREIGN KEY (Id_Turno) references Turno(Id_Turno)
   ALTER TABLE Doctor ADD Id_Sueldo INT NOT NULL;
   ALTER TABLE Doctor ADD FOREIGN KEY (Id_Sueldo) references Sueldo(Id_Sueldo)



SELECT * FROM Doctor

		-- Tabla Medicamento --

CREATE TABLE Medicamento(
		Id_Med INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL,
		Descripcion VARCHAR(50) NOT NULL,
		Cantidad INT NOT NULL,
)
SELECT * FROM Medicamento

		-- Tabla Receta --

CREATE TABLE Receta(
		Id_Receta INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Id_Med INT NOT NULL,
		Cedula VARCHAR(50) NOT NULL,
		NSS VARCHAR(50) NOT NULL,
		Fecha_Receta DATETIME NOT NULL,
		Hora_Receta TIME NOT NULL,
		Notas VARCHAR(50) NULL,
)
 ALTER TABLE Receta ADD FOREIGN KEY (Id_Med) references Medicamento(Id_Med)
 ALTER TABLE Receta ADD FOREIGN KEY (Cedula) references Doctor(Cedula)
 ALTER TABLE Receta ADD FOREIGN KEY (NSS) references Paciente(NSS)


SELECT * FROM Receta

		-- Tabla Historial --

CREATE TABLE Historial(
		Id_Historial INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Num_ext VARCHAR(50) NOT NULL,
		Id_Receta INT NOT NULL,
		Estatus VARCHAR(50) NOT NULL,
		Fecha_Historial DATETIME NOT NULL,
		Hora_Historial TIME NOT NULL,
		Observaciones VARCHAR(50) NOT NULL,
)

   ALTER TABLE Historial ADD FOREIGN KEY (Num_ext) references Consultorio(Num_ext)
   ALTER TABLE Historial ADD FOREIGN KEY (Id_Receta) references Receta(Id_Receta)


SELECT * FROM Historial
		-- Tabla Expediente --

CREATE TABLE Expediente(
		Id_Expediente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Id_Historial INT NOT NULL,
		Fecha_Expediente DATETIME NOT NULL,
)
		ALTER TABLE Expediente ADD FOREIGN KEY (Id_Historial) references Historial(Id_Historial)
		ON DELETE CASCADE ON UPDATE CASCADE

SELECT * FROM Expediente
		-- Tabla Departamento --

CREATE TABLE Departamento(
		Id_departamento INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		Nombre VARCHAR(50) NOT NULL,
)
Alter authorization on database::[Hospital] to [sa]
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------- Trigger ----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA PERSONA 

---insert 

CREATE TRIGGER TR_INS_Persona
ON Persona 
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Persona')
END

---- delete

CREATE TRIGGER TR_DELETE_Persona
ON Persona
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Persona')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Persona
ON Persona
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Persona')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Sueldo

--- insert 
CREATE TRIGGER TR_INS_Sueldo
ON Sueldo
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Sueldo')
END
--- delete 
CREATE TRIGGER TR_DELETE_Sueldo
ON Sueldo
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Sueldo')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Sueldo
ON Sueldo
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Sueldo')
END 
-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Turno

--- insert 
CREATE TRIGGER TR_INS_Turno
ON Turno
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Turno')
END
--- delete 
CREATE TRIGGER TR_DELETE_Turno
ON Turno
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Turno')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Turno
ON Turno
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Turno')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Especialidad

--- insert 
CREATE TRIGGER TR_INS_Especialidad
ON Especialidad
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Especialidad')
END
--- delete 
CREATE TRIGGER TR_DELETE_Especialidad
ON Especialidad
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Especialidad')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Especialidad
ON Especialidad
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Especialidad')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Paciente

--- insert 
CREATE TRIGGER TR_INS_Paciente
ON Paciente
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Paciente')
END
--- delete 
CREATE TRIGGER TR_DELETE_Paciente
ON Paciente
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Paciente')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Paciente
ON Paciente
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Paciente')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Paciente

--- insert 
CREATE TRIGGER TR_INS_Cita
ON Cita
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Cita')
END
--- delete 
CREATE TRIGGER TR_DELETE_Cita
ON Cita
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Cita')
END
---- UPDATE

CREATE TRIGGER TR_UPDATE_Cita
ON Cita
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Cita')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Recepcionista

--- insert 
CREATE TRIGGER TR_INS_Recepcionista
ON Recepcionista
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Recepcionista')
END
--- delete 
CREATE TRIGGER TR_DELETE_Recepcionista
ON Recepcionista
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Recepcionista')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Recepcionista
ON Recepcionista
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Recepcionista')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Consultorio

--- insert 
CREATE TRIGGER TR_INS_Consultorio
ON Consultorio
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Consultorio')
END
--- delete 
CREATE TRIGGER TR_DELETE_Consultorio
ON Consultorio
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Consultorio')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Consultorio
ON Consultorio
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Consultorio')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Enfermera

--- insert 
CREATE TRIGGER TR_INS_Enfermera
ON Enfermera
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Enfermera')
END
--- delete 
CREATE TRIGGER TR_DELETE_Enfermera
ON Enfermera
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Enfermera')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Enfermera
ON Enfermera
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Enfermera')
END 


-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Doctor

--- insert 
CREATE TRIGGER TR_INS_Doctor
ON Doctor
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Doctor')
END
--- delete 
CREATE TRIGGER TR_DELETE_Doctor
ON Doctor
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Doctor')
END
---- UPDATE

CREATE TRIGGER TR_UPDATE_Doctor
ON Doctor
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Doctor')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Medicamento

--- insert 
CREATE TRIGGER TR_INS_Medicamento
ON Medicamento
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Medicamento')
END
--- delete 
CREATE TRIGGER TR_DELETE_Medicamento
ON Medicamento
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Medicamento')
END 

---- UPDATE

CREATE TRIGGER TR_UPDATE_Medicamento
ON Medicamento
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Medicamento')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Receta

--- insert 
CREATE TRIGGER TR_INS_Receta
ON Receta
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Receta')
END
--- delete 
CREATE TRIGGER TR_DELETE_Receta
ON Receta
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Receta')
END 

---- UPDATE

CREATE TRIGGER TR_UPDATE_Receta
ON Receta
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Receta')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Historial

--- insert 
CREATE TRIGGER TR_INS_Historial
ON Historial
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Historial')
END
--- delete 
CREATE TRIGGER TR_DELETE_Historial
ON Historial
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Historial')
END 

---- UPDATE

CREATE TRIGGER TR_UPDATE_Historial
ON Historial
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Historial')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Expediente

--- insert 
CREATE TRIGGER TR_INS_Expediente
ON Expediente
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Expediente')
END
--- delete 
CREATE TRIGGER TR_DELETE_Expediente
ON Expediente
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Expediente')
END 
---- UPDATE

CREATE TRIGGER TR_UPDATE_Expediente
ON Expediente
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Expediente')
END 

-- CREAMOS TRIGGER DE INSERT Y DELETE PARA LA TABLA Departamento

--- insert 
CREATE TRIGGER TR_INS_Departamento
ON Departamento
AFTER INSERT
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('INSERT',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Departamento')
END
--- delete 
CREATE TRIGGER TR_DELETE_Departamento
ON Departamento
AFTER DELETE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('DELETE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Departamento')
END 

---- UPDATE

CREATE TRIGGER TR_UPDATE_Departamento
ON Departamento
AFTER UPDATE
AS BEGIN 
	INSERT INTO [HB].[dbo].Bitacora_Persona(operacion, usuario, host,modificado, tabla)
	VALUES('UPDATE',SUSER_NAME(),@@SERVERNAME, GETDATE(),'Departamento')
END 