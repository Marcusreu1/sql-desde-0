-- 610. Triangle Judgement
-- Dificultad: Fácil
-- https://leetcode.com/problems/triangle-judgement/

/*
PROBLEMA:
Determinar si los tres lados de cada fila pueden formar un triángulo válido.
Devolver 'Yes' si es posible y 'No' si no lo es.

TABLAS:

Triangle (x, y, z)

RESULTADO ESPERADO:

x   y   z   triangle
13  15  30  No
10  20  15  Yes
*/

-- PASO 1: FROM Triangle para seleccionar la única tabla disponible

-- PASO 2: CASE WHEN para evaluar la desigualdad del triángulo
-- Las tres condiciones deben cumplirse al mismo tiempo (AND):
-- x + y > z
-- x + z > y
-- y + z > x
-- Si las tres se cumplen → 'Yes', si no → 'No'

SELECT
    x,                                                      -- Primer lado
    y,                                                      -- Segundo lado
    z,                                                      -- Tercer lado
    CASE
        WHEN ((x+y > z) AND (x+z > y) AND (z+y > x))      -- Desigualdad del triángulo
        THEN 'Yes'                                          -- Sí forma triángulo
        ELSE 'No'                                           -- No forma triángulo
    END AS triangle                                         -- Alias del resultado
FROM Triangle;                                              -- Tabla de lados

/*
POR QUÉ CADA PARTE:

- CASE WHEN: Necesitamos evaluar una condición y devolver un valor según el resultado
- Tres condiciones con AND: La desigualdad del triángulo requiere que TODAS se cumplan
  - Si falta una sola, no se puede formar el triángulo
- Sin WHERE: No filtramos nada, evaluamos TODAS las filas
- Sin GROUP BY: No agrupamos, cada fila se evalúa individualmente

CONCEPTOS NUEVOS:
- Ninguno (CASE WHEN y AND ya vistos, la lógica matemática del triángulo es externa a SQL)
*/
