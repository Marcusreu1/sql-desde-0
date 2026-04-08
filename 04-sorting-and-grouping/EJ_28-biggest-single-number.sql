-- 619. Biggest Single Number
-- Dificultad: Fácil
-- https://leetcode.com/problems/biggest-single-number/

/*
PROBLEMA:
Encontrar el número más grande que aparece una sola vez en la tabla.
Si no existe, devolver NULL.

TABLAS:

MyNumbers (num)

RESULTADO ESPERADO:

num
6
*/

-- PASO 1: GROUP BY num para agrupar los números
-- Necesitamos contar cuántas veces aparece cada número

-- PASO 2: HAVING COUNT(num) = 1 para quedarnos solo con los que aparecen una vez
-- Filtramos los grupos que tienen exactamente 1 aparición

-- PASO 3: ORDER BY num DESC para ordenar de mayor a menor
-- Queremos el más grande primero

-- PASO 4: LIMIT 1 para quedarnos solo con el primero (el más grande)

-- PASO 5: Envolver todo en una subconsulta en el SELECT
-- Si la subconsulta no encuentra resultados, devuelve NULL automáticamente

SELECT(
    SELECT num                              -- Seleccionar el número
    FROM MyNumbers                          -- Tabla de números
    GROUP BY num                            -- Agrupar por número
    HAVING COUNT(num) = 1                   -- Solo los que aparecen una vez
    ORDER BY num DESC                       -- Ordenar de mayor a menor
    LIMIT 1                                 -- Quedarnos con el más grande
) AS num;                                   -- Alias del resultado

/*
POR QUÉ CADA PARTE:

- GROUP BY num + HAVING COUNT(num) = 1: Identificar números que aparecen exactamente una vez
- ORDER BY num DESC: Poner el más grande primero
- LIMIT 1: Tomar solo ese número más grande
- Subconsulta en SELECT: Si no hay números únicos, devuelve NULL automáticamente
  - Sin subconsulta: no devolvería ninguna fila (incorrecto)
  - Con subconsulta: devuelve una fila con NULL (correcto)

CONCEPTOS NUEVOS:
- LIMIT (limitar la cantidad de filas en el resultado)
- Subconsulta en el SELECT (devuelve NULL automáticamente si no hay resultados)
*/
