-- 1484. Group Sold Products by The Date
-- Dificultad: Easy
-- https://leetcode.com/problems/group-sold-products-by-the-date/

/*
PROBLEMA:
Para cada fecha de venta, encontrar la cantidad de productos distintos 
vendidos y listar sus nombres en una sola cadena separados por coma, 
ordenados alfabéticamente.

TABLA:

Activities (sell_date, product)

RESULTADO ESPERADO (ejemplo):

sell_date    num_sold  products
2020-05-30   2        Headphone,Basketball
2020-06-01   2        Bible,Pencil
2020-06-02   1        Mask
*/

-- PASO 1: FROM Activities
-- Solo tenemos una tabla, la seleccionamos directamente

-- PASO 2: GROUP BY sell_date
-- Agrupamos por fecha para tener un resultado por cada día

-- PASO 3: COUNT(DISTINCT product) para contar productos únicos por fecha

-- PASO 4: GROUP_CONCAT() para unir los productos en un solo texto
-- DISTINCT → sin duplicados
-- ORDER BY product → orden alfabético
-- SEPARATOR ',' → separados por coma

-- PASO 5: ORDER BY sell_date para ordenar el resultado final por fecha

SELECT
    sell_date,                                          -- Fecha de venta
    COUNT(DISTINCT product) AS num_sold,                -- Cantidad de productos únicos
    GROUP_CONCAT(                                       
        DISTINCT product                                -- Productos únicos
        ORDER BY product                                -- Ordenados alfabéticamente
        SEPARATOR ','                                   -- Separados por coma
    ) AS products                                       -- Lista de productos en un texto
FROM Activities                                         -- Tabla de actividades
GROUP BY sell_date                                      -- Un resultado por fecha
ORDER BY sell_date;                                     -- Ordenar por fecha

/*
POR QUÉ CADA PARTE:

GROUP_CONCAT(): Necesitamos unir varios productos en una sola celda de texto
DISTINCT dentro de GROUP_CONCAT(): Elimina productos duplicados en la misma fecha
ORDER BY dentro de GROUP_CONCAT(): El problema pide orden alfabético
SEPARATOR ',': El problema pide que estén separados por coma
COUNT(DISTINCT product): Contar solo productos únicos, no repetidos
GROUP BY sell_date: Un resultado por cada fecha
ORDER BY sell_date: Requisito del problema

CONCEPTOS USADOS:

- GROUP_CONCAT() (unir valores de texto en una cadena) [NUEVO]
- SEPARATOR (definir separador dentro de GROUP_CONCAT) [NUEVO]
- COUNT(DISTINCT)
- GROUP BY
- ORDER BY
*/
