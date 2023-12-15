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