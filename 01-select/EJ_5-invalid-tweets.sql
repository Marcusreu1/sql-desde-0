-- 1683. Invalid Tweets
-- Dificultad: Fácil
-- https://leetcode.com/problems/invalid-tweets/

/*
PROBLEMA:
Escribir una consulta que devuelva los ids de los tweets que son inválidos.
Un tweet es inválido si la cantidad de caracteres en su contenido
es estrictamente mayor a 15.

TABLA:
- Tweets (tweet_id, content)
  - tweet_id: identificador único del tweet
  - content: contenido/texto del tweet

RESULTADO ESPERADO:
| tweet_id |
|----------|
| 2        |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Tweets

-- PASO 2: WHERE para filtrar los tweets inválidos
-- Usamos LENGTH(content) para contar los caracteres del contenido
-- El tweet es inválido si tiene ESTRICTAMENTE más de 15 caracteres (>15)

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos tweet_id, que es lo que nos pide el problema

SELECT tweet_id                          -- Id del tweet inválido
FROM Tweets                              -- Tabla de donde tomamos los datos
WHERE LENGTH(content) > 15;              -- Condición: más de 15 caracteres

/*
POR QUÉ CADA PARTE:
- FROM Tweets: Es la única tabla disponible
- WHERE LENGTH(content) > 15: Filtra los tweets cuyo contenido supera los 15 caracteres
  - LENGTH(): Cuenta la cantidad de caracteres de un texto
  - > 15: Estrictamente mayor (15 exacto sigue siendo válido)
- SELECT tweet_id: El problema solo pide devolver los ids

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- LENGTH() (función para contar caracteres de un texto)
- > (operador estrictamente mayor que)
*/
