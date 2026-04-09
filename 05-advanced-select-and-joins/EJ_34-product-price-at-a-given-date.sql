-- 1164. Product Price at a Given Date
-- Dificultad: Media
-- https://leetcode.com/problems/product-price-at-a-given-date/

/*
PROBLEMA:
Encontrar el precio de todos los productos en la fecha 2019-08-16.
- Si el producto tuvo cambios de precio antes o en esa fecha: el más reciente.
- Si nunca tuvo un cambio antes de esa fecha: precio por defecto = 10.

TABLAS:

Products (product_id, new_price, change_date)

RESULTADO ESPERADO:

product_id  price
2           50
1           35
3           10
*/

-- PASO 1: Subconsulta interna para obtener todos los productos distintos
-- SELECT DISTINCT product_id asegura tener la lista completa de productos

-- PASO 2: LEFT JOIN con Products para traer todos los cambios de precio
-- LEFT JOIN porque queremos todos los productos, incluso sin cambios
-- USING(product_id) como atajo del ON cuando la columna se llama igual

-- PASO 3: ROW_NUMBER() para rankear los cambios de precio de cada producto
-- PARTITION BY product_id: reinicia la numeración por cada producto
-- ORDER BY con CASE WHEN: las fechas <= 2019-08-16 van primero (DESC)
-- Las fechas posteriores se convierten en NULL y van al final

-- PASO 4: COALESCE(new_price, 10) para asignar precio por defecto
-- Si el producto no tiene cambios válidos, new_price es NULL → devuelve 10

-- PASO 5: Consulta externa filtra WHERE rn = 1
-- Se queda solo con el resultado más relevante de cada producto

SELECT
    product_id,                                             -- Identificador del producto
    price                                                   -- Precio en la fecha indicada
FROM (
    SELECT
        product_id,
        COALESCE(new_price, 10) AS price,                   -- Precio o 10 por defecto si es NULL
        ROW_NUMBER() OVER (                                 -- Numerar filas por producto
            PARTITION BY product_id                         -- Reiniciar numeración por producto
            ORDER BY
                CASE WHEN change_date <= '2019-08-16'
                    THEN change_date                        -- Fechas válidas van primero
                END DESC                                    -- Más reciente primero, NULL al final
        ) AS rn                                             -- Alias del número de fila
    FROM (SELECT DISTINCT product_id FROM Products) all_products  -- Todos los productos
    LEFT JOIN Products USING (product_id)                   -- Traer sus cambios de precio
) ranked                                                    -- Alias de la tabla derivada
WHERE rn = 1;                                               -- Solo el primer resultado por producto

/*
POR QUÉ CADA PARTE:

- Subconsulta DISTINCT: Garantizar que aparezcan TODOS los productos, incluso sin cambios
- LEFT JOIN: Mantener productos sin cambios de precio (aparecen con NULL)
- CASE WHEN en ORDER BY: Las fechas > 2019-08-16 se vuelven NULL y van al final del DESC
- ROW_NUMBER() + PARTITION BY: Asignar ranking por producto para luego quedarnos con el primero
- COALESCE(new_price, 10): Si no hay precio válido (NULL), asignar 10 por defecto
- WHERE rn = 1: Quedarnos solo con la fila más relevante de cada producto

CONCEPTOS NUEVOS:
- COALESCE() (devuelve el primer valor no NULL de una lista)
- ROW_NUMBER() OVER(...) (asignar número secuencial a cada fila)
- PARTITION BY (dividir filas en grupos para funciones de ventana)
- USING(columna) (atajo del ON cuando la columna se llama igual en ambas tablas)
*/
