
/* ------------------------------------------ MIGRACIÓN CON PROCEDURES ------------------------------------------ */

CREATE PROCEDURE LOS_GDDS.MIGRAR_Agente
AS 
BEGIN
	INSERT INTO LOS_GDDS.Agente
		(dni, nombre, apellido, fecha_nacimiento, fecha_registro, mail, telefono)
	SELECT DISTINCT m.AGENTE_DNI, m.AGENTE_NOMBRE, m.AGENTE_APELLIDO, m.AGENTE_FECHA_NAC, m.AGENTE_FECHA_REGISTRO, m.AGENTE_MAIL, m.AGENTE_TELEFONO
    FROM gd_esquema.Maestra m
    WHERE m.AGENTE_DNI IS NOT NULL 
END
GO


-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Provincia
AS 
BEGIN
	INSERT INTO LOS_GDDS.Provincia(nombre)

	SELECT DISTINCT m.INMUEBLE_PROVINCIA
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_CODIGO IS NOT NULL 
    UNION
	SELECT DISTINCT m.SUCURSAL_PROVINCIA
    FROM gd_esquema.Maestra m
    WHERE m.SUCURSAL_CODIGO IS NOT NULL 
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Localidad
AS 
BEGIN
	INSERT INTO LOS_GDDS.Localidad(nombre, provincia_id) 

	SELECT DISTINCT m.INMUEBLE_LOCALIDAD, p.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON m.INMUEBLE_PROVINCIA = p.nombre
    ---WHERE m.INMUEBLE_CODIGO IS NOT NULL 

    UNION

	SELECT DISTINCT m.SUCURSAL_LOCALIDAD, p.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON p.nombre = m.SUCURSAL_PROVINCIA
   --- WHERE m.SUCURSAL_CODIGO IS NOT NULL 
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Barrio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Barrio(nombre, localidad_id)
	SELECT DISTINCT m.INMUEBLE_BARRIO, l.id
    JOIN LOS_GDDS.Localidad l ON m.INMUEBLE_LOCALIDAD = l.nombre
    FROM gd_esquema.Maestra m
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Sucursal
AS 
BEGIN
	INSERT INTO LOS_GDDS.Sucursal
		(id, nombre, direccion, telefono, localidad_id)
	SELECT DISTINCT m.SUCURSAL_CODIGO, m.SUCURSAL_NOMBRE, m.SUCURSAL_DIRECCION, M.SUCURSAL_TELEFONO, l.id
    JOIN LOS_GDDS.Localidad l ON m.SUCURSAL_LOCALIDAD = l.nombre
    FROM gd_esquema.Maestra m
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_PROPIETARIO 
AS
BEGIN
    INSERT INTO LOS_GDDS.Propietario (id, nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
    SELECT 
        PROPIETARIO_DNI, PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL, PROPIETARIO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE PROPIETARIO_DNI IS NOT NULL;
END;

------------- INMUEBLE ----------------
CREATE PROCEDURE LOS_GDDS.MIGRAR_Disposicion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Disposicion (nombre)
	SELECT DISTINCT m.INMUEBLE_DISPOSICION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_inmueble (nombre)
	SELECT DISTINCT m.INMUEBLE_ESTADO
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Orientacion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Orientacion (nombre)
	SELECT DISTINCT m.INMUEBLE_ORIENTACION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_inmueble(nombre)
	SELECT DISTINCT m.INMUEBLE_TIPO_INMUEBLE
    FROM gd_esquema.Maestra m
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Caracteristica
AS 
BEGIN
	INSERT INTO LOS_GDDS.Caracteristica(nombre)
	VALUES(wifi), (cable), (calefaccion), (gas);
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_INMUEBLE AS
BEGIN
    INSERT INTO LOS_GDDS.Inmueble (id, tipo_inmueble_id, descripcion, propietario_id, direccion, barrio_id, superficie_total, disposicion_id, estado_id, orientacion_id, antiguedad, ultima_expensa, cantidad_ambientes)
    SELECT 
        INMUEBLE_CODIGO, INMUEBLE_TIPO_INMUEBLE, INMUEBLE_DESCRIPCION, p.id, INMUEBLE_DIRECCION, b.id, INMUEBLE_SUPERFICIETOTAL, d.id, e.id, o.id, INMUEBLE_ANTIGUEDAD, INMUEBLE_EXPESAS, INMUEBLE_CANT_AMBIENTES
    FROM gd_esquema.Maestra m
    LEFT JOIN LOS_GDDS.Propietario p ON m.PROPIETARIO_DNI = p.dni -- en la tabla maestra no hay un INMUEBLE_PROPIETARIO, no se como hacer esto
    LEFT JOIN LOS_GDDS.Disposicion d ON m.INMUEBLE_DISPOSICION = d.nombre
    LEFT JOIN LOS_GDDS.Estado_inmueble e ON m.INMUEBLE_ESTADO = e.nombre
    LEFT JOIN LOS_GDDS.Orientacion o ON m.INMUEBLE_ORIENTACION = o.nombre
    LEFT JOIN LOS_GDDS.Barrio b ON m.INMUEBLE_BARRIO = b.nombre
    WHERE INMUEBLE_CODIGO IS NOT NULL;
END;

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_CaracteristicaInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_WIFI
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'wifi'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_CABLE
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'cable'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_CALEFACCION
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'calefaccion'
    WHERE INMUEBLE_CODIGO IS NOT NULL;

    INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id, valor)
	SELECT DISTINCT c.id, i.id, m.INMUEBLE_CARACTERISTICA_GAS
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Inmueble i ON m.INMUEBLE_CODIGO = i.id
    JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'gas'
    WHERE INMUEBLE_CODIGO IS NOT NULL;
    
END
GO


------------- ANUNCIO ----------------         
CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAnuncio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_anuncio
        (nombre)
	SELECT DISTINCT m.ANUNCIO_ESTADO 
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Operacion  
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_anuncio
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_OPERACION
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoPeriodo
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_periodo
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_PERIODO
    FROM gd_esquema.Maestra m
END
GO


-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Moneda
AS 
BEGIN
	INSERT INTO LOS_GDDS.Moneda
        (nombre)
	SELECT DISTINCT m.ANUNCIO_MONEDA
    FROM gd_esquema.Maestra m
    WHERE m.ANUNCIO_CODIGO IS NOT NULL
    UNION
    SELECT DISTINCT m.VENTA_MONEDA
    FROM gd_esquema.Maestra m
    WHERE m.VENTA_CODIGO IS NOT NULL
END
GO

------------- COMPRADOR ----------------

CREATE PROCEDURE LOS_GDDS.MIGRAR_Comprador
AS 
BEGIN
	INSERT INTO LOS_GDDS.Comprador
        (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
	SELECT DISTINCT m.COMPRADOR_NOMBRE, m.COMPRADOR_APELLIDO, m.COMPRADOR_DNI, m.COMPRADOR_FECHA_REGISTRO, 
                    m.COMPRADOR_TELEFONO, m.COMPRADOR_MAIL, m.COMPRADOR_FECHA_NAC
    FROM gd_esquema.Maestra m
END
GO


------------- PAGO ----------------

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_MedioPago
AS 
BEGIN
	INSERT INTO LOS_GDDS.Medio_pago
        (nombre)

	SELECT DISTINCT m.PAGO_ALQUILER_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.ALQUILER_CODIGO IS NOT NULL 
    UNION
	SELECT DISTINCT m.PAGO_VENTA_MEDIO_PAGO
    FROM gd_esquema.Maestra m
    WHERE m.VENTA_CODIGO IS NOT NULL 
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoVenta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Pago_venta
        (importe, moneda_id, cotizacion, medio_pago_id)
	SELECT DISTINCT m.PAGO_VENTA_IMPORTE, mon.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.PAGO_VENTA_MONEDA
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_VENTA_MEDIO_PAGO
END
GO

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Pago_alquiler
        (id, fecha, num_periodo, descripcion_periodo, fecha_inicio_periodo, fecha_fin_periodo, importe, medio_pago_id)
	SELECT DISTINCT m.PAGO_ALQUILER_CODIGO, m.PAGO_ALQUILER_NRO_PERIODO, m.PAGO_ALQUILER_DESC, m.PAGO_ALQUILER_FEC_INI,
                    m.PAGO_ALQUILER_FEC_FIN, m.PAGO_ALQUILER_IMPORTE, mp.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_VENTA_MEDIO_PAGO
END
GO

------------- VENTA ----------------

-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Venta
        (id, anuncio_id, comprador_id, fecha_venta, precio, moneda_id, pago_venta_id, comision)
	SELECT DISTINCT m.VENTA_CODIGO, c.id, m.VENTA_FECHA, m.VENTA_PRECIO_VENTA, mon.id, m.VENTA_COMISION
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Comprador c ON c.nombre = m.COMPRADOR_NOMBRE AND c.apellido = m.COMPRADOR_APELLIDO AND c.dni = m.COMPRADOR_DNI
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.VENTA_MONEDA
    
END
GO


------------- ALQUILER ----------------


CREATE PROCEDURE LOS_GDDS.MIGRAR_Inquilino
AS 
BEGIN
	INSERT INTO LOS_GDDS.Inquilino
        (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
	SELECT DISTINCT m.INQUILINO_NOMBRE, m.INQUILINO_APELLIDO, m.INQUILINO_DNI, m.INQUILINO_FECHA_REGISTRO, 
                    m.INQUILINO_TELEFONO, m.INQUILINO_MAIL, m.INQUILINO_FECHA_NAC
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_alquiler
        (nombre)
	SELECT DISTINCT m.ALQUILER_ESTADO
    FROM gd_esquema.Maestra m
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_DetalleAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Detalle_alquiler
        (periodo_inicio, periodo_fin, precio)
	SELECT DISTINCT m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN, m.DETALLE_ALQ_PRECIO
    FROM gd_esquema.Maestra m
END
GO

/*
Hago los procedures suponiendo que estos cambios ya estan hechos.
El alquiler deberia tener un pago_alquiler_id como lo tiene venta con pago_venta ---> Cambiar en der y tablas.
Sacar de pago_alquiler el alquiler_id 
Duda con alquiler
Como tengo duda con alquiler no puedo hacer venta completa
Con venta duda con pago_venta_id
el id del inquilino deberia ser autogenerado ? porq la maestra no tiene ni id ni codigo para los inquilinos
El detalle alquiler no deberia tener alquiler_id si no que el alquiler deberia tener el detalle_id
FALTARIA ALQUILER-VENTA_INQUILINO_CARACTERISTICAS
*/
-------

------------- EJECUCION DE PROCEDURES ----------------

EXEC LOS_GDDS.MIGRAR_Provincia
EXEC LOS_GDDS.MIGRAR_Localidad
EXEC LOS_GDDS.MIGRAR_Barrio
EXEC LOS_GDDS.MIGRAR_Sucursal
EXEC LOS_GDDS.MIGRAR_Agente
EXEC LOS_GDDS.MIGRAR_Disposicion
EXEC LOS_GDDS.MIGRAR_EstadoInmueble
EXEC LOS_GDDS.MIGRAR_TipoInmueble
EXEC LOS_GDDS.MIGRAR_Orientacion
--- ACA LA DE CARACTERISTICA
--- ACA LA DE AMBIENTE
EXEC LOS_GDDS.MIGRAR_PROPIETARIO
EXEC LOS_GDDS.MIGRAR_EstadoAnuncio
EXEC LOS_GDDS.MIGRAR_Operacion
EXEC LOS_GDDS.MIGRAR_TipoPeriodo
EXEC LOS_GDDS.MIGRAR_Moneda
EXEC LOS_GDDS.MIGRAR_MedioPago
EXEC LOS_GDDS.MIGRAR_PagoVenta
EXECE LOS_GDD.MIGRAR_Comprador
EXEC LOS_GDDS.MIGRAR_DetalleAlquiler
EXEC LOS_GDDS.MIGRAR_Inquilino
EXEC LOS_GDDS.MIGRAR_EstadoAlquiler
EXEC LOS_GDDS.MIGRAR_PagoAlquiler
--- ACA ANUNCIO
--- ACA ALQUILER
--- ACA VENTA
--- ACA INMUEBLE
