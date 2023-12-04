-- Tablas de Hechos
CREATE TABLE LOS_GDDS.BI_Venta (
    id IDENTITY(1,1) NUMERIC(18,0) PRIMARY KEY,
    tiempo_id INT, -- FK
    tipo_inmueble_id INT, --FK
    sucursal_id INT, -- FK
    ubicación_id INT, -- FK
    tipo_moneda_id INT, --FK
    cantidad_ventas INT
    precio_promedio_m2 NUMERIC(18,2),
);

CREATE TABLE LOS_GDDS.BI_Alquiler (
    id IDENTITY(1,1) NUMERIC(18,0) PRIMARY KEY,
    tiempo_id INT, -- FK
    rango_etario_inquilino_id INT, -- FK
    rango_etario_empleado_id INT, -- FK
    ubicación_id INT, -- FK
    tipo_operacion_id INT, -- FK
    sucursal_id INT, -- FK
    cant_alquileres_activos INT, 
    porcentaje_pagos_fuera_termino NUMERIC(18,2),
    cantidad_pagos INT
);

CREATE TABLE LOS_GDDS.BI_Anuncio (
    id IDENTITY(1,1) NUMERIC(18,0) PRIMARY KEY,
    tipo_operacion_id INT, -- FK
    ubicación_id INT, -- FK
    ambiente_id INT, -- FK
    tiempo_id INT, --FK
    tipo_inmueble_id INT, --FK
    tipo_moneda_id INT, --FK
    rango_etario_empleado_id INT, -- FK
    sucursal_id INT, -- FK
    rango_m2_id INT, -- FK
    cantidad_dias_promedio_publicado INT,
    precio_promedio_inmuebles NUMERIC(18,2),
    cantidad_anuncios INT,
    monto_operaciones NUMERIC(18,2),
    cantidad_operaciones_concretadas INT, 
    promedio_comision  NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_PagoAlquiler (
    id IDENTITY(1,1) NUMERIC(18,0) PRIMARY KEY,
    tiempo_id INT, -- FK
    promedio_aumento NUMERIC(18,2),
    cantidad_pagos INT
);

-- Tablas de Dimensiones
CREATE TABLE LOS_GDDS.BI_Tiempo (
    id INT PRIMARY KEY,
    anio INT,
    cuatrimestre INT,
    mes INT
);

CREATE TABLE LOS_GDDS.BI_Ubicacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
	provincia NVARCHAR(100),
    localidad NVARCHAR(100),
    barrio NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_RANGO_ETARIO(
	RANGO_ETARIO_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_ETARIO_DESCRIPCION nvarchar(255)
);


CREATE TABLE LOS_GDDS.BI_RANGO_M2(
    RANGO_M2_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_M2_DESCRIPCION nvarchar(255)
);

CREATE TABLE LOS_GDDS.BI_Tipo_inmueble(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Ambiente(
    id INT  PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Tipo_Operacion(
  id INT  PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.BI_Tipo_Moneda( 
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);


-- Vistas
