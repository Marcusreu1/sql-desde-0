-- 2356. Number of Unique Subjects Taught by Each Teacher
-- Dificultad: Fácil
-- https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/

/*
PROBLEMA:
Calcular la cantidad de materias únicas que enseña cada profesor.
Un profesor puede enseñar la misma materia en diferentes departamentos,
pero solo debe contarse una vez.

TABLAS:

Teacher (teacher_id, subject_id, dept_id)

RESULTADO ESPERADO:

teacher_id  cnt
1           2
2           4
*/

-- PASO 1: FROM Teacher para seleccionar la única tabla disponible

-- PASO 2: GROUP BY teacher_id para agrupar por profesor
-- Necesitamos un resultado por cada profesor

-- PASO 3: COUNT(DISTINCT subject_id) para contar materias únicas
-- DISTINCT dentro del COUNT evita contar materias repetidas
-- Sin DISTINCT contaría duplicados (misma materia en distintos departamentos)

SELECT
    t.teacher_id,                           -- Identificador del profesor
    COUNT(DISTINCT subject_id) AS cnt       -- Cantidad de materias únicas
FROM Teacher t                              -- Tabla de profesores
GROUP BY t.teacher_id;                      -- Agrupar por profesor

/*
POR QUÉ CADA PARTE:

- GROUP BY teacher_id: Necesitamos un conteo POR cada profesor
- COUNT(DISTINCT subject_id): Solo contar materias únicas, no repetidas por departamento
- Sin DISTINCT: Un profesor con matemáticas en 3 departamentos contaría 3 en vez de 1

CONCEPTOS NUEVOS:
- COUNT(DISTINCT columna) (contar solo valores únicos dentro de un grupo)
*/
