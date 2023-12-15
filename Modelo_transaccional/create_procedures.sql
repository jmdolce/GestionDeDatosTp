
/* ------------------------------------------ MIGRACIÓN CON PROCEDURES ------------------------------------------ */

CREATE PROCEDURE LOS_GDDS.MIGRAR_Agente
AS 
BEGIN
	INSERT INTO LOS_GDDS.Agente
		(dni, nombre, apellido, fecha_nacimiento, fecha_registro, mail, telefono, sucursal_id)
	SELECT DISTINCT m.AGENTE_DNI, m.AGENTE_NOMBRE, m.AGENTE_APELLIDO, m.AGENTE_FECHA_NAC, m.AGENTE_FECHA_REGISTRO, m.AGENTE_MAIL, m.AGENTE_TELEFONO, m.SUCURSAL_CODIGO
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


CREATE PROCEDURE LOS_GDDS.MIGRAR_Localidad
AS 
BEGIN
	INSERT INTO LOS_GDDS.Localidad(nombre, provincia_id) 

	SELECT m.INMUEBLE_LOCALIDAD, p.id 
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON m.INMUEBLE_PROVINCIA = p.nombre
    WHERE m.INMUEBLE_PROVINCIA IS NOT NULL 

    UNION

	SELECT m.SUCURSAL_LOCALIDAD, p.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Provincia p ON p.nombre = m.SUCURSAL_PROVINCIA
    WHERE m.SUCURSAL_PROVINCIA IS NOT NULL 
END
GO


-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Barrio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Barrio (nombre, localidad_id)
	SELECT DISTINCT m.INMUEBLE_BARRIO,  l.id
    FROM gd_esquema.Maestra m
    LEFT JOIN LOS_GDDS.Localidad l ON m.INMUEBLE_LOCALIDAD = l.nombre
END
GO




-- CHEQUEAR
CREATE PROCEDURE LOS_GDDS.MIGRAR_Sucursal
AS 
BEGIN
	INSERT INTO LOS_GDDS.Sucursal
		(id, nombre, direccion, telefono, localidad_id)
	SELECT DISTINCT m.SUCURSAL_CODIGO, m.SUCURSAL_NOMBRE, m.SUCURSAL_DIRECCION, M.SUCURSAL_TELEFONO, l.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Localidad l ON m.SUCURSAL_LOCALIDAD = l.nombre  
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Propietario
AS
BEGIN
    INSERT INTO LOS_GDDS.Propietario (id, nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
    SELECT DISTINCT
        PROPIETARIO_DNI, PROPIETARIO_NOMBRE, PROPIETARIO_APELLIDO, PROPIETARIO_DNI, PROPIETARIO_FECHA_REGISTRO, PROPIETARIO_TELEFONO, PROPIETARIO_MAIL, PROPIETARIO_FECHA_NAC
    FROM gd_esquema.Maestra
    WHERE PROPIETARIO_DNI IS NOT NULL;
END
GO

------------- INMUEBLE ----------------
CREATE PROCEDURE LOS_GDDS.MIGRAR_Disposicion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Disposicion (nombre)
	SELECT DISTINCT m.INMUEBLE_DISPOSICION
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_DISPOSICION IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_inmueble (nombre)
	SELECT DISTINCT m.INMUEBLE_ESTADO
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_ESTADO IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Orientacion
AS 
BEGIN
	INSERT INTO LOS_GDDS.Orientacion (nombre)
	SELECT DISTINCT m.INMUEBLE_ORIENTACION
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_ORIENTACION IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoInmueble
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_inmueble(nombre)
	SELECT DISTINCT m.INMUEBLE_TIPO_INMUEBLE
    FROM gd_esquema.Maestra m
    WHERE m.INMUEBLE_TIPO_INMUEBLE IS NOT NULL
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Ambiente
AS
BEGIN
    INSERT INTO LOS_GDDS.Ambiente(nombre)
    SELECT DISTINCT INMUEBLE_CANT_AMBIENTES
    FROM gd_esquema.Maestra m
    WHERE INMUEBLE_CODIGO IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Inmueble
AS
BEGIN
    INSERT INTO LOS_GDDS.Inmueble(id, tipo_inmueble_id, descripcion, direccion, propietario_id, barrio_id, superficie_total, disposicion_id, estado_id, orientacion_id, ambiente_id ,antiguedad, ultima_expensa)
    SELECT
        m.INMUEBLE_CODIGO,
        MAX(ti.id) AS id,
        MAX(m.INMUEBLE_DESCRIPCION) AS INMUEBLE_DESCRIPCION,
        MAX(m.INMUEBLE_DIRECCION) AS INMUEBLE_DIRECCION,
        MAX(p.id) AS p_id,
        MAX(b.id) AS b_id,
        MAX(m.INMUEBLE_SUPERFICIETOTAL) AS INMUEBLE_SUPERFICIETOTAL,
        MAX(d.id) AS d_id,
        MAX(e.id) AS e_id,
        MAX(o.id) AS o_id,
        MAX(a.id),
        MAX(m.INMUEBLE_ANTIGUEDAD) AS INMUEBLE_ANTIGUEDAD,
        MAX(m.INMUEBLE_EXPESAS) AS INMUEBLE_EXPESAS
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Propietario p ON m.PROPIETARIO_DNI = p.dni
    JOIN LOS_GDDS.Disposicion d ON m.INMUEBLE_DISPOSICION = d.nombre
    JOIN LOS_GDDS.Estado_inmueble e ON m.INMUEBLE_ESTADO = e.nombre
    JOIN LOS_GDDS.Orientacion o ON m.INMUEBLE_ORIENTACION = o.nombre
    
    JOIN LOS_GDDS.Localidad l ON l.nombre = m.INMUEBLE_LOCALIDAD -- checkear
    JOIN LOS_GDDS.Barrio b ON m.INMUEBLE_BARRIO = b.nombre AND b.localidad_id = l.id

    JOIN LOS_GDDS.Tipo_inmueble ti ON m.INMUEBLE_TIPO_INMUEBLE = ti.nombre
    JOIN LOS_GDDS.Ambiente a ON a.nombre = INMUEBLE_CANT_AMBIENTES

    WHERE INMUEBLE_CODIGO IS NOT NULL
    GROUP BY m.INMUEBLE_CODIGO;
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_Caracteristica
AS 
BEGIN
	INSERT INTO LOS_GDDS.Caracteristica(nombre)
	VALUES('wifi'), ('cable'), ('calefaccion'), ('gas')
END
GO


CREATE PROCEDURE LOS_GDDS.MIGRAR_CaracteristicaInmueble
AS 
BEGIN
    DECLARE @CaracteristicaNombre NVARCHAR(100)
    DECLARE @InmuebleCodigo NUMERIC(18, 0)
    DECLARE @CaracteristicaWifi INT
    DECLARE @CaracteristicaCable INT
    DECLARE @CaracteristicaCalefaccion INT
    DECLARE @CaracteristicaGas INT

    -- Declarar el cursor para recorrer la tabla Maestra
    DECLARE caracteristica_cursor CURSOR FOR
    SELECT INMUEBLE_CODIGO, 
           INMUEBLE_CARACTERISTICA_WIFI, 
           INMUEBLE_CARACTERISTICA_CABLE, 
           INMUEBLE_CARACTERISTICA_CALEFACCION, 
           INMUEBLE_CARACTERISTICA_GAS
    FROM gd_esquema.Maestra
    
    OPEN caracteristica_cursor

    FETCH NEXT FROM caracteristica_cursor INTO @InmuebleCodigo, @CaracteristicaWifi, @CaracteristicaCable, @CaracteristicaCalefaccion, @CaracteristicaGas

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @CaracteristicaWifi = 1
        BEGIN
            INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id)
            SELECT DISTINCT c.id, i.id
            FROM LOS_GDDS.Inmueble i
            JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'wifi'
            WHERE i.id = @InmuebleCodigo
            AND NOT EXISTS (
                SELECT 1
                FROM LOS_GDDS.Caracteristica_inmueble ci
                WHERE ci.caracteristica_id = c.id AND ci.inmueble_id = i.id
            );
        END

        IF @CaracteristicaCable = 1
        BEGIN
            INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id)
            SELECT DISTINCT c.id, i.id
            FROM LOS_GDDS.Inmueble i
            JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'cable'
            WHERE i.id = @InmuebleCodigo
            AND NOT EXISTS (
                SELECT 1
                FROM LOS_GDDS.Caracteristica_inmueble ci
                WHERE ci.caracteristica_id = c.id AND ci.inmueble_id = i.id
            );
        END

        IF @CaracteristicaCalefaccion = 1
        BEGIN
            INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id)
            SELECT DISTINCT c.id, i.id
            FROM LOS_GDDS.Inmueble i
            JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'calefaccion'
            WHERE i.id = @InmuebleCodigo
            AND NOT EXISTS (
                SELECT 1
                FROM LOS_GDDS.Caracteristica_inmueble ci
                WHERE ci.caracteristica_id = c.id AND ci.inmueble_id = i.id
            );
        END

        IF @CaracteristicaGas = 1
        BEGIN
            INSERT INTO LOS_GDDS.Caracteristica_inmueble(caracteristica_id, inmueble_id)
            SELECT DISTINCT c.id, i.id
            FROM LOS_GDDS.Inmueble i
            JOIN LOS_GDDS.Caracteristica c ON c.nombre = 'gas'
            WHERE i.id = @InmuebleCodigo
            AND NOT EXISTS (
                SELECT 1
                FROM LOS_GDDS.Caracteristica_inmueble ci
                WHERE ci.caracteristica_id = c.id AND ci.inmueble_id = i.id
            );
        END

        FETCH NEXT FROM caracteristica_cursor INTO @InmuebleCodigo, @CaracteristicaWifi, @CaracteristicaCable, @CaracteristicaCalefaccion, @CaracteristicaGas
    END

    CLOSE caracteristica_cursor
    DEALLOCATE caracteristica_cursor
END
GO


------------- ANUNCIO ----------------    

CREATE PROCEDURE LOS_GDDS.MIGRAR_Anuncio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Anuncio(id, fecha_publicacion, agente_id, inmueble_id, operacion_id, precio_inmueble, moneda_id, periodo_id, estado_id, fecha_finalizacion, costo_publicacion)
	SELECT DISTINCT m.ANUNCIO_CODIGO ,m.ANUNCIO_FECHA_PUBLICACION, ag.id, m.INMUEBLE_CODIGO, o.id, m.ANUNCIO_PRECIO_PUBLICADO, mon.id, tp.id, ea.id, m.ANUNCIO_FECHA_FINALIZACION, m.ANUNCIO_COSTO_ANUNCIO
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Operacion o ON m.ANUNCIO_TIPO_OPERACION = o.nombre
    JOIN LOS_GDDS.Agente ag ON m.AGENTE_DNI = ag.dni
    JOIN LOS_GDDS.Moneda mon ON m.ANUNCIO_MONEDA = mon.nombre
    JOIN LOS_GDDS.Tipo_periodo tp ON m.ANUNCIO_TIPO_PERIODO = tp.nombre
    JOIN LOS_GDDS.Estado_anuncio ea ON m.ANUNCIO_ESTADO = ea.nombre
    
    WHERE m.INMUEBLE_CODIGO IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAnuncio
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_anuncio
        (nombre)
	SELECT DISTINCT m.ANUNCIO_ESTADO 
    FROM gd_esquema.Maestra m
    WHERE m.ANUNCIO_ESTADO IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Operacion  
AS 
BEGIN
	INSERT INTO LOS_GDDS.Operacion
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_OPERACION
    FROM gd_esquema.Maestra m
    WHERE m.ANUNCIO_TIPO_OPERACION IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_TipoPeriodo
AS 
BEGIN
	INSERT INTO LOS_GDDS.Tipo_periodo
        (nombre)
	SELECT DISTINCT m.ANUNCIO_TIPO_PERIODO
    FROM gd_esquema.Maestra m
    WHERE m.ANUNCIO_TIPO_PERIODO IS NOT NULL
END
GO



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
    WHERE m.COMPRADOR_DNI IS NOT NULL
END
GO


------------- PAGO ----------------


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


CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoVenta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Pago_venta
        (importe, moneda_id, cotizacion, medio_pago_id, venta_id)
	SELECT DISTINCT m.PAGO_VENTA_IMPORTE, mon.id, m.PAGO_VENTA_COTIZACION, mp.id, m.VENTA_CODIGO
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.PAGO_VENTA_MONEDA
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_VENTA_MEDIO_PAGO
END
GO


 CREATE PROCEDURE LOS_GDDS.MIGRAR_PagoAlquiler
 AS 
 BEGIN
	INSERT INTO LOS_GDDS.Pago_alquiler
        (id, alquiler_id, fecha, num_periodo, descripcion_periodo, fecha_inicio_periodo, fecha_fin_periodo, importe, medio_pago_id) 	
    SELECT DISTINCT m.PAGO_ALQUILER_CODIGO, m.ALQUILER_CODIGO, m.PAGO_ALQUILER_FECHA ,m.PAGO_ALQUILER_NRO_PERIODO, m.PAGO_ALQUILER_DESC, m.PAGO_ALQUILER_FEC_INI,
                    m.PAGO_ALQUILER_FEC_FIN, m.PAGO_ALQUILER_IMPORTE, mp.id
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Medio_pago mp ON mp.nombre = m.PAGO_ALQUILER_MEDIO_PAGO
	WHERE m.PAGO_ALQUILER_CODIGO IS NOT NULL
 END
 GO

----------- VENTA ----------------


CREATE PROCEDURE LOS_GDDS.MIGRAR_Venta
AS 
BEGIN
	INSERT INTO LOS_GDDS.Venta
        (id, anuncio_id, comprador_id, fecha_venta, precio, moneda_id, comision)
	SELECT DISTINCT m.VENTA_CODIGO, m.ANUNCIO_CODIGO, c.id, m.VENTA_FECHA, m.VENTA_PRECIO_VENTA, mon.id, m.VENTA_COMISION
    FROM gd_esquema.Maestra m
    JOIN LOS_GDDS.Comprador c ON c.nombre = m.COMPRADOR_NOMBRE AND c.apellido = m.COMPRADOR_APELLIDO AND c.dni = m.COMPRADOR_DNI
    JOIN LOS_GDDS.Moneda mon ON mon.nombre = m.VENTA_MONEDA
    
END
GO


------------- ALQUILER ----------------

-- Aca tomamos que el importe del alquiler es el del mes MAS VIEJO (porque un mismo alquiler tiene distintos importes, un por cada mes de renta)
CREATE PROCEDURE LOS_GDDS.MIGRAR_Alquiler
AS
BEGIN
    ;WITH CTE AS (
        SELECT
            m.ALQUILER_CODIGO,
            m.ALQUILER_FECHA_INICIO,
            e.id AS estado_id,
            m.ALQUILER_FECHA_FIN,
            m.ALQUILER_CANT_PERIODOS,
            m.ALQUILER_COMISION,
            m.ALQUILER_GASTOS_AVERIGUA,
            m.ALQUILER_DEPOSITO,
            m.ANUNCIO_CODIGO,
            m.PAGO_ALQUILER_IMPORTE,
            inq.id AS inquilino_id,
            m.PAGO_ALQUILER_FEC_INI,
            ROW_NUMBER() OVER (PARTITION BY m.ANUNCIO_CODIGO ORDER BY m.PAGO_ALQUILER_FEC_INI ASC) AS rn
        FROM gd_esquema.Maestra m
        JOIN LOS_GDDS.Estado_alquiler e ON m.ALQUILER_ESTADO = e.nombre
        JOIN LOS_GDDS.Inquilino inq ON m.INQUILINO_DNI = inq.dni
        WHERE m.ALQUILER_CODIGO IS NOT NULL
    )
    
    INSERT INTO LOS_GDDS.Alquiler(id, fecha_inicio, estado_id, fecha_fin, cantidad_periodos, comision, gastos_averiguaciones, deposito, anuncio_id, importe, inquilino_id)
    SELECT
        ALQUILER_CODIGO,
        ALQUILER_FECHA_INICIO,
        estado_id,
        ALQUILER_FECHA_FIN,
        ALQUILER_CANT_PERIODOS,
        ALQUILER_COMISION,
        ALQUILER_GASTOS_AVERIGUA,
        ALQUILER_DEPOSITO,
        ANUNCIO_CODIGO,
        PAGO_ALQUILER_IMPORTE,
        inquilino_id
    FROM CTE
    WHERE rn = 1;
END
GO


 CREATE PROCEDURE LOS_GDDS.MIGRAR_DetalleAlquiler
 AS 
 BEGIN
 	INSERT INTO LOS_GDDS.Detalle_alquiler(periodo_inicio, periodo_fin, precio, alquiler_id)
 	SELECT DISTINCT m.DETALLE_ALQ_NRO_PERIODO_INI, m.DETALLE_ALQ_NRO_PERIODO_FIN, m.DETALLE_ALQ_PRECIO, m.ALQUILER_CODIGO
    FROM gd_esquema.Maestra m
    WHERE m.DETALLE_ALQ_NRO_PERIODO_INI IS NOT NULL
 END
 GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_Inquilino
AS 
BEGIN
	INSERT INTO LOS_GDDS.Inquilino
        (nombre, apellido, dni, fecha_registro, telefono, mail, fecha_nacimiento)
	SELECT DISTINCT m.INQUILINO_NOMBRE, m.INQUILINO_APELLIDO, m.INQUILINO_DNI, m.INQUILINO_FECHA_REGISTRO, 
                    m.INQUILINO_TELEFONO, m.INQUILINO_MAIL, m.INQUILINO_FECHA_NAC
    FROM gd_esquema.Maestra m
    WHERE m.INQUILINO_DNI IS NOT NULL
END
GO

CREATE PROCEDURE LOS_GDDS.MIGRAR_EstadoAlquiler
AS 
BEGIN
	INSERT INTO LOS_GDDS.Estado_alquiler
        (nombre)
	SELECT DISTINCT m.ALQUILER_ESTADO
    FROM gd_esquema.Maestra m
    WHERE m.ALQUILER_ESTADO IS NOT NULL
END
GO