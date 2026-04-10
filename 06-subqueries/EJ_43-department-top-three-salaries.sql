-- 185. Department Top Three Salaries
-- Dificultad: Hard
-- https://leetcode.com/problems/department-top-three-salaries/

/*
PROBLEMA:
Encontrar los empleados que tienen uno de los tres salarios únicos
más altos dentro de su departamento.

TABLAS:

Employee (id, name, salary, departmentId)
Department (id, name)

RESULTADO ESPERADO (ejemplo):

Department  Employee  Salary
IT          Max       90000
IT          Joe       85000
IT          Randy     85000
IT          Will      70000
Sales       Henry     80000
Sales       Sam       60000
*/

-- PASO 1: JOIN entre Employee y Department
-- Necesitamos el nombre del departamento, así que conectamos ambas tablas

-- PASO 2: Subconsulta correlacionada en WHERE
-- Por cada empleado, contamos cuántos salarios DISTINTOS en su mismo
-- departamento son MAYORES al suyo
-- Si ese conteo es menor que 3, el empleado está en el top 3

-- PASO 3: SELECT con los campos requeridos
-- Nombre del departamento, nombre del empleado y salario

SELECT
    d.name AS Department,                -- Nombre del departamento
    e1.name AS Employee,                 -- Nombre del empleado
    e1.salary AS Salary                  -- Salario del empleado
FROM Employee e1                         -- Tabla principal: empleados
JOIN Department d                        -- Unimos con departamentos
    ON e1.departmentId = d.id            -- Condición: mismo departamento
WHERE 3 > (                              -- Filtramos: el conteo debe ser menor a 3
    SELECT COUNT(DISTINCT e2.salary)     -- Contamos salarios únicos...
    FROM Employee e2                     -- ...de otros empleados
    WHERE e2.departmentId = e1.departmentId  -- Del mismo departamento (correlación)
    AND e2.salary > e1.salary            -- Que ganen MÁS que el empleado actual
);

/*
POR QUÉ CADA PARTE:

JOIN: Necesitamos el nombre del departamento que está en otra tabla
Subconsulta correlacionada: Permite comparar cada empleado contra
    su propio departamento, fila por fila
COUNT(DISTINCT): Contamos salarios únicos, no empleados (si dos ganan
    igual, cuenta como un solo salario)
3 > (...): Si hay 0, 1 o 2 salarios mayores, el empleado está en el top 3

CONCEPTOS USADOS:

- JOIN
- Subconsulta correlacionada (Correlated Subquery) [NUEVO]
- COUNT(DISTINCT)
- Comparación con resultado de subconsulta
*/
