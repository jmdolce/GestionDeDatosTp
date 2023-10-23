USE [GD2C2023]
GO

/* CREACION DEL SCHEMA */

CREATE SCHEMA LOS_GDDS
GO


/* CREACION DE TABLAS */

/* ------------------------------------------ TIPIFICACION ------------------------------------------ */

CREATE TABLE Propietario(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    dni INT,
    fecha_registro DATE,
    telefono INT,
    mail VARCHAR(20),
    fecha_nacimiento DATE
);

CREATE TABLE Disposicion(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Estado_inmueble(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Orientacion(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

/* ------------------------------------------ INMUEBLE ------------------------------------------ */

CREATE TABLE Inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    tipo_inmueble_id INT, --FK
    descripcion TEXT,
    propietario_id INT, -- FK
    direccion VARCHAR(30),
    provincia_id INT, --FK
    superficie_total FLOAT, 
    disposicion_id INT, --FK
    estado_id INT, --FK
    orientacion_id INT, --FK
    antiguedad INT,
    caracteristica_id INT, --FK
    ultima_expensa FLOAT,
    cantidad_ambientes INT
);

CREATE TABLE Caracteristica_inmueble(
    caracteristica_id INT, --FK
    inmueble_id INT, --FK
    PRIMARY KEY (caracteristica_id, inmueble_id)
);

CREATE TABLE Inmueble_Ambiente(
    inmueble_id INT, --FK
    ambiente_id INT, --FK
	PRIMARY KEY (inmueble_id, ambiente_id)
);

CREATE TABLE Caracteristica(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Ambiente(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE Venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    anuncio_id INT, --FK
    comprador_id INT, --FK
    fecha_venta DATE,
    precio FLOAT,
    moneda_id INT, --FK
    pago_venta_id INT, --FK
    comision FLOAT
);

CREATE TABLE Pago_venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    importe FLOAT,
    moneda_id INT,      -- FK
    cotizacion FLOAT,
    medio_pago_id INTEGER -- FK 
);

CREATE TABLE Comprador(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    dni INT,
    fecha_registro DATE,
    telefono INT,
    mail VARCHAR(20),
    fecha_nacimiento DATE
);

/* ------------------------------------------ ANUNCIO ------------------------------------------ */

CREATE TABLE Anuncio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha_publicacion DATE,
    agente_id INT, -- FK
    operacion_id INT, -- FK
    superficie_total FLOAT,
    precio_inmueble FLOAT,
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion FLOAT
);

CREATE TABLE Agente(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    sucursal_id INT --FK
);

CREATE TABLE Sucursal(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    provincia_id INT --FK
);

CREATE TABLE Estado_anuncio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Operacion(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20)  
);

CREATE TABLE Tipo_periodo(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20)  
);

