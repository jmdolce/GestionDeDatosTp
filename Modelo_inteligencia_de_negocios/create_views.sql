--- VISTA 1 ---

CREATE VIEW LOS_GDDS.VIEW_duracion_anuncios_publicados 
AS
SELECT
    t.anio,
    t.cuatrimestre,
    ISNULL(o.nombre, 0) AS TipoOperacion,
    ISNULL(b.nombre, 0) AS Barrio,
    ISNULL(iamb.ambiente_id, 0)AS Ambientes,
    ISNULL(AVG(DATEDIFF(DAY, a.fecha_publicacion, a.fecha_finalizacion)), 0) AS DuracionPromedio

FROM LOS_GDDS.BI_Tiempo t
INNER JOIN LOS_GDDS.BI_Anuncio a ON YEAR(a.fecha_publicacion) = t.anio AND DATEPART(QUARTER, a.fecha_publicacion) = t.cuatrimestre
INNER JOIN LOS_GDDS.BI_Operacion o ON a.operacion_id = o.id
INNER JOIN LOS_GDDS.BI_Inmueble i ON a.inmueble_id = i.id
INNER JOIN LOS_GDDS.BI_Barrio b ON i.barrio_id = b.id
INNER JOIN LOS_GDDS.BI_Inmueble_Ambiente iamb ON i.id = iamb.inmueble_id

GROUP BY t.anio, t.cuatrimestre, o.nombre, b.nombre, iamb.ambiente_id


--- VISTA 2 --- 



