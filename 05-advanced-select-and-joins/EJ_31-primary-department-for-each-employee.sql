-- 1789. Primary Department for Each Employee
-- Dificultad: Fácil
-- https://leetcode.com/problems/primary-department-for-each-employee/

/*
PROBLEMA:
Encontrar el departamento principal de cada empleado.
- Si pertenece a varios departamentos: el que tiene primary_flag = 'Y'
- Si pertenece a un solo departamento: ese es el principal por defecto

TABLAS:

Employee (employee_id, department_id, primary_flag)

RESULTADO ESPERADO:

employee_id  department_id
1            1
2            1
3            3
4            2
*/

-- PASO 1: FROM Employee para seleccionar la única tabla disponible

-- PASO 2: WHERE con dos condiciones unidas por OR
-- Caso 1: primary_flag = 'Y' → empleados con departamento marcado como principal
-- Caso 2: subconsulta para encontrar empleados con un solo departamento
--         GROUP BY employee_id + HAVING COUNT(*) = 1 → un solo registro = un solo departamento

-- PASO 3: SELECT employee_id y department_id

SELECT
    employee_id,                                            -- Identificador del empleado
    department_id                                           -- Su departamento principal
FROM Employee                                               -- Tabla de empleados
WHERE primary_flag = 'Y'                                    -- Caso 1: flag marcado como principal
   OR employee_id IN (                                      -- Caso 2: empleados con un solo departamento
       SELECT employee_id                                   -- Buscar empleados
       FROM Employee                                        -- En la misma tabla
       GROUP BY employee_id                                 -- Agrupar por empleado
       HAVING COUNT(*) = 1                                  -- Que tengan exactamente un registro
   );

/*
POR QUÉ CADA PARTE:

- primary_flag = 'Y': Cubre el caso de empleados con múltiples departamentos
- Subconsulta con HAVING COUNT(*) = 1: Cubre el caso de empleados con un solo departamento
  que puede no tener la 'Y' pero igual es su principal por defecto
- OR: Necesitamos ambos casos, con que cumpla uno de los dos es suficiente
- Sin el OR: 
  - Solo con flag 'Y': perderíamos empleados de un solo departamento sin flag
  - Solo con subconsulta: perderíamos el departamento principal de los que tienen varios
*/
