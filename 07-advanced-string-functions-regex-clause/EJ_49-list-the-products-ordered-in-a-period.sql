-- 1327. List the Products Ordered in a Period
-- Dificultad: Easy
-- https://leetcode.com/problems/list-the-products-ordered-in-a-period/

/*
PROBLEMA:
Encontrar los productos que tuvieron al menos 100 unidades pedidas
en febrero de 2020. Mostrar nombre del producto y total de unidades.

TABLAS:

Products (product_id, product_name)
Orders (order_id, order_date, product_id, unit)

RESULTADO ESPERADO (ejemplo):

product_name       unit
Leetcode Solutions 130
Leetcode Kit       100
*/

-- PASO 1: Subconsulta para procesar los pedidos de febrero 2020
-- WHERE con BETWEEN para filtrar solo fechas de febrero 2020
-- GROUP BY product_id para sumar unidades por producto
-- HAVING SUM(unit) >= 100 para quedarnos solo con los de 100+

-- PASO 2: JOIN con Products
-- Conectamos la subconsulta con Products para obtener el nombre
-- JOIN normal porque solo queremos los productos que cumplieron el filtro

-- PASO 3: SELECT con nombre del producto y total de unidades

SELECT
    p.product_name,                           -- Nombre del producto
    feb_orders.total_unit AS unit             -- Total de unidades en febrero
FROM Products p                               -- Tabla de productos
JOIN (
    SELECT 
        product_id,                           -- Para conectar con Products
        SUM(unit) AS total_unit               -- Sumar unidades por producto
    FROM Orders                               -- Tabla de pedidos
    WHERE order_date                          
        BETWEEN '2020-02-01'                  -- Desde el 1 de febrero
        AND '2020-02-29'                      -- Hasta el 29 de febrero
    GROUP BY product_id                       -- Agrupar por producto
    HAVING SUM(unit) >= 100                   -- Solo los de 100+ unidades
) feb_orders                                  -- Alias de la subconsulta
    ON p.product_id = feb_orders.product_id;  -- Condición: mismo producto

/*
POR QUÉ CADA PARTE:

Subconsulta en FROM: Primero procesamos los pedidos (filtrar, sumar, filtrar
    grupos) y luego usamos ese resultado como tabla para el JOIN
BETWEEN: Filtrar solo las fechas dentro de febrero 2020
GROUP BY: Necesitamos sumar unidades POR producto
HAVING >= 100: Filtramos después de agrupar (no sirve WHERE aquí porque
    la suma aún no existe)
JOIN (no LEFT): Solo queremos productos que sí cumplieron la condición,
    no necesitamos los que no

CONCEPTOS USADOS:

- Subconsulta en el FROM / tabla derivada
- BETWEEN
- GROUP BY
- HAVING
- SUM()
- JOIN
*/
