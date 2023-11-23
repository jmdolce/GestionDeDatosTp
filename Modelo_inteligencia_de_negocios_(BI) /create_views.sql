--- VISTA 1 ---

/* CHEQUEAR !!!!!!!!!!!!!

CREATE VIEW BI_LOS_GDDS.VIEW_PROMEDIO_PUBLICACION_ANUNCIOS 
AS
    SELECT
        YEAR(a.fecha_publicacion) AS Anio,
        DATEPART(QUARTER, a.fecha_publicacion) AS Cuatrimestre,
        o.nombre AS Operacion,
        b.nombre AS Barrio,
        COUNT(*) AS CantidadAnuncios,
        AVG(DATEDIFF(DAY, a.fecha_publicacion, a.fecha_finalizacion)) AS DuracionPromedio

    FROM BI_LOS_GDDS.BI_Anuncio a
    JOIN BI_LOS_GDDS.BI_Operacion o ON a.operacion_id = o.id
    JOIN BI_LOS_GDDS.BI_Barrio b ON a.barrio_id = b.id
    JOIN BI_LOS_GDDS.BI_Inmueble_Ambiente ia ON a.inmueble_id = ia.inmueble_id

    GROUP BY YEAR(a.fecha_publicacion), DATEPART(QUARTER, a.fecha_publicacion), o.nombre, b.nombre

    ORDER BY Anio, Cuatrimestre, Operacion, Barrio
GO
*/

--- VISTA 2 --- 



