-- 1211. Queries Quality and Percentage
-- Dificultad: Fácil
-- https://leetcode.com/problems/queries-quality-and-percentage/

/*
PROBLEMA:
Escribir una consulta que calcule para cada query_name:
1. quality: promedio de (rating / position)
2. poor_query_percentage: porcentaje de filas con rating < 3
Redondear ambos a 2 decimales.

TABLA:
- Queries (query_name, result, position, rating)
  - query_name: nombre de la consulta
  - result: resultado de la consulta
  - position: posición del resultado (1 a 500)
  - rating: calificación del usuario (1 a 5)
  - Cada query_name puede tener múltiples filas

RESULTADO ESPERADO:
| query_name | quality | poor_query_percentage |
|------------|---------|-----------------------|
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Queries

-- PASO 2: GROUP BY para agrupar por query_name
-- Necesitamos los cálculos POR CADA consulta

-- PASO 3: SELECT con dos cálculos
-- quality: ROUND(AVG(rating * 1.0 / position), 2)
--   * 1.0 para forzar división decimal
--   AVG() promedia las divisiones por cada grupo
-- poor_query_percentage: ROUND(SUM(rating < 3) * 100.0 / COUNT(*), 2)
--   SUM(rating < 3) cuenta las filas con rating menor a 3
--   * 100.0 / COUNT(*) lo convierte a porcentaje

SELECT 
    query_name,                                                -- Nombre de la consulta
    ROUND(                                                     -- Redondear a 2 decimales
        AVG(rating * 1.0 / position),                          -- Promedio de (rating / posición)
    2) AS quality,                                             -- Alias: calidad
    ROUND(                                                     -- Redondear a 2 decimales
        SUM(rating < 3) * 100.0                                -- Filas con rating < 3 * 100
        / COUNT(*),                                            -- Dividido entre total de filas
    2) AS poor_query_percentage                                -- Alias: % mala calificación
FROM Queries                                                   -- Tabla de consultas
GROUP BY query_name;                                           -- Agrupar por consulta

/*
POR QUÉ CADA PARTE:
- FROM Queries: Es la única tabla disponible
- GROUP BY query_name: Agrupa por consulta para calcular por cada una
- AVG(rating * 1.0 / position): Promedio de la razón rating/posición
  (* 1.0 asegura que la división sea decimal, no entera)
- SUM(rating < 3): Cuenta filas con mala calificación
  (la condición devuelve 1 si es true, 0 si es false, y SUM los suma)
- * 100.0 / COUNT(*): Convierte el conteo a porcentaje
- ROUND(..., 2): El problema pide 2 decimales en ambos cálculos

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- GROUP BY (agrupar filas por una columna)
- AVG() (función de agregación para calcular promedios)
- SUM() con condición booleana (contar filas que cumplen una condición)
- COUNT(*) (contar total de filas por grupo)
- ROUND() (redondear a cierta cantidad de decimales)
- Operaciones aritméticas (* 1.0, * 100.0)
*/
