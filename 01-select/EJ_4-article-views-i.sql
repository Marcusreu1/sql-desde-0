-- 1148. Article Views I
-- Dificultad: Fácil
-- https://leetcode.com/problems/article-views-i/

/*
PROBLEMA:
Escribir una consulta que encuentre todos los autores que vieron
al menos uno de sus propios artículos.
El resultado debe estar ordenado por id de forma ascendente.

TABLA:
- Views (article_id, author_id, viewer_id, view_date)
  - article_id: id del artículo
  - author_id: id del autor del artículo
  - viewer_id: id de la persona que vio el artículo
  - view_date: fecha en que se vio el artículo
  - No tiene valor único, pueden haber filas repetidas

RESULTADO ESPERADO:
| id |
|----|
| 4  |
| 7  |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Views

-- PASO 2: WHERE para filtrar los autores que vieron sus propios artículos
-- Un autor vio su propio artículo cuando author_id = viewer_id

-- PASO 3: ORDER BY para ordenar el resultado de forma ascendente
-- El problema pide que el resultado esté ordenado por id

-- PASO 4: SELECT DISTINCT para obtener los autores sin duplicados
-- DISTINCT elimina filas repetidas (un autor puede haber visto sus artículos varias veces)
-- AS id para renombrar la columna como lo pide el problema

SELECT DISTINCT author_id AS id         -- Id del autor (sin duplicados, renombrado a "id")
FROM Views                              -- Tabla de donde tomamos los datos
WHERE author_id = viewer_id             -- Condición: el autor es el mismo que el viewer
ORDER BY id;                            -- Ordenar de menor a mayor

/*
POR QUÉ CADA PARTE:
- FROM Views: Es la única tabla disponible
- WHERE author_id = viewer_id: Así identificamos que el autor vio su propio artículo
- DISTINCT: Sin esto, un autor podría aparecer múltiples veces en el resultado
- AS id: El problema pide que la columna se llame "id", no "author_id"
- ORDER BY id: El problema pide el resultado ordenado de forma ascendente

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- DISTINCT (eliminar duplicados)
- AS (alias para renombrar columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- ORDER BY (ordenar resultados)
*/
