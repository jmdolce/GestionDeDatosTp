

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
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Estado_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Orientacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
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
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
);

CREATE TABLE LOS_GDDS.Ambiente(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Tipo_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE LOS_GDDS.Venta(
    id NUMERIC(18,0) PRIMARY KEY, ---esto es el codigo
    anuncio_id INT NULL, --FK
    comprador_id INT, --FK
    fecha_venta DATETIME,
    precio NUMERIC(18,2),
    moneda_id INT, --FK
    comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Pago_venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    importe NUMERIC(18,2),
    moneda_id INT,      -- FK
    cotizacion NUMERIC(18,2),
    medio_pago_id INT, -- FK
    venta_id NUMERIC(18,0) -- FK
);

CREATE TABLE LOS_GDDS.Comprador(
    id INT IDENTITY(1,1) PRIMARY KEY,
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
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha_publicacion DATETIME,
    agente_id NUMERIC(19,0) NULL, -- FK
    inmueble_id NUMERIC(18,0) NULL, -- FK
    operacion_id INT, -- FK
    precio_inmueble NUMERIC(18,2),
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Agente(
    id NUMERIC(19,0) IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    sucursal_id NUMERIC(18,0) NULL, --FK
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
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
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Localidad(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    provincia_id INT --FK
);

CREATE TABLE LOS_GDDS.Barrio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    localidad_id INT -- FK
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE LOS_GDDS.Alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    anuncio_id INT NULL, -- FK
    inquilino_id INT NULL, -- FK
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    importe NUMERIC(18,2) NULL,   -- no esta en la global
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
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Estado_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Detalle_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    periodo_inicio NUMERIC(18,0),
    periodo_fin NUMERIC(18,0),
    precio NUMERIC(18,2),
    alquiler_id NUMERIC(18,0) NULL --FK
);

CREATE TABLE LOS_GDDS.Medio_pago(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);