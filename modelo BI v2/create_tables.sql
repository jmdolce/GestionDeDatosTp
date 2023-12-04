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
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Tipo_Operacion(
  id INT  PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.BI_Tipo_Moneda( 
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

-- Tablas de Hechos
CREATE TABLE LOS_GDDS.BI_Venta (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tiempo_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tiempo(id),
    tipo_inmueble_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_inmueble(id),
    sucursal_id NUMERIC(18, 0) FOREIGN KEY REFERENCES LOS_GDDS.BI_Sucursal(id),
    ubicación_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Ubicacion(id),
    tipo_moneda_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_Moneda(id),
    cantidad_ventas INT,
    precio_promedio_m2 NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_Alquiler (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tiempo_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tiempo(id),
    rango_etario_inquilino_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID),
    rango_etario_empleado_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID),
    ubicación_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Ubicacion(id),
    tipo_operacion_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_Operacion(id),
    sucursal_id NUMERIC(18, 0) FOREIGN KEY REFERENCES LOS_GDDS.BI_Sucursal(id),
    cant_alquileres_activos INT,
    porcentaje_pagos_fuera_termino NUMERIC(18,2),
    cantidad_pagos INT
);

CREATE TABLE LOS_GDDS.BI_Anuncio (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tipo_operacion_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_Operacion(id),
    ubicación_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Ubicacion(id),
    ambiente_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Ambiente(id),
    tiempo_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tiempo(id),
    tipo_inmueble_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_inmueble(id),
    tipo_moneda_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tipo_Moneda(id),
    rango_etario_empleado_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID),
    sucursal_id NUMERIC(18, 0) FOREIGN KEY REFERENCES LOS_GDDS.BI_Sucursal(id),
    rango_m2_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_RANGO_M2(RANGO_M2_ID),
    cantidad_dias_promedio_publicado INT,
    precio_promedio_inmuebles NUMERIC(18,2),
    cantidad_anuncios INT,
    monto_operaciones NUMERIC(18,2),
    cantidad_operaciones_concretadas INT, 
    promedio_comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_PagoAlquiler (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tiempo_id INT FOREIGN KEY REFERENCES LOS_GDDS.BI_Tiempo(id),
    promedio_aumento NUMERIC(18,2),
    cantidad_pagos INT
);

