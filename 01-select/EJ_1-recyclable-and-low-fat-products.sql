-- 1757. Recyclable and Low Fat Products
-- Dificultad: Fácil
-- https://leetcode.com/problems/recyclable-and-low-fat-products/

/*
PROBLEMA:
Escribir una consulta que devuelva los ids de los productos que son
tanto bajos en grasas (low fats) como reciclables (recyclable).

TABLA:
- Products (product_id, low_fats, recyclable)
  - low_fats: 'Y' = bajo en grasas, 'N' = no bajo en grasas
  - recyclable: 'Y' = reciclable, 'N' = no reciclable

RESULTADO ESPERADO:
| product_id |
|------------|
| 1          |
| 3          |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Products

-- PASO 2: WHERE para filtrar los datos con condiciones
-- Necesitamos que se cumplan DOS condiciones al mismo tiempo:
--   1. low_fats = 'Y' (que sea bajo en grasas)
--   2. recyclable = 'Y' (que sea reciclable)
-- Usamos AND porque ambas condiciones deben cumplirse simultáneamente

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos el product_id, que es lo que nos pide el problema

SELECT product_id                        -- Columna que queremos obtener
FROM Products                            -- Tabla de donde tomamos los datos
WHERE low_fats = 'Y'                     -- Condición 1: bajo en grasas
  AND recyclable = 'Y';                  -- Condición 2: reciclable

/*
POR QUÉ CADA PARTE:
- FROM Products: Es la única tabla disponible y contiene toda la info necesaria
- WHERE con AND: El problema pide que AMBAS condiciones se cumplan, no solo una
- SELECT product_id: El problema solo pide devolver los ids de los productos

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- AND (operador lógico para múltiples condiciones)
*/
