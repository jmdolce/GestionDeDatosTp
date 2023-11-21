

/* CREACION DE TABLAS */

/* ------------------------------------------ TIPIFICACION ------------------------------------------ */

CREATE TABLE BI_LOS_GDDS.BI_Propietario(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE BI_LOS_GDDS.BI_Disposicion(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Estado_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Orientacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ INMUEBLE ------------------------------------------ */

CREATE TABLE BI_LOS_GDDS.BI_Inmueble(
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

CREATE TABLE BI_LOS_GDDS.BI_Caracteristica_inmueble(
    caracteristica_id INT, --FK
    inmueble_id NUMERIC(18,0), --FK
    PRIMARY KEY (caracteristica_id, inmueble_id)
);

CREATE TABLE BI_LOS_GDDS.BI_Inmueble_Ambiente(
    inmueble_id NUMERIC(18,0), --FK
    ambiente_id INT, --FK
	PRIMARY KEY (inmueble_id, ambiente_id)
);

CREATE TABLE BI_LOS_GDDS.BI_Caracteristica(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
);

CREATE TABLE BI_LOS_GDDS.BI_Ambiente(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Tipo_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE BI_LOS_GDDS.BI_Venta(
    id NUMERIC(18,0) PRIMARY KEY, ---esto es el codigo
    anuncio_id NUMERIC(18,0) NULL, --FK
    comprador_id INT, --FK
    fecha_venta DATETIME,
    precio NUMERIC(18,2),
    moneda_id INT, --FK
    comision NUMERIC(18,2)
);

CREATE TABLE BI_LOS_GDDS.BI_Pago_venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    importe NUMERIC(18,2),
    moneda_id INT,      -- FK
    cotizacion NUMERIC(18,2),
    medio_pago_id INT, -- FK
    venta_id NUMERIC(18,0) -- FK
);

CREATE TABLE BI_LOS_GDDS.BI_Comprador(
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

CREATE TABLE BI_LOS_GDDS.BI_Anuncio(
    id NUMERIC(18,0) PRIMARY KEY,
    fecha_publicacion DATETIME,
    agente_id NUMERIC(19,0), -- FK
    inmueble_id NUMERIC(18,0), -- FK
    operacion_id INT, -- FK
    precio_inmueble NUMERIC(18,2),
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion NUMERIC(18,2)
);

CREATE TABLE BI_LOS_GDDS.BI_Agente(
    id NUMERIC(19,0) IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    sucursal_id NUMERIC(18,0) , --FK
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

CREATE TABLE BI_LOS_GDDS.BI_Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100),
    localidad_id INT --FK
);

CREATE TABLE BI_LOS_GDDS.BI_Estado_anuncio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Operacion(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE BI_LOS_GDDS.BI_Tipo_periodo(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE BI_LOS_GDDS.BI_Moneda(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE BI_LOS_GDDS.BI_Provincia(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Localidad(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    provincia_id INT --FK
);

CREATE TABLE BI_LOS_GDDS.BI_Barrio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    localidad_id INT -- FK
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE BI_LOS_GDDS.BI_Alquiler(
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
    deposito NUMERIC(18,2)
);

CREATE TABLE BI_LOS_GDDS.BI_Pago_alquiler(
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

CREATE TABLE BI_LOS_GDDS.BI_Inquilino(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE BI_LOS_GDDS.BI_Estado_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE BI_LOS_GDDS.BI_Detalle_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    periodo_inicio NUMERIC(18,0),
    periodo_fin NUMERIC(18,0),
    precio NUMERIC(18,2),
    alquiler_id NUMERIC(18,0) NULL --FK
);

CREATE TABLE BI_LOS_GDDS.BI_Medio_pago(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);


--- COSAS NUEVAS ---

CREATE TABLE BI_LOS_GDDS.BI_RANGO_ETARIO(
	RANGO_ETARIO_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_ETARIO_DESCRIPCION nvarchar(255)
);
