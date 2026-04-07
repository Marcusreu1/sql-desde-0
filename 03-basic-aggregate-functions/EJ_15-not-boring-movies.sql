-- 620. Not Boring Movies
-- Dificultad: Fácil
-- https://leetcode.com/problems/not-boring-movies/

/*
PROBLEMA:
Escribir una consulta que devuelva las películas que tengan un id impar
y cuya descripción no sea 'boring'.
Ordenar el resultado por rating de mayor a menor.

TABLA:
- Cinema (id, movie, description, rating)
  - id: identificador único de la película (autoincremento)
  - movie: nombre de la película
  - description: descripción de la película
  - rating: calificación de la película (0 a 10, 2 decimales)

RESULTADO ESPERADO:
| id | movie      | description | rating |
|----|------------|-------------|--------|
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Cinema

-- PASO 2: WHERE para filtrar con dos condiciones
-- Condición 1: id % 2 = 1 (id impar, el residuo de dividir entre 2 es 1)
-- Condición 2: description != 'boring' (descripción diferente de 'boring')
-- Usamos AND porque ambas condiciones deben cumplirse al mismo tiempo

-- PASO 3: ORDER BY rating DESC para ordenar de mayor a menor calificación
-- DESC = descendente (de mayor a menor)

-- PASO 4: SELECT * para traer todas las columnas
-- El problema pide toda la información de las películas

SELECT *                                           -- Todas las columnas
FROM Cinema                                        -- Tabla de películas
WHERE id % 2 = 1                                   -- Condición 1: id impar
  AND description != 'boring'                      -- Condición 2: no es 'boring'
ORDER BY rating DESC;                              -- Ordenar por rating de mayor a menor

/*
POR QUÉ CADA PARTE:
- FROM Cinema: Es la única tabla disponible
- WHERE id % 2 = 1: Filtra solo películas con id impar
  (% es el operador módulo: residuo de la división entre 2)
- AND description != 'boring': Excluye películas con descripción 'boring'
- ORDER BY rating DESC: Ordena de mayor a menor calificación
  (DESC = descendente, sin DESC ordenaría de menor a mayor)
- SELECT *: El problema pide toda la información, no solo algunas columnas

CONCEPTOS UTILIZADOS:
- SELECT * (seleccionar todas las columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- % (operador módulo para verificar par/impar)
- != (operador de desigualdad)
- AND (operador lógico: ambas condiciones deben cumplirse)
- ORDER BY (ordenar resultados)
- DESC (orden descendente)
*/
