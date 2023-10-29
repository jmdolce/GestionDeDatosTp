/* ------------- EJECUCION DE PROCEDURES ---------------- */

EXEC LOS_GDDS.MIGRAR_Provincia ---OK
EXEC LOS_GDDS.MIGRAR_Localidad--OK
EXEC LOS_GDDS.MIGRAR_Barrio--CHEQUEAR


EXEC LOS_GDDS.MIGRAR_Sucursal---OK

EXEC LOS_GDDS.MIGRAR_Agente---OK

EXEC LOS_GDDS.MIGRAR_Disposicion ---OK
EXEC LOS_GDDS.MIGRAR_EstadoInmueble---OK
EXEC LOS_GDDS.MIGRAR_TipoInmueble --OK
EXEC LOS_GDDS.MIGRAR_Orientacion --OK


--- ACA LA DE CARACTERISTICA
--- ACA LA DE AMBIENTE


EXEC LOS_GDDS.MIGRAR_PROPIETARIO ---OK
EXEC LOS_GDDS.MIGRAR_Inmueble---
EXEC LOS_GDDS.MIGRAR_EstadoAnuncio---OK


EXEC LOS_GDDS.MIGRAR_Operacion---OK
EXEC LOS_GDDS.MIGRAR_TipoPeriodo---OK
EXEC LOS_GDDS.MIGRAR_Moneda---OK
EXEC LOS_GDDS.MIGRAR_MedioPago---OK


EXEC LOS_GDDS.MIGRAR_PagoVenta---OK
EXEC LOS_GDD.MIGRAR_Comprador  ---OK

EXEC LOS_GDDS.MIGRAR_Inquilino---OK
EXEC LOS_GDDS.MIGRAR_EstadoAlquiler---OK


-- Primero hacer alquiler 

--EXEC LOS_GDDS.MIGRAR_DetalleAlquiler
--EXEC LOS_GDDS.MIGRAR_PagoAlquiler


--- ACA ANUNCIO
--- ACA ALQUILER
--- ACA VENTA


--- ACA INMUEBLE




SELECT * from LOS_GDDS.Provincia
SELECT * from LOS_GDDS.Localidad
SELECT * from LOS_GDDS.Barrio
SELECT * from LOS_GDDS.Sucursal

SELECT * from LOS_GDDS.Agente



SELECT * from LOS_GDDS.Propietario
SELECT * from LOS_GDDS.Comprador
SELECT * from LOS_GDDS.Disposicion

SELECT * from LOS_GDDS.Tipo_inmueble

SELECT * from LOS_GDDS.Estado_inmueble
SELECT * from LOS_GDDS.Orientacion

SELECT * from LOS_GDDS.Estado_anuncio


SELECT * from LOS_GDDS.Operacion
SELECT * from LOS_GDDS.Tipo_periodo
SELECT * from LOS_GDDS.Moneda
SELECT * from LOS_GDDS.Medio_pago


SELECT * from LOS_GDDS.Pago_venta
SELECT * from LOS_GDDS.Detalle_alquiler

SELECT * from LOS_GDDS.Inquilino
SELECT * from LOS_GDDS.Estado_alquiler




SELECT * from gd_esquema.Maestra

