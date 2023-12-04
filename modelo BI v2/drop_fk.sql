/* ------------------------------------------ DROP DE FKS ------------------------------------------ */

IF OBJECT_ID ('LOS_GDDS.BI_Venta_tiempo_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT BI_Venta_tiempo_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Venta_tipo_inmueble_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT BI_Venta_tipo_inmueble_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Venta_sucursal_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT BI_Venta_sucursal_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Venta_ubicacion_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT BI_Venta_ubicacion_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Venta_tipo_moneda_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT BI_Venta_tipo_moneda_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_tiempo_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_tiempo_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_rango_etario_inquilino_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_rango_etario_inquilino_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_rango_etario_empleado_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_rango_etario_empleado_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_ubicacion_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_ubicacion_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_tipo_operacion_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_tipo_operacion_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Alquiler_sucursal_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Alquiler DROP CONSTRAINT BI_Alquiler_sucursal_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_tipo_operacion_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_tipo_operacion_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_ubicacion_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_ubicacion_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_ambiente_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_ambiente_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_tiempo_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_tiempo_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_tipo_inmueble_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_tipo_inmueble_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_tipo_moneda_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_tipo_moneda_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_rango_etario_empleado_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_rango_etario_empleado_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_sucursal_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_sucursal_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_Anuncio_rango_m2_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Anuncio DROP CONSTRAINT BI_Anuncio_rango_m2_fk;
    
IF OBJECT_ID ('LOS_GDDS.BI_PagoAlquiler_tiempo_fk', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_PagoAlquiler DROP CONSTRAINT BI_PagoAlquiler_tiempo_fk;
