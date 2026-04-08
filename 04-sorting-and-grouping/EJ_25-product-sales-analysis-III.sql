-- 1070. Product Sales Analysis III
-- Dificultad: Media
-- https://leetcode.com/problems/product-sales-analysis-iii/

/*
PROBLEMA:
Obtener el primer año en que se vendió cada producto,
junto con la cantidad y el precio de esa primera venta.

TABLAS:

Sales (sale_id, product_id, year, quantity, price)
Product (product_id, product_name)

RESULTADO ESPERADO:

product_id  first_year  quantity  price
100         2008        10        5000
200         2011        15        9000
*/

-- PASO 1: Subconsulta para obtener el primer año de venta de cada producto
-- GROUP BY product_id para agrupar por producto
-- MIN(year) para obtener el año más antiguo de cada uno

-- PASO 2: WHERE (product_id, year) IN (subconsulta)
-- Filtramos con dos columnas para asegurar que coincida
-- tanto el producto como su año mínimo específico

-- PASO 3: SELECT con las columnas que pide el problema
-- year renombrado como first_year con AS

SELECT
    product_id,                                 -- Identificador del producto
    year AS first_year,                         -- Primer año de venta (renombrado)
    quantity,                                   -- Cantidad vendida en ese primer año
    price                                       -- Precio de esa primera venta
FROM Sales                                      -- Tabla de ventas
WHERE (product_id, year) IN (                   -- Filtrar solo primeras ventas
    SELECT product_id, MIN(year)                -- Producto + su año más antiguo
    FROM Sales                                  -- Misma tabla (subconsulta)
    GROUP BY product_id                         -- Agrupar por producto
);

/*
POR QUÉ CADA PARTE:

- Subconsulta con MIN(year): Encontrar el año más antiguo de venta de cada producto
- WHERE (product_id, year) IN: Necesitamos las dos columnas para no traer ventas incorrectas
  - Solo product_id: traería TODAS las ventas del producto
  - Solo MIN(year): podría traer productos que coincidan en ese año pero no sea su primer año
- AS first_year: Alias requerido por el formato de salida del problema

CONCEPTOS NUEVOS:
- Ninguno (combinación de WHERE (col1, col2) IN subconsulta, MIN() y GROUP BY ya vistos)
*/
