/* ------------------------------------------ DROP DE TABLAS ------------------------------------------ */

IF OBJECT_ID('LOS_GDDS.BI_Ubicacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Ubicacion;

IF OBJECT_ID('LOS_GDDS.BI_Venta', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Venta;
    
IF OBJECT_ID('LOS_GDDS.BI_Alquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Alquiler;
    
IF OBJECT_ID('LOS_GDDS.BI_Anuncio', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Anuncio;
    
IF OBJECT_ID('LOS_GDDS.BI_PagoAlquiler', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_PagoAlquiler;
    
IF OBJECT_ID('LOS_GDDS.BI_Tiempo', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tiempo;
    
IF OBJECT_ID('LOS_GDDS.BI_RANGO_ETARIO', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_RANGO_ETARIO;
    
IF OBJECT_ID('LOS_GDDS.BI_RANGO_M2', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_RANGO_M2;
    
IF OBJECT_ID('LOS_GDDS.BI_Tipo_inmueble', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_inmueble;
    
IF OBJECT_ID('LOS_GDDS.BI_Ambiente', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Ambiente;
    
IF OBJECT_ID('LOS_GDDS.BI_Tipo_Operacion', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_Operacion;
    
IF OBJECT_ID('LOS_GDDS.BI_Tipo_Moneda', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Tipo_Moneda;
    
IF OBJECT_ID('LOS_GDDS.BI_Sucursal', 'U') IS NOT NULL
    DROP TABLE LOS_GDDS.BI_Sucursal;
