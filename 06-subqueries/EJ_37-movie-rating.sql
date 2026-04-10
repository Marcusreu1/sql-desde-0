-- 1341. Movie Rating
-- Dificultad: Media
-- https://leetcode.com/problems/movie-rating/

/*
PROBLEMA:
Encontrar dos cosas:
1. El usuario que ha calificado más películas (empate: primero alfabéticamente)
2. La película con mayor promedio de rating en feb 2020 (empate: primero alfabéticamente)
Ambos resultados en una sola columna "results".

TABLAS:

Movies (movie_id, title)
Users (user_id, name)
MovieRating (movie_id, user_id, rating, created_at)

RESULTADO ESPERADO:

results
Daniel
Frozen 2
*/

-- CONSULTA 1: Usuario que más películas ha calificado
-- PASO 1: JOIN entre Users y MovieRating para conectar usuarios con calificaciones
-- PASO 2: GROUP BY para agrupar por usuario
-- PASO 3: ORDER BY COUNT(*) DESC para el que más calificó primero
--         name ASC como desempate alfabético
-- PASO 4: LIMIT 1 para quedarnos con el primero

-- CONSULTA 2: Película mejor calificada en febrero 2020
-- PASO 1: JOIN entre Movies y MovieRating para conectar películas con calificaciones
-- PASO 2: WHERE BETWEEN para filtrar solo febrero 2020
-- PASO 3: GROUP BY para agrupar por película
-- PASO 4: ORDER BY AVG(rating) DESC para mayor promedio primero
--         title ASC como desempate alfabético
-- PASO 5: LIMIT 1 para quedarnos con la primera

-- UNION ALL para unir ambos resultados sin eliminar duplicados

(SELECT
    name AS results                                         -- Nombre del usuario
FROM Users u                                                -- Tabla de usuarios
JOIN MovieRating mr                                         -- Tabla de calificaciones
    ON u.user_id = mr.user_id                               -- Condición: mismo usuario
GROUP BY u.user_id, u.name                                  -- Agrupar por usuario
ORDER BY COUNT(*) DESC, name ASC                            -- Más calificaciones primero, empate: alfabético
LIMIT 1)                                                    -- Solo el primero

UNION ALL                                                   -- Unir sin eliminar duplicados

(SELECT
    title AS results                                        -- Título de la película
FROM Movies m                                               -- Tabla de películas
JOIN MovieRating mr                                         -- Tabla de calificaciones
    ON m.movie_id = mr.movie_id                             -- Condición: misma película
WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'     -- Solo febrero 2020
GROUP BY m.movie_id, m.title                                -- Agrupar por película
ORDER BY AVG(rating) DESC, title ASC                        -- Mayor promedio primero, empate: alfabético
LIMIT 1);                                                   -- Solo la primera

/*
POR QUÉ CADA PARTE:

- Dos consultas separadas: El problema pide dos cosas completamente diferentes
- UNION ALL en vez de UNION: Si el usuario y la película se llaman igual, UNION eliminaría uno
- Paréntesis en cada consulta: Necesarios para que ORDER BY y LIMIT funcionen por separado
  - Sin paréntesis: el ORDER BY y LIMIT se aplicarían al resultado final combinado
- ORDER BY con dos criterios: Primero el principal (COUNT o AVG) y luego el desempate (nombre/título)
- LIMIT 1 en ambas: Solo queremos un resultado de cada consulta

CONCEPTOS NUEVOS:
- UNION ALL (combina resultados sin eliminar duplicados, a diferencia de UNION)
*/
