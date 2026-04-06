-- 1378. Replace Employee ID With The Unique Identifier
-- Dificultad: Fácil
-- https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/

/*
PROBLEMA:
Escribir una consulta que muestre el unique_id y el nombre de cada empleado.
Si un empleado no tiene un unique_id, debe aparecer como NULL.

TABLAS:
- Employees (id, name)
  - id: identificador único del empleado
  - name: nombre del empleado
- EmployeeUNI (id, unique_id)
  - id: id del empleado
  - unique_id: identificador único alternativo del empleado
  - No todos los empleados tienen un unique_id

RESULTADO ESPERADO:
| unique_id | name     |
|-----------|----------|
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Employees es la tabla principal porque necesitamos TODOS los empleados

-- PASO 2: LEFT JOIN para traer la información del unique_id
-- LEFT JOIN porque queremos todos los empleados aunque no tengan unique_id
-- ON para conectar ambas tablas por la columna que tienen en común (id)

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- unique_id de la tabla EmployeeUNI y name de la tabla Employees

SELECT eu.unique_id,                     -- Id único alternativo (NULL si no tiene)
       e.name                            -- Nombre del empleado
FROM Employees e                         -- Tabla principal: todos los empleados
LEFT JOIN EmployeeUNI eu                 -- Traer info de unique_id (LEFT = incluir todos)
    ON e.id = eu.id;                     -- Condición de unión: mismo id de empleado

/*
POR QUÉ CADA PARTE:
- FROM Employees: Es la tabla que contiene todos los empleados
- LEFT JOIN EmployeeUNI: Trae el unique_id, pero sin perder empleados que no lo tengan
  (INNER JOIN los perdería)
- ON e.id = eu.id: Conecta ambas tablas por el id del empleado
- SELECT eu.unique_id, e.name: Son las columnas que pide el problema

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON (condición de unión entre tablas)
- Alias de tablas (e, eu) para simplificar la escritura
*/
