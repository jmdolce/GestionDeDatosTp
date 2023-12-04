CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Venta
	SELECT v.id, t.id, ti.id, s.id, u.id, m.id, COUNT(*), AVG() -- precio_promedio_m2 (no se como calcularlo)
    FROM LOS_GDDS.Venta v
    JOIN LOS_GDDS.Anuncio a ON v.anuncio_id = a.id
    JOIN LOS_GDDS.BI_Inmueble i ON a.inmueble_id = i.id -- aca uso la tabla BI porque necesito la ubicacion
    JOIN LOS_GDDS.Tipo_inmueble ti ON i.tipo_inmueble_id = ti.id
    JOIN LOS_GDDS.Moneda m ON a.moneda_id = m.id
    JOIN LOS_GDDS.Ubicacion u ON i.ubicacion_id = u.id
    JOIN LOS_GDDS.Tiempo t ON DATEPART(YEAR, v.fecha_venta) = t.anio AND DATEPART(QUARTER, v.fecha_venta) = t.cuatrimestre
    JOIN LOS_GDDS.Agente ag ON ag.id = a.agente_id
    JOIN LOS_GDDS.Sucursal s ON s.id = ag.sucursal_id
    GROUP BY t.id, i,id, u.id, m.id, s.id -- agrupo por las FK
END
GO