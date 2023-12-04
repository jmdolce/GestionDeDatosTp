Tabla de Hechos:
Hecho_Anuncio:
Atributos:
AnuncioID (Clave primaria)
DuracionDias
PrecioInmueble
MonedaID (Clave foránea hacia Dim_TipoMoneda)
RangoEtarioID (Clave foránea hacia Dim_RangoEtario)
TipoOperacionID (Clave foránea hacia Dim_TipoOperacion)

Hecho_Alquiler:
Atributos:
AlquilerID (Clave primaria)
Mes (Clave foránea hacia Dim_Tiempo)
AnuncioID (Clave foránea hacia Hecho_Anuncio)
PorcentajeIncumplimiento
PorcentajeIncrementoAlquiler

Hecho_Venta:
Atributos:
VentaID (Clave primaria)
Mes (Clave foránea hacia Dim_Tiempo)
AnuncioID (Clave foránea hacia Hecho_Anuncio)
PrecioM2
ValorComision

Tablas Dimensionales:
Dim_Tiempo:
Atributos: Fecha, Año, Cuatrimestre, Mes.
Dim_Ubicacion:
Atributos: Provincia, Localidad, Barrio.
Dim_Sucursal:
Atributos: Sucursal.
Dim_RangoEtario:
Atributos: Rango (<25, 25-35, 35-50, >50).
Dim_TipoInmueble:
Atributos: TipoInmueble.
Dim_Ambientes:
Atributos: Ambientes.
Dim_RangoM2:
Atributos: RangoM2 (<35, 35-55, 55-75, 75-100, >100).
Dim_TipoOperacion:
Atributos: TipoOperacion.
Dim_TipoMoneda:
Atributos: TipoMoneda.


------ CREATE TABLES ------

--- DIMESIONES ---

CREATE TABLE LOS_GDDS.BI_Tipo_Moneda( 
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);


CREATE TABLE LOS_GDDS.BI_Tipo_Operacion(
  id INT  PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.BI_Ubicacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
	provincia NVARCHAR(100),
    localidad NVARCHAR(100),
    barrio NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_RANGO_ETARIO(
	RANGO_ETARIO_ID INT IDENTITY(1,1) PRIMARY KEY,
	RANGO_ETARIO_DESCRIPCION nvarchar(255)
);

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

CREATE TABLE LOS_GDDS.BI_Ambiente(
    id INT  PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Tipo_inmueble(
    id INT  PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.BI_Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100),
    ubicacion_id INT --FK
);

--- HECHOS ---

CREATE TABLE Hecho_Anuncio (
  Anuncio_id INT PRIMARY KEY,
  DuracionDias INT,
  PrecioInmueble NUMERIC(18,2),
  Moneda_id INT,  -- FK
  RangoEtarioID INT,  -- FK
  TipoOperacion_id INT,  -- FK
  tiempo_id INT, -- FK
  tipo_inmueble_id INT, -- FK
  sucursal_id INT, -- FK
  ambiente_id INT, -- FK
  rango_m2_id INT, -- FK
  ubicacion_id INT -- FK
)

CREATE TABLE Hecho_Alquiler (
  AlquilerID INT PRIMARY KEY,
  tiempo_id INT,  -- FK
  Anuncio_id INT,  -- FK
  importe NUMERIC(18,2),
  comision NUMERIC(18,2),
  fecha_inicio DATETIME,
  fecha_fin DATETIME,
  cantidad_periodos NUMERIC(18,0)
)

CREATE TABLE Hecho_Venta (
  Venta_id INT PRIMARY KEY,
  tiempo_id INT,  -- FK
  AnuncioID INT,  -- FK
  PrecioM2 NUMERIC(18,2),
  ValorComision NUMERIC(18,2),
  fecha_venta DATETIME
)





------ CREATE PROCEDURES ------


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_TipoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_inmueble
	SELECT * FROM LOS_GDDS.Tipo_inmueble
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Ambiente
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Ambiente
    SELECT * FROM LOS_GDDS.Ambiente
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Tipo_Moneda
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_Moneda
    SELECT * FROM LOS_GDDS.Moneda
END
GO 

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Tipo_Operacion
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_Operacion
    SELECT * FROM LOS_GDDS.Operacion
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_RANGO_ETARIO
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_DESCRIPCION)
		VALUES('<25')
	INSERT INTO LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_DESCRIPCION)
		VALUES('25-35')
	INSERT INTO LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_DESCRIPCION)
		VALUES('35-55')
	INSERT INTO LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_DESCRIPCION)
		VALUES('>55')
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_RANGO_M2
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_RANGO_M2(RANGO_M2_DESCRIPCION)
		VALUES('<35')
	INSERT INTO LOS_GDDS.BI_RANGO_M2(RANGO_M2_DESCRIPCION)
		VALUES('35-55')
	INSERT INTO LOS_GDDS.BI_RANGO_M2(RANGO_M2_DESCRIPCION)
		VALUES('55-75')
	INSERT INTO LOS_GDDS.BI_RANGO_M2(RANGO_M2_DESCRIPCION)
		VALUES('75-100')
	INSERT INTO LOS_GDDS.BI_RANGO_M2(RANGO_M2_DESCRIPCION)
		VALUES('>100')
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Ubicacion
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Ubicacion
        (provincia, localidad, barrio)
    SELECT p.nombre AS provincia, l.nombre AS localidad, b.nombre AS barrio FROM LOS_GDDS.Barrio b
    RIGHT JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
    RIGHT JOIN LOS_GDDS.Provincia p ON l.provincia_id = p.id
END
GO 

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Tiempo
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Tiempo (id, anio, cuatrimestre, mes)
    SELECT
        ROW_NUMBER() OVER (ORDER BY n1.number) AS id,
        YEAR(DATEADD(MONTH, n1.number - 1, '2024-01-01')) AS anio,
        (MONTH(DATEADD(MONTH, n1.number - 1, '2024-01-01')) - 1) / 4 + 1 AS cuatrimestre,
        MONTH(DATEADD(MONTH, n1.number - 1, '2024-01-01')) AS mes
    FROM
        master.dbo.spt_values n1
    WHERE
        n1.type = 'P' AND n1.number BETWEEN 1 AND 48;
END
GO


--- SON NECESARIOS TANTOS DATOS EN SUCURSAL ??????????? ---
CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Sucursal
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Sucursal(id, nombre, direccion, telefono, ubicacion_id)
    SELECT s.id, s.nombre, s.direccion, s.telefono, u.id FROM LOS_GDDS.Sucursal s
    JOIN LOS_GDDS.Localidad l ON s.localidad_id = l.id
    JOIN LOS_GDDS.BI_Ubicacion u ON l.nombre = u.localidad
END
GO 