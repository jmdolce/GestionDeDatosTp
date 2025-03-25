# GestionDeDatosTp
TP -  Gestion de Datos - UTN-FRBA - 2023

📌 Descripción

El objetivo del TP es simular la implementación de un nuevo sistema para una inmobiliaria, permitiendo gestionar anuncios, alquileres y ventas de inmuebles. 

Se desarrollaron dos modelos de base de datos:

Modelo transaccional: Organiza y normaliza los datos originales proporcionados en una tabla maestra desnormalizada.
Modelo de Inteligencia de Negocios (BI): Permite generar indicadores clave para la toma de decisiones.

📂 Contenido

Dentro de la carpeta "Entregable" se encuentran las versiones finales.

script_creacion_inicial.sql: Creación del esquema transaccional y migración de datos desde la tabla maestra.
script_creacion_BI.sql: Creación del modelo de BI y migración de datos desde el modelo transaccional.
Diagrama del modelo.
Decisiones.pdf: Documento con la estrategia de modelado y migración de datos.


🛠️ Tecnologías utilizadas

SQL Server 2019
T-SQL para la creación de tablas, migración de datos y consultas optimizadas.


🏗️ Desarrollo

Análisis y normalización: Se analizó la tabla maestra y se diseñó un modelo de datos optimizado.
Migración: Se implementaron procedimientos almacenados (Stored Procedures) para trasladar los datos al nuevo modelo.
Creación de BI: Se desarrolló un modelo dimensional para generar indicadores clave de negocio.
Consultas de análisis: Se crearon vistas y consultas para responder preguntas estratégicas de la inmobiliaria.
