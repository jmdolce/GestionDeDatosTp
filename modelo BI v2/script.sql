USE [GD2C2023]
GO

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
    tiempo_id INT,
    tipo_inmueble_id INT ,
    sucursal_id NUMERIC(18, 0),
    ubicación_id INT,
    tipo_moneda_id INT,
    cantidad_ventas INT,
    precio_promedio_m2 NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_Alquiler (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tiempo_id INT ,
    rango_etario_inquilino_id INT ,
    rango_etario_empleado_id INT,
    ubicación_id INT,
    tipo_operacion_id INT,
    sucursal_id NUMERIC(18, 0),
    cant_alquileres_activos INT,
    porcentaje_pagos_fuera_termino NUMERIC(18,2),
    cantidad_pagos INT
);

CREATE TABLE LOS_GDDS.BI_Anuncio (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tipo_operacion_id INT ,
    ubicación_id INT ,
    ambiente_id INT,
    tiempo_id INT,
    tipo_inmueble_id INT,
    tipo_moneda_id INT,
    rango_etario_empleado_id INT,
    sucursal_id NUMERIC(18, 0),
    rango_m2_id INT,
    cantidad_dias_promedio_publicado INT,
    precio_promedio_inmuebles NUMERIC(18,2),
    cantidad_anuncios INT,
    monto_operaciones NUMERIC(18,2),
    cantidad_operaciones_concretadas INT, 
    promedio_comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.BI_PagoAlquiler (
    id NUMERIC(18,0) IDENTITY(1,1) PRIMARY KEY,
    tiempo_id INT,
    promedio_aumento NUMERIC(18,2),
    cantidad_pagos INT
);

-- FK_Venta_Tiempo
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Venta_TipoInmueble
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_TipoInmueble FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id);
GO

-- FK_Venta_Sucursal
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Venta_Ubicacion
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Venta_TipoMoneda
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_TipoMoneda FOREIGN KEY (tipo_moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id);
GO


