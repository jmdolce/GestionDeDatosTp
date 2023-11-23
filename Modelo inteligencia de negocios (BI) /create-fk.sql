
-- /* ------------------------------------------ FOREIGN KEYS ------------------------------------------ */

-- Anuncio
ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_agente
FOREIGN KEY (agente_id) REFERENCES LOS_GDDS.BI_Agente(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_periodo
FOREIGN KEY (periodo_id) REFERENCES LOS_GDDS.BI_Tipo_periodo(id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_rangoEtario
FOREIGN KEY (rango_etario_agente_id) REFERENCES LOS_GDDS.BI_rango_etario(rango_etario_id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_rangoM2
FOREIGN KEY (rango_m2_id) REFERENCES LOS_GDDS.BI_RANGO_M2(rango_m2_id)
GO

ALTER TABLE LOS_GDDS.BI_Anuncio 
ADD CONSTRAINT FK_anuncio_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_anuncio(id)
GO

-- Inmueble
ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_tipo
FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_propietario
FOREIGN KEY (propietario_id) REFERENCES LOS_GDDS.BI_Propietario(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_barrio
FOREIGN KEY (barrio_id) REFERENCES LOS_GDDS.BI_Barrio(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_disposicion
FOREIGN KEY (disposicion_id) REFERENCES LOS_GDDS.BI_Disposicion(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_inmueble(id)
GO


ALTER TABLE LOS_GDDS.BI_Inmueble
ADD CONSTRAINT FK_inmueble_orientacion
FOREIGN KEY (orientacion_id) REFERENCES LOS_GDDS.BI_Orientacion(id)
GO

-- Venta
ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_venta_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.BI_Anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_venta_comprador
FOREIGN KEY (comprador_id) REFERENCES LOS_GDDS.BI_Comprador(id)
GO

ALTER TABLE LOS_GDDS.BI_Venta 
ADD CONSTRAINT FK_venta_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_venta
ADD CONSTRAINT FK_PagoVenta_venta
FOREIGN KEY (venta_id) REFERENCES LOS_GDDS.BI_Venta(id)
GO

-- Pago_venta
ALTER TABLE LOS_GDDS.BI_Pago_venta 
ADD CONSTRAINT FK_pago_moneda
FOREIGN KEY (moneda_id) REFERENCES LOS_GDDS.BI_Moneda(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_venta 
ADD CONSTRAINT FK_pago_medio
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.BI_Medio_pago(id)
GO

-- Ubicacion

ALTER TABLE LOS_GDDS.BI_Localidad 
ADD CONSTRAINT FK_localidad_provincia
FOREIGN KEY (provincia_id) REFERENCES LOS_GDDS.BI_Provincia(id)
GO

-- Alquiler
ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_alquiler_anuncio
FOREIGN KEY (anuncio_id) REFERENCES LOS_GDDS.BI_Anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_alquiler_inquilino
FOREIGN KEY (inquilino_id) REFERENCES LOS_GDDS.BI_Inquilino(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_alquiler_estado
FOREIGN KEY (estado_id) REFERENCES LOS_GDDS.BI_Estado_anuncio(id)
GO

ALTER TABLE LOS_GDDS.BI_Alquiler 
ADD CONSTRAINT FK_alquiler_rangoEtario
FOREIGN KEY (rango_etario_inquilino_id) REFERENCES LOS_GDDS.BI_rango_etario(rango_etario_id)
GO

-- Pago Alquiler
ALTER TABLE LOS_GDDS.BI_Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.BI_Alquiler(id)
GO

ALTER TABLE LOS_GDDS.BI_Pago_alquiler
ADD CONSTRAINT FK_pagoAlquiler_medioPago
FOREIGN KEY (medio_pago_id) REFERENCES LOS_GDDS.BI_Medio_pago(id)
GO

-- Detalle Alquiler
ALTER TABLE LOS_GDDS.BI_Detalle_alquiler
ADD CONSTRAINT FK_detalleAlquiler_alquiler
FOREIGN KEY (alquiler_id) REFERENCES LOS_GDDS.BI_Alquiler(id)

-- Agente
ALTER TABLE LOS_GDDS.BI_Agente
ADD CONSTRAINT FK_agente_sucursal
FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id)
GO


-- Sucursal
ALTER TABLE LOS_GDDS.BI_Sucursal
ADD CONSTRAINT FK_sucursal_ubicacion
FOREIGN KEY (ubicacion_id) REFERENCES LOS_GDDS.BI_Ubicacion(id)
GO

-- Caracteristica Inmueble
ALTER TABLE LOS_GDDS.BI_Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_caracteristica
FOREIGN KEY (caracteristica_id) REFERENCES LOS_GDDS.BI_Caracteristica(id)
GO

ALTER TABLE LOS_GDDS.BI_Caracteristica_inmueble
ADD CONSTRAINT FK_caracteristicaInmueble_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

-- Inmueble_Ambiente
ALTER TABLE LOS_GDDS.BI_Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_inmueble
FOREIGN KEY (inmueble_id) REFERENCES LOS_GDDS.BI_Inmueble(id)
GO

ALTER TABLE LOS_GDDS.BI_Inmueble_Ambiente
ADD CONSTRAINT FK_inmuebleAmbiente_ambiente
FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.BI_Ambiente(id)
GO