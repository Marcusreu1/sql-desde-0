-- 1141. User Activity for the Past 30 Days I
-- Dificultad: Fácil
-- https://leetcode.com/problems/user-activity-for-the-past-30-days-i/

/*
PROBLEMA:
Encontrar la cantidad de usuarios activos únicos por día
para el período de 30 días que termina el 2019-07-27 (inclusive).
Un usuario puede tener múltiples actividades en un mismo día,
pero solo debe contarse una vez.

TABLAS:

Activity (user_id, session_id, activity_date, activity_type)

RESULTADO ESPERADO:

day         active_users
2019-07-20  2
2019-07-21  2
*/

-- PASO 1: FROM Activity para seleccionar la única tabla disponible

-- PASO 2: WHERE con BETWEEN para filtrar solo los últimos 30 días
-- El rango va del 2019-06-28 al 2019-07-27 (inclusive ambos extremos)

-- PASO 3: GROUP BY activity_date para agrupar por día
-- Necesitamos un conteo por cada fecha

-- PASO 4: COUNT(DISTINCT user_id) para contar usuarios únicos por día
-- DISTINCT evita contar al mismo usuario más de una vez si tuvo múltiples actividades

SELECT
    activity_date AS day,                           -- Fecha de actividad renombrada como "day"
    COUNT(DISTINCT user_id) AS active_users         -- Usuarios únicos activos ese día
FROM Activity                                       -- Tabla de actividades
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'  -- Solo últimos 30 días
GROUP BY activity_date;                             -- Agrupar por día

/*
POR QUÉ CADA PARTE:

- BETWEEN '2019-06-28' AND '2019-07-27': Filtrar solo el rango de 30 días que pide el problema
- GROUP BY activity_date: Un resultado por cada día
- COUNT(DISTINCT user_id): Un usuario con 5 actividades en un día solo cuenta como 1
- AS day: Alias requerido por el formato de salida del problema

CONCEPTOS NUEVOS:
- Ninguno (combinación de BETWEEN, COUNT(DISTINCT), GROUP BY y AS ya vistos)
*/
