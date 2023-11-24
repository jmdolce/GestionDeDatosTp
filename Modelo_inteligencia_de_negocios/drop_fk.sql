/* ------------------------------------------ DROP DE FKS ------------------------------------------ */

IF OBJECT_ID ('LOS_GDD.FK_BI_ANUNCIO_INMUEBLE', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_ANUNCIO_INMUEBLE
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_anuncio_agente', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_anuncio_agente
GO

IF OBJECT_ID ('LOS_GDD.FK_BI_anuncio_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_anuncio_moneda
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_anuncio_periodo', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_anuncio_periodo
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_anuncio_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_anuncio_estado
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_anuncio_operacion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_ANUNCIO DROP CONSTRAINT FK_BI_anuncio_operacion
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_tipo', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_tipo
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_propietario', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_propietario
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_ubicacion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_ubicacion
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_disposicion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_disposicion
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_estado
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_inmueble_orientacion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble DROP CONSTRAINT FK_BI_inmueble_orientacion
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_venta_anuncio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT FK_BI_venta_anuncio
GO 

IF OBJECT_ID ('LOS_GDD.FK_BI_venta_comprador', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT FK_BI_venta_comprador
GO

IF OBJECT_ID ('LOS_GDD.FK_BI_venta_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT FK_BI_venta_moneda
GO

IF OBJECT_ID ('LOS_GDD.FK_BI_venta_pago', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.BI_Venta DROP CONSTRAINT FK_BI_venta_pago
GO


IF OBJECT_ID ('LOS_GDD.FK_BI_pago_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Pago_venta DROP CONSTRAINT FK_BI_pago_moneda
GO  



IF OBJECT_ID ('LOS_GDD.FK_BI_pago_medio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Pago_venta DROP CONSTRAINT FK_BI_pago_medio
GO  

IF OBJECT_ID ('LOS_GDD.FK_BI_alquiler_anuncio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Alquiler DROP CONSTRAINT FK_BI_alquiler_anuncio
GO  

IF OBJECT_ID ('LOS_GDD.FK_BI_alquiler_inquilino', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Alquiler DROP CONSTRAINT FK_BI_alquiler_inquilino
GO  


IF OBJECT_ID ('LOS_GDD.FK_BI_alquiler_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Alquiler DROP CONSTRAINT FK_BI_alquiler_estado
GO  

IF OBJECT_ID ('LOS_GDD.FK_BI_pagoAlquiler_alquiler', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Pago_alquiler DROP CONSTRAINT FK_BI_pagoAlquiler_alquiler
GO  


IF OBJECT_ID ('LOS_GDD.FK_BI_pagoAlquiler_medioPago', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Pago_alquiler DROP CONSTRAINT FK_BI_pagoAlquiler_medioPago
GO  



IF OBJECT_ID ('LOS_GDD.FK_BI_detalleAlquiler_alquiler', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Detalle_alquiler DROP CONSTRAINT FK_BI_detalleAlquiler_alquiler
GO  


IF OBJECT_ID ('LOS_GDD.FK_BI_agente_sucursal', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Agente DROP CONSTRAINT FK_BI_agente_sucursal
GO  


IF OBJECT_ID ('LOS_GDD.FK_BI_sucursal_ubicacion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Sucursal DROP CONSTRAINT FK_BI_sucursal_ubicacion
GO  


IF OBJECT_ID ('LOS_GDD.FK_BI_caracteristicaInmueble_caracteristica', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Caracteristica_inmueble DROP CONSTRAINT FK_BI_caracteristicaInmueble_caracteristica
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_caracteristicaInmueble_inmueble', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Caracteristica_inmueble DROP CONSTRAINT FK_BI_caracteristicaInmueble_inmueble
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_inmuebleAmbiente_inmueble', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble_Ambiente DROP CONSTRAINT FK_BI_inmuebleAmbiente_inmueble
GO   

IF OBJECT_ID ('LOS_GDD.FK_BI_inmuebleAmbiente_ambiente', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.BI_Inmueble_Ambiente DROP CONSTRAINT FK_BI_inmuebleAmbiente_ambiente
GO   