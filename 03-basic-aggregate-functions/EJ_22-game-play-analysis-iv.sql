-- 550. Game Play Analysis IV
-- Dificultad: Media
-- https://leetcode.com/problems/game-play-analysis-iv/

/*
PROBLEMA:
Calcular la fracción de jugadores que volvieron a iniciar sesión
al día siguiente de su primer inicio de sesión.
Redondear a 2 decimales.

TABLAS:

Activity (player_id, device_id, event_date, games_played)

RESULTADO ESPERADO:

fraction
0.33
*/

-- PASO 1: Subconsulta en el FROM para obtener el primer login de cada jugador
-- MIN(event_date) nos da la fecha más antigua (primer inicio de sesión)
-- GROUP BY player_id para agrupar por jugador
-- Esta subconsulta funciona como una tabla temporal con alias "first"

-- PASO 2: LEFT JOIN con Activity para buscar si jugaron al día siguiente
-- LEFT JOIN porque queremos TODOS los jugadores (incluso los que no volvieron)
-- ON con dos condiciones: mismo jugador Y fecha = primer login + 1 día
-- DATE_ADD con INTERVAL 1 DAY para calcular el día siguiente

-- PASO 3: COUNT(next_day.event_date) para contar los que SÍ volvieron
-- COUNT(columna) no cuenta NULL → solo cuenta los que tienen match en el JOIN

-- PASO 4: Dividir entre COUNT(first.player_id) para obtener la fracción
-- Multiplicar por 1.0 para forzar división decimal

-- PASO 5: ROUND(..., 2) para redondear a 2 decimales

SELECT
    ROUND(                                                  -- Redondear a 2 decimales
        COUNT(next_day.event_date) * 1.0                    -- Jugadores que volvieron al día siguiente
        / COUNT(first.player_id),                           -- Total de jugadores
    2) AS fraction                                          -- Alias del resultado
FROM (
    SELECT player_id, MIN(event_date) AS first_login        -- Primer login de cada jugador
    FROM Activity                                           -- Tabla de actividad
    GROUP BY player_id                                      -- Agrupar por jugador
) AS first                                                  -- Alias de la tabla derivada
LEFT JOIN Activity AS next_day                              -- Buscar actividad del día siguiente
    ON first.player_id = next_day.player_id                 -- Mismo jugador
    AND next_day.event_date = DATE_ADD(first.first_login, INTERVAL 1 DAY); -- Día siguiente al primer login

/*
POR QUÉ CADA PARTE:

- Subconsulta en FROM: Necesitamos el primer login como tabla base para hacer el JOIN
- LEFT JOIN: Mantener todos los jugadores, incluso los que no volvieron (aparecen como NULL)
- DATE_ADD + INTERVAL 1 DAY: Calcular exactamente el día siguiente al primer login
- COUNT(columna) vs COUNT(*): COUNT(next_day.event_date) ignora NULL, así solo cuenta los que volvieron
- * 1.0: Forzar división decimal para no perder precisión
- ROUND(..., 2): Formato requerido por el problema

CONCEPTOS NUEVOS:
- Subconsulta en el FROM / tabla derivada (usar una subconsulta como si fuera una tabla, requiere alias)
*/
