

/* CREACION DE TABLAS */

/* ------------------------------------------ TIPIFICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Propietario(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.BI_Disposicion(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Estado_inmueble(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Orientacion(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ INMUEBLE ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Inmueble(
    id NUMERIC(18,0) PRIMARY KEY,
    tipo_inmueble_id INT, --FK
    descripcion NVARCHAR(100),
    propietario_id INT, -- FK
    direccion NVARCHAR(100),
    ubicacion_id INT, --FK
    superficie_total NUMERIC(18,2), 
    disposicion_id INT, --FK
    estado_id INT, --FK
    orientacion_id INT, --FK
    antiguedad NUMERIC(18,0),
    ultima_expensa NUMERIC(18,2),
);

CREATE TABLE LOS_GDDS.BI_Caracteristica_inmueble(
    caracteristica_id INT, --FK
    inmueble_id NUMERIC(18,0), --FK
    PRIMARY KEY (caracteristica_id, inmueble_id)
);

CREATE TABLE LOS_GDDS.BI_Inmueble_Ambiente(
    inmueble_id NUMERIC(18,0), --FK
    ambiente_id INT, --FK
	PRIMARY KEY (inmueble_id, ambiente_id)
);

CREATE TABLE LOS_GDDS.BI_Caracteristica(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100),
);

CREATE TABLE LOS_GDDS.BI_Ambiente(
    id INT  PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Tipo_inmueble(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Venta(
    id NUMERIC(18,0) PRIMARY KEY, ---esto es el codigo
    anuncio_id NUMERIC(18,0) NULL, --FK
    comprador_id INT, --FK
    fecha_venta DATETIME,
    precio NUMERIC(18,2),
    moneda_id INT, --FK
    comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_Pago_venta(
    id INT  PRIMARY KEY,
    importe NUMERIC(18,2),
    moneda_id INT,      -- FK
    cotizacion NUMERIC(18,2),
    medio_pago_id INT, -- FK
    venta_id NUMERIC(18,0) -- FK
);

CREATE TABLE LOS_GDDS.BI_Comprador(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

-- /* ------------------------------------------ ANUNCIO ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Anuncio(
    id NUMERIC(18,0) PRIMARY KEY,
    fecha_publicacion DATE,
    agente_id NUMERIC(19,0), -- FK
    inmueble_id NUMERIC(18,0), -- FK
    operacion_id INT, -- FK
    precio_inmueble NUMERIC(18,2),
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion NUMERIC(18,2),
    rango_etario_agente_id INT, --FK
    rango_m2_id INT, --FK
    tiempo_id INT -- FK
);

CREATE TABLE LOS_GDDS.BI_Agente(
    id NUMERIC(19,0)  PRIMARY KEY,
    nombre NVARCHAR(100),
    sucursal_id NUMERIC(18,0) , --FK
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.BI_Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100),
    ubicacion_id INT --FK
);

CREATE TABLE LOS_GDDS.BI_Estado_anuncio(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Tipo_Operacion(
  id INT  PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.BI_Tipo_periodo(
  id INT  PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.BI_Tipo_Moneda( 
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Ubicacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
	provincia NVARCHAR(100),
    localidad NVARCHAR(100),
    barrio NVARCHAR(100)
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE LOS_GDDS.BI_Alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    anuncio_id NUMERIC(18,0), -- FK
    inquilino_id INT, -- FK
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    importe NUMERIC(18,2),  
    cantidad_periodos NUMERIC(18,0),
    comision NUMERIC(18,2),
    gastos_averiguaciones NUMERIC(18,2),
    estado_id INT, --FK
    deposito NUMERIC(18,2),
    rango_etario_inquilino_id INT, --FK
    tiempo_inicio_id INT -- FK
);

CREATE TABLE LOS_GDDS.BI_Pago_alquiler(
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

CREATE TABLE LOS_GDDS.BI_Inquilino(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.BI_Estado_alquiler(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Detalle_alquiler(
    id INT  PRIMARY KEY,
    periodo_inicio NUMERIC(18,0),
    periodo_fin NUMERIC(18,0),
    precio NUMERIC(18,2),
    alquiler_id NUMERIC(18,0) NULL --FK
);

CREATE TABLE LOS_GDDS.BI_Medio_pago(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);


--- COSAS NUEVAS ---

CREATE TABLE LOS_GDDS.BI_RANGO_ETARIO(
	RANGO_ETARIO_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_ETARIO_DESCRIPCION nvarchar(255)
);


--- En anuncio la fk ? como con el rango etario del agente ?
CREATE TABLE LOS_GDDS.BI_RANGO_M2(
    RANGO_M2_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_M2_DESCRIPCION nvarchar(255)
);


CREATE TABLE LOS_GDDS.BI_Tiempo (
    id INT PRIMARY KEY,
    anio INT,
    cuatrimestre INT,
    mes INT
);