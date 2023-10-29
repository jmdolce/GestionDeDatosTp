/* ------------------------------------------ DROP DE TABLAS ------------------------------------------ */

-- Al veces tira error al principio. Ejecutar varias veces hasta que no tire mas errores

-- Drop tables with no dependencies

IF OBJECT_ID('LOS_GDDS.Pago_venta', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Pago_venta;
GO

IF OBJECT_ID('LOS_GDDS.Venta', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Venta;
GO

IF OBJECT_ID('LOS_GDDS.Detalle_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Detalle_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.Pago_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Pago_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.Alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Alquiler;
GO

IF OBJECT_ID('LOS_GDDS.Comprador', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Comprador;
GO

IF OBJECT_ID('LOS_GDDS.Inquilino', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Inquilino;
GO

IF OBJECT_ID('LOS_GDDS.Agente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Agente;
GO

IF OBJECT_ID('LOS_GDDS.Sucursal', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Sucursal;
GO

IF OBJECT_ID('LOS_GDDS.Provincia', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Provincia;
GO

IF OBJECT_ID('LOS_GDDS.Localidad', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Localidad;
GO

IF OBJECT_ID('LOS_GDDS.Barrio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Barrio;
GO

IF OBJECT_ID('LOS_GDDS.Propietario', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Propietario;
GO

IF OBJECT_ID('LOS_GDDS.Disposicion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Disposicion;
GO

IF OBJECT_ID('LOS_GDDS.Estado_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Estado_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Orientacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Orientacion;
GO

IF OBJECT_ID('LOS_GDDS.Caracteristica', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Caracteristica;
GO

IF OBJECT_ID('LOS_GDDS.Ambiente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Ambiente;
GO

IF OBJECT_ID('LOS_GDDS.Tipo_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Tipo_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Operacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Operacion;
GO

IF OBJECT_ID('LOS_GDDS.Tipo_periodo', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Tipo_periodo;
GO

IF OBJECT_ID('LOS_GDDS.Moneda', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Moneda;
GO

IF OBJECT_ID('LOS_GDDS.Estado_anuncio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Estado_anuncio;
GO

-- Drop tables with dependencies in the correct order

IF OBJECT_ID('LOS_GDDS.Inmueble_Ambiente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Inmueble_Ambiente;
GO

IF OBJECT_ID('LOS_GDDS.Caracteristica_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Caracteristica_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Anuncio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Anuncio;
GO

-- Finally, drop remaining tables

IF OBJECT_ID('LOS_GDDS.Tipo_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Tipo_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Estado_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Estado_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.Estado_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Estado_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.Medio_pago', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Medio_pago;
GO


IF OBJECT_ID('LOS_GDDS.Disposicion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Disposicion;
GO

IF OBJECT_ID('LOS_GDDS.Orientacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Orientacion;
GO

IF OBJECT_ID('LOS_GDDS.Caracteristica', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.Caracteristica;
GO


-- Verify that all tables are dropped!

IF OBJECT_ID('LOS_GDDS.Pago_venta', 'U') IS NULL
    PRINT 'LOS_GDDS.Pago_venta dropped';

IF OBJECT_ID('LOS_GDDS.Venta', 'U') IS NULL
    PRINT 'LOS_GDDS.Venta dropped';

IF OBJECT_ID('LOS_GDDS.Detalle_alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.Detalle_alquiler dropped';

IF OBJECT_ID('LOS_GDDS.Pago_alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.Pago_alquiler dropped';

IF OBJECT_ID('LOS_GDDS.Alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.Alquiler dropped';

IF OBJECT_ID('LOS_GDDS.Comprador', 'U') IS NULL
    PRINT 'LOS_GDDS.Comprador dropped';

IF OBJECT_ID('LOS_GDDS.Inquilino', 'U') IS NULL
    PRINT 'LOS_GDDS.Inquilino dropped';

IF OBJECT_ID('LOS_GDDS.Agente', 'U') IS NULL
    PRINT 'LOS_GDDS.Agente dropped';

IF OBJECT_ID('LOS_GDDS.Sucursal', 'U') IS NULL
    PRINT 'LOS_GDDS.Sucursal dropped';

IF OBJECT_ID('LOS_GDDS.Provincia', 'U') IS NULL
    PRINT 'LOS_GDDS.Provincia dropped';

IF OBJECT_ID('LOS_GDDS.Localidad', 'U') IS NULL
    PRINT 'LOS_GDDS.Localidad dropped';

IF OBJECT_ID('LOS_GDDS.Barrio', 'U') IS NULL
    PRINT 'LOS_GDDS.Barrio dropped';

IF OBJECT_ID('LOS_GDDS.Propietario', 'U') IS NULL
    PRINT 'LOS_GDDS.Propietario dropped';

IF OBJECT_ID('LOS_GDDS.Disposicion', 'U') IS NULL
    PRINT 'LOS_GDDS.Disposicion dropped';

IF OBJECT_ID('LOS_GDDS.Estado_inmueble', 'U') IS NULL
    PRINT 'LOS_GDDS.Estado_inmueble dropped';

IF OBJECT_ID('LOS_GDDS.Orientacion', 'U') IS NULL
    PRINT 'LOS_GDDS.Orientacion dropped';

IF OBJECT_ID('LOS_GDDS.Caracteristica', 'U') IS NULL
    PRINT 'LOS_GDDS.Caracteristica dropped';

IF OBJECT_ID('LOS_GDDS.Ambiente', 'U') IS NULL
    PRINT 'LOS_GDDS.Ambiente dropped';

IF OBJECT_ID('LOS_GDDS.Tipo_inmueble', 'U') IS NULL
    PRINT 'LOS_GDDS.Tipo_inmueble dropped';

IF OBJECT_ID('LOS_GDDS.Operacion', 'U') IS NULL
    PRINT 'LOS_GDDS.Operacion dropped';

IF OBJECT_ID('LOS_GDDS.Tipo_periodo', 'U') IS NULL
    PRINT 'LOS_GDDS.Tipo_periodo dropped';

IF OBJECT_ID('LOS_GDDS.Moneda', 'U') IS NULL
    PRINT 'LOS_GDDS.Moneda dropped';

IF OBJECT_ID('LOS_GDDS.Estado_anuncio', 'U') IS NULL
    PRINT 'LOS_GDDS.Estado_anuncio dropped';

PRINT 'All tables dropped successfully.';
