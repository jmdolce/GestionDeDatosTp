/* ------------------------------------------ DROP DE TABLAS ------------------------------------------ */

-- Al veces tira error al principio. Ejecutar varias veces hasta que no tire mas errores

-- Drop tables with no dependencies

IF OBJECT_ID('LOS_GDDS.BI_Ubicacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Ubicacion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Tiempo', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tiempo;
GO

IF OBJECT_ID('LOS_GDDS.BI_Pago_venta', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Pago_venta;
GO

IF OBJECT_ID('LOS_GDDS.BI_Venta', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Venta;
GO

IF OBJECT_ID('LOS_GDDS.BI_Detalle_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Detalle_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.BI_Pago_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Pago_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.BI_Rango_etario', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Rango_etario;
GO

IF OBJECT_ID('LOS_GDDS.BI_RANGO_M2', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_RANGO_M2;
GO

IF OBJECT_ID('LOS_GDDS.BI_Alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Alquiler;
GO

IF OBJECT_ID('LOS_GDDS.BI_Comprador', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Comprador;
GO

IF OBJECT_ID('LOS_GDDS.BI_Inquilino', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Inquilino;
GO

IF OBJECT_ID('LOS_GDDS.BI_Agente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Agente;
GO

IF OBJECT_ID('LOS_GDDS.BI_Sucursal', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Sucursal;
GO

IF OBJECT_ID('LOS_GDDS.BI_Provincia', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Provincia;
GO

IF OBJECT_ID('LOS_GDDS.BI_Localidad', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Localidad;
GO

IF OBJECT_ID('LOS_GDDS.BI_Barrio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Barrio;
GO

IF OBJECT_ID('LOS_GDDS.BI_Propietario', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Propietario;
GO

IF OBJECT_ID('LOS_GDDS.BI_Disposicion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Disposicion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Estado_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Estado_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Orientacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Orientacion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Caracteristica', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Caracteristica;
GO

IF OBJECT_ID('LOS_GDDS.BI_Ambiente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Ambiente;
GO

IF OBJECT_ID('LOS_GDDS.BI_Tipo_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Tipo_Operacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_Operacion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Tipo_periodo', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_periodo;
GO

IF OBJECT_ID('LOS_GDDS.BI_Tipo_Moneda', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_Moneda;
GO

IF OBJECT_ID('LOS_GDDS.BI_Estado_anuncio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Estado_anuncio;
GO

-- Drop tables with dependencies in the correct order

IF OBJECT_ID('LOS_GDDS.BI_Inmueble_Ambiente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Inmueble_Ambiente;
GO

IF OBJECT_ID('LOS_GDDS.BI_Caracteristica_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Caracteristica_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Anuncio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Anuncio;
GO

-- Finally, drop remaining tables

IF OBJECT_ID('LOS_GDDS.BI_Tipo_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Estado_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Estado_inmueble;
GO

IF OBJECT_ID('LOS_GDDS.BI_Estado_alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Estado_alquiler;
GO

IF OBJECT_ID('LOS_GDDS.BI_Medio_pago', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Medio_pago;
GO


IF OBJECT_ID('LOS_GDDS.BI_Disposicion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Disposicion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Orientacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Orientacion;
GO

IF OBJECT_ID('LOS_GDDS.BI_Caracteristica', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Caracteristica;
GO



-- Verify that all tables are dropped!

IF OBJECT_ID('LOS_GDDS.BI_Pago_venta', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Pago_venta dropped';

IF OBJECT_ID('LOS_GDDS.BI_Venta', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Venta dropped';

IF OBJECT_ID('LOS_GDDS.BI_Detalle_alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Detalle_alquiler dropped';

IF OBJECT_ID('LOS_GDDS.BI_Pago_alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Pago_alquiler dropped';

IF OBJECT_ID('LOS_GDDS.BI_Alquiler', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Alquiler dropped';

IF OBJECT_ID('LOS_GDDS.BI_Comprador', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Comprador dropped';

IF OBJECT_ID('LOS_GDDS.BI_Inquilino', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Inquilino dropped';

IF OBJECT_ID('LOS_GDDS.BI_Agente', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Agente dropped';

IF OBJECT_ID('LOS_GDDS.BI_Sucursal', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Sucursal dropped';

IF OBJECT_ID('LOS_GDDS.BI_Provincia', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Provincia dropped';

IF OBJECT_ID('LOS_GDDS.BI_Localidad', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Localidad dropped';

IF OBJECT_ID('LOS_GDDS.BI_Barrio', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Barrio dropped';

IF OBJECT_ID('LOS_GDDS.BI_Propietario', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Propietario dropped';

IF OBJECT_ID('LOS_GDDS.BI_Disposicion', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Disposicion dropped';

IF OBJECT_ID('LOS_GDDS.BI_Estado_inmueble', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Estado_inmueble dropped';

IF OBJECT_ID('LOS_GDDS.BI_Orientacion', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Orientacion dropped';

IF OBJECT_ID('LOS_GDDS.BI_Caracteristica', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Caracteristica dropped';

IF OBJECT_ID('LOS_GDDS.BI_Ambiente', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Ambiente dropped';

IF OBJECT_ID('LOS_GDDS.BI_Tipo_inmueble', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Tipo_inmueble dropped';

IF OBJECT_ID('LOS_GDDS.BI_Tipo_Operacion', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Tipo_Operacion dropped';

IF OBJECT_ID('LOS_GDDS.BI_Tipo_periodo', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Tipo_periodo dropped';

IF OBJECT_ID('LOS_GDDS.BI_Tipo_Moneda', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Tipo_Moneda dropped';

IF OBJECT_ID('LOS_GDDS.BI_Estado_anuncio', 'U') IS NULL
    PRINT 'LOS_GDDS.BI_Estado_anuncio dropped';

PRINT 'All tables dropped successfully.';
