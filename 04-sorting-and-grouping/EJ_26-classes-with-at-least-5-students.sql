-- 596. Classes More Than 5 Students
-- Dificultad: Fácil
-- https://leetcode.com/problems/classes-more-than-5-students/

/*
PROBLEMA:
Encontrar todas las clases que tengan 5 o más estudiantes inscritos.

TABLAS:

Courses (student, class)

RESULTADO ESPERADO:

class
Math
*/

-- PASO 1: FROM Courses para seleccionar la única tabla disponible

-- PASO 2: GROUP BY class para agrupar por clase
-- Necesitamos contar estudiantes POR cada clase

-- PASO 3: HAVING COUNT(student) >= 5 para filtrar las clases
-- Usamos HAVING porque filtramos sobre el resultado de COUNT()
-- WHERE no sirve aquí porque el conteo se hace DESPUÉS de agrupar

-- PASO 4: SELECT class para mostrar solo el nombre de la clase

SELECT
    class                                   -- Nombre de la clase
FROM Courses                                -- Tabla de cursos
GROUP BY class                              -- Agrupar por clase
HAVING COUNT(student) >= 5;                 -- Solo clases con 5 o más estudiantes

/*
POR QUÉ CADA PARTE:

- GROUP BY class: Necesitamos agrupar para contar estudiantes por clase
- HAVING COUNT(student) >= 5: Filtramos grupos (no filas individuales), por eso HAVING y no WHERE
- SELECT solo class: El problema solo pide el nombre de la clase, no el conteo

CONCEPTOS NUEVOS:
- Ninguno (combinación de GROUP BY, HAVING y COUNT() ya vistos)
*/
