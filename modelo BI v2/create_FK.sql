-- FK_Venta_Tiempo
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Venta_TipoInmueble
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_TipoInmueble FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id);
GO

-- FK_Venta_Sucursal
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Venta_Ubicacion
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Venta_TipoMoneda
ALTER TABLE LOS_GDDS.BI_Venta
    ADD CONSTRAINT FK_Venta_TipoMoneda FOREIGN KEY (tipo_moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id);
GO


-- FK_Alquiler_Tiempo
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Alquiler_RangoEtarioInquilino
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_RangoEtarioInquilino FOREIGN KEY (rango_etario_inquilino_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Alquiler_RangoEtarioEmpleado
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_RangoEtarioEmpleado FOREIGN KEY (rango_etario_empleado_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Alquiler_Ubicacion
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Alquiler_TipoOperacion
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_TipoOperacion FOREIGN KEY (tipo_operacion_id) REFERENCES LOS_GDDS.BI_Tipo_Operacion(id);
GO

-- FK_Alquiler_Sucursal
ALTER TABLE LOS_GDDS.BI_Alquiler
    ADD CONSTRAINT FK_Alquiler_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Anuncio_TipoOperacion
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoOperacion FOREIGN KEY (tipo_operacion_id) REFERENCES LOS_GDDS.BI_Tipo_Operacion(id);
GO

-- FK_Anuncio_Ubicacion
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Ubicacion FOREIGN KEY (ubicación_id) REFERENCES LOS_GDDS.BI_Ubicacion(id);
GO

-- FK_Anuncio_Ambiente
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Ambiente FOREIGN KEY (ambiente_id) REFERENCES LOS_GDDS.BI_Ambiente(id);
GO

-- FK_Anuncio_Tiempo
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO

-- FK_Anuncio_TipoInmueble
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoInmueble FOREIGN KEY (tipo_inmueble_id) REFERENCES LOS_GDDS.BI_Tipo_inmueble(id);
GO

-- FK_Anuncio_TipoMoneda
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_TipoMoneda FOREIGN KEY (tipo_moneda_id) REFERENCES LOS_GDDS.BI_Tipo_Moneda(id);
GO

-- FK_Anuncio_RangoEtarioEmpleado
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_RangoEtarioEmpleado FOREIGN KEY (rango_etario_empleado_id) REFERENCES LOS_GDDS.BI_RANGO_ETARIO(RANGO_ETARIO_ID);
GO

-- FK_Anuncio_Sucursal
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_Sucursal FOREIGN KEY (sucursal_id) REFERENCES LOS_GDDS.BI_Sucursal(id);
GO

-- FK_Anuncio_RangoM2
ALTER TABLE LOS_GDDS.BI_Anuncio
    ADD CONSTRAINT FK_Anuncio_RangoM2 FOREIGN KEY (rango_m2_id) REFERENCES LOS_GDDS.BI_RANGO_M2(RANGO_M2_ID);
GO

-- FK_PagoAlquiler_Tiempo
ALTER TABLE LOS_GDDS.BI_PagoAlquiler
    ADD CONSTRAINT FK_PagoAlquiler_Tiempo FOREIGN KEY (tiempo_id) REFERENCES LOS_GDDS.BI_Tiempo(id);
GO
