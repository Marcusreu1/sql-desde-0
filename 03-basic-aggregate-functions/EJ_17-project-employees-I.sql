-- 1075. Project Employees I
-- Dificultad: Fácil
-- https://leetcode.com/problems/project-employees-i/

/*
PROBLEMA:
Escribir una consulta que calcule el promedio de años de experiencia
de los empleados asignados a cada proyecto.
Redondear a 2 decimales.

TABLAS:
- Project (project_id, employee_id)
  - project_id: id del proyecto
  - employee_id: id del empleado asignado
  - (project_id, employee_id) es la clave única
- Employee (employee_id, name, experience_years)
  - employee_id: identificador único del empleado
  - name: nombre del empleado
  - experience_years: años de experiencia del empleado

RESULTADO ESPERADO:
| project_id | average_years |
|------------|---------------|
| 1          | 2.00          |
| 2          | 2.50          |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Project es la tabla principal porque necesitamos TODOS los proyectos

-- PASO 2: LEFT JOIN para traer los años de experiencia de cada empleado
-- LEFT JOIN porque queremos todos los proyectos aunque algún empleado no exista
-- ON para conectar ambas tablas por employee_id

-- PASO 3: GROUP BY para agrupar por proyecto
-- Necesitamos un promedio POR CADA proyecto

-- PASO 4: SELECT con ROUND(AVG(...), 2) para calcular el promedio
-- AVG() calcula el promedio simple automáticamente (suma / cantidad)
-- ROUND() redondea a 2 decimales

SELECT p.project_id,                               -- Id del proyecto
       ROUND(                                      -- Redondear a 2 decimales
           AVG(e.experience_years),                -- Promedio de años de experiencia
       2) AS average_years                         -- Alias que pide el problema
FROM Project p                                     -- Tabla principal: proyectos
LEFT JOIN Employee e                               -- Traer info de empleados
    ON p.employee_id = e.employee_id               -- Condición de unión: mismo employee_id
GROUP BY p.project_id;                             -- Agrupar por proyecto

/*
POR QUÉ CADA PARTE:
- FROM Project: Es la tabla que contiene todos los proyectos con sus empleados
- LEFT JOIN Employee: Trae los años de experiencia sin perder ningún proyecto
- ON p.employee_id = e.employee_id: Conecta ambas tablas por el id del empleado
- GROUP BY p.project_id: Agrupa por proyecto para un promedio por cada uno
- AVG(e.experience_years): Promedio simple de años de experiencia
  (a diferencia del ejercicio anterior, aquí no necesitamos ponderar)
- ROUND(..., 2): El problema pide 2 decimales

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON (condición de unión entre tablas)
- GROUP BY (agrupar filas por una columna)
- AVG() (función de agregación para calcular promedios simples)
- ROUND() (redondear a cierta cantidad de decimales)
- Alias de tablas (p, e) para simplificar la escritura
*/
