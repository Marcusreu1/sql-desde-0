-- 570. Managers with at Least Five Direct Reports
-- Dificultad: Medio
-- https://leetcode.com/problems/managers-with-at-least-five-direct-reports/

/*
PROBLEMA:
Escribir una consulta que encuentre los nombres de los managers
que tienen al menos 5 empleados que les reportan directamente.

TABLA:
- Employee (id, name, department, managerId)
  - id: identificador único del empleado
  - name: nombre del empleado
  - department: departamento del empleado
  - managerId: id del manager/jefe directo (puede ser NULL)

RESULTADO ESPERADO:
| name |
|------|
| John |
*/

-- PASO 1: FROM con Self JOIN para conectar empleados con sus managers
-- employee representa a los empleados que reportan
-- manager representa a los jefes

-- PASO 2: JOIN (INNER JOIN) porque solo nos interesan empleados que SÍ tienen manager
-- ON para conectar el managerId del empleado con el id del manager

-- PASO 3: GROUP BY para agrupar por manager
-- Agrupamos por manager.id porque es el valor único
-- (podrían existir dos managers con el mismo nombre)

-- PASO 4: HAVING para filtrar managers con al menos 5 reportes
-- Usamos HAVING y no WHERE porque estamos filtrando con COUNT()
-- WHERE se ejecuta ANTES del GROUP BY, HAVING se ejecuta DESPUÉS

-- PASO 5: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos el nombre del manager

SELECT manager.name                                -- Nombre del manager
FROM Employee employee                             -- Tabla: empleados que reportan
JOIN Employee manager                              -- Self JOIN: managers/jefes
    ON employee.managerId = manager.id             -- Conectar empleado con su manager
GROUP BY manager.id                                -- Agrupar por manager
HAVING COUNT(*) >= 5;                              -- Solo managers con 5 o más reportes

/*
POR QUÉ CADA PARTE:
- FROM Employee employee: Representa los empleados que reportan a alguien
- JOIN Employee manager: Conecta cada empleado con su manager (misma tabla)
  (INNER JOIN porque solo nos interesan empleados con manager)
- ON employee.managerId = manager.id: El managerId del empleado = id del manager
- GROUP BY manager.id: Agrupa por manager para contar empleados por cada uno
- HAVING COUNT(*) >= 5: Filtra solo managers con 5 o más reportes directos
  (no podemos usar WHERE porque filtramos con una función de agregación)
- SELECT manager.name: El problema solo pide el nombre del manager

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- Self JOIN (unir una tabla consigo misma)
- JOIN / INNER JOIN (solo registros con coincidencia en ambos lados)
- ON (condición de unión entre tablas)
- GROUP BY (agrupar filas por una columna)
- HAVING (filtrar grupos usando funciones de agregación)
- COUNT(*) (función de agregación para contar filas)
- >= (operador mayor o igual que)
- Alias descriptivos de tablas (employee, manager)
*/
