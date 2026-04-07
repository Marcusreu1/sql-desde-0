-- 1280. Students and Examinations
-- Dificultad: Fácil
-- https://leetcode.com/problems/students-and-examinations/

/*
PROBLEMA:
Escribir una consulta que muestre cada estudiante con cada materia
y cuántas veces ese estudiante presentó el examen de esa materia.
Deben aparecer TODAS las combinaciones, incluso si el conteo es 0.
Ordenar por student_id y subject_name.

TABLAS:
- Students (student_id, student_name)
  - student_id: identificador único del estudiante
  - student_name: nombre del estudiante
- Subjects (subject_name)
  - subject_name: nombre de la materia (valor único)
- Examinations (student_id, subject_name)
  - student_id: id del estudiante
  - subject_name: nombre de la materia
  - No tiene valor único, cada fila = una vez que se presentó el examen

RESULTADO ESPERADO:
| student_id | student_name | subject_name | attended_exams |
|------------|--------------|--------------|----------------|
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Students es nuestra tabla base

-- PASO 2: CROSS JOIN para generar TODAS las combinaciones de estudiantes y materias
-- No necesita ON porque su objetivo es hacer todas las combinaciones posibles

-- PASO 3: LEFT JOIN para traer la información de exámenes presentados
-- LEFT JOIN porque queremos mantener TODAS las combinaciones del CROSS JOIN
-- ON con dos condiciones: mismo estudiante Y misma materia

-- PASO 4: GROUP BY con múltiples columnas
-- Agrupamos por estudiante y materia para contar exámenes por cada combinación

-- PASO 5: ORDER BY para ordenar como pide el problema
-- Ordenar por student_id y subject_name

-- PASO 6: SELECT con COUNT(columna específica)
-- COUNT(e.student_id) no cuenta los NULL, así los que no tienen examen quedan en 0

SELECT s.student_id,                               -- Id del estudiante
       s.student_name,                             -- Nombre del estudiante
       su.subject_name,                            -- Nombre de la materia
       COUNT(e.student_id) AS attended_exams       -- Cantidad de exámenes presentados
FROM Students s                                    -- Tabla principal: estudiantes
CROSS JOIN Subjects su                             -- Todas las combinaciones con materias
LEFT JOIN Examinations e                           -- Traer info de exámenes presentados
    ON s.student_id = e.student_id                 -- Mismo estudiante
    AND su.subject_name = e.subject_name           -- Misma materia
GROUP BY s.student_id, s.student_name,             -- Agrupar por estudiante
         su.subject_name                           -- y por materia
ORDER BY s.student_id, su.subject_name;            -- Ordenar por id y materia

/*
POR QUÉ CADA PARTE:
- FROM Students: Tabla base con todos los estudiantes
- CROSS JOIN Subjects: Genera todas las combinaciones estudiante-materia
  (sin esto, solo aparecerían las combinaciones que tienen exámenes)
- LEFT JOIN Examinations: Trae los exámenes sin perder combinaciones sin examen
- ON con dos condiciones: Conecta por estudiante Y materia al mismo tiempo
- GROUP BY con 3 columnas: Un conteo por cada combinación estudiante-materia
- COUNT(e.student_id): No cuenta NULL, así las combinaciones sin examen = 0
  (COUNT(*) daría 1 en vez de 0, lo cual sería incorrecto)
- ORDER BY: Ordena como lo pide el problema

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- CROSS JOIN (generar todas las combinaciones posibles entre dos tablas)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON con múltiples condiciones (AND)
- GROUP BY con múltiples columnas
- COUNT(columna) (contar filas excluyendo NULL)
- ORDER BY (ordenar resultados)
- Alias de tablas (s, su, e) para simplificar la escritura
*/
