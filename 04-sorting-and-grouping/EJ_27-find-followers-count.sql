-- 1729. Find Followers Count
-- Dificultad: Fácil
-- https://leetcode.com/problems/find-followers-count/

/*
PROBLEMA:
Calcular la cantidad de seguidores de cada usuario.
Ordenar los resultados por user_id de forma ascendente.

TABLAS:

Followers (user_id, follower_id)

RESULTADO ESPERADO:

user_id  followers_count
0        1
1        1
2        2
*/

-- PASO 1: FROM Followers para seleccionar la única tabla disponible

-- PASO 2: GROUP BY user_id para agrupar por usuario
-- Necesitamos contar seguidores POR cada usuario

-- PASO 3: ORDER BY user_id para ordenar de forma ascendente
-- El problema pide explícitamente este orden

-- PASO 4: SELECT con user_id y COUNT(follower_id) para el conteo de seguidores

SELECT
    user_id,                                    -- Identificador del usuario
    COUNT(follower_id) AS followers_count        -- Cantidad de seguidores
FROM Followers                                   -- Tabla de seguidores
GROUP BY user_id                                 -- Agrupar por usuario
ORDER BY user_id;                                -- Ordenar por user_id ascendente

/*
POR QUÉ CADA PARTE:

- GROUP BY user_id: Necesitamos agrupar para contar seguidores por usuario
- COUNT(follower_id): Cuenta los seguidores de cada usuario
- ORDER BY user_id: Formato de salida requerido por el problema (ascendente por defecto)

CONCEPTOS NUEVOS:
- Ninguno (combinación de GROUP BY, COUNT() y ORDER BY ya vistos)
*/