-- FK_Alquiler_Tiempo
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Alquiler_RangoEtarioInquilino
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_RangoEtarioInquilino FOREIGN KEY (rango_etario_inquilino_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Alquiler_RangoEtarioEmpleado
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_RangoEtarioEmpleado FOREIGN KEY (rango_etario_empleado_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Alquiler_Ubicacion
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Alquiler_TipoOperacion
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_TipoOperacion FOREIGN KEY (tipo_operacion_id) REFERENCES LOS_GDDS.BI_Tipo_Operacion(id);
GO

-- FK_Alquiler_Sucursal
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Anuncio_TipoOperacion
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoOperacion FOREIGN KEY (tipo_operacion_id) REFERENCES LOS_GDDS.BI_Tipo_Operacion(id);
GO

-- FK_Anuncio_Ubicacion
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Anuncio_Ambiente
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Ambiente FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.BI_Ambiente(id);
GO

-- FK_Anuncio_Tiempo
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Anuncio_TipoInmueble
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoInmueble FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id);
GO

-- FK_Anuncio_TipoMoneda
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoMoneda FOREIGN KEY (tipo_moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id);
GO

-- FK_Anuncio_RangoEtarioEmpleado
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_RangoEtarioEmpleado FOREIGN KEY (rango_etario_empleado_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Anuncio_Sucursal
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Anuncio_RangoM2
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_RangoM2 FOREIGN KEY (rango_m2_id) REFERENCES LOS_GDDS.BI_RANGO_M2(RANGO_M2_ID);
GO

-- FK_PagoAlquiler_Tiempo
ALTER TABLE LOS_GDDS.BI_PagoAlquiler
    ADD CONSTRAINT FK_PagoAlquiler_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

--- FUNCTIONS ---

CREATE FUNCTION LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(@fecha_nac DATETIME)
	RETURNS INT
BEGIN
	DECLARE @EDAD INT
	DECLARE @ID_RANGO INT
	
	SET @EDAD = YEAR(GETDATE()) - YEAR(@fecha_nac)

	IF @EDAD < 25
		SET @ID_RANGO = 1

	IF @EDAD BETWEEN 25 AND 35 
		SET @ID_RANGO = 2

	IF @EDAD BETWEEN 35 AND 50
		SET @ID_RANGO = 3

	IF @EDAD > 50
		SET @ID_RANGO = 4

	RETURN @ID_RANGO
	
END
GO


CREATE FUNCTION LOS_GDDS.FX_CALCULAR_RANGO_M2(@INMUEBLE NUMERIC(18,0))
    RETURNS INT
BEGIN
    DECLARE @SUPERFICIE_TOTAL NUMERIC(18,2)
    DECLARE @RANGO_M2 INT

    SET @SUPERFICIE_TOTAL = (SELECT i.SUPERFICIE_TOTAL FROM INMUEBLE i WHERE i.id = @INMUEBLE)

    IF @SUPERFICIE_TOTAL < 35
        SET @RANGO_M2 = 1

    IF @SUPERFICIE_TOTAL BETWEEN 35 AND 55
        SET @RANGO_M2 = 2

    IF @SUPERFICIE_TOTAL BETWEEN 55 AND 75
        SET @RANGO_M2 = 3

    IF @SUPERFICIE_TOTAL BETWEEN 75 AND 100
        SET @RANGO_M2 = 4
    
    IF @SUPERFICIE_TOTAL > 100
        SET @RANGO_M2 = 5

    RETURN @RANGO_M2
	
END
GO

-- PROCEDURES DE DIMENSIONES
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
		VALUES('35-50')
	INSERT INTO LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_DESCRIPCION)
		VALUES('>50')
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

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Sucursal
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Sucursal
    SELECT s.id, s.nombre, s.direccion, s.telefono
    FROM LOS_GDDS.Sucursal s
END
GO

-- TABLAS DE HECHOS

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Venta
	SELECT t.id, ti.id, s.id, u.id, m.id, COUNT(DISTINCT v.id), AVG(v.precio / i.superficie_total) 
    FROM LOS_GDDS.BI_Tiempo t  
	LEFT JOIN LOS_GDDS.Venta v ON DATEPART(YEAR, v.fecha_venta) = t.anio AND DATEPART(MONTH, v.fecha_venta) = t.mes

    JOIN LOS_GDDS.Anuncio a ON v.anuncio_id = a.id
    JOIN LOS_GDDS.Inmueble i ON a.inmueble_id = i.id 
    JOIN LOS_GDDS.Tipo_inmueble ti ON i.tipo_inmueble_id = ti.id
    JOIN LOS_GDDS.Moneda m ON a.moneda_id = m.id

    JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

    JOIN LOS_GDDS.Agente ag ON ag.id = a.agente_id
    JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id
    GROUP BY t.id, ti.id, s.id, u.id, m.id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id) -- agrupo por las FK
END
GO



CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Alquiler
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Alquiler                                     
	SELECT t.id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(inq.fecha_nacimiento), LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento), u.id,
	an.operacion_id, s.id,
	ISNULL(SUM(CASE WHEN ea.nombre = 'Activo' THEN 1 ELSE 0 END), 0), -- cantidad alquileres activos 
	ISNULL((SUM(CASE WHEN pa.fecha >= pa.fecha_fin_periodo THEN 1 ELSE 0 END) * 100.0) / COUNT(DISTINCT pa.id), 0), -- porcentaje_pagos_fuera_termino
	COUNT(DISTINCT pa.id) -- cantidad_pagos 
		
	FROM LOS_GDDS.BI_Tiempo t   -- TODO: el LEFT JOIN no me devuelve todos los tiempos (e.g. el tiempo con id 10 no esta en la tabla de alquiler BI) 
	LEFT JOIN LOS_GDDS.Alquiler a ON DATEPART(YEAR, a.fecha_inicio) = t.anio AND DATEPART(MONTH, a.fecha_inicio) = t.mes
	JOIN LOS_GDDS.Alquiler al ON al.id = a.id
	JOIN LOS_GDDS.Inquilino inq ON al.inquilino_id = inq.id

	JOIN LOS_GDDS.Anuncio an ON an.id = a.anuncio_id
	JOIN LOS_GDDS.Inmueble i ON i.id = an.inmueble_id
	JOIN LOS_GDDS.Agente ag ON ag.id = an.agente_id		
	JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id
	JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

	JOIN LOS_GDDS.Pago_alquiler pa ON pa.alquiler_id = a.id
    JOIN LOS_GDDS.Estado_alquiler ea ON ea.id = a.estado_id
											
	GROUP BY t.id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(inq.fecha_nacimiento), LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento), u.id, an.operacion_id, s.id
