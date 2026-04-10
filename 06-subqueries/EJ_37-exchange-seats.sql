-- 626. Exchange Seats
-- Dificultad: Media
-- https://leetcode.com/problems/exchange-seats/

/*
PROBLEMA:
Intercambiar los asientos de cada par de estudiantes consecutivos.
Si el número total es impar, el último estudiante no se mueve.
Ordenar por id.

TABLAS:

Seat (id, student)

RESULTADO ESPERADO:

id  student
1   Doris
2   Abbot
3   Green
4   Emery
5   Jeames
*/

-- PASO 1: CASE WHEN para manejar tres escenarios de intercambio
-- Caso 1: id impar Y NO es el último → sube un asiento (id + 1)
-- Caso 2: id par → baja un asiento (id - 1)
-- Caso 3 (ELSE): id impar Y es el último → se queda igual

-- PASO 2: Subconsulta para saber el total de asientos
-- SELECT COUNT(*) FROM Seat para verificar si es el último

-- PASO 3: ORDER BY id ASC para ordenar por el nuevo id

SELECT
    CASE
        WHEN id % 2 = 1                                    -- Si el id es impar
            AND id != (SELECT COUNT(*) FROM Seat)           -- Y NO es el último asiento
            THEN id + 1                                     -- Sube un asiento
        WHEN id % 2 = 0                                    -- Si el id es par
            THEN id - 1                                     -- Baja un asiento
        ELSE id                                             -- Último asiento impar: se queda igual
    END AS id,                                              -- Nuevo id después del intercambio
    student                                                 -- Nombre del estudiante
FROM Seat                                                   -- Tabla de asientos
ORDER BY id ASC;                                            -- Ordenar por nuevo id

/*
POR QUÉ CADA PARTE:

- CASE WHEN con tres escenarios: Cada asiento se trata diferente según sea par, impar o el último
  - Impar (no último): Se intercambia con el siguiente → id + 1
  - Par: Se intercambia con el anterior → id - 1
  - Impar (último): No tiene pareja → se queda con el mismo id
- Subconsulta COUNT(*): Necesaria para saber si un id impar es el último
  - Sin esto: el último asiento impar intentaría intercambiarse con uno que no existe
- ORDER BY id ASC: El resultado debe estar ordenado por el nuevo id
- % 2: Operador módulo para determinar si es par o impar (ya visto en ejercicio 15)

CONCEPTOS NUEVOS:
- Ninguno (combinación de CASE WHEN, %, subconsulta y ORDER BY ya vistos)
*/
