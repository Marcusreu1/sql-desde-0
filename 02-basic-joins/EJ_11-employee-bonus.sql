-- 577. Employee Bonus
-- Dificultad: Fácil
-- https://leetcode.com/problems/employee-bonus/

/*
PROBLEMA:
Escribir una consulta que devuelva el nombre y el bono de cada empleado
cuyo bono sea menor a 1000. Los empleados sin bono también deben aparecer.

TABLAS:
- Employee (empId, name, supervisor, salary)
  - empId: identificador único del empleado
  - name: nombre del empleado
  - supervisor: id del supervisor
  - salary: salario del empleado
- Bonus (empId, bonus)
  - empId: id del empleado
  - bonus: monto del bono
  - No todos los empleados tienen un bono

RESULTADO ESPERADO:
| name | bonus |
|------|-------|
| Brad | null  |
| John | null  |
| Dan  | 500   |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Employee es la tabla principal porque necesitamos TODOS los empleados

-- PASO 2: LEFT JOIN para traer la información del bono
-- LEFT JOIN porque queremos todos los empleados aunque no tengan bono
-- ON para conectar ambas tablas por empId

-- PASO 3: WHERE para filtrar los empleados con bono < 1000 o sin bono
-- Condición 1: bonus < 1000 (bono menor a 1000)
-- Condición 2: bonus IS NULL (empleados sin bono)
-- Usamos OR porque basta con cumplir UNA de las dos condiciones
-- Sin IS NULL, los empleados sin bono se excluirían

-- PASO 4: SELECT para indicar qué columnas queremos ver
-- El problema pide: name y bonus

SELECT name,                                       -- Nombre del empleado
       bonus                                       -- Monto del bono (NULL si no tiene)
FROM Employee                                      -- Tabla principal: empleados
LEFT JOIN Bonus                                    -- Traer info de bonos
    ON Employee.empId = Bonus.EmpId                -- Condición de unión: mismo empId
WHERE Bonus.bonus < 1000                           -- Bono menor a 1000
   OR Bonus.bonus IS NULL;                         -- O sin bono (NULL)

/*
POR QUÉ CADA PARTE:
- FROM Employee: Es la tabla que contiene todos los empleados
- LEFT JOIN Bonus: Trae el bono sin perder empleados que no tengan uno
  (INNER JOIN los perdería)
- ON Employee.empId = Bonus.EmpId: Conecta ambas tablas por el id del empleado
- WHERE bonus < 1000: Filtra empleados con bono menor a 1000
- OR bonus IS NULL: Incluye empleados sin bono
  (sin esto, los NULL se excluirían porque NULL < 1000 no es verdadero)

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON (condición de unión entre tablas)
- WHERE (filtrar filas con condiciones)
- IS NULL (verificar valores nulos)
- OR (operador lógico: al menos una condición debe cumplirse)
- < (operador menor que)
*/
