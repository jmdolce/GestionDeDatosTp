--- VISTA 1 ---

CREATE VIEW LOS_GDDS.Vista_duracion_anuncios_publicados 
AS
SELECT 
	t.anio, 
	t.cuatrimestre, 
	op.nombre AS [Tipo operacion], 
	u.barrio, 
	i.descripcion AS [inmueble], 
	iamb.ambiente_id [Ambiente], 
	AVG(DATEDIFF(day, a.fecha_publicacion, a.fecha_finalizacion)) AS [Duracion dias]
FROM LOS_GDDS.BI_Anuncio a 
JOIN LOS_GDDS.BI_Tiempo t ON t.id = a.tiempo_id
JOIN LOS_GDDS.BI_Tipo_Operacion op ON a.operacion_id = op.id
JOIN LOS_GDDS.BI_Inmueble i ON i.id = a.inmueble_id
JOIN LOS_GDDS.BI_Ubicacion u ON u.id = i.ubicacion_id 
JOIN LOS_GDDS.BI_Inmueble_Ambiente iamb ON iamb.inmueble_id = i.id
GROUP BY t.anio, t.cuatrimestre, op.nombre, u.barrio, iamb.ambiente_id, i.descripcion
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
	COUNT(*) AS [Cantidad Anuncios],
	AVG(a.precio_inmueble) AS [Precio Promedio],
	tm.nombre AS [Tipo Moneda]
FROM LOS_GDDS.BI_Anuncio a 
JOIN LOS_GDDS.BI_Tiempo t ON t.id = a.tiempo_id
JOIN LOS_GDDS.BI_Tipo_Operacion op ON a.operacion_id = op.id
JOIN LOS_GDDS.BI_Inmueble i ON i.id = a.inmueble_id
JOIN LOS_GDDS.BI_Tipo_inmueble ti ON i.tipo_inmueble_id = ti.id
JOIN LOS_GDDS.BI_RANGO_M2 rm ON a.rango_m2_id = rm.RANGO_M2_ID
JOIN LOS_GDDS.BI_Tipo_Moneda tm ON a.moneda_id = tm.id
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
	COUNT(*) AS [Cantidad Alquileres]
FROM LOS_GDDS.BI_Alquiler al
JOIN LOS_GDDS.BI_Tiempo t ON t.id = al.tiempo_inicio_id
JOIN LOS_GDDS.BI_Inquilino i ON i.id = al.inquilino_id
JOIN LOS_GDDS.BI_RANGO_ETARIO re ON al.rango_etario_inquilino_id = re.RANGO_ETARIO_ID
JOIN LOS_GDDS.BI_Anuncio an ON an.id = al.anuncio_id
JOIN LOS_GDDS.BI_Inmueble im ON an.inmueble_id = im.id
JOIN LOS_GDDS.BI_Ubicacion u ON im.ubicacion_id = u.id
GROUP BY t.anio, t.cuatrimestre, re.RANGO_ETARIO_DESCRIPCION, u.barrio
ORDER BY [Cantidad Alquileres] DESC
GO

--- VISTA 4 ---

CREATE VIEW LOS_GDDS.Vista_PorcentajeIncumplimientoPagos AS
SELECT
    t.anio,
    t.mes,
    ISNULL(COUNT(pa.id), 0) AS TotalPagos,
    ISNULL(SUM(CASE WHEN pa.fecha > al.fecha_fin THEN 1 ELSE 0 END), 0) AS PagosIncumplidos,
    ISNULL((SUM(CASE WHEN pa.fecha > al.fecha_fin THEN 1 ELSE 0 END) * 100.0) / COUNT(pa.id), 0) AS PorcentajeIncumplimiento
	
FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Pago_alquiler pa ON YEAR(pa.fecha) = t.anio AND MONTH(pa.fecha) = t.mes
LEFT JOIN LOS_GDDS.BI_Alquiler al ON pa.alquiler_id = al.id

GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes
GO

--- VISTA 5 ---

-- Ningun alquiler que tuvo incremento esta ACTIVO xd
CREATE VIEW LOS_GDDS.Vista_PorcentajeIncrementoAlquiler AS
SELECT
    t.anio,
    t.mes,
    ISNULL(AVG(CASE WHEN pa.importe > pant.importe AND ea.nombre = 'Activo' THEN ((pa.importe - pant.importe) / pant.importe) * 100 ELSE 0 END), 0) AS PorcentajeIncrementoPromedio

FROM LOS_GDDS.BI_Tiempo t
LEFT JOIN LOS_GDDS.BI_Pago_alquiler pa ON YEAR(pa.fecha) = t.anio AND MONTH(pa.fecha) = t.mes
LEFT JOIN LOS_GDDS.BI_Alquiler al ON pa.alquiler_id = al.id
LEFT JOIN LOS_GDDS.BI_Estado_alquiler ea ON al.estado_id = ea.id
JOIN LOS_GDDS.Pago_alquiler pant ON pant.alquiler_id = pa.alquiler_id AND pant.num_periodo = pa.num_periodo - 1

GROUP BY t.anio, t.mes
ORDER BY t.anio, t.mes
GO

--- VISTA 6 ---

CREATE VIEW LOS_GDDS.Vista_PrecioPromedioM2
AS
SELECT
    t.nombre AS TipoInmueble,
    u.localidad AS Localidad,
    t_anio.anio,
    t_anio.cuatrimestre,
    AVG(v.precio / i.superficie_total) AS PrecioPromedioM2

FROM LOS_GDDS.BI_Venta v
 JOIN LOS_GDDS.BI_Anuncio a ON v.anuncio_id = a.id
