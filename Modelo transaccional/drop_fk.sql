/* ------------------------------------------ DROP DE FKS ------------------------------------------ */

IF OBJECT_ID ('LOS_GDD.FK_ANUNCIO_INMUEBLE', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.ANUNCIO DROP CONSTRAINT FK_ANUNCIO_INMUEBLE
GO   

IF OBJECT_ID ('LOS_GDD.FK_anuncio_agente', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.ANUNCIO DROP CONSTRAINT FK_anuncio_agente
GO

IF OBJECT_ID ('LOS_GDD.FK_anuncio_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.ANUNCIO DROP CONSTRAINT FK_anuncio_moneda
GO   

IF OBJECT_ID ('LOS_GDD.FK_anuncio_periodo', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.ANUNCIO DROP CONSTRAINT FK_anuncio_periodo
GO   

IF OBJECT_ID ('LOS_GDD.FK_anuncio_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.ANUNCIO DROP CONSTRAINT FK_anuncio_estado
GO 

IF OBJECT_ID ('LOS_GDD.FK_inmueble_tipo', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_tipo
GO 

IF OBJECT_ID ('LOS_GDD.FK_inmueble_propietario', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_propietario
GO 

IF OBJECT_ID ('LOS_GDD.FK_inmueble_barrio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_barrio
GO 


IF OBJECT_ID ('LOS_GDD.FK_inmueble_disposicion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_disposicion
GO 

IF OBJECT_ID ('LOS_GDD.FK_inmueble_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_estado
GO 

IF OBJECT_ID ('LOS_GDD.FK_inmueble_orientacion', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble DROP CONSTRAINT FK_inmueble_orientacion
GO 

IF OBJECT_ID ('LOS_GDD.FK_venta_anuncio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.Venta DROP CONSTRAINT FK_venta_anuncio
GO 

IF OBJECT_ID ('LOS_GDD.FK_venta_comprador', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.Venta DROP CONSTRAINT FK_venta_comprador
GO

IF OBJECT_ID ('LOS_GDD.FK_venta_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.Venta DROP CONSTRAINT FK_venta_moneda
GO

IF OBJECT_ID ('LOS_GDD.FK_venta_pago', 'F') IS NOT NULL
    ALTER TABLE LOS_GDDS.Venta DROP CONSTRAINT FK_venta_pago
GO


IF OBJECT_ID ('LOS_GDD.FK_pago_moneda', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Pago_venta DROP CONSTRAINT FK_pago_moneda
GO  



IF OBJECT_ID ('LOS_GDD.FK_pago_medio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Pago_venta DROP CONSTRAINT FK_pago_medio
GO  



IF OBJECT_ID ('LOS_GDD.FK_localidad_provincia', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Localidad DROP CONSTRAINT FK_localidad_provincia
GO  

IF OBJECT_ID ('LOS_GDD.FK_alquiler_anuncio', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Alquiler DROP CONSTRAINT FK_alquiler_anuncio
GO  

IF OBJECT_ID ('LOS_GDD.FK_alquiler_inquilino', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Alquiler DROP CONSTRAINT FK_alquiler_inquilino
GO  


IF OBJECT_ID ('LOS_GDD.FK_alquiler_estado', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Alquiler DROP CONSTRAINT FK_alquiler_estado
GO  

IF OBJECT_ID ('LOS_GDD.FK_pagoAlquiler_alquiler', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Pago_alquiler DROP CONSTRAINT FK_pagoAlquiler_alquiler
GO  


IF OBJECT_ID ('LOS_GDD.FK_pagoAlquiler_medioPago', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Pago_alquiler DROP CONSTRAINT FK_pagoAlquiler_medioPago
GO  



IF OBJECT_ID ('LOS_GDD.FK_detalleAlquiler_alquiler', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Detalle_alquiler DROP CONSTRAINT FK_detalleAlquiler_alquiler
GO  


IF OBJECT_ID ('LOS_GDD.FK_agente_sucursal', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Agente DROP CONSTRAINT FK_agente_sucursal
GO  


IF OBJECT_ID ('LOS_GDD.FK_sucursal_provincia', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Sucursal DROP CONSTRAINT FK_sucursal_provincia
GO  


IF OBJECT_ID ('LOS_GDD.FK_caracteristicaInmueble_caracteristica', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Caracteristica_inmueble DROP CONSTRAINT FK_caracteristicaInmueble_caracteristica
GO   

IF OBJECT_ID ('LOS_GDD.FK_caracteristicaInmueble_inmueble', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Caracteristica_inmueble DROP CONSTRAINT FK_caracteristicaInmueble_inmueble
GO   

IF OBJECT_ID ('LOS_GDD.FK_inmuebleAmbiente_inmueble', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble_Ambiente DROP CONSTRAINT FK_inmuebleAmbiente_inmueble
GO   

IF OBJECT_ID ('LOS_GDD.FK_inmuebleAmbiente_ambiente', 'F') IS NOT NULL
    ALTER TABLE LOS_GDD.Inmueble_Ambiente DROP CONSTRAINT FK_inmuebleAmbiente_ambiente
GO   