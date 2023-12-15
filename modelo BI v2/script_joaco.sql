USE GD2C2023
GO

PRINT 'Iniciando creacion y migracion del modelo BI'


------------ CREACION DE LAS TABLAS DE DIMENSIONES -------------------------
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hechoAnuncio')
DROP TABLE TAN_BIONICOS.BI_hechoAnuncio
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hechoAlquiler')
DROP TABLE TAN_BIONICOS.BI_hechoAlquiler
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hechoVenta')
DROP TABLE TAN_BIONICOS.BI_hechoVenta
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_hechoPagoAlquiler')
DROP TABLE TAN_BIONICOS.BI_hechoPagoAlquiler
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_moneda')
DROP TABLE TAN_BIONICOS.BI_moneda
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_tipoOperacion')
DROP TABLE TAN_BIONICOS.BI_tipoOperacion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_rangoM2')
DROP TABLE TAN_BIONICOS.BI_rangoM2
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_ambientes')
DROP TABLE TAN_BIONICOS.BI_ambientes
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_tipoInmueble')
DROP TABLE TAN_BIONICOS.BI_tipoInmueble
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_rangoEtario')
DROP TABLE TAN_BIONICOS.BI_rangoEtario
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_ubicacion')
DROP TABLE TAN_BIONICOS.BI_ubicacion
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_sucursal')
DROP TABLE TAN_BIONICOS.BI_sucursal
IF EXISTS (SELECT name FROM sys.tables WHERE name = 'BI_tiempo')
DROP TABLE TAN_BIONICOS.BI_tiempo

------------- DIMENSIONES --------------------------

create table TAN_BIONICOS.BI_tiempo(
    id numeric(18, 0) IDENTITY PRIMARY KEY,
    anio numeric(4,0),
    cuatrimestre numeric(18,0),
    mes numeric(2,0), 
)

create table TAN_BIONICOS.BI_sucursal(
    id numeric(18, 0) PRIMARY KEY,
    nombre nvarchar(100),
)

create table TAN_BIONICOS.BI_ubicacion(
    id numeric(18, 0) IDENTITY PRIMARY KEY,
    provincia nvarchar(100),
    localidad nvarchar(100),
    barrio nvarchar(100),
)

create table TAN_BIONICOS.BI_rangoEtario(
    id numeric(18, 0) IDENTITY PRIMARY KEY,
    rango nvarchar(100)
)

create table TAN_BIONICOS.BI_tipoInmueble(
    id numeric(18, 0) PRIMARY KEY,
    tipo nvarchar(100)
)

create table TAN_BIONICOS.BI_ambientes(
    id numeric(18, 0) PRIMARY KEY,
    ambientes nvarchar(100)
)

create table TAN_BIONICOS.BI_rangoM2(
    id numeric(18, 0) IDENTITY PRIMARY KEY,
    rango nvarchar(100)
)

create table TAN_BIONICOS.BI_tipoOperacion(
    id numeric(18, 0) PRIMARY KEY,
    operacion nvarchar(100)
)

create table TAN_BIONICOS.BI_moneda(
    id numeric(18, 0) PRIMARY KEY,
    nombre nvarchar(100) 
)

------------------------ FUNCIONES -----------------------------------

IF OBJECT_ID('TAN_BIONICOS.cuatrimestre', 'FN') IS NOT NULL
    DROP FUNCTION TAN_BIONICOS.cuatrimestre;
GO
create function TAN_BIONICOS.cuatrimestre(@fecha datetime)
returns numeric(18,0)
AS
BEGIN
    return
    case
		WHEN Month(@fecha) BETWEEN 1 AND 4 THEN 1
		WHEN Month(@fecha) BETWEEN 5 AND 8 THEN 2
		WHEN Month(@fecha) BETWEEN 9 AND 12 THEN 3
	END
END
GO


IF OBJECT_ID('TAN_BIONICOS.rangoEtario', 'FN') IS NOT NULL
    DROP FUNCTION TAN_BIONICOS.rangoEtario;
GO
CREATE FUNCTION TAN_BIONICOS.rangoEtario (@fechaNacimiento DATE)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @edad INT
    DECLARE @rangoEtarioID NVARCHAR(100)
    SET @edad = DATEDIFF(YEAR, @fechaNacimiento, GETDATE())
    IF @edad <= 25
        SET @rangoEtarioID = '< 25'
    ELSE IF @edad <= 35
        SET @rangoEtarioID = '25 - 35'
    ELSE IF @edad <= 50
        SET @rangoEtarioID = '35 - 50';
    ELSE
        SET @rangoEtarioID = '> 50';
    RETURN @rangoEtarioID;
END;
GO


IF OBJECT_ID('TAN_BIONICOS.rangoM2', 'FN') IS NOT NULL
    DROP FUNCTION TAN_BIONICOS.rangoM2;
GO
create function TAN_BIONICOS.rangoM2(@m2 numeric(18, 2))
returns nvarchar(100)
AS
BEGIN
    return
    case
		WHEN @m2 < 35 THEN '< 35'
		WHEN @m2 BETWEEN 35 AND 55 THEN '35 - 55'
		WHEN @m2 BETWEEN 56 AND 75 THEN '55 - 75'
        WHEN @m2 BETWEEN 76 AND 100 THEN '75 - 100'
        WHEN @m2 >100 THEN '> 100'
	END
END
go



-------------------- HECHOS --------------------------------------

CREATE TABLE TAN_BIONICOS.BI_hechoAnuncio (
    tiempo numeric(18, 0) references TAN_BIONICOS.BI_tiempo, 
    ubicacion numeric(18, 0) references TAN_BIONICOS.BI_ubicacion, 
    rangoEtario numeric(18, 0) references TAN_BIONICOS.BI_rangoEtario, 
    ambientes numeric(18, 0) references TAN_BIONICOS.BI_ambientes,
    tipoInmueble numeric(18, 0) references TAN_BIONICOS.BI_tipoInmueble,
    sucursal numeric(18, 0) references TAN_BIONICOS.BI_sucursal,
    rangoM2 numeric(18, 0) references TAN_BIONICOS.BI_rangoM2,
    tipoOperacion numeric(18, 0) references TAN_BIONICOS.BI_tipoOperacion,
    moneda numeric(18, 0) references TAN_BIONICOS.BI_moneda,
    cantidadAnuncios numeric(18, 0),
    totalTiempoPublicado numeric(18, 0),
    cantidadOperacionesConcretadas numeric(18, 0),
    precioTotal numeric(18, 0),
    totalComision numeric(18, 0),
    montoTotalOperacionesConcretadas numeric(18, 0),
    PRIMARY KEY (tiempo, ubicacion, sucursal, rangoEtario, tipoInmueble, ambientes, rangoM2, tipoOperacion, moneda)
)

CREATE TABLE TAN_BIONICOS.BI_hechoAlquiler (
    ubicacion numeric(18, 0) references TAN_BIONICOS.BI_ubicacion, 
    tiempo numeric(18, 0) references TAN_BIONICOS.BI_tiempo, 
    moneda numeric(18, 0) references TAN_BIONICOS.BI_moneda, 
    tipoInmueble numeric(18, 0) references TAN_BIONICOS.BI_tipoInmueble, 
    ambientes numeric(18, 0) references TAN_BIONICOS.BI_ambientes, 
    rangoM2 numeric(18, 0) references TAN_BIONICOS.BI_rangoM2, 
    sucursal numeric(18, 0) references TAN_BIONICOS.BI_sucursal, 
    cantidadAlquileres numeric(18, 0),
    rangoEtarioInquilino numeric(18, 0) references TAN_BIONICOS.BI_rangoEtario, 
    PRIMARY KEY (tiempo, ubicacion, sucursal, rangoEtarioInquilino, tipoInmueble, ambientes, rangoM2, moneda)
)

CREATE TABLE TAN_BIONICOS.BI_hechoVenta (
    ubicacion numeric(18, 0) references TAN_BIONICOS.BI_ubicacion, 
    tiempo numeric(18, 0) references TAN_BIONICOS.BI_tiempo, 
    sucursal numeric(18, 0) references TAN_BIONICOS.BI_sucursal, 
    rangoEtarioAgente numeric(18, 0) references TAN_BIONICOS.BI_rangoEtario, 
    tipoInmueble numeric(18, 0) references TAN_BIONICOS.BI_tipoInmueble, 
    ambientes numeric(18, 0) references TAN_BIONICOS.BI_ambientes, 
    rangoM2 numeric(18, 0) references TAN_BIONICOS.BI_rangoM2, 
    moneda numeric(18, 0) references TAN_BIONICOS.BI_moneda, 
    cantidadVentas numeric(18, 0),
    precioTotalXM2 numeric(18, 0),
    PRIMARY KEY (tiempo, ubicacion, sucursal, rangoEtarioAgente, tipoInmueble, ambientes, rangoM2, moneda)
)

CREATE TABLE TAN_BIONICOS.BI_hechoPagoAlquiler (
    tiempo numeric(18, 0) references TAN_BIONICOS.BI_tiempo,
    totalPagosIncumplidos numeric(18, 0),
    cantidadPagos numeric(18, 0),
    promedioAumento numeric(18, 0),
    cantPorcentajesAumento numeric(18, 0),
    totalPorcentajeAumento numeric(18, 0),
    PRIMARY KEY (tiempo)
)


--------------------------------------------

-------------------------- MIGRACION DE DIMENSIONES --------------------------------


INSERT INTO TAN_BIONICOS.BI_tiempo(anio, cuatrimestre, mes)
    select distinct year(fechaInicio), TAN_BIONICOS.cuatrimestre(fechaInicio), month(fechaInicio)
    from TAN_BIONICOS.alquiler
    union
    select distinct year(fechaFin), TAN_BIONICOS.cuatrimestre(fechaFin), month(fechaFin)
    from TAN_BIONICOS.alquiler
    union
    select distinct year(fechaPublicacion), TAN_BIONICOS.cuatrimestre(fechaPublicacion), month(fechaPublicacion)
    from TAN_BIONICOS.anuncio
    union
    select distinct year(fechaFinalizacion), TAN_BIONICOS.cuatrimestre(fechaFinalizacion), month(fechaFinalizacion)
    from TAN_BIONICOS.anuncio
    union
    select distinct year(fechaPago), TAN_BIONICOS.cuatrimestre(fechaPago), month(fechaPago)
    from TAN_BIONICOS.pagoDeAlquiler
    union
    select distinct year(fechaVencimiento), TAN_BIONICOS.cuatrimestre(fechaVencimiento), month(fechaVencimiento)
    from TAN_BIONICOS.pagoDeAlquiler
    union
    select distinct year(fechaInicio), TAN_BIONICOS.cuatrimestre(fechaInicio), month(fechaInicio)
    from TAN_BIONICOS.pagoDeAlquiler
    union
    select distinct year(fechaFin), TAN_BIONICOS.cuatrimestre(fechaFin), month(fechaFin)
    from TAN_BIONICOS.pagoDeAlquiler
    union
    select distinct year(fechaVenta), TAN_BIONICOS.cuatrimestre(fechaVenta), month(fechaVenta)
    from TAN_BIONICOS.venta  


	
INSERT INTO TAN_BIONICOS.BI_sucursal(id, nombre)
    select distinct id, nombre
    from TAN_BIONICOS.sucursal


	
INSERT INTO TAN_BIONICOS.BI_ubicacion (provincia, localidad, barrio)
    select distinct p.nombre, l.nombre, b.nombre
    from TAN_BIONICOS.inmueble i
		join TAN_BIONICOS.barrio b on b.id = i.barrio
		join TAN_BIONICOS.localidad l on l.id = i.localidad
		join TAN_BIONICOS.provincia p on p.id = i.provincia
    union
    select distinct p.nombre,l.nombre,null
    from TAN_BIONICOS.sucursal s
		join TAN_BIONICOS.localidad l on l.id = s.localidad
		join TAN_BIONICOS.provincia p on p.id = s.provincia


	
INSERT INTO TAN_BIONICOS.BI_rangoEtario (rango)
values
('< 25'),
('25 - 35'),
('35 - 50'),
('> 50')


	
INSERT INTO TAN_BIONICOS.BI_tipoInmueble (id, tipo)
select distinct id, nombre
from TAN_BIONICOS.tipoInmueble


INSERT INTO TAN_BIONICOS.BI_ambientes(id, ambientes)
select distinct id, detalle
from TAN_BIONICOS.ambientes


	
INSERT INTO TAN_BIONICOS.BI_rangoM2 (rango)
values
('< 35'),
('35 - 55'),
('55 - 75'),
('75 - 100'),
('> 100')


	
INSERT INTO TAN_BIONICOS.BI_tipoOperacion(id, operacion)
select distinct id, nombre
from TAN_BIONICOS.tipoOperacion


	
INSERT INTO TAN_BIONICOS.BI_moneda(id, nombre)
select distinct id, nombreCompleto
from TAN_BIONICOS.moneda


----------------------------------- MIGRACION DE HECHOS ---------------------------------------------------------


insert into TAN_BIONICOS.BI_hechoAlquiler (ubicacion, tiempo, moneda, tipoInmueble, ambientes, rangoM2, sucursal,
											cantidadAlquileres, rangoEtarioInquilino)
select u.id, t.id, a.moneda, i.tipo, i.cantidadAmbientes, r2.id, ag.sucursal, 
		count(distinct alq.id),
		re.id
from TAN_BIONICOS.alquiler alq
    join TAN_BIONICOS.anuncio a on a.id = alq.anuncio
    join TAN_BIONICOS.inmueble i on i.id = a.inmueble
    join TAN_BIONICOS.provincia pr on pr.id = i.provincia
    join TAN_BIONICOS.localidad l on l.id = i.localidad
    join TAN_BIONICOS.barrio b on b.id = i.barrio
    join TAN_BIONICOS.BI_ubicacion u on u.provincia = pr.nombre and u.localidad = l.nombre and u.barrio = b.nombre
    join TAN_BIONICOS.BI_tiempo t on t.cuatrimestre = TAN_BIONICOS.cuatrimestre(alq.fechaInicio) and t.anio = year(alq.fechaInicio) and t.mes = month(alq.fechaInicio)
    join TAN_BIONICOS.BI_rangoM2 r2 on r2.rango = TAN_BIONICOS.rangoM2(i.superficieTotal)
    join TAN_BIONICOS.inquilino inq on inq.id = alq.inquilino
    join TAN_BIONICOS.persona p on p.id = inq.persona
    join TAN_BIONICOS.agente ag on ag.id = a.agente
    join TAN_BIONICOS.BI_rangoEtario re on re.rango = TAN_BIONICOS.rangoEtario(p.fechaNacimiento)
group by u.id, t.id, a.moneda, i.tipo, i.cantidadAmbientes, r2.id, ag.sucursal, re.id


-- insert para tipo de operacion venta
insert into TAN_BIONICOS.BI_hechoAnuncio (tiempo, ubicacion, rangoEtario, ambientes, tipoInmueble, sucursal, rangoM2, tipoOperacion, moneda,
											cantidadAnuncios, totalTiempoPublicado, cantidadOperacionesConcretadas, precioTotal, totalComision,
											montoTotalOperacionesConcretadas)
select t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda, 
		count(distinct a.id), 
		sum(datediff(day, a.fechaPublicacion, a.fechaFinalizacion)),
		COUNT(DISTINCT v.id),
		sum(a.precio),
		SUM(COALESCE(v.comisionInmobiliaria, 0)),
		SUM(COALESCE(v.precioVenta, 0) + COALESCE(v.comisionInmobiliaria, 0))
from TAN_BIONICOS.anuncio a
    join TAN_BIONICOS.BI_tiempo t on year(a.fechaPublicacion) = t.anio and month(a.fechaPublicacion) = t.mes and TAN_BIONICOS.cuatrimestre(a.fechaPublicacion) = t.cuatrimestre
    join TAN_BIONICOS.agente ag on a.agente = ag.id
    join TAN_BIONICOS.persona p on p.id = ag.persona
    join TAN_BIONICOS.sucursal s on ag.sucursal = s.id
	join TAN_BIONICOS.inmueble i on i.id = a.inmueble
	join TAN_BIONICOS.provincia pr on pr.id = i.provincia
	join TAN_BIONICOS.localidad l on l.id = i.localidad
	join TAN_BIONICOS.barrio b on b.id = i.barrio
    join TAN_BIONICOS.BI_ubicacion u on u.provincia = pr.nombre and u.localidad = l.nombre and u.barrio = b.nombre
    join TAN_BIONICOS.BI_rangoEtario re on re.rango = TAN_BIONICOS.rangoEtario(p.fechaNacimiento) 
    join TAN_BIONICOS.BI_rangoM2 r2 on r2.rango = TAN_BIONICOS.rangoM2(i.superficieTotal)
    join TAN_BIONICOS.tipoOperacion tipoOp on tipoOp.id = a.tipoOperacion
	left join TAN_BIONICOS.venta v on v.anuncio = a.id
where tipoOp.nombre = 'Tipo Operaci�n Venta'
group by t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda


-- insert para tipo de operacion alquiler contrato
insert into TAN_BIONICOS.BI_hechoAnuncio (tiempo, ubicacion, rangoEtario, ambientes, tipoInmueble, sucursal, rangoM2, tipoOperacion, moneda,
											cantidadAnuncios, totalTiempoPublicado, cantidadOperacionesConcretadas, precioTotal, totalComision,
											montoTotalOperacionesConcretadas)
select t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda, 
		count(distinct a.id), 
		sum(datediff(day, a.fechaPublicacion, a.fechaFinalizacion)),
		COUNT(DISTINCT alq.id),
		sum(a.precio),
		SUM(COALESCE(alq.comision, 0)),
		SUM(COALESCE(alq.deposito, 0) + COALESCE(alq.comision, 0) + COALESCE(alq.gastosDeAveriguaciones, 0))
from TAN_BIONICOS.anuncio a
    join TAN_BIONICOS.BI_tiempo t on year(a.fechaPublicacion) = t.anio and month(a.fechaPublicacion) = t.mes and TAN_BIONICOS.cuatrimestre(a.fechaPublicacion) = t.cuatrimestre
    join TAN_BIONICOS.agente ag on a.agente = ag.id
    join TAN_BIONICOS.persona p on p.id = ag.persona
    join TAN_BIONICOS.sucursal s on ag.sucursal = s.id
	join TAN_BIONICOS.inmueble i on i.id = a.inmueble
	join TAN_BIONICOS.provincia pr on pr.id = i.provincia
	join TAN_BIONICOS.localidad l on l.id = i.localidad
	join TAN_BIONICOS.barrio b on b.id = i.barrio
    join TAN_BIONICOS.BI_ubicacion u on u.provincia = pr.nombre and u.localidad = l.nombre and u.barrio = b.nombre
    join TAN_BIONICOS.BI_rangoEtario re on re.rango = TAN_BIONICOS.rangoEtario(p.fechaNacimiento) 
    join TAN_BIONICOS.BI_rangoM2 r2 on r2.rango = TAN_BIONICOS.rangoM2(i.superficieTotal)
    join TAN_BIONICOS.tipoOperacion tipoOp on tipoOp.id = a.tipoOperacion
	left join TAN_BIONICOS.alquiler alq on alq.anuncio = a.id
where tipoOp.nombre = 'Tipo Operaci�n Alquiler Contrato'
group by t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda


-- insert para tipo de operacion alquiler temporario
insert into TAN_BIONICOS.BI_hechoAnuncio (tiempo, ubicacion, rangoEtario, ambientes, tipoInmueble, sucursal, rangoM2, tipoOperacion, moneda,
											cantidadAnuncios, totalTiempoPublicado, cantidadOperacionesConcretadas, precioTotal, totalComision,
											montoTotalOperacionesConcretadas)
select t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda, 
		count(distinct a.id), 
		sum(datediff(day, a.fechaPublicacion, a.fechaFinalizacion)),
		COUNT(DISTINCT alq.id),
		sum(a.precio),
		SUM(COALESCE(alq.comision, 0)),
		SUM(COALESCE(alq.deposito, 0) + COALESCE(alq.comision, 0) + COALESCE(alq.gastosDeAveriguaciones, 0))
from TAN_BIONICOS.anuncio a
    join TAN_BIONICOS.BI_tiempo t on year(a.fechaPublicacion) = t.anio and month(a.fechaPublicacion) = t.mes and TAN_BIONICOS.cuatrimestre(a.fechaPublicacion) = t.cuatrimestre
    join TAN_BIONICOS.agente ag on a.agente = ag.id
    join TAN_BIONICOS.persona p on p.id = ag.persona
    join TAN_BIONICOS.sucursal s on ag.sucursal = s.id
	join TAN_BIONICOS.inmueble i on i.id = a.inmueble
	join TAN_BIONICOS.provincia pr on pr.id = i.provincia
	join TAN_BIONICOS.localidad l on l.id = i.localidad
	join TAN_BIONICOS.barrio b on b.id = i.barrio
    join TAN_BIONICOS.BI_ubicacion u on u.provincia = pr.nombre and u.localidad = l.nombre and u.barrio = b.nombre
    join TAN_BIONICOS.BI_rangoEtario re on re.rango = TAN_BIONICOS.rangoEtario(p.fechaNacimiento) 
    join TAN_BIONICOS.BI_rangoM2 r2 on r2.rango = TAN_BIONICOS.rangoM2(i.superficieTotal)
    join TAN_BIONICOS.tipoOperacion tipoOp on tipoOp.id = a.tipoOperacion
	left join TAN_BIONICOS.alquiler alq on alq.anuncio = a.id
where tipoOp.nombre = 'Tipo Operaci�n Alquiler Temporario'
group by t.id, u.id, re.id, i.cantidadAmbientes, i.tipo, s.id, r2.id, a.tipoOperacion, a.moneda
	

insert into TAN_BIONICOS.BI_hechoVenta (ubicacion, tiempo, sucursal, rangoEtarioAgente, tipoInmueble, ambientes, rangoM2, moneda,
										cantidadVentas, precioTotalXM2)
select u.id, t.id, ag.sucursal, re.id, i.tipo, i.cantidadAmbientes, r2.id, v.moneda,
		count(distinct v.id),
		SUM(v.precioVenta / i.superficieTotal) 
from TAN_BIONICOS.venta v
    join TAN_BIONICOS.anuncio a on v.anuncio = a.id
    join TAN_BIONICOS.inmueble i on i.id = a.inmueble
    join TAN_BIONICOS.provincia pr on pr.id = i.provincia
    join TAN_BIONICOS.localidad l on l.id = i.localidad
    join TAN_BIONICOS.barrio b on b.id = i.barrio
    join TAN_BIONICOS.BI_ubicacion u on u.provincia = pr.nombre and u.localidad = l.nombre and u.barrio = b.nombre
    join TAN_BIONICOS.BI_tiempo t on year(v.fechaVenta) = t.anio and month(v.fechaVenta) = t.mes and TAN_BIONICOS.cuatrimestre(v.fechaVenta) = t.cuatrimestre
    join TAN_BIONICOS.agente ag on ag.id = a.agente
    join TAN_BIONICOS.persona p on p.id = ag.persona
    join TAN_BIONICOS.BI_rangoEtario re on re.rango = TAN_BIONICOS.rangoEtario(p.fechaNacimiento)
    join TAN_BIONICOS.BI_rangoM2 r2 on r2.rango = TAN_BIONICOS.rangoM2(i.superficieTotal)
group by u.id, t.id, ag.sucursal, re.id, i.tipo, i.cantidadAmbientes, r2.id, v.moneda


	
INSERT INTO TAN_BIONICOS.BI_hechoPagoAlquiler(tiempo, totalPorcentajeAumento, cantidadPagos, cantPorcentajesAumento, totalPagosIncumplidos)
SELECT DISTINCT
    t.id,
    SUM(coalesce((pa.importe - pago_anterior.importe), 0) / coalesce((pago_anterior.importe*100),1)) AS totalPorcentajeAumento,
    COUNT(*) AS cantidadPagos,
	sum(case when pago_anterior.id is null then 0 else 1 end) as cantPorcentajesAumento,
    sum(CASE WHEN (pa.fechaPago >= pa.fechaVencimiento) then 1 else 0 end) AS totalPagosIncumplidos
FROM TAN_BIONICOS.alquiler a
        JOIN TAN_BIONICOS.estadoAlquiler ea ON a.estadoAlquiler = ea.id
        JOIN TAN_BIONICOS.pagoDeAlquiler pa ON pa.alquiler = a.id
        LEFT JOIN TAN_BIONICOS.pagoDeAlquiler pago_anterior ON pago_anterior.alquiler = pa.alquiler AND
															YEAR(pago_anterior.fechaPago) = YEAR(pa.fechaPago) AND
															MONTH(pago_anterior.fechaPago) = MONTH(pa.fechaPago) - 1 AND
															pago_anterior.importe < pa.importe AND
															GETDATE() < pa.fechaFin
        join TAN_BIONICOS.BI_tiempo t on year(pa.fechaPago) = t.anio and month(pa.fechaPago) = t.mes and TAN_BIONICOS.cuatrimestre(pa.fechaPago) = t.cuatrimestre
WHERE pa.fechaPago IS NOT NULL
GROUP BY t.id
ORDER BY totalPagosIncumplidos DESC





-------------------------- VISTAS ----------------------------------------

-- Vista del punto 1
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_promedioTiempoPublicado', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_promedioTiempoPublicado
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_promedioTiempoPublicado
AS
    SELECT t.anio, t.cuatrimestre, u.provincia, u.localidad, u.barrio, o.operacion, am.ambientes, SUM(a.totalTiempoPublicado) / SUM(a.cantidadAnuncios) AS promedioTiempoPublicado
    FROM TAN_BIONICOS.BI_hechoAnuncio a
        JOIN TAN_BIONICOS.BI_tipoOperacion o ON a.tipoOperacion = o.id
		JOIN TAN_BIONICOS.BI_ubicacion u ON a.ubicacion = u.id
		JOIN TAN_BIONICOS.BI_ambientes am ON a.ambientes = am.id
		JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
	GROUP BY o.operacion, u.id, u.barrio, u.localidad, u.provincia, am.ambientes, t.cuatrimestre, t.anio
GO


-- Vista del punto 2
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_precioPromedio', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_precioPromedio
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_precioPromedio
AS
    SELECT t.anio, t.cuatrimestre, m.nombre, o.operacion, ti.tipo, r.rango AS rangoM2, SUM(a.precioTotal) / SUM(a.cantidadAnuncios) AS precioPromedio
    FROM TAN_BIONICOS.BI_hechoAnuncio a 
        JOIN TAN_BIONICOS.BI_tipoOperacion o ON a.tipoOperacion = o.id
		JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
		JOIN TAN_BIONICOS.BI_tipoInmueble ti ON a.tipoInmueble = ti.id
		JOIN TAN_BIONICOS.BI_rangoM2 r ON a.rangoM2 = r.id
		JOIN TAN_BIONICOS.BI_moneda m ON a.moneda = m.id
	GROUP BY m.nombre, o.operacion, ti.tipo, r.rango, t.cuatrimestre, t.anio
GO


-- Vista del punto 3
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_top5Barrios', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_top5Barrios
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_top5Barrios
AS
    SELECT top 5 re.rango, u.barrio, u.localidad, u.provincia, t.anio, t.cuatrimestre, sum(a.cantidadAlquileres) AS cantidadAlquileres
    from TAN_BIONICOS.BI_hechoAlquiler a
        join TAN_BIONICOS.BI_rangoEtario re on a.rangoEtarioInquilino = re.id
        join TAN_BIONICOS.BI_ubicacion u on a.ubicacion = u.id
        join TAN_BIONICOS.BI_tiempo t on a.tiempo = t.id
    GROUP BY re.rango, u.id, u.barrio, u.localidad, u.provincia, t.anio, t.cuatrimestre
    order by cantidadAlquileres desc
GO


-- Vista del punto 4
IF OBJECT_ID('TAN_BIONICOS.BI_alquiler_porcentajeIncumplimientoPagos', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_alquiler_porcentajeIncumplimientoPagos
GO
CREATE VIEW TAN_BIONICOS.BI_alquiler_porcentajeIncumplimientoPagos
AS
    SELECT t.anio, t.mes, concat(100 * SUM(a.totalPagosIncumplidos) / sum(a.cantidadPagos), '%') AS porcentajeIncumplimientoPagos
    FROM TAN_BIONICOS.BI_hechoPagoAlquiler a
        JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
    GROUP BY t.mes, t.anio
GO


-- Vista del punto 5
IF OBJECT_ID('TAN_BIONICOS.BI_alquiler_porcentajeIncrementoValor', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_alquiler_porcentajeIncrementoValor
GO
CREATE VIEW TAN_BIONICOS.BI_alquiler_porcentajeIncrementoValor
AS
GO
    SELECT t.anio, t.mes, concat(sum(pa.totalPorcentajeAumento) / sum(pa.cantPorcentajesAumento), '%') AS porcentajePromedioIncrement
    FROM TAN_BIONICOS.BI_hechoPagoAlquiler pa
        JOIN TAN_BIONICOS.BI_tiempo t ON pa.tiempo = t.id
    WHERE pa.cantPorcentajesAumento != 0
    GROUP BY t.mes, t.anio



-- Vista del punto 6
IF OBJECT_ID('TAN_BIONICOS.BI_venta_precioPromedioXM2', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_venta_precioPromedioXM2
GO
CREATE VIEW TAN_BIONICOS.BI_venta_precioPromedioXM2
AS
	SELECT t.anio, t.cuatrimestre, ti.tipo, u.localidad, u.provincia, SUM(v.precioTotalXM2) / SUM(v.cantidadVentas) AS porcentajePromedioXM2
	FROM TAN_BIONICOS.BI_hechoVenta v 
        JOIN TAN_BIONICOS.BI_tiempo t ON v.tiempo = t.id
	    JOIN TAN_BIONICOS.BI_tipoInmueble ti ON v.tipoInmueble = ti.id
        JOIN TAN_BIONICOS.BI_ubicacion u ON v.ubicacion = u.id
	GROUP BY ti.tipo, t.cuatrimestre, t.anio, u.localidad, u.provincia
GO


-- Vista del punto 7
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_promedioComision', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_promedioComision
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_promedioComision
AS
	SELECT t.anio, t.cuatrimestre, o.operacion, s.nombre AS sucursal, SUM(a.totalComision) / SUM(a.cantidadAnuncios) promedioComision
	FROM TAN_BIONICOS.BI_hechoAnuncio a
        JOIN TAN_BIONICOS.BI_tipoOperacion o ON a.tipoOperacion = o.id
		JOIN TAN_BIONICOS.BI_sucursal s ON a.sucursal = s.id
		JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
	GROUP BY o.operacion, s.id, s.nombre, t.cuatrimestre, t.anio
GO



-- Vista del punto 8
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_porcentajeOperacionesConcretadas', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_porcentajeOperacionesConcretadas
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_porcentajeOperacionesConcretadas
AS
	SELECT 100 * SUM(a.cantidadOperacionesConcretadas) / SUM(a.cantidadAnuncios) AS porcentajeOperacionesConcretadas,
	s.nombre AS sucursal, r.rango AS rangoEtario, t.anio
	FROM TAN_BIONICOS.BI_hechoAnuncio a
        JOIN TAN_BIONICOS.BI_sucursal s ON a.sucursal = s.id
		JOIN TAN_BIONICOS.BI_rangoEtario r ON a.rangoEtario = r.id
		JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
	GROUP BY s.nombre, r.rango, t.anio
GO



-- Vista del punto 9
IF OBJECT_ID('TAN_BIONICOS.BI_anuncio_montoCierreContratos', 'V') IS NOT NULL
	DROP VIEW TAN_BIONICOS.BI_anuncio_montoCierreContratos
GO
CREATE VIEW TAN_BIONICOS.BI_anuncio_montoCierreContratos
AS
	SELECT s.nombre AS sucursal, t.cuatrimestre, m.nombre, SUM(a.montoTotalOperacionesConcretadas) AS montoCierreContratos
	FROM TAN_BIONICOS.BI_hechoAnuncio a
        JOIN TAN_BIONICOS.BI_sucursal s ON a.sucursal = s.id
		JOIN TAN_BIONICOS.BI_tiempo t ON a.tiempo = t.id
		JOIN TAN_BIONICOS.BI_moneda m ON a.moneda = m.id
	GROUP BY s.nombre, t.cuatrimestre, m.nombre
GO

