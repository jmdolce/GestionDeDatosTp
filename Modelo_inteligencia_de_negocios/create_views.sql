--- VISTA 1 ---

CREATE VIEW LOS_GDDS.VIEW_duracion_anuncios_publicados 
AS
SELECT 
	t.anio, 
	t.cuatrimestre, 
	op.nombre AS [Tipo operacion], 
	u.barrio, 
	i.descripcion AS [inmueble], 
	iamb.ambiente_id [Ambiente], 
	DATEDIFF(day, a.fecha_publicacion, a.fecha_finalizacion) AS [Duracion dias]
FROM LOS_GDDS.BI_Anuncio a 
JOIN LOS_GDDS.BI_Tiempo t ON t.id = a.tiempo_id
JOIN LOS_GDDS.BI_Tipo_Operacion op ON a.operacion_id = op.id
JOIN LOS_GDDS.BI_Inmueble i ON i.id = a.inmueble_id
JOIN LOS_GDDS.BI_Ubicacion u ON u.id = i.ubicacion_id 
JOIN LOS_GDDS.BI_Inmueble_Ambiente iamb ON iamb.inmueble_id = i.id

GROUP BY t.anio, t.cuatrimestre, op.nombre, u.barrio, iamb.ambiente_id, i.descripcion, a.fecha_publicacion, a.fecha_finalizacion
HAVING t.anio = YEAR(GETDATE()) AND t.cuatrimestre = (MONTH(GETDATE()) - 1) / 4 + 1 -- que sea de este cuatrimestre

--- VISTA 2 --- 



