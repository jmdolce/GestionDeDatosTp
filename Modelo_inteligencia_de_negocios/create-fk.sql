
-- /* ------------------------------------------ FOREIGN KEYS ------------------------------------------ */

-- Anuncio
ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_agente
FOREIGN KEY (agente_id) REFERENCES LOS_GDDS.BI_Agente(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_periodo
FOREIGN KEY (periodo_id) REFERENCES LOS_GDDS.BI_Tipo_periodo(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_rangoEtario
FOREIGN KEY (rango_etario_agente_id) REFERENCES LOS_GDDS.BI_rango_etario(rango_etario_id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_rangoM2
FOREIGN KEY (rango_m2_id) REFERENCES LOS_GDDS.BI_RANGO_M2(rango_m2_id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_operacion
FOREIGN KEY (operacion_id) REFERENCES LOS_GDDS.BI_Tipo_Operacion(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_BI_anuncio_tiempo
FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id)
GO

-- Inmueble
ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_propietario
FOREIGN KEY (propietario_id) REFERENCES LOS_GDDS.BI_Propietario(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_ubicacion
FOREIGN KEY (ubicacion_id) REFERENCES LOS_GDDS.BI_Ubicacion(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_disposicion
FOREIGN KEY (disposicion_id) REFERENCES LOS_GDDS.BI_Disposicion(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_inmueble(id)
GO


ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_BI_inmueble_orientacion
FOREIGN KEY (orientacion_id) REFERENCES LOS_GDDS.BI_Orientacion(id)
GO

-- Venta
ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_BI_venta_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.BI_Anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_BI_venta_comprador
FOREIGN KEY (comprador_id) REFERENCES LOS_GDDS.BI_Comprador(id)
GO

ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_BI_venta_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_venta
ADD CONSTRAINT FK_BI_PagoVenta_venta
FOREIGN KEY (venta_id) REFERENCES LOS_GDDS.BI_Venta(id)
GO

-- Pago_venta
ALTER TABLE LOS_GDDS.BI_Pago_venta 
ADD CONSTRAINT FK_BI_pago_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_venta 
ADD CONSTRAINT FK_BI_pago_medio
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.BI_Medio_pago(id)
GO


-- Alquiler
ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_BI_alquiler_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.BI_Anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_BI_alquiler_inquilino
FOREIGN KEY (inquilino_id) REFERENCES LOS_GDDS.BI_Inquilino(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_BI_alquiler_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_BI_alquiler_rangoEtario
FOREIGN KEY (rango_etario_inquilino_id) REFERENCES LOS_GDDS.BI_rango_etario(rango_etario_id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler
ADD CONSTRAINT FK_BI_alquiler_tiempo
FOREIGN KEY (tiempo_inicio_id) REFERENCES LOS_GDDS.BI_Tiempo(id)
GO

-- Pago Alquiler
ALTER TABLE LOS_GDDS.BI_Pago_alquiler
ADD CONSTRAINT FK_BI_pagoAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.BI_Alquiler(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_alquiler
ADD CONSTRAINT FK_BI_pagoAlquiler_medioPago
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.BI_Medio_pago(id)
GO

-- Detalle Alquiler
ALTER TABLE LOS_GDDS.BI_Detalle_alquiler
ADD CONSTRAINT FK_BI_detalleAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.BI_Alquiler(id)

-- Agente
ALTER TABLE LOS_GDDS.BI_Agente
ADD CONSTRAINT FK_BI_agente_sucursal
FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id)
GO


-- Sucursal
ALTER TABLE LOS_GDDS.BI_Sucursal
ADD CONSTRAINT FK_BI_sucursal_ubicacion
FOREIGN KEY (ubicacion_id) REFERENCES LOS_GDDS.BI_Ubicacion(id)
GO

-- Caracteristica Inmueble
ALTER TABLE LOS_GDDS.BI_Caracteristica_inmueble
ADD CONSTRAINT FK_BI_caracteristicaInmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES LOS_GDDS.BI_Caracteristica(id)
GO

ALTER TABLE LOS_GDDS.BI_Caracteristica_inmueble
ADD CONSTRAINT FK_BI_caracteristicaInmueble_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

-- Inmueble_Ambiente
ALTER TABLE LOS_GDDS.BI_Inmueble_Ambiente
ADD CONSTRAINT FK_BI_inmuebleAmbiente_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble_Ambiente
ADD CONSTRAINT FK_BI_inmuebleAmbiente_ambiente
FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.BI_Ambiente(id)
GO