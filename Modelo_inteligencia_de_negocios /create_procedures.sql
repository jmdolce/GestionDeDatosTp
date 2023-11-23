
/* ------------------------------------------ MIGRACIÓN CON PROCEDURES ------------------------------------------ */

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Agente
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Agente
	SELECT * FROM LOS_GDDS.Agente
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Sucursal
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Sucursal(id, nombre, direccion, telefono, ubicacion_id)
    SELECT s.id, s.nombre, s.direccion, s.telefono, u.id FROM LOS_GDDS.Sucursal s
    JOIN LOS_GDDS.Localidad l ON s.localidad_id = l.id
    JOIN LOS_GDDS.BI_Ubicacion u ON l.nombre = u.localidad
END
GO 


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Propietario
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Propietario ()
    SELECT * FROM LOS_GDDS.Propietario
END
GO

------------- INMUEBLE ----------------
CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Disposicion
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Disposicion ()
	SELECT * FROM LOS_GDDS.Disposicion
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_EstadoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Estado_inmueble ()
	SELECT * FROM LOS_GDDS.Estado_inmueble
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Orientacion
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Orientacion ()
	SELECT * FROM LOS_GDDS.Orientacion
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_TipoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_inmueble()
	SELECT * FROM LOS_GDDS.Tipo_inmueble
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Ambiente
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Ambiente()
    SELECT * FROM LOS_GDDS.Ambiente
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Inmueble
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Inmueble(id, tipo_inmueble_id, descripcion, propietario_id, direccion, ubicacion_id, 
									superficie_total, estado_id, orientacion_id, antiguedad, ultima_expensa)
    SELECT i.id, i.tipo_inmueble_id, i.descripcion, i.propietario_id, i.direccion, u.id, 
			i.superficie_total, i.estado_id, i.orientacion_id, i.antiguedad, i.ultima_expensa FROM LOS_GDDS.Inmueble i
	JOIN LOS_GDDS.Barrio b ON b.id =  i.barrio_id
	JOIN LOS_GDDS.BI_Ubicacion u ON u.barrio = b.nombre
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_AmbienteInmueble
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Inmueble_Ambiente()
    SELECT * FROM LOS_GDDS.Inmueble_Ambiente
END
GO



CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Caracteristica
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Caracteristica()
	SELECT * FROM LOS_GDDS.Caracteristica
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_CaracteristicaInmueble
AS 
BEGIN
    INSERT INTO LOS_GDDS.BI_Caracteristica_inmueble()
	SELECT * FROM LOS_GDDS.Caracteristica_inmueble
END
GO


------------- ANUNCIO ----------------    

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Anuncio
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Anuncio
        (id, fecha_publicacion, agente, inmueble_id, operacion_id, precio_inmueble, moneda_id, 
        periodo_id, estado_id, fecha_finalizacion, costo_publicacion, rango_etario_agente_id, a.rango_m2_id)
    SELECT  a.id, a.fecha_publicacion, a.agente_id, a.operacion_id, a.precio_inmueble, a.moneda_id, 
            a.periodo_id, a.estado_id, a.fecha_finalizacion, a.costo_publicacion, BI.FX_CALCULAR_RANGO_ETARIO_AGENTE(a.agente_id),
            BI.FX_CALCULAR_RANGO_M2(a.inmueble_id) FROM LOS_GDDS.Anuncio a
END
GO 

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_EstadoAnuncio
AS 
BEGIN
	SELECT * FROM LOS_GDDS.Estado_anuncio
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Tipo_Operacion
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_Operacion
    SELECT * FROM LOS_GDDS.Operacion
END
GO 

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_TipoPeriodo
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_periodo ()
	SELECT * FROM LOS_GDDS.Tipo_periodo
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Tipo_Moneda
AS
BEGIN
	INSERT INTO LOS_GDDS.BI_Tipo_Moneda
    SELECT * FROM LOS_GDDS.Moneda
END
GO 

------------- COMPRADOR ----------------

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Comprador
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Comprador()
	SELECT * FROM LOS_GDDS.Comprador
END
GO


------------- PAGO ----------------


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_MedioPago
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Medio_pago()

	SELECT * FROM LOS_GDDS.Medio_pago
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_PagoVenta
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Pago_venta()
	SELECT * FROM LOS_GDDS.Pago_venta
END
GO


 CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_PagoAlquiler
 AS 
 BEGIN
	INSERT INTO LOS_GDDS.BI_Pago_alquiler() 	
    SELECT * FROM LOS_GDDS.Pago_alquiler
 END
 GO

----------- VENTA ----------------


CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Venta()
	SELECT * FROM LOS_GDDS.Venta
END
GO


------------- ALQUILER ----------------

-- Aca tomamos que el importe del alquiler es el del mes MAS VIEJO (porque un mismo alquiler tiene distintos importes, un por cada mes de renta)
CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Alquiler
AS
BEGIN
    INSERT INTO LOS_GDDS.BI_Alquiler(id, anuncio_id, inquilino_id, fecha_inicio, fecha_fin, importe, cantidad_periodos, comision, gastos_averiguaciones,
                                    estado_id, deposito, rango_etario_inquilino_id)
	SELECT a.id, a.anuncio_id, a.inquilino_id, a.fecha_inicio, a.fecha_fin, a.importe, a.cantidad_periodos, a.comision, a.gastos_averiguaciones,
                                    a.estado_id, a.deposito, BI.FX_CALCULAR_RANGO_ETARIO_INQUILINO(rango_etario_inquilino_id) FROM LOS_GDDS.Alquiler a   
END
GO


 CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_DetalleAlquiler
 AS 
 BEGIN
 	INSERT INTO LOS_GDDS.BI_Detalle_alquiler()
 	SELECT * FROM LOS_GDDS.Detalle_alquiler
 END
 GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_Inquilino
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Inquilino()
	SELECT * FROM LOS_GDDS.Inquilino
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_BI_EstadoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.BI_Estado_alquiler()
	SELECT * FROM LOS_GDDS.Estado_alquiler
END
GO

--- COSAS NUEVAS ---

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