CREATE TABLE Moneda(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE Provincia(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    localidad_id INT --FK
);

CREATE TABLE Localidad(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    barrio_id INT --FK
);

CREATE TABLE Barrio(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE Alquiler(
    id INT PRIMARY KEY,
    anuncio_id INT, -- FK
    inquilino_id INT, -- FK
    fecha_inicio DATE,
    fecha_fin DATE,
    importe FLOAT,
    cantidad_periodos INT,
    comision FLOAT,
    gastos_averiguaciones FLOAT,
    estado_id INT, --FK
    deposito FLOAT
);

CREATE TABLE Pago_alquiler(
    id INT PRIMARY KEY,
    alquiler_id INT, -- FK
    fecha DATE,
    num_peeriodo INT,
    descripcion_periodo VARCHAR(255),
    fecha_inicio_periodo DATE,
    fecha_fin_periodo DATE,
    importe FLOAT,
    medio_pago_id INT --FK
);

CREATE TABLE Inquilino(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    dni INT,
    fecha_registro DATE,
    telefono INT,
    mail VARCHAR(20),
    fecha_nacimiento DATE
);

CREATE TABLE Estado_alquiler(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Detalle_alquiler(
    id INT PRIMARY KEY,
    periodo_inicio INT,
    periodo_fin INT,
    precio FLOAT,
    alquiler_id INT --FK
);

CREATE TABLE Medio_pago(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);



/* ------------------------------------------ FOREIGN KEYS ------------------------------------------ */

-- Anuncio
ALTER TABLE Anuncio 
ADD CONSTRAINT FK_anuncio_agente
FOREIGN KEY (agente_id) REFERENCES Agente(id)
GO

ALTER TABLE Anuncio 
ADD CONSTRAINT FK_anuncio_inmueble
FOREIGN KEY (inmueble_id) REFERENCES Inmueble(id)
GO

ALTER TABLE Anuncio 
ADD CONSTRAINT FK_anuncio_moneda
FOREIGN KEY (moneda_id) REFERENCES Moneda(id)
GO

ALTER TABLE Anuncio 
ADD CONSTRAINT FK_anuncio_periodo
FOREIGN KEY (periodo_id) REFERENCES Periodo(id)
GO

ALTER TABLE Anuncio 
ADD CONSTRAINT FK_anuncio_estado
FOREIGN KEY (estado_id) REFERENCES Estado_anuncio(id)
GO

-- Inmueble
ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES Inmueble_tipo(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_propietario
FOREIGN KEY (propietario_id) REFERENCES Propietario(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_provincia
FOREIGN KEY (provincia_id) REFERENCES Provincia(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_disposicion
FOREIGN KEY (disposicion_id) REFERENCES Disposicion(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_estado
FOREIGN KEY (estado_id) REFERENCES Estado_inmueble(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES FK_inmueble_tipo(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_orientacion
FOREIGN KEY (orientacion_id) REFERENCES Orientacion(id)
GO

ALTER TABLE Inmueble
ADD CONSTRAINT FK_inmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES Caracteristica_inmueble(id)
GO

-- Venta
ALTER TABLE Venta 
ADD CONSTRAINT FK_venta_anuncio
FOREIGN KEY (anuncio_id) REFERENCES Anuncio(id)
GO

ALTER TABLE Venta 
ADD CONSTRAINT FK_venta_comprador
FOREIGN KEY (comprador_id) REFERENCES Comprador(id)
GO

ALTER TABLE Venta 
ADD CONSTRAINT FK_venta_moneda
FOREIGN KEY (moneda_id) REFERENCES Moneda(id)
GO

ALTER TABLE Venta 
ADD CONSTRAINT FK_venta_pago
FOREIGN KEY (pago_venta_id) REFERENCES Pago_venta(id)
GO

-- Pago_venta
ALTER TABLE Pago_venta 
ADD CONSTRAINT FK_pago_moneda
FOREIGN KEY (moneda_id) REFERENCES Moneda(id)
GO

ALTER TABLE Pago_venta 
ADD CONSTRAINT FK_pago_medio
FOREIGN KEY (medio_id) REFERENCES Medio_pago(id)
GO

-- Ubicacion
ALTER TABLE Provincia 
ADD CONSTRAINT FK_provincia_localidad
FOREIGN KEY (localidad_id) REFERENCES Localidad(id)
GO

ALTER TABLE Localidad 
ADD CONSTRAINT FK_localidad_barrio
FOREIGN KEY (barrio_id) REFERENCES Barrio(id)
GO

-- Alquiler
ALTER TABLE Alquiler 
ADD CONSTRAINT FK_alquiler_anuncio
FOREIGN KEY (anuncio_id) REFERENCES Anuncio(id)
GO

ALTER TABLE Alquiler 
ADD CONSTRAINT FK_alquiler_inquilino
FOREIGN KEY (inquilino_id) REFERENCES Inquilino(id)
GO

ALTER TABLE Alquiler 
ADD CONSTRAINT FK_alquiler_estado
FOREIGN KEY (estado_id) REFERENCES Estado_anuncio(id)
GO

-- Pago Alquiler
ALTER TABLE Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES Alquiler(id)
GO

ALTER TABLE Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_medioPago
FOREIGN KEY (medio_pago_id) REFERENCES Alquiler(id)
GO

-- Detalle Alquiler
ALTER TABLE Detalle_alquiler
ADD CONSTRAINT FK_detalleAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES Alquiler(id)

-- Agente
ALTER TABLE Agente
ADD CONSTRAINT FK_agente_sucursal
FOREIGN KEY (sucursal_id) REFERENCES Sucursal(id)
GO

-- Sucursal
ALTER TABLE Sucursal
ADD CONSTRAINT FK_sucursal_provincia
FOREIGN KEY (provincia_id) REFERENCES Provincia(id)
GO

-- Caracteristica Inmueble
ALTER TABLE Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES Caracteristica(id)
GO

ALTER TABLE Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_inmueble
FOREIGN KEY (inmueble_id) REFERENCES Inmueble(id)
GO

-- Inmueble_Ambiente
ALTER TABLE Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_inmueble
FOREIGN KEY (inmueble_id) REFERENCES Inmueble(id)
GO

ALTER TABLE Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_ambiente
FOREIGN KEY (ambiente_id) REFERENCES Ambiente(id)
GO


/*
CREATE PROCEDURE PEDIDOS_APP.MIGRAR_USUARIO 
AS 
BEGIN
	INSERT INTO Tabla
		(campo1, campo2, ...)
	SELECT DISTINCT 
END
GO


CREATE PROCEDURE PEDIDOS_APP.MIGRAR_MEDIO_PAGO 
AS 
BEGIN
	INSERT INTO PEDIDOS_APP.MEDIO_PAGO
		(MEDIO_PAGO_NRO_TARJETA, MEDIO_PAGO_TIPO, MARCA_TARJETA, USUARIO_DNI)
	SELECT DISTINCT m.MEDIO_PAGO_NRO_TARJETA, m.MEDIO_PAGO_TIPO, m.MARCA_TARJETA, u.USUARIO_DNI
	FROM gd_esquema.Maestra m
	JOIN USUARIO u on u.USUARIO_DNI = m.USUARIO_DNI
	where m.MEDIO_PAGO_NRO_TARJETA is not null
END
GO
*/

