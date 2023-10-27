USE [GD2C2023]
GO

/* CREACION DEL SCHEMA */

CREATE SCHEMA LOS_GDDS
GO


/* CREACION DE TABLAS */

/* ------------------------------------------ TIPIFICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.Propietario(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Disposicion(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE LOS_GDDS.Estado_inmueble(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE LOS_GDDS.Orientacion(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

/* ------------------------------------------ INMUEBLE ------------------------------------------ */

CREATE TABLE LOS_GDDS.Inmueble(
    id NUMERIC(18,0) PRIMARY KEY,
    tipo_inmueble_id INT, --FK
    descripcion NVARCHAR(100),
    propietario_id INT, -- FK
    direccion NVARCHAR(100),
    provincia_id INT, --FK
    superficie_total NUMERIC(18,2), 
    disposicion_id INT, --FK
    estado_id INT, --FK
    orientacion_id INT, --FK
    antiguedad NUMERIC(18,0),
    ultima_expensa NUMERIC(18,2),
    cantidad_ambientes NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Caracteristica_inmueble(
    caracteristica_id INT, --FK
    inmueble_id NUMERIC(18,0), --FK
    PRIMARY KEY (caracteristica_id, inmueble_id)
);

CREATE TABLE LOS_GDDS.Inmueble_Ambiente(
    inmueble_id NUMERIC(18,0), --FK
    ambiente_id INT, --FK
	PRIMARY KEY (inmueble_id, ambiente_id)
);

CREATE TABLE LOS_GDDS.Caracteristica(
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    valor NUMERIC (18,0)
);

CREATE TABLE LOS_GDDS.Ambiente(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE LOS_GDDS.Tipo_inmueble(
    id INT PRIMARY KEY,
    nombre VARCHAR(20)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE LOS_GDDS.Venta(
    id NUMERIC(18,0)  PRIMARY KEY, ---esto es el codigo
    anuncio_id NUMERIC(19,0), --FK
    comprador_id INT, --FK
    fecha_venta DATETIME,
    precio NUMERIC(18,2),
    moneda_id INT, --FK
    pago_venta_id INT, --FK
    comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Pago_venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    importe NUMERIC(18,2),
    moneda_id INT,      -- FK
    cotizacion NUMERIC(18,2),
    medio_pago_id INT -- FK 
);

CREATE TABLE LOS_GDDS.Comprador(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

/* ------------------------------------------ ANUNCIO ------------------------------------------ */

CREATE TABLE LOS_GDDS.Anuncio(
    id NUMERIC(19,0) PRIMARY KEY,
    fecha_publicacion DATETIME,
    agente_id NUMERIC(19,0), -- FK
    inmueble_id NUMERIC(18,0), -- FK
    operacion_id INT, -- FK
    superficie_total FLOAT, -- no se que tipo de dato es
    precio_inmueble NUMERIC(18,2),
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Agente(
    id NUMERIC(19,0) PRIMARY KEY,
    nombre NVARCHAR(100),
    sucursal_id NUMERIC(18,0), --FK
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Sucursal(
    id NUMERIC(18, 0),
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100),
    localidad_id INT --FK
);

CREATE TABLE LOS_GDDS.Estado_anuncio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE LOS_GDDS.Operacion(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20)  
);

CREATE TABLE LOS_GDDS.Tipo_periodo(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre VARCHAR(20)  
);

CREATE TABLE LOS_GDDS.Moneda(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.Provincia(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    localidad_id INT --FK
);

CREATE TABLE LOS_GDDS.Localidad(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    barrio_id INT --FK
);

CREATE TABLE LOS_GDDS.Barrio(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE LOS_GDDS.Alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    anuncio_id NUMERIC(19,0), -- FK
    inquilino_id INT, -- FK
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    importe NUMERIC(18,2),   -- no esta en la global
    cantidad_periodos NUMERIC(18,0),
    comision NUMERIC(18,2),
    gastos_averiguaciones NUMERIC(18,2),
    estado_id INT, --FK
    deposito NUMERIC(18,2)
);



CREATE TABLE LOS_GDDS.Pago_alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    alquiler_id NUMERIC(18,0), -- FK
    fecha DATETIME,
    num_periodo INT,    
    descripcion_periodo NVARCHAR(100),
    fecha_inicio_periodo DATETIME,
    fecha_fin_periodo DATETIME,
    importe NUMERIC(18,2),
    medio_pago_id INT --FK
);

CREATE TABLE LOS_GDDS.Inquilino(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Estado_alquiler(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Detalle_alquiler(
    id INT PRIMARY KEY,
    periodo_inicio NUMERIC(18,0),
    periodo_fin NUMERIC(18,0),
    precio NUMERIC(18,2),
    alquiler_id NUMERIC(18,0) --FK
);

CREATE TABLE LOS_GDDS.Medio_pago(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);



/* ------------------------------------------ FOREIGN KEYS ------------------------------------------ */

-- Anuncio
ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_agente
FOREIGN KEY (agente_id) REFERENCES LOS_GDDS.Agente(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.Inmueble(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_periodo
FOREIGN KEY (periodo_id) REFERENCES LOS_GDDS.Tipo_periodo(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_anuncio(id)
GO

-- Inmueble
ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.Tipo_inmueble(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_propietario
FOREIGN KEY (propietario_id) REFERENCES LOS_GDDS.Propietario(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_provincia
FOREIGN KEY (provincia_id) REFERENCES LOS_GDDS.Provincia(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_disposicion
FOREIGN KEY (disposicion_id) REFERENCES LOS_GDDS.Disposicion(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_inmueble(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.Tipo_inmueble(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_orientacion
FOREIGN KEY (orientacion_id) REFERENCES LOS_GDDS.Orientacion(id)
GO

-- Venta
ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.Anuncio(id)
GO

ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_comprador
FOREIGN KEY (comprador_id) REFERENCES LOS_GDDS.Comprador(id)
GO

ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_pago
FOREIGN KEY (pago_venta_id) REFERENCES LOS_GDDS.Pago_venta(id)
GO

-- Pago_venta
ALTER TABLE LOS_GDDS.Pago_venta 
ADD CONSTRAINT FK_pago_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Pago_venta 
ADD CONSTRAINT FK_pago_medio
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.Medio_pago(id)
GO

-- Ubicacion
ALTER TABLE LOS_GDDS.Provincia 
ADD CONSTRAINT FK_provincia_localidad
FOREIGN KEY (localidad_id) REFERENCES LOS_GDDS.Localidad(id)
GO

ALTER TABLE LOS_GDDS.Localidad 
ADD CONSTRAINT FK_localidad_barrio
FOREIGN KEY (barrio_id) REFERENCES LOS_GDDS.Barrio(id)
GO

-- Alquiler
ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.Anuncio(id)
GO

ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_inquilino
FOREIGN KEY (inquilino_id) REFERENCES LOS_GDDS.Inquilino(id)
GO

ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_anuncio(id)
GO

-- Pago Alquiler
ALTER TABLE LOS_GDDS.Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.Alquiler(id)
GO

ALTER TABLE LOS_GDDS.Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_medioPago
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.Medio_pago(id)
GO

-- Detalle Alquiler
ALTER TABLE LOS_GDDS.Detalle_alquiler
ADD CONSTRAINT FK_detalleAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.Alquiler(id)

-- Agente
ALTER TABLE LOS_GDDS.Agente
ADD CONSTRAINT FK_agente_sucursal
FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.Sucursal(id)
GO

-- Sucursal
ALTER TABLE LOS_GDDS.Sucursal
ADD CONSTRAINT FK_sucursal_provincia
FOREIGN KEY (localidad_id) REFERENCES LOS_GDDS.Localidad(id)
GO

-- Caracteristica Inmueble
ALTER TABLE LOS_GDDS.Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES LOS_GDDS.Caracteristica(id)
GO

ALTER TABLE LOS_GDDS.Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.Inmueble(id)
GO

-- Inmueble_Ambiente
ALTER TABLE LOS_GDDS.Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.Inmueble(id)
GO

ALTER TABLE LOS_GDDS.Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_ambiente
FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.Ambiente(id)
GO

/* ------------------------------------------ MIGRACIÓN CON PROCEDURES ------------------------------------------ */

CREATE PROCEDURE LOS_GDDS.MIGRAR_Agente
AS 
BEGIN
	INSERT INTO LOS_GDDS.Agente
		(dni, nombre, apellido, fecha_nacimiento, fecha_registro, mail, telefono)
	SELECT DISTINCT m.AGENTE_DNI, m.AGENTE_NOMBRE, m.AGENTE_APELLIDO, m.AGENTE_FECHA_NAC, m.AGENTE_FECHA_REGISTRO, m.AGENTE_MAIL, m.AGENTE_TELEFONO
    FROM gd_esquema.Maestra m
    WHERE m.AGENTE_DNI IS NOT NULL 
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Sucursal
AS 
BEGIN
	INSERT INTO LOS_GDDS.Sucursal
		()
	SELECT DISTINCT m.SUCURSAL_CODIGO, M.SUCURSAL_NOMBRE
    FROM gd_esquema.Maestra m
END
GO



-- CREATE PROCEDURE PEDIDOS_APP.MIGRAR_MEDIO_PAGO 
-- AS 
-- BEGIN
-- 	INSERT INTO PEDIDOS_APP.MEDIO_PAGO
-- 		(MEDIO_PAGO_NRO_TARJETA, MEDIO_PAGO_TIPO, MARCA_TARJETA, USUARIO_DNI)
-- 	SELECT DISTINCT m.MEDIO_PAGO_NRO_TARJETA, m.MEDIO_PAGO_TIPO, m.MARCA_TARJETA, u.USUARIO_DNI
-- 	FROM gd_esquema.Maestra m
-- 	JOIN USUARIO u on u.USUARIO_DNI = m.USUARIO_DNI
-- 	where m.MEDIO_PAGO_NRO_TARJETA is not null
-- END
-- GO

