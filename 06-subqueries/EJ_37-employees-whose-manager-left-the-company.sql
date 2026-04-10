-- 1978. Employees Whose Manager Left the Company
-- Dificultad: Fácil
-- https://leetcode.com/problems/employees-whose-manager-left-the-company/

/*
PROBLEMA:
Encontrar los empleados que tienen un salario menor a 30000
y cuyo manager ya no está en la empresa.
Ordenar por employee_id.

TABLAS:

Employees (employee_id, name, manager_id, salary)

RESULTADO ESPERADO:

employee_id
11
*/

-- PASO 1: FROM Employees para seleccionar la única tabla disponible

-- PASO 2: WHERE con tres condiciones unidas por AND
-- salary < 30000: solo empleados con salario bajo
-- manager_id IS NOT NULL: que tengan un manager asignado
-- manager_id NOT IN (subconsulta): que su manager ya no exista en la tabla

-- PASO 3: Subconsulta para obtener todos los employee_id existentes
-- Si el manager_id no está en esta lista → el manager dejó la empresa

-- PASO 4: ORDER BY employee_id para ordenar el resultado

SELECT
    employee_id                                             -- Identificador del empleado
FROM Employees                                              -- Tabla de empleados
WHERE salary < 30000                                        -- Salario menor a 30000
    AND manager_id IS NOT NULL                              -- Que tenga un manager asignado
    AND manager_id NOT IN(                                  -- Cuyo manager ya NO exista
        SELECT employee_id                                  -- Lista de empleados actuales
        FROM Employees                                      -- En la misma tabla
    )
ORDER BY employee_id;                                       -- Ordenar por id del empleado

/*
POR QUÉ CADA PARTE:

- salary < 30000: El problema solo pide empleados con salario bajo
- manager_id IS NOT NULL: Si no tiene manager, no aplica (no tiene jefe que haya dejado la empresa)
  - Sin esto: podría incluir empleados sin jefe que no son relevantes
- NOT IN (subconsulta): Verificar que el manager_id no exista como employee_id
  - Si el manager_id no está en la lista de empleados actuales → se fue de la empresa
- ORDER BY: Formato de salida requerido por el problema

CONCEPTOS NUEVOS:
- NOT IN (inverso de IN: verifica que un valor NO esté en un conjunto de resultados)
*/