JOIN LOS_GDDS.BI_Inmueble i ON a.inmueble_id = i.id
JOIN LOS_GDDS.BI_Tipo_inmueble t ON i.tipo_inmueble_id = t.id
JOIN LOS_GDDS.BI_Ubicacion u ON i.ubicacion_id = u.id
JOIN LOS_GDDS.BI_Tiempo t_anio ON DATEPART(YEAR, v.fecha_venta) = t_anio.anio AND DATEPART(QUARTER, v.fecha_venta) = t_anio.cuatrimestre

GROUP BY t.nombre, u.localidad, t_anio.anio, t_anio.cuatrimestre
GO

--- VISTA 7 ---

CREATE VIEW LOS_GDDS.Vista_ValorPromedioComision
AS
WITH AnunciosConComision AS (
    SELECT
        COALESCE(va.operacion_id, aa.operacion_id) AS operacion_id,
        COALESCE(ag.sucursal_id, NULL) AS sucursal_id,
        COALESCE(v.comision, a.comision) AS comision,
        COALESCE(YEAR(v.fecha_venta), YEAR(a.fecha_inicio)) AS anio,
        COALESCE(DATEPART(QUARTER, v.fecha_venta), DATEPART(QUARTER, a.fecha_inicio)) AS cuatrimestre
    FROM LOS_GDDS.BI_Venta v
    FULL JOIN LOS_GDDS.BI_Alquiler a ON v.anuncio_id = a.anuncio_id
    LEFT JOIN LOS_GDDS.BI_Anuncio va ON v.anuncio_id = va.id
    LEFT JOIN LOS_GDDS.BI_Anuncio aa ON a.anuncio_id = aa.id
    LEFT JOIN LOS_GDDS.BI_Agente ag ON COALESCE(va.agente_id, aa.agente_id) = ag.id
)
SELECT
    ISNULL(op.nombre , '-') AS TipoOperacion,
    ISNULL(s.nombre ,'-') AS Sucursal,
    t.anio,
    t.cuatrimestre,
    ISNULL(AVG(ac.comision), 0) AS ValorPromedioComision
FROM LOS_GDDS.BI_Tipo_Operacion op
CROSS JOIN LOS_GDDS.BI_Tiempo t
LEFT JOIN AnunciosConComision ac ON op.id = ac.operacion_id AND t.anio = ac.anio AND t.cuatrimestre = ac.cuatrimestre
LEFT JOIN LOS_GDDS.BI_Sucursal s ON s.id = ac.sucursal_id  -- Añadí este JOIN para obtener el nombre de la sucursal

GROUP BY op.nombre, s.nombre, t.anio, t.cuatrimestre
ORDER BY t.anio, t.cuatrimestre, op.nombre, s.nombre
GO

--- VISTA 8 ---

CREATE VIEW LOS_GDDS.Vista_PorcentajeOperacionesConcretadas AS
SELECT
    s.nombre AS Sucursal,
    e.RANGO_ETARIO_DESCRIPCION AS RangoEtario,
    t.anio AS Anio,
    COUNT(a.id) AS TotalAnuncios,
    COUNT(v.id) AS VentasConcretadas,
    COUNT(al.id) AS AlquileresConcretados,
    ISNULL(ROUND(CAST(COUNT(v.id) AS DECIMAL) / NULLIF(COUNT(a.id), 0) * 100, 2), 0) AS PorcentajeVentas,
    ISNULL(ROUND(CAST(COUNT(al.id) AS DECIMAL) / NULLIF(COUNT(a.id), 0) * 100, 2), 0) AS PorcentajeAlquileres
FROM
    LOS_GDDS.BI_Sucursal s
CROSS JOIN
    LOS_GDDS.BI_RANGO_ETARIO e
CROSS JOIN
    LOS_GDDS.BI_Tiempo t
LEFT JOIN
    LOS_GDDS.BI_Agente ag ON s.id = ag.sucursal_id
LEFT JOIN
    LOS_GDDS.BI_Anuncio a ON ag.id = a.agente_id AND a.tiempo_id = t.id
LEFT JOIN
    LOS_GDDS.BI_Venta v ON a.id = v.anuncio_id
LEFT JOIN
    LOS_GDDS.BI_Alquiler al ON a.id = al.anuncio_id AND al.tiempo_inicio_id = t.id
GROUP BY
    s.nombre, e.RANGO_ETARIO_DESCRIPCION, t.anio
ORDER BY
    t.anio, e.RANGO_ETARIO_DESCRIPCION, s.nombre
GO

--- VISTA 9 ---

CREATE VIEW LOS_GDDS.Vista_MontoCierreContratos
AS
SELECT
    s.nombre AS Sucursal,
    t.anio AS Anio,
    COALESCE(t.cuatrimestre, 0) AS cuatrimestre,
    o.nombre AS TipoOperacion,
    m.nombre AS TipoMoneda,
    SUM(COALESCE(ISNULL(v.precio, a.importe), 0)) AS MontoTotal

FROM LOS_GDDS.BI_Tiempo t
CROSS JOIN LOS_GDDS.BI_Sucursal s
CROSS JOIN LOS_GDDS.BI_Tipo_Operacion o
CROSS JOIN LOS_GDDS.BI_Tipo_Moneda m
LEFT JOIN LOS_GDDS.BI_Agente ag ON s.id = ag.sucursal_id
LEFT JOIN LOS_GDDS.BI_Anuncio va ON ag.id = va.agente_id
LEFT JOIN LOS_GDDS.BI_Venta v ON va.id = v.anuncio_id 
LEFT JOIN LOS_GDDS.BI_Alquiler a ON va.id = a.anuncio_id 

GROUP BY s.nombre, t.anio, t.cuatrimestre, o.nombre, m.nombre

GO	

