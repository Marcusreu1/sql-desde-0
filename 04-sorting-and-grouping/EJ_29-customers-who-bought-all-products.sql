-- 1045. Customers Who Bought All Products
-- Dificultad: Media
-- https://leetcode.com/problems/customers-who-bought-all-products/

/*
PROBLEMA:
Encontrar los clientes que compraron TODOS los productos del catálogo.

TABLAS:

Customer (customer_id, product_key)
Product (product_key)

RESULTADO ESPERADO:

customer_id
1
3
*/

-- PASO 1: INNER JOIN entre Customer y Product
-- Unimos para validar que las compras correspondan a productos existentes
-- INNER JOIN porque solo nos interesan compras con productos válidos

-- PASO 2: GROUP BY customer_id para agrupar por cliente
-- Necesitamos contar los productos de cada cliente

-- PASO 3: HAVING COUNT(DISTINCT c.product_key) = (subconsulta)
-- COUNT(DISTINCT c.product_key): productos únicos que compró el cliente
-- Subconsulta COUNT(*) FROM Product: total de productos en el catálogo
-- Si son iguales → el cliente compró todos los productos

-- PASO 4: SELECT customer_id para mostrar solo el identificador del cliente

SELECT
    c.customer_id                                       -- Identificador del cliente
FROM Customer c                                         -- Tabla de compras
INNER JOIN Product p                                    -- Catálogo de productos
    ON c.product_key = p.product_key                    -- Condición: mismo producto
GROUP BY c.customer_id                                  -- Agrupar por cliente
HAVING COUNT(DISTINCT c.product_key) = (                -- Productos únicos comprados
    SELECT COUNT(*) FROM Product                        -- = total de productos del catálogo
);

/*
POR QUÉ CADA PARTE:

- INNER JOIN: Solo considerar compras de productos válidos del catálogo
- GROUP BY customer_id: Agrupar para contar productos por cliente
- COUNT(DISTINCT c.product_key): Contar productos únicos (evitar duplicados si compró el mismo producto varias veces)
- Subconsulta en HAVING: El total de productos no es fijo, se calcula dinámicamente
  - Si pusiéramos un número fijo (ej: = 3), al agregar un producto nuevo la query fallaría
- Lógica: si productos_únicos_comprados = total_productos → compró todos

CONCEPTOS NUEVOS:
- Subconsulta en el HAVING (comparar resultado de agregación con un valor dinámico)
*/