END
GO



CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Anuncio
AS
BEGIN
	-- operaciones de ventas
    INSERT INTO LOS_GDDS.BI_Anuncio
    SELECT 
		a.operacion_id, u.id, amb.id, t.id, i.tipo_inmueble_id, a.moneda_id, 
		LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento) AS rango_etario_agente,
		s.id AS sucursal_id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id) AS rango_m2,
		AVG(DATEDIFF(DAY, a.fecha_publicacion, a.fecha_finalizacion)) AS cantidad_dias_promedio_publicado,
		AVG(a.precio_inmueble) AS precio_promedio_inmuebles,
		COUNT(DISTINCT a.id) AS cantidad_anuncios,
		SUM(ISNULL(v.precio, 0) + ISNULL(v.comision, 0)) AS monto_operaciones,
		ISNULL(SUM(CASE WHEN ea.nombre IN ('Vendido', 'Alquilado') THEN 1 ELSE 0 END), 0) AS cantidad_operaciones_concretadas,
		AVG(ISNULL(v.comision, 0)) AS promedio_comision
	FROM LOS_GDDS.BI_Tiempo t  
	LEFT JOIN LOS_GDDS.Anuncio a ON DATEPART(YEAR, a.fecha_publicacion) = t.anio AND DATEPART(MONTH, a.fecha_publicacion) = t.mes

	JOIN LOS_GDDS.Inmueble i ON i.id = a.inmueble_id
	JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

	LEFT JOIN LOS_GDDS.Agente ag ON ag.id = a.agente_id
	LEFT JOIN LOS_GDDS.Estado_anuncio ea ON ea.id = a.estado_id
	LEFT JOIN LOS_GDDS.Ambiente amb ON amb.id = i.ambiente_id
	LEFT JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id

	-- para evitar filas duplicadas que distorcionen los calculos
	LEFT JOIN (
		SELECT 
			v.anuncio_id,
			ISNULL(SUM(v.precio), 0) AS precio,
			ISNULL(SUM(v.comision), 0) AS comision
		FROM LOS_GDDS.Venta v
		GROUP BY v.anuncio_id
	) v ON a.id = v.anuncio_id

	JOIN LOS_GDDS.Operacion o ON o.id = a.operacion_id

	WHERE o.nombre = 'Tipo Operación Venta'

	GROUP BY 
		a.operacion_id, u.id, amb.id, t.id, i.tipo_inmueble_id, a.moneda_id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento), s.id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id);

	-- operaciones de alquileres
	INSERT INTO LOS_GDDS.BI_Anuncio
	SELECT 
		a.operacion_id, u.id, amb.id, t.id, i.tipo_inmueble_id, a.moneda_id, 
		LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento) AS rango_etario_agente,
		s.id AS sucursal_id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id) AS rango_m2,
		AVG(DATEDIFF(DAY, a.fecha_publicacion, a.fecha_finalizacion)) AS cantidad_dias_promedio_publicado,
		AVG(a.precio_inmueble) AS precio_promedio_inmuebles,
		COUNT(DISTINCT a.id) AS cantidad_anuncios,
		SUM(ISNULL(al.monto_total, 0)) AS monto_operaciones,
		ISNULL(SUM(CASE WHEN ea.nombre IN ('Vendido', 'Alquilado') THEN 1 ELSE 0 END), 0) AS cantidad_operaciones_concretadas,
		AVG(ISNULL(al.comision, 0)) AS promedio_comision
	FROM LOS_GDDS.BI_Tiempo t  
	LEFT JOIN LOS_GDDS.Anuncio a ON DATEPART(YEAR, a.fecha_publicacion) = t.anio AND DATEPART(MONTH, a.fecha_publicacion) = t.mes

	JOIN LOS_GDDS.Inmueble i ON i.id = a.inmueble_id
	JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

	LEFT JOIN LOS_GDDS.Agente ag ON ag.id = a.agente_id
	LEFT JOIN LOS_GDDS.Estado_anuncio ea ON ea.id = a.estado_id
	LEFT JOIN LOS_GDDS.Ambiente amb ON amb.id = i.ambiente_id
	LEFT JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id

	-- para evitar filas duplicadas que distorcionen los calculos
	LEFT JOIN (
		SELECT 
			al.anuncio_id,
			SUM(ISNULL(al.importe, 0) + ISNULL(al.deposito, 0) + ISNULL(al.gastos_averiguaciones, 0)) AS monto_total,
			AVG(ISNULL(al.comision, 0)) AS comision
		FROM LOS_GDDS.Alquiler al
		GROUP BY al.anuncio_id
	) al ON a.id = al.anuncio_id

	JOIN LOS_GDDS.Operacion o ON o.id = a.operacion_id

	WHERE o.nombre IN ('Tipo Operación Alquiler Contrato', 'Tipo Operación Alquiler Temporario')

	GROUP BY 
		a.operacion_id, u.id, amb.id, t.id, i.tipo_inmueble_id, a.moneda_id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(ag.fecha_nacimiento), s.id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id);

