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
    barrio_id INT, --FK
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
    valor NUMERIC (18,0),
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
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Operacion(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.Tipo_periodo(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.Moneda(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.Provincia(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Localidad(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    provincia_id INT --FK
);

CREATE TABLE LOS_GDDS.Barrio(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    localidad_id INT -- FK
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

CREATE PROCEDURE LOS_GDDS.MIGRAR_Provincia
AS 
BEGIN
	INSERT INTO LOS_GDDS.Provincia(nombre)

	SELECT DISTINCT m.INMUEBLE_PROVINCIA
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_CODIGO IS NOT NULL 
    UNION
	SELECT DISTINCT m.SUCURSAL_PROVINCIA
    FROM gd_esquema.Maestra m
    WHERE m.SUCURSAL_CODIGO IS NOT NULL 
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Localidad
AS 
BEGIN
	INSERT INTO LOS_GDDS.Localidad(nombre, provincia_id) 

	SELECT DISTINCT m.INMUEBLE_LOCALIDAD, p.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON m.INMUEBLE_PROVINCIA = p.nombre
    WHERE m.INMUEBLE_CODIGO IS NOT NULL 

    UNION

	SELECT DISTINCT m.SUCURSAL_LOCALIDAD, p.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON p.nombre = m.SUCURSAL_PROVINCIA
    WHERE m.SUCURSAL_CODIGO IS NOT NULL 
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Barrio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Barrio(nombre, localidad_id)
	SELECT DISTINCT m.INMUEBLE_BARRIO, l.id
    JOIN LOS_GDDS.Localidad l ON m.INMUEBLE_LOCALIDAD = l.nombre
    FROM gd_esquema.Maestra m
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Sucursal
AS 
BEGIN
	INSERT INTO LOS_GDDS.Sucursal
		(id, nombre, direccion, telefono, localidad_id)
	SELECT DISTINCT m.SUCURSAL_CODIGO, m.SUCURSAL_NOMBRE, m.SUCURSAL_DIRECCION, M.SUCURSAL_TELEFONO, l.id
    JOIN LOS_GDDS.Localidad l ON m.SUCURSAL_LOCALIDAD = l.nombre
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_PROPIETARIO 
AS
BEGIN
    INSERT INTO LOS_GDDS.Propietario (id, nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
    SELECT 
        PROPIETARIO_DNI, PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL, PROPIETARIO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE PROPIETARIO_DNI IS NOT NULL;
END;

------------- INMUEBLE ----------------
CREATE PROCEDURE LOS_GDDS.MIGRAR_Disposicion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Disposicion (nombre)
	SELECT DISTINCT m.INMUEBLE_DISPOSICION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_inmueble (nombre)
	SELECT DISTINCT m.INMUEBLE_ESTADO
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Orientacion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Orientacion (nombre)
	SELECT DISTINCT m.INMUEBLE_ORIENTACION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_inmueble(nombre)
	SELECT DISTINCT m.INMUEBLE_TIPO_INMUEBLE
    FROM gd_esquema.Maestra m
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Caracteristica
AS 
BEGIN
	INSERT INTO LOS_GDDS.Caracteristica(nombre)
	VALUES(wifi), (cable), (calefaccion), (gas);
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_INMUEBLE AS
BEGIN
    INSERT INTO LOS_GDDS.Inmueble (id, tipo_inmueble_id, descripcion, propietario_id, direccion, barrio_id, superficie_total, disposicion_id, estado_id, orientacion_id, antiguedad, ultima_expensa, cantidad_ambientes)
    SELECT 
        INMUEBLE_CODIGO, INMUEBLE_TIPO_INMUEBLE, INMUEBLE_DESCRIPCION, p.id, INMUEBLE_DIRECCION, b.id, INMUEBLE_SUPERFICIETOTAL, d.id, e.id, o.id, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS, INMUEBLE_CANT_AMBIENTES
    FROM gd_esquema.Maestra m
    LEFT JOIN LOS_GDDS.Propietario p ON m.PROPIETARIO_DNI = p.dni -- en la tabla maestra no hay un INMUEBLE_PROPIETARIO, no se como hacer esto
    LEFT JOIN LOS_GDDS.Disposicion d ON m.INMUEBLE_DISPOSICION = d.nombre
    LEFT JOIN LOS_GDDS.Estado_inmueble e ON m.INMUEBLE_ESTADO = e.nombre
    LEFT JOIN LOS_GDDS.Orientacion o ON m.INMUEBLE_ORIENTACION = o.nombre
    LEFT JOIN LOS_GDDS.Barrio b ON m.INMUEBLE_BARRIO = b.nombre
    WHERE INMUEBLE_CODIGO IS NOT NULL;
END;

CREATE PROCEDURE LOS_GDDS.MIGRAR_CaracteristicaInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_WIFI
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'wifi'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_CABLE
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'cable'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_CALEFACCION
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'calefaccion'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_GAS
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'gas'
    WHERE INMUEBLE_CODIGO IS NOT NULL;
    
END
GO


------------- ANUNCIO ----------------
CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAnuncio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_anuncio
        (nombre)
	SELECT DISTINCT m.ANUNCIO_ESTADO 
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Operacion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_anuncio
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_OPERACION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoPeriodo
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_periodo
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_PERIODO
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Moneda
AS 
BEGIN
	INSERT INTO LOS_GDDS.Moneda
        (nombre)
	SELECT DISTINCT m.ANUNCIO_MONEDA
    FROM gd_esquema.Maestra m
    WHERE m.ANUNCIO_CODIGO IS NOT NULL
    UNION
    SELECT DISTINCT m.VENTA_MONEDA
    FROM gd_esquema.Maestra m
    WHERE m.VENTA_CODIGO IS NOT NULL
END
GO

------------- COMPRADOR ----------------

CREATE PROCEDURE LOS_GDDS.MIGRAR_Comprador
AS 
BEGIN
	INSERT INTO LOS_GDDS.Comprador
        (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
	SELECT DISTINCT m.COMPRADOR_NOMBRE, m.COMPRADOR_APELLIDO, m.COMPRADOR_DNI, m.COMPRADOR_FECHA_REGISTRO, 
                    m.COMPRADOR_TELEFONO, m.COMPRADOR_MAIL, m.COMPRADOR_FECHA_NAC
    FROM gd_esquema.Maestra m
END
GO


------------- PAGO ----------------

CREATE PROCEDURE LOS_GDDS.MIGRAR_MedioPago
AS 
BEGIN
	INSERT INTO LOS_GDDS.Medio_pago
        (nombre)

	SELECT DISTINCT m.PAGO_ALQUILER_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.ALQUILER_CODIGO IS NOT NULL 
    UNION
	SELECT DISTINCT m.PAGO_VENTA_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.VENTA_CODIGO IS NOT NULL 
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoVenta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Pago_venta
        (importe, moneda_id, cotizacion, medio_pago_id)
	SELECT DISTINCT m.PAGO_VENTA_IMPORTE, mon.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.PAGO_VENTA_MONEDA
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_VENTA_MEDIO_PAGO
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Pago_alquiler
        (id, fecha, num_periodo, descripcion_periodo, fecha_inicio_periodo, fecha_fin_periodo, importe, medio_pago_id)
	SELECT DISTINCT m.PAGO_ALQUILER_CODIGO, m.PAGO_ALQUILER_NRO_PERIODO, m.PAGO_ALQUILER_DESC, m.PAGO_ALQUILER_FEC_INI,
                    m.PAGO_ALQUILER_FEC_FIN, m.PAGO_ALQUILER_IMPORTE, mp.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_VENTA_MEDIO_PAGO
END
GO

------------- VENTA ----------------

CREATE PROCEDURE LOS_GDDS.MIGRAR_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Venta
        (id, anuncio_id, comprador_id, fecha_venta, precio, moneda_id, pago_venta_id, comision)
	SELECT DISTINCT m.VENTA_CODIGO, c.id, m.VENTA_FECHA, m.VENTA_PRECIO_VENTA, mon.id, m.VENTA_COMISION
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Comprador c ON c.nombre = m.COMPRADOR_NOMBRE AND c.apellido = m.COMPRADOR_APELLIDO AND c.dni = m.COMPRADOR_DNI
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.VENTA_MONEDA
    
END
GO


------------- ALQUILER ----------------


 CREATE PROCEDURE LOS_GDDS.MIGRAR_Inquilino
AS 
BEGIN
	INSERT INTO LOS_GDDS.Inquilino
        (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
	SELECT DISTINCT m.INQUILINO_NOMBRE, m.INQUILINO_APELLIDO, m.INQUILINO_DNI, m.INQUILINO_FECHA_REGISTRO, 
                    m.INQUILINO_TELEFONO, m.INQUILINO_MAIL, m.INQUILINO_FECHA_NAC
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_alquiler
        (nombre)
	SELECT DISTINCT m.ALQUILER_ESTADO
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_DetalleAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Detalle_alquiler
        (periodo_inicio, periodo_fin, precio)
	SELECT DISTINCT m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN, m.DETALLE_ALQ_PRECIO
    FROM gd_esquema.Maestra m
END
GO

/*
Hago los procedures suponiendo que estos cambios ya estan hechos.
El alquiler deberia tener un pago_alquiler_id como lo tiene venta con pago_venta ---> Cambiar en der y tablas.
Sacar de pago_alquiler el alquiler_id 
Duda con alquiler
Como tengo duda con alquiler no puedo hacer venta completa
Con venta duda con pago_venta_id
el id del inquilino deberia ser autogenerado ? porq la maestra no tiene ni id ni codigo para los inquilinos
El detalle alquiler no deberia tener alquiler_id si no que el alquiler deberia tener el detalle_id
FALTARIA ALQUILER-VENTA_INQUILINO_CARACTERISTICAS
*/
-------

------------- EJECUCION DE PROCEDURES ----------------

EXEC LOS_GDDS.MIGRAR_Provincia
EXEC LOS_GDDS.MIGRAR_Localidad
EXEC LOS_GDDS.MIGRAR_Barrio
EXEC LOS_GDDS.MIGRAR_Sucursal
EXEC LOS_GDDS.MIGRAR_Agente
EXEC LOS_GDDS.MIGRAR_Disposicion
EXEC LOS_GDDS.MIGRAR_EstadoInmueble
EXEC LOS_GDDS.MIGRAR_TipoInmueble
EXEC LOS_GDDS.MIGRAR_Orientacion
--- ACA LA DE CARACTERISTICA
--- ACA LA DE AMBIENTE
EXEC LOS_GDDS.MIGRAR_PROPIETARIO
EXEC LOS_GDDS.MIGRAR_EstadoAnuncio
EXEC LOS_GDDS.MIGRAR_Operacion
EXEC LOS_GDDS.MIGRAR_TipoPeriodo
EXEC LOS_GDDS.MIGRAR_Moneda
EXEC LOS_GDDS.MIGRAR_MedioPago
EXEC LOS_GDDS.MIGRAR_PagoVenta
EXEC LOS_GDDS.MIGRAR_DetalleAlquiler
EXEC LOS_GDDS.MIGRAR_Inquilino
EXEC LOS_GDDS.MIGRAR_EstadoAlquiler
EXEC LOS_GDDS.MIGRAR_PagoAlquiler
--- ACA ANUNCIO
--- ACA ALQUILER
--- ACA VENTA
--- ACA INMUEBLE




CREATE TABLE [gd_esquema].[Maestra](
	[INMUEBLE_CODIGO] [numeric](18, 0) NULL,
	[INMUEBLE_NOMBRE] [nvarchar](100) NULL,
	[INMUEBLE_DESCRIPCION] [nvarchar](100) NULL,
	[INMUEBLE_DIRECCION] [nvarchar](100) NULL,
	[INMUEBLE_SUPERFICIETOTAL] [numeric](18, 2) NULL,
	[INMUEBLE_ANTIGUEDAD] [numeric](18, 0) NULL,
	[INMUEBLE_EXPESAS] [numeric](18, 2) NULL,
	[INMUEBLE_CARACTERISTICA_WIFI] [numeric](18, 0) NULL,
	[INMUEBLE_CARACTERISTICA_CABLE] [numeric](18, 0) NULL,
	[INMUEBLE_CARACTERISTICA_CALEFACCION] [numeric](18, 0) NULL,
	[INMUEBLE_CARACTERISTICA_GAS] [numeric](18, 0) NULL,
	[INMUEBLE_BARRIO] [nvarchar](100) NULL,
	[INMUEBLE_LOCALIDAD] [nvarchar](100) NULL,
	[INMUEBLE_PROVINCIA] [nvarchar](100) NULL,
	[INMUEBLE_TIPO_INMUEBLE] [nvarchar](100) NULL,

	[PROPIETARIO_NOMBRE] [nvarchar](100) NULL,
	[PROPIETARIO_APELLIDO] [nvarchar](100) NULL,
	[PROPIETARIO_DNI] [numeric](18, 0) NULL,
	[PROPIETARIO_FECHA_REGISTRO] [datetime] NULL,
	[PROPIETARIO_TELEFONO] [numeric](18, 0) NULL,
	[PROPIETARIO_MAIL] [nvarchar](255) NULL,
	[PROPIETARIO_FECHA_NAC] [datetime] NULL,
    
	[INMUEBLE_CANT_AMBIENTES] [nvarchar](100) NULL,
	[INMUEBLE_ORIENTACION] [nvarchar](100) NULL,
	[INMUEBLE_DISPOSICION] [nvarchar](100) NULL,
	[INMUEBLE_ESTADO] [nvarchar](100) NULL,

	[ANUNCIO_CODIGO] [numeric](19, 0) NULL,
	[ANUNCIO_FECHA_PUBLICACION] [datetime] NULL,
	[ANUNCIO_PRECIO_PUBLICADO] [numeric](18, 2) NULL,
	[ANUNCIO_COSTO_ANUNCIO] [numeric](18, 2) NULL,
	[ANUNCIO_FECHA_FINALIZACION] [datetime] NULL,
	[ANUNCIO_TIPO_OPERACION] [nvarchar](100) NULL,
	[ANUNCIO_MONEDA] [nvarchar](100) NULL,
	[ANUNCIO_ESTADO] [nvarchar](100) NULL,
	[ANUNCIO_TIPO_PERIODO] [nvarchar](100) NULL,

	[AGENTE_NOMBRE] [nvarchar](100) NULL,
	[AGENTE_APELLIDO] [nvarchar](100) NULL,
	[AGENTE_DNI] [numeric](18, 0) NULL,
	[AGENTE_FECHA_REGISTRO] [datetime] NULL,
	[AGENTE_TELEFONO] [numeric](18, 0) NULL,
	[AGENTE_MAIL] [nvarchar](100) NULL,
	[AGENTE_FECHA_NAC] [datetime] NULL,

	[SUCURSAL_CODIGO] [numeric](18, 0) NULL,
	[SUCURSAL_NOMBRE] [nvarchar](100) NULL,
	[SUCURSAL_DIRECCION] [nvarchar](100) NULL,
	[SUCURSAL_TELEFONO] [nvarchar](100) NULL,
	[SUCURSAL_LOCALIDAD] [nvarchar](100) NULL,
	[SUCURSAL_PROVINCIA] [nvarchar](100) NULL,

	[VENTA_CODIGO] [numeric](18, 0) NULL,
	[VENTA_FECHA] [datetime] NULL,
	[VENTA_PRECIO_VENTA] [numeric](18, 2) NULL,
	[VENTA_COMISION] [numeric](18, 2) NULL,

	[COMPRADOR_NOMBRE] [nvarchar](100) NULL,
	[COMPRADOR_APELLIDO] [nvarchar](100) NULL,
	[COMPRADOR_DNI] [numeric](18, 0) NULL,
	[COMPRADOR_FECHA_REGISTRO] [datetime] NULL,
	[COMPRADOR_TELEFONO] [numeric](18, 0) NULL,
	[COMPRADOR_MAIL] [nvarchar](100) NULL,
	[COMPRADOR_FECHA_NAC] [datetime] NULL,
    
	[VENTA_MONEDA] [nvarchar](100) NULL,
	[PAGO_VENTA_IMPORTE] [numeric](18, 2) NULL,
	[PAGO_VENTA_MONEDA] [nvarchar](100) NULL,
	[PAGO_VENTA_COTIZACION] [numeric](18, 2) NULL,
	[PAGO_VENTA_MEDIO_PAGO] [nvarchar](100) NULL,

	[ALQUILER_CODIGO] [numeric](18, 0) NULL,
	[ALQUILER_FECHA_INICIO] [datetime] NULL,
	[ALQUILER_FECHA_FIN] [datetime] NULL,
	[ALQUILER_CANT_PERIODOS] [numeric](18, 0) NULL,
	[ALQUILER_DEPOSITO] [numeric](18, 2) NULL,
	[ALQUILER_COMISION] [numeric](18, 2) NULL,
	[ALQUILER_GASTOS_AVERIGUA] [numeric](18, 2) NULL,
    [ALQUILER_ESTADO] [nvarchar](100) NULL,

    [DETALLE_ALQ_NRO_PERIODO_INI] [numeric](18, 0) NULL,
	[DETALLE_ALQ_NRO_PERIODO_FIN] [numeric](18, 0) NULL,
	[DETALLE_ALQ_PRECIO] [numeric](18, 2) NULL,

	[INQUILINO_NOMBRE] [nvarchar](100) NULL,
	[INQUILINO_APELLIDO] [nvarchar](100) NULL,
	[INQUILINO_DNI] [numeric](18, 0) NULL,
	[INQUILINO_FECHA_REGISTRO] [datetime] NULL,
	[INQUILINO_TELEFONO] [numeric](18, 0) NULL,
	[INQUILINO_MAIL] [nvarchar](100) NULL,
	[INQUILINO_FECHA_NAC] [datetime] NULL,
	
	
	[PAGO_ALQUILER_CODIGO] [numeric](18, 0) NULL,
	[PAGO_ALQUILER_FECHA] [datetime] NULL,
	[PAGO_ALQUILER_FECHA_VENCIMIENTO] [datetime] NULL,
	[PAGO_ALQUILER_NRO_PERIODO] [numeric](18, 0) NULL,
	[PAGO_ALQUILER_DESC] [nvarchar](100) NULL,
	[PAGO_ALQUILER_FEC_INI] [datetime] NULL,
	[PAGO_ALQUILER_FEC_FIN] [datetime] NULL,
	[PAGO_ALQUILER_IMPORTE] [numeric](18, 2) NULL,
	[PAGO_ALQUILER_MEDIO_PAGO] [nvarchar](100) NULL

) ON [PRIMARY]
GO


