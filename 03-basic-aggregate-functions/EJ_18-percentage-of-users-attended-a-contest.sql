-- 1633. Percentage of Users Attended a Contest
-- Dificultad: Fácil
-- https://leetcode.com/problems/percentage-of-users-attended-a-contest/

/*
PROBLEMA:
Escribir una consulta que calcule el porcentaje de usuarios que se
registraron en cada concurso.
Porcentaje = (usuarios registrados / total de usuarios) * 100.
Redondear a 2 decimales.
Ordenar por porcentaje DESC, y si hay empate por contest_id ASC.

TABLAS:
- Users (user_id, user_name)
  - user_id: identificador único del usuario
  - user_name: nombre del usuario
- Register (contest_id, user_id)
  - contest_id: id del concurso
  - user_id: id del usuario que se registró
  - (contest_id, user_id) es la clave única

RESULTADO ESPERADO:
| contest_id | percentage |
|------------|------------|
| 208        | 100.00     |
| 209        | 100.00     |
| 210        | 50.00      |
| 215        | 33.33      |
*/

-- PASO 1: FROM para seleccionar la tabla base
-- Users como tabla base

-- PASO 2: RIGHT JOIN para traer todos los registros de concursos
-- RIGHT JOIN porque queremos todos los registros de Register (tabla derecha)
-- ON para conectar ambas tablas por user_id

-- PASO 3: GROUP BY para agrupar por concurso
-- Necesitamos un porcentaje POR CADA concurso

-- PASO 4: ORDER BY con dos criterios para ordenar el resultado
-- Primero por porcentaje DESC (mayor a menor)
-- Segundo por contest_id ASC para desempatar (menor a mayor)

-- PASO 5: SELECT con subconsulta para calcular el porcentaje
-- COUNT(r.user_id): Usuarios registrados en cada concurso
-- (SELECT COUNT(*) FROM Users): Total de usuarios en la plataforma (subconsulta)
-- * 100.0: Convertir a porcentaje
-- ROUND(..., 2): Redondear a 2 decimales

SELECT r.contest_id,                                           -- Id del concurso
       ROUND(                                                  -- Redondear a 2 decimales
           COUNT(r.user_id) * 100.0                            -- Registrados * 100
           / (SELECT COUNT(*) FROM Users),                     -- Dividido entre total de usuarios
       2) AS percentage                                        -- Alias que pide el problema
FROM Users u                                                   -- Tabla base: usuarios
RIGHT JOIN Register r                                          -- Traer todos los registros
    ON u.user_id = r.user_id                                   -- Condición de unión: mismo user_id
GROUP BY r.contest_id                                          -- Agrupar por concurso
ORDER BY percentage DESC, r.contest_id ASC;                    -- Ordenar por % DESC, id ASC

/*
POR QUÉ CADA PARTE:
- FROM Users: Tabla base de usuarios
- RIGHT JOIN Register: Mantiene todos los registros de concursos (tabla derecha)
- ON u.user_id = r.user_id: Conecta ambas tablas por el id del usuario
- GROUP BY r.contest_id: Agrupa por concurso para un porcentaje por cada uno
- COUNT(r.user_id) * 100.0: Cantidad de registrados convertida a porcentaje
- (SELECT COUNT(*) FROM Users): Subconsulta que obtiene el total de usuarios
  (se ejecuta una vez y su resultado se usa en la división)
- ROUND(..., 2): El problema pide 2 decimales
- ORDER BY percentage DESC, r.contest_id ASC: Ordena por porcentaje de mayor a menor,
  y si hay empate, por contest_id de menor a mayor

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- RIGHT JOIN (unir tablas manteniendo todos los registros de la derecha)
- ON (condición de unión entre tablas)
- GROUP BY (agrupar filas por una columna)
- ORDER BY con múltiples criterios (DESC y ASC)
- COUNT() (función de agregación para contar filas)
- Subconsulta / Subquery (consulta dentro de otra consulta)
- ROUND() (redondear a cierta cantidad de decimales)
- Operaciones aritméticas (* 100.0 / total)
*/