END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_PagoAlquiler
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_PagoAlquiler
    SELECT t.id, 
    	AVG((pa.importe - pant.importe) / pant.importe * 100), -- promedio aumento
    	COUNT(DISTINCT pa.id) -- cant pagos

	FROM LOS_GDDS.BI_Tiempo t
    
	LEFT JOIN LOS_GDDS.Pago_alquiler pa ON DATEPART(YEAR, pa.fecha_inicio_periodo) = t.anio AND DATEPART(MONTH, pa.fecha_inicio_periodo) = t.mes 
	JOIN LOS_GDDS.Pago_alquiler pant ON pant.alquiler_id = pa.alquiler_id AND pant.num_periodo = pa.num_periodo - 1
	JOIN LOS_GDDS.Alquiler al ON al.id = pa.alquiler_id
	JOIN LOS_GDDS.Estado_alquiler ea ON ea.id = al.estado_id
    GROUP BY t.id 
	ORDER BY t.id
END
GO

/* ------------- EJECUCION DE PROCEDURES ---------------- */

EXEC LOS_GDDS.MIGRAR_BI_TipoInmueble

EXEC LOS_GDDS.MIGRAR_BI_Ambiente

EXEC LOS_GDDS.MIGRAR_BI_Tipo_Moneda

EXEC LOS_GDDS.MIGRAR_BI_Tipo_Operacion

EXEC LOS_GDDS.MIGRAR_BI_RANGO_ETARIO

EXEC LOS_GDDS.MIGRAR_BI_RANGO_M2

EXEC LOS_GDDS.MIGRAR_BI_Ubicacion

EXEC LOS_GDDS.MIGRAR_BI_Tiempo

EXEC LOS_GDDS.MIGRAR_BI_Sucursal

EXEC LOS_GDDS.MIGRAR_BI_Anuncio

EXEC LOS_GDDS.MIGRAR_BI_Venta

EXEC LOS_GDDS.MIGRAR_BI_PagoAlquiler

EXEC LOS_GDDS.MIGRAR_BI_Alquiler
GO


--- VISTA 1 ---

CREATE VIEW LOS_GDDS.Vista_duracion_anuncios_publicados 
AS
SELECT 
	t.anio, 
	t.cuatrimestre, 
	op.nombre AS [Tipo operacion], 
	u.provincia AS Provincia,  
	u.localidad AS Localidad,
	u.barrio AS Barrio, 
	amb.nombre [Ambiente], 
	AVG(a.cantidad_dias_promedio_publicado) AS [Tiempo promedio publicado]
FROM LOS_GDDS.BI_Anuncio a 
JOIN LOS_GDDS.BI_Tiempo t ON t.id = a.tiempo_id
JOIN LOS_GDDS.BI_Tipo_Operacion op ON a.tipo_operacion_id = op.id
JOIN LOS_GDDS.BI_Ubicacion u ON u.id = a.ubicación_id
JOIN LOS_GDDS.BI_Ambiente amb ON amb.id = a.tipo_inmueble_id

GROUP BY t.anio, t.cuatrimestre, op.nombre, u.provincia, u.localidad, u.barrio, amb.nombre
GO
--- VISTA 2 --- 

CREATE VIEW LOS_GDDS.Vista_precio_promedio_anuncios
AS
SELECT 
	t.anio, 
	t.cuatrimestre, 
	op.nombre AS [Tipo operacion], 
	ti.nombre AS [Tipo inmueble],
	rm.RANGO_M2_DESCRIPCION AS [Rango m2],
	AVG(a.precio_promedio_inmuebles) [Precio Promedio Inmuebles],
	tm.nombre AS [Tipo Moneda]
FROM LOS_GDDS.BI_Anuncio a 
JOIN LOS_GDDS.BI_Tiempo t ON t.id = a.tiempo_id
JOIN LOS_GDDS.BI_Tipo_Operacion op ON a.tipo_operacion_id = op.id
JOIN LOS_GDDS.BI_Tipo_inmueble ti ON a.tipo_inmueble_id = ti.id
JOIN LOS_GDDS.BI_RANGO_M2 rm ON a.rango_m2_id = rm.RANGO_M2_ID
JOIN LOS_GDDS.BI_Tipo_Moneda tm ON a.tipo_moneda_id = tm.id
GROUP BY t.anio, t.cuatrimestre, op.nombre, ti.nombre, rm.RANGO_M2_DESCRIPCION, tm.nombre
GO

--- VISTA 3 --- 

CREATE VIEW LOS_GDDS.Vista_barrios_mas_elegidos_alquiler
AS
SELECT TOP 5
	t.anio,
	t.cuatrimestre,
	re.RANGO_ETARIO_DESCRIPCION AS [Rango Etario],
	u.barrio,
	al.cant_alquileres_activos AS [Cantidad Alquileres]
FROM LOS_GDDS.BI_Alquiler al
JOIN LOS_GDDS.BI_Tiempo t ON t.id = al.tiempo_id
JOIN LOS_GDDS.BI_RANGO_ETARIO re ON al.rango_etario_inquilino_id = re.RANGO_ETARIO_ID
JOIN LOS_GDDS.BI_Ubicacion u ON al.ubicación_id = u.id
GROUP BY t.anio, t.cuatrimestre, re.RANGO_ETARIO_DESCRIPCION, u.barrio, al.cant_alquileres_activos
ORDER BY al.cant_alquileres_activos DESC
GO

--- VISTA 4 ---

CREATE VIEW LOS_GDDS.Vista_PorcentajeIncumplimientoPagos AS
SELECT
    t.anio,
    t.mes,
    ISNULL(AVG(al.porcentaje_pagos_fuera_termino) ,0) AS PorcentajeIncumplimiento
	
FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Alquiler al ON al.tiempo_id = t.id

GROUP BY t.anio, t.mes
GO
--- VISTA 5 ---

-- Ningun alquiler que tuvo incremento esta ACTIVO, asi que deje de lado esa condicion (en el create procedure de BI_PagoAlquiler)
CREATE VIEW LOS_GDDS.Vista_PorcentajeIncrementoAlquiler AS
SELECT
    t.anio,
    t.mes,
    pa.promedio_aumento AS PorcentajeIncrementoPromedio

FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_PagoAlquiler pa ON pa.tiempo_id = t.id

GROUP BY t.anio, t.mes, pa.promedio_aumento
HAVING pa.promedio_aumento > 0
GO

--- VISTA 6 ---

CREATE VIEW LOS_GDDS.Vista_PrecioPromedioM2
AS
SELECT
    t.anio,
    t.cuatrimestre,
    ti.nombre AS TipoInmueble,
    u.provincia AS Provincia,
    u.localidad AS Localidad,
    AVG(v.precio_promedio_m2) AS PrecioPromedioM2

FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Venta v ON v.tiempo_id = t.id
JOIN LOS_GDDS.BI_Tipo_inmueble ti ON v.tipo_inmueble_id = ti.id
JOIN LOS_GDDS.BI_Ubicacion u ON v.ubicación_id = u.id

GROUP BY t.anio, t.cuatrimestre, ti.nombre, u.provincia, u.localidad
GO

--- VISTA 7 ---

CREATE VIEW LOS_GDDS.Vista_ValorPromedioComision
AS
SELECT 
    t.anio,
    t.cuatrimestre,
    o.nombre AS [Tipo Operacion],
    s.nombre AS Sucursal,
    AVG(a.promedio_comision) AS [Promedio Comision]
FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Anuncio a ON a.tiempo_id = t.id
JOIN LOS_GDDS.BI_Tipo_Operacion o ON o.id = a.tipo_operacion_id
JOIN LOS_GDDS.BI_Sucursal s ON s.id = a.sucursal_id

GROUP BY t.anio, t.cuatrimestre, o.nombre, s.nombre
GO

--- VISTA 8 ---

CREATE VIEW LOS_GDDS.Vista_PorcentajeOperacionesConcretadas AS
SELECT
    t.anio,
    s.nombre AS Sucursal, 
    re.RANGO_ETARIO_DESCRIPCION AS [Rango Etario],
    CAST(SUM(a.cantidad_operaciones_concretadas) AS NUMERIC(18,2)) * 100 / CAST(SUM(a.cantidad_anuncios) AS NUMERIC(18,2)) AS [Porcentaje Operacioenes Concretadas]
FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Anuncio a ON a.tiempo_id = t.id
LEFT JOIN LOS_GDDS.BI_RANGO_ETARIO re ON re.RANGO_ETARIO_ID = a.rango_etario_empleado_id
JOIN LOS_GDDS.BI_SUCURSAL s ON s.id = a.sucursal_id

GROUP BY t.anio, s.nombre, re.RANGO_ETARIO_DESCRIPCION
GO

--- VISTA 9 ---

CREATE VIEW LOS_GDDS.Vista_MontoCierreContratos
AS
SELECT
    t.anio,
    t.cuatrimestre,
    s.nombre AS Sucursal,
    o.nombre AS TipoOperacion,
    m.nombre AS TipoMoneda,
    SUM(a.monto_operaciones) AS MontoTotal

FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Anuncio a ON a.tiempo_id = t.id
JOIN LOS_GDDS.BI_Sucursal s ON s.id = a.sucursal_id
JOIN LOS_GDDS.BI_Tipo_Operacion o ON o.id = a.tipo_operacion_id 
JOIN LOS_GDDS.BI_Tipo_Moneda m ON m.id = a.tipo_moneda_id

GROUP BY t.anio, t.cuatrimestre, s.nombre, o.nombre, m.nombre
GO	