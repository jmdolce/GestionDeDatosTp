
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
