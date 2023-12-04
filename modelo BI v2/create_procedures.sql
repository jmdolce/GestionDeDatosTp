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
	SELECT v.id, t.id, ti.id, s.id, u.id, m.id, COUNT(DISTINCT v.id), AVG(a.precio_inmueble) 
    FROM LOS_GDDS.Venta v
    JOIN LOS_GDDS.Anuncio a ON v.anuncio_id = a.id
    JOIN LOS_GDDS.Inmueble i ON a.inmueble_id = i.id 
    JOIN LOS_GDDS.Tipo_inmueble ti ON i.tipo_inmueble_id = ti.id
    JOIN LOS_GDDS.Moneda m ON a.moneda_id = m.id

    JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

    JOIN LOS_GDDS.BI_Tiempo t ON DATEPART(YEAR, v.fecha_venta) = t.anio AND DATEPART(MONTH, v.fecha_venta) = t.mes
    JOIN LOS_GDDS.Agente ag ON ag.id = a.agente_id
    JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id
    GROUP BY t.id, i.id, u.id, m.id, s.id, LOS_GDDS.FX_CALCULAR_RANGO_M2(a.inmueble_id) -- agrupo por las FK
END
GO



CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Alquiler
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Alquiler
	SELECT t.id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(in.fecha_nacimiento), LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(emp.fecha_nacimiento), u.id,
	o.id, s.id, -- cantidad alquileres activos (puede ser un subselect o una funcion) ?,
	-- porcentaje_pagos_fuera_termino ?? 
	-- cantidad_pagos ??
		
	FROM LOS_GDDS.Alquiler a   
	JOIN LOS_GDDS.BI_Tiempo t ON DATEPART(YEAR, a.fecha_inicio) = t.anio AND DATEPART(MONTH, a.fecha_inicio) = t.mes
	JOIN LOS_GDDS.Alquiler al ON al.id = a.alquiler_id
	JOIN LOS_GDDS.Inquilino in ON al.inquilino_id = in.id
	-- empleado ???

	JOIN LOS_GDDS.Inmueble i ON i.id = a.inmueble_id
	JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.Localidad l ON b.localidad_id = l.id
	JOIN LOS_GDDS.Provincia p ON p.id = l.provincia_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre AND u.localidad = l.nombre AND u.provincia = p.nombre

	JOIN LOS_GDDS.BI_Tipo_Operacion o ON o.id = a.operacion_id
	JOIN LOS_GDDS.BI_Sucursal s ON s.id = a.sucursal_id
	
	GROUP BY t.id, LOS_GDDS.FX_CALCULAR_RANGO_ETARIO(in.fecha_nacimiento), u.id, o.id, s.id
END
GO




CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_PagoAlquiler
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_PagoAlquiler
    SELECT * 

	FROM LOS_GDDS.Pago_alquiler pa
	JOIN LOS_GDDS.BI_Tiempo t ON DATEPART(YEAR, pa.fecha_inicio_periodo) = t.anio AND DATEPART(MONTH, pa.fecha_inicio_periodo) = t.mes 
	JOIN LOS_GDDS.Pago_alquiler pant ON pant.alquiler_id = pa.alquiler_id AND pant.num_periodo = pa.num_periodo - 1 -- y habria que verificar que el anio sea el mismo, creo

END
GO




CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Anuncio
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Anuncio
    SELECT
    


END
GO







