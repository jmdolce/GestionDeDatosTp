USE [GD2C2023]
GO

/* CREACION DEL SCHEMA */

CREATE SCHEMA LOS_GDDS
GO



/* CREACION DE TABLAS */

/* ------------------------------------------ TIPIFICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.Propietario(
    id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Disposicion(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Estado_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Orientacion(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ INMUEBLE ------------------------------------------ */

CREATE TABLE LOS_GDDS.Inmueble(
    id NUMERIC(18,0) PRIMARY KEY,
    tipo_inmueble_id INT, --FK
    descripcion NVARCHAR(100),
    propietario_id INT, -- FK
    direccion NVARCHAR(100),
    barrio_id INT, --FK
    superficie_total NUMERIC(18,2), 
    disposicion_id INT, --FK
    estado_id INT, --FK
    orientacion_id INT, --FK
    ambiente_id INT, -- FK
    antiguedad NUMERIC(18,0),
    ultima_expensa NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Caracteristica_inmueble(
    caracteristica_id INT, --FK
    inmueble_id NUMERIC(18,0), --FK
    PRIMARY KEY (caracteristica_id, inmueble_id)
);

CREATE TABLE LOS_GDDS.Caracteristica(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
);

CREATE TABLE LOS_GDDS.Ambiente(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre nVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Tipo_inmueble(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ VENTA ------------------------------------------ */

CREATE TABLE LOS_GDDS.Venta(
    id NUMERIC(18,0) PRIMARY KEY, ---esto es el codigo
    anuncio_id NUMERIC(18,0) NULL, --FK
    comprador_id INT, --FK
    fecha_venta DATETIME,
    precio NUMERIC(18,2),
    moneda_id INT, --FK
    comision NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Pago_venta(
    id INT IDENTITY(1,1) PRIMARY KEY,
    importe NUMERIC(18,2),
    moneda_id INT,      -- FK
    cotizacion NUMERIC(18,2),
    medio_pago_id INT, -- FK
    venta_id NUMERIC(18,0) -- FK
);

CREATE TABLE LOS_GDDS.Comprador(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

/* ------------------------------------------ ANUNCIO ------------------------------------------ */

CREATE TABLE LOS_GDDS.Anuncio(
    id NUMERIC(18,0) PRIMARY KEY,
    fecha_publicacion DATE,
    agente_id NUMERIC(19,0), -- FK
    inmueble_id NUMERIC(18,0), -- FK
    operacion_id INT, -- FK
    precio_inmueble NUMERIC(18,2),
    moneda_id INT, --FK
    periodo_id INT, -- FK
    estado_id INT, -- FK
    fecha_finalizacion DATE,
    costo_publicacion NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Agente(
    id NUMERIC(19,0) IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    sucursal_id NUMERIC(18,0) , --FK
    apellido NVARCHAR(100),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(100),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Sucursal(
    id NUMERIC(18, 0) PRIMARY KEY,
    nombre NVARCHAR(100),
    direccion NVARCHAR(100),
    telefono NVARCHAR(100),
    localidad_id INT --FK
);

CREATE TABLE LOS_GDDS.Estado_anuncio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Operacion(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.Tipo_periodo(
  id INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(100)  
);

CREATE TABLE LOS_GDDS.Moneda(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

/* ------------------------------------------ UBICACION ------------------------------------------ */

CREATE TABLE LOS_GDDS.Provincia(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Localidad(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    provincia_id INT --FK
);

CREATE TABLE LOS_GDDS.Barrio(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    localidad_id INT -- FK
);

/* ------------------------------------------ ALQUILER ------------------------------------------ */

CREATE TABLE LOS_GDDS.Alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    anuncio_id NUMERIC(18,0), -- FK
    inquilino_id INT, -- FK
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    importe NUMERIC(18,2),  
    cantidad_periodos NUMERIC(18,0),
    comision NUMERIC(18,2),
    gastos_averiguaciones NUMERIC(18,2),
    estado_id INT, --FK
    deposito NUMERIC(18,2)
);

CREATE TABLE LOS_GDDS.Pago_alquiler(
    id NUMERIC(18,0) PRIMARY KEY,
    alquiler_id NUMERIC(18,0), -- FK
    fecha DATETIME,
    num_periodo INT,    
    descripcion_periodo NVARCHAR(100),
    fecha_inicio_periodo DATETIME,
    fecha_fin_periodo DATETIME,
    importe NUMERIC(18,2),
    medio_pago_id INT --FK
);

CREATE TABLE LOS_GDDS.Inquilino(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100),
    apellido NVARCHAR(20),
    dni NUMERIC(18,0),
    fecha_registro DATETIME,
    telefono NUMERIC(18,0),
    mail NVARCHAR(255),
    fecha_nacimiento DATETIME
);

CREATE TABLE LOS_GDDS.Estado_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);

CREATE TABLE LOS_GDDS.Detalle_alquiler(
    id INT IDENTITY(1,1) PRIMARY KEY,
    periodo_inicio NUMERIC(18,0),
    periodo_fin NUMERIC(18,0),
    precio NUMERIC(18,2),
    alquiler_id NUMERIC(18,0) NULL --FK
);

CREATE TABLE LOS_GDDS.Medio_pago(
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(100)
);


/* ------------------------------------------ FOREIGN KEYS ------------------------------------------ */

-- Anuncio
ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_agente
FOREIGN KEY (agente_id) REFERENCES LOS_GDDS.Agente(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.Inmueble(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_periodo
FOREIGN KEY (periodo_id) REFERENCES LOS_GDDS.Tipo_periodo(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_anuncio(id)
GO

ALTER TABLE LOS_GDDS.Anuncio 
ADD CONSTRAINT FK_anuncio_operacion
FOREIGN KEY (operacion_id) REFERENCES LOS_GDDS.Operacion(id)
GO

-- Inmueble
ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.Tipo_inmueble(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_propietario
FOREIGN KEY (propietario_id) REFERENCES LOS_GDDS.Propietario(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_barrio
FOREIGN KEY (barrio_id) REFERENCES LOS_GDDS.Barrio(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_disposicion
FOREIGN KEY (disposicion_id) REFERENCES LOS_GDDS.Disposicion(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_inmueble(id)
GO


ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_orientacion
FOREIGN KEY (orientacion_id) REFERENCES LOS_GDDS.Orientacion(id)
GO

ALTER TABLE LOS_GDDS.Inmueble
ADD CONSTRAINT FK_inmueble_ambiente
FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.Ambiente(id)
GO

-- Venta
ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.Anuncio(id)
GO

ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_comprador
FOREIGN KEY (comprador_id) REFERENCES LOS_GDDS.Comprador(id)
GO

ALTER TABLE LOS_GDDS.Venta 
ADD CONSTRAINT FK_venta_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Pago_venta
ADD CONSTRAINT FK_PagoVenta_venta
FOREIGN KEY (venta_id) REFERENCES LOS_GDDS.Venta(id)
GO

-- Pago_venta
ALTER TABLE LOS_GDDS.Pago_venta 
ADD CONSTRAINT FK_pago_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.Moneda(id)
GO

ALTER TABLE LOS_GDDS.Pago_venta 
ADD CONSTRAINT FK_pago_medio
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.Medio_pago(id)
GO

-- Ubicacion

ALTER TABLE LOS_GDDS.Localidad 
ADD CONSTRAINT FK_localidad_provincia
FOREIGN KEY (provincia_id) REFERENCES LOS_GDDS.Provincia(id)
GO

-- Alquiler
ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.Anuncio(id)
GO

ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_inquilino
FOREIGN KEY (inquilino_id) REFERENCES LOS_GDDS.Inquilino(id)
GO

ALTER TABLE LOS_GDDS.Alquiler 
ADD CONSTRAINT FK_alquiler_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.Estado_anuncio(id)
GO

-- Pago Alquiler
ALTER TABLE LOS_GDDS.Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.Alquiler(id)
GO

ALTER TABLE LOS_GDDS.Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_medioPago
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.Medio_pago(id)
GO

-- Detalle Alquiler
ALTER TABLE LOS_GDDS.Detalle_alquiler
ADD CONSTRAINT FK_detalleAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.Alquiler(id)

-- Agente
ALTER TABLE LOS_GDDS.Agente
ADD CONSTRAINT FK_agente_sucursal
FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.Sucursal(id)
GO


-- Sucursal
ALTER TABLE LOS_GDDS.Sucursal
ADD CONSTRAINT FK_sucursal_provincia
FOREIGN KEY (localidad_id) REFERENCES LOS_GDDS.Localidad(id)
GO

-- Caracteristica Inmueble
ALTER TABLE LOS_GDDS.Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES LOS_GDDS.Caracteristica(id)
GO

ALTER TABLE LOS_GDDS.Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.Inmueble(id)
GO


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

/* ------------- EJECUCION DE PROCEDURES ---------------- */

EXEC LOS_GDDS.MIGRAR_Provincia ---OK
EXEC LOS_GDDS.MIGRAR_Localidad--OK
EXEC LOS_GDDS.MIGRAR_Barrio--CHEQUEAR

EXEC LOS_GDDS.MIGRAR_PROPIETARIO ---OK

EXEC LOS_GDDS.MIGRAR_Sucursal---OK

EXEC LOS_GDDS.MIGRAR_Agente---OK

EXEC LOS_GDDS.MIGRAR_Disposicion ---OK
EXEC LOS_GDDS.MIGRAR_EstadoInmueble---OK
EXEC LOS_GDDS.MIGRAR_TipoInmueble --OK
EXEC LOS_GDDS.MIGRAR_Orientacion --OK


EXEC LOS_GDDS.MIGRAR_Ambiente-- OK
EXEC LOS_GDDS.MIGRAR_Inmueble -- OK
EXEC LOS_GDDS.MIGRAR_Caracteristica-- OK
EXEC LOS_GDDS.MIGRAR_CaracteristicaInmueble --OK



EXEC LOS_GDDS.MIGRAR_EstadoAnuncio---OK


EXEC LOS_GDDS.MIGRAR_Operacion---OK
EXEC LOS_GDDS.MIGRAR_TipoPeriodo---OK
EXEC LOS_GDDS.MIGRAR_Moneda---OK
EXEC LOS_GDDS.MIGRAR_MedioPago---OK

EXEC LOS_GDDS.MIGRAR_Inquilino---OK
EXEC LOS_GDDS.MIGRAR_EstadoAlquiler---OK

EXEC LOS_GDDS.MIGRAR_Anuncio --OK
EXEC LOS_GDDS.MIGRAR_Alquiler --OK

EXEC LOS_GDDS.MIGRAR_DetalleAlquiler -- OK
EXEC LOS_GDDS.MIGRAR_PagoAlquiler --OK

EXEC LOS_GDDS.MIGRAR_Comprador  
EXEC LOS_GDDS.MIGRAR_Venta --OK
EXEC LOS_GDDS.MIGRAR_PagoVenta -- OK