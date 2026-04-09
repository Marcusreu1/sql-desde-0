-- 1731. The Number of Employees Which Report to Each Employee
-- Dificultad: Fácil
-- https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/

/*
PROBLEMA:
Encontrar los empleados que tienen al menos una persona que les reporta.
Para cada uno, mostrar la cantidad de reportes directos y el promedio
de edad de esos empleados, redondeado al entero más cercano.
Ordenar por employee_id.

TABLAS:

Employees (employee_id, name, reports_to, age)

RESULTADO ESPERADO:

employee_id  name   reports_count  average_age
9            Hercy  2              39
*/

-- PASO 1: Self JOIN para relacionar managers con sus empleados
-- Alias "e" = managers (jefes)
-- Alias "a" = empleados que reportan
-- ON: el employee_id del manager = reports_to del empleado

-- PASO 2: WHERE a.reports_to IS NOT NULL
-- Filtramos para quedarnos solo con managers que tienen reportes
-- Sin esto, aparecerían también empleados sin nadie reportándoles

-- PASO 3: GROUP BY e.employee_id, e.name
-- Agrupamos por manager para calcular conteo y promedio
-- Ambas columnas porque las dos aparecen en el SELECT

-- PASO 4: ORDER BY e.employee_id
-- El problema pide los resultados ordenados por id

-- PASO 5: SELECT con COUNT y ROUND(AVG())
-- COUNT(a.reports_to): cantidad de empleados que le reportan
-- ROUND(AVG(a.age), 0): promedio de edad redondeado al entero

SELECT
    e.employee_id,                                  -- Identificador del manager
    e.name,                                         -- Nombre del manager
    COUNT(a.reports_to) AS reports_count,            -- Cantidad de empleados que le reportan
    ROUND(AVG(a.age), 0) AS average_age             -- Promedio de edad redondeado al entero
FROM Employees e                                    -- Tabla principal (managers)
LEFT JOIN Employees a                               -- Misma tabla (empleados que reportan)
    ON e.employee_id = a.reports_to                 -- Manager = reports_to del empleado
WHERE a.reports_to IS NOT NULL                      -- Solo managers con al menos un reporte
GROUP BY e.employee_id, e.name                      -- Agrupar por manager
ORDER BY e.employee_id;                             -- Ordenar por id del manager

/*
POR QUÉ CADA PARTE:

- Self JOIN: Managers y empleados están en la misma tabla, necesitamos relacionarla consigo misma
- Alias "e" y "a": Distinguir el rol de cada copia de la tabla (manager vs empleado)
- LEFT JOIN + WHERE IS NOT NULL: Primero traemos todo y luego filtramos los que sí tienen reportes
- GROUP BY con dos columnas: Ambas se muestran en el SELECT, necesitan estar en el GROUP BY
- ROUND(AVG(), 0): Redondear al entero más cercano (0 decimales)
- ORDER BY: Formato de salida requerido por el problema
*/
