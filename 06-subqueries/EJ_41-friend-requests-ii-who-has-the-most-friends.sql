-- 602. Friend Requests II: Who Has the Most Friends
-- Dificultad: Media
-- https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/

/*
PROBLEMA:
Encontrar la persona con más amigos y cuántos amigos tiene.
Una amistad cuenta para ambos lados (quien envía y quien acepta).

TABLAS:

RequestAccepted (requester_id, accepter_id, accept_date)

RESULTADO ESPERADO:

id  num
3   3
*/

-- PASO 1: Primera subconsulta - contar amigos por solicitudes ENVIADAS
-- GROUP BY requester_id + COUNT(*): cuántas solicitudes envió cada persona

-- PASO 2: UNION ALL con segunda subconsulta - contar amigos por solicitudes ACEPTADAS
-- GROUP BY accepter_id + COUNT(*): cuántas solicitudes aceptó cada persona
-- UNION ALL porque no queremos eliminar duplicados entre ambos lados

-- PASO 3: GROUP BY id en consulta externa para juntar ambos conteos
-- SUM(cnt): suma solicitudes enviadas + aceptadas = total de amigos

-- PASO 4: ORDER BY num DESC + LIMIT 1 para obtener el que más amigos tiene

SELECT
    id,                                                     -- Identificador de la persona
    SUM(cnt) AS num                                         -- Total de amigos (enviados + aceptados)
FROM (
    SELECT requester_id AS id, COUNT(*) AS cnt              -- Amigos por solicitudes enviadas
    FROM RequestAccepted                                    -- Tabla de solicitudes
    GROUP BY requester_id                                   -- Agrupar por quien envió

    UNION ALL                                               -- Unir sin eliminar duplicados

    SELECT accepter_id AS id, COUNT(*) AS cnt               -- Amigos por solicitudes aceptadas
    FROM RequestAccepted                                    -- Misma tabla
    GROUP BY accepter_id                                    -- Agrupar por quien aceptó
) AS counts                                                 -- Alias de la tabla combinada
GROUP BY id                                                 -- Juntar ambos conteos por persona
ORDER BY num DESC                                           -- Mayor cantidad de amigos primero
LIMIT 1;                                                    -- Solo la persona con más amigos

/*
POR QUÉ CADA PARTE:

- Dos subconsultas con UNION ALL: Cada amistad cuenta para ambos lados
  - Solo requester_id: ignoraría amigos ganados por aceptar solicitudes
  - Solo accepter_id: ignoraría amigos ganados por enviar solicitudes
- UNION ALL y no UNION: Una persona puede estar en ambos lados y necesitamos ambos conteos
  - UNION eliminaría filas si coincide id y cnt, perdiendo conteos válidos
- SUM(cnt) con GROUP BY: Suma ambos conteos (enviados + aceptados) por persona
- ORDER BY DESC + LIMIT 1: Obtener solo la persona con el mayor total

CONCEPTOS NUEVOS:
- Ninguno (combinación de UNION ALL, GROUP BY, SUM, COUNT, ORDER BY y LIMIT ya vistos)
*/
