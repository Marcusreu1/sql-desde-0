-- 1068. Product Sales Analysis I
-- Dificultad: Fácil
-- https://leetcode.com/problems/product-sales-analysis-i/

/*
PROBLEMA:
Escribir una consulta que devuelva el nombre del producto, el año
y el precio de cada venta registrada en la tabla Sales.

TABLAS:
- Sales (sale_id, product_id, year, quantity, price)
  - sale_id: id de la venta
  - product_id: id del producto vendido
  - year: año de la venta
  - quantity: cantidad vendida
  - price: precio por unidad
  - (sale_id, year) es la clave única de esta tabla
- Product (product_id, product_name)
  - product_id: identificador único del producto
  - product_name: nombre del producto

RESULTADO ESPERADO:
| product_name | year | price |
|--------------|------|-------|
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Sales es la tabla principal porque el problema pide info de cada venta

-- PASO 2: LEFT JOIN para traer el nombre del producto
-- LEFT JOIN porque queremos TODAS las ventas
-- ON para conectar ambas tablas por product_id

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- product_name de Product, year y price de Sales

SELECT p.product_name,                   -- Nombre del producto (de la tabla Product)
       s.year,                           -- Año de la venta
       s.price                           -- Precio por unidad
FROM Sales s                             -- Tabla principal: ventas
LEFT JOIN Product p                      -- Traer nombre del producto
    ON s.product_id = p.product_id;      -- Condición de unión: mismo product_id

/*
POR QUÉ CADA PARTE:
- FROM Sales: Es la tabla que contiene todas las ventas
- LEFT JOIN Product: Trae el nombre del producto sin perder ninguna venta
- ON s.product_id = p.product_id: Conecta ambas tablas por el id del producto
- SELECT product_name, year, price: Son las columnas que pide el problema

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON (condición de unión entre tablas)
- Alias de tablas (s, p) para simplificar la escritura
*/
