-- 1164. Product Price at a Given Date
-- Dificultad: Medium
-- https://leetcode.com/problems/product-price-at-a-given-date/

/*
PROBLEMA:
Encontrar el precio de todos los productos en la fecha 2019-08-16.
Si un producto tuvo cambios antes o en esa fecha, tomar el más reciente.
Si no tuvo cambios antes de esa fecha, el precio por defecto es 10.

TABLA:

Products (product_id, new_price, change_date)

RESULTADO ESPERADO (ejemplo):

product_id  price
2           50
1           35
3           10
*/

-- PARTE 1: Productos CON cambios en o antes de 2019-08-16
-- Subconsulta para obtener la fecha de cambio más reciente por producto
-- Filtramos la fila exacta con (product_id, change_date) IN (subconsulta)

-- PARTE 2: Productos SIN cambios antes de 2019-08-16
-- NOT IN para encontrar los que no tienen ningún cambio válido
-- Les asignamos el precio por defecto: 10

-- UNION para combinar ambas partes en un solo resultado

SELECT
    product_id,                              -- ID del producto
    new_price AS price                       -- Precio del cambio más reciente
FROM Products
WHERE (product_id, change_date) IN (         -- Fila exacta del cambio más reciente
    SELECT product_id, MAX(change_date)      -- Fecha máxima por producto
    FROM Products
    WHERE change_date <= '2019-08-16'        -- Solo cambios válidos (en o antes)
    GROUP BY product_id                      -- Una fecha máxima por producto
)

UNION

SELECT
    DISTINCT product_id,                     -- Productos sin cambios válidos
    10 AS price                              -- Precio por defecto
FROM Products
WHERE product_id NOT IN (                    -- Que NO estén en el grupo con cambios
    SELECT product_id
    FROM Products
    WHERE change_date <= '2019-08-16'        -- Ningún cambio en o antes de la fecha
);

/*
POR QUÉ CADA PARTE:

PARTE 1 - WHERE (product_id, change_date) IN: Filtramos la fila exacta
    del cambio más reciente por producto, así obtenemos directamente
    el new_price correcto
MAX(change_date): Nos da la fecha del cambio más reciente dentro del
    rango válido (<= 2019-08-16)
PARTE 2 - NOT IN: Identifica productos que NUNCA tuvieron un cambio
    antes de la fecha, a estos les asignamos 10
UNION: Combina ambos grupos en un solo resultado sin duplicados

CONCEPTOS USADOS:

- COALESCE() (primer valor no NULL de una lista) [NUEVO]
- ROW_NUMBER() OVER(...) (número secuencial por fila) [NUEVO]
- PARTITION BY (dividir filas en grupos para funciones de ventana) [NUEVO]
- USING(columna) (atajo del ON) [NUEVO]
- WHERE (col1, col2) IN (subconsulta)
- NOT IN
- MAX()
- UNION
- DISTINCT
*/
