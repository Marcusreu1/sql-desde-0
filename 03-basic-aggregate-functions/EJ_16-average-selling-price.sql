-- 1251. Average Selling Price
-- Dificultad: Fácil
-- https://leetcode.com/problems/average-selling-price/

/*
PROBLEMA:
Escribir una consulta que calcule el precio promedio de venta de cada producto.
El promedio es PONDERADO: SUM(precio × unidades) / SUM(unidades).
Si un producto no tiene ventas, el precio promedio debe ser 0.
Redondear a 2 decimales.

TABLAS:
- Prices (product_id, start_date, end_date, price)
  - product_id: id del producto
  - start_date: inicio del periodo de vigencia del precio
  - end_date: fin del periodo de vigencia del precio
  - price: precio del producto durante ese periodo
  - (product_id, start_date, end_date) es la clave única
  - Los periodos de un mismo producto no se solapan
- UnitsSold (product_id, purchase_date, units)
  - product_id: id del producto
  - purchase_date: fecha de la compra
  - units: cantidad de unidades vendidas

RESULTADO ESPERADO:
| product_id | average_price |
|------------|---------------|
| 1          | 6.96          |
| 2          | 16.96         |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Prices es la tabla principal porque necesitamos TODOS los productos

-- PASO 2: LEFT JOIN para traer la información de ventas
-- LEFT JOIN porque queremos todos los productos aunque no tengan ventas
-- ON con dos condiciones:
--   1. Mismo producto (product_id)
--   2. Fecha de compra dentro del periodo de vigencia del precio (BETWEEN)

-- PASO 3: GROUP BY para agrupar por producto
-- Necesitamos un precio promedio POR CADA producto

-- PASO 4: SELECT con promedio ponderado
-- SUM(price * units): Total de dinero generado
-- SUM(units): Total de unidades vendidas
-- División = promedio ponderado
-- IFNULL: Si no hay ventas, devolver 0 en vez de NULL
-- ROUND: Redondear a 2 decimales

SELECT p.product_id,                                           -- Id del producto
       ROUND(                                                  -- Redondear a 2 decimales
           IFNULL(                                             -- Si es NULL, devolver 0
               SUM(p.price * u.units)                          -- Total de dinero generado
               / SUM(u.units),                                 -- Dividido entre total de unidades
           0),                                                 -- Valor por defecto si NULL
       2) AS average_price                                     -- Alias que pide el problema
FROM Prices p                                                  -- Tabla principal: precios
LEFT JOIN UnitsSold u                                          -- Traer info de ventas
    ON u.product_id = p.product_id                             -- Mismo producto
    AND u.purchase_date BETWEEN p.start_date AND p.end_date   -- Fecha dentro del periodo
GROUP BY p.product_id;                                         -- Agrupar por producto

/*
POR QUÉ CADA PARTE:
- FROM Prices: Contiene todos los productos con sus precios por periodo
- LEFT JOIN UnitsSold: Trae las ventas sin perder productos sin ventas
- ON con dos condiciones:
  - u.product_id = p.product_id: Mismo producto
  - u.purchase_date BETWEEN p.start_date AND p.end_date: Asigna a cada venta
    el precio correcto según la fecha de compra
- GROUP BY p.product_id: Agrupa por producto para un promedio por cada uno
- SUM(price * units) / SUM(units): Promedio ponderado
  (no usamos AVG porque necesitamos ponderar por unidades vendidas)
- IFNULL(..., 0): Productos sin ventas tendrían NULL, lo convertimos a 0
- ROUND(..., 2): El problema pide 2 decimales

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON con múltiples condiciones (AND)
- BETWEEN (verificar si un valor está dentro de un rango)
- GROUP BY (agrupar filas por una columna)
- SUM() (función de agregación para sumar valores)
- IFNULL() (reemplazar NULL por un valor por defecto)
- ROUND() (redondear a cierta cantidad de decimales)
- Promedio ponderado (SUM(a*b) / SUM(b))
*/
