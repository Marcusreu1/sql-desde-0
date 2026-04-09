-- 180. Consecutive Numbers
-- Dificultad: Media
-- https://leetcode.com/problems/consecutive-numbers/

/*
PROBLEMA:
Encontrar todos los números que aparecen al menos tres veces consecutivas en la tabla.

TABLAS:

Logs (id, num)

RESULTADO ESPERADO:

ConsecutiveNums
1
*/

-- PASO 1: Subconsulta con LAG() para acceder a filas anteriores
-- LAG(num, 1) OVER (ORDER BY id): obtiene el num de la fila anterior
-- LAG(num, 2) OVER (ORDER BY id): obtiene el num de dos filas atrás
-- OVER (ORDER BY id): define el orden para saber qué fila va antes

-- PASO 2: WHERE para comparar las tres filas consecutivas
-- num = prev_num AND num = prev_prev_num
-- Si los tres son iguales → hay tres consecutivos

-- PASO 3: DISTINCT para evitar duplicados en el resultado
-- Si un número aparece 4+ veces consecutivas, aparecería varias veces sin DISTINCT

SELECT
    DISTINCT num AS ConsecutiveNums                         -- Números consecutivos (sin duplicados)
FROM (
    SELECT
        num,                                                -- Número de la fila actual
        LAG(num, 1) OVER (ORDER BY id) AS prev_num,        -- Número de la fila anterior
        LAG(num, 2) OVER (ORDER BY id) AS prev_prev_num    -- Número de dos filas atrás
    FROM Logs                                               -- Tabla de registros
) AS windowed                                               -- Alias de la tabla derivada
WHERE num = prev_num AND num = prev_prev_num;               -- Los tres deben ser iguales

/*
POR QUÉ CADA PARTE:

- Subconsulta en FROM: Necesitamos primero crear las columnas con LAG para luego filtrar
- LAG(num, 1): Acceder a la fila anterior sin necesidad de Self JOIN
- LAG(num, 2): Acceder a dos filas atrás
- OVER (ORDER BY id): El id garantiza el orden correcto de las filas
- WHERE con dos condiciones AND: Las tres filas deben tener el mismo número
- DISTINCT: Evitar que un número aparezca más de una vez en el resultado

CONCEPTOS NUEVOS:
- Window Functions / funciones de ventana (cálculos sobre filas relacionadas sin agrupar)
- OVER (ORDER BY columna) (define el orden de la ventana)
- LAG(columna, n) (acceder al valor de n filas anteriores)
*/
