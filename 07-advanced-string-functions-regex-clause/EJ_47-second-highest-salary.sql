-- 176. Second Highest Salary
-- Dificultad: Medium
-- https://leetcode.com/problems/second-highest-salary/

/*
PROBLEMA:
Encontrar el segundo salario más alto de la tabla Employee.
Si no existe, devolver NULL.

TABLA:

Employee (id, salary)

RESULTADO ESPERADO (ejemplo):

SecondHighestSalary
200
*/

-- PASO 1: Subconsulta para encontrar el segundo salario
-- DISTINCT salary → eliminar salarios duplicados
-- ORDER BY salary DESC → ordenar de mayor a menor
-- LIMIT 1 OFFSET 1 → saltar el primero y tomar el segundo

-- PASO 2: Envolver en SELECT externo
-- Si la subconsulta no encuentra resultado, devuelve NULL automáticamente
-- Esto cubre el caso donde no exista un segundo salario

SELECT
    (SELECT DISTINCT salary            -- Salarios únicos
     FROM Employee                     -- Tabla de empleados
     ORDER BY salary DESC              -- De mayor a menor
     LIMIT 1 OFFSET 1                  -- Saltar el 1ro, tomar el 2do
    ) AS SecondHighestSalary;          -- Alias del resultado (NULL si no existe)

/*
POR QUÉ CADA PARTE:

DISTINCT: Si varios empleados ganan lo mismo, cuenta como un solo salario
ORDER BY salary DESC: Necesitamos que el más alto quede primero para poder
    saltar al segundo con OFFSET
LIMIT 1 OFFSET 1: OFFSET salta el salario más alto, LIMIT toma solo el siguiente
Subconsulta en SELECT: Si no hay segundo salario, devuelve NULL automáticamente
    (requisito del problema)

CONCEPTOS USADOS:

- OFFSET (saltar filas antes de tomar resultados) [NUEVO]
- LIMIT
- DISTINCT
- ORDER BY DESC
- Subconsulta en el SELECT
*/
