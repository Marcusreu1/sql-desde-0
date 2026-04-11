-- 1667. Fix Names in a Table
-- Dificultad: Easy
-- https://leetcode.com/problems/fix-names-in-a-table/

/*
PROBLEMA:
Arreglar los nombres para que solo la primera letra sea mayúscula
y el resto minúsculas. Ordenar por user_id.

TABLA:

Users (user_id, name)

RESULTADO ESPERADO (ejemplo):

user_id  name
1        Alice
2        Bob
4        Daniel
*/

-- PASO 1: FROM Users
-- Solo tenemos una tabla, así que la seleccionamos directamente

-- PASO 2: Dividir el nombre en dos partes y transformarlas
-- SUBSTRING(name, 1, 1) → extraer la primera letra
-- UPPER() → convertirla a mayúscula
-- SUBSTRING(name, 2) → extraer todo desde la segunda letra
-- LOWER() → convertirlo a minúscula
-- CONCAT() → pegar ambas partes

-- PASO 3: ORDER BY user_id
-- El problema pide que el resultado esté ordenado por user_id

SELECT
    user_id,                              -- ID del usuario
    CONCAT(
        UPPER(SUBSTRING(name, 1, 1)),     -- Primera letra en mayúscula
        LOWER(SUBSTRING(name, 2))         -- Resto del nombre en minúscula
    ) AS name                             -- Alias: nombre corregido
FROM Users                                -- Tabla de usuarios
ORDER BY user_id;                         -- Ordenar por ID de usuario

/*
POR QUÉ CADA PARTE:

SUBSTRING(name, 1, 1): Extraemos solo la primera letra para tratarla aparte
UPPER(): Garantizamos que esa primera letra sea mayúscula
SUBSTRING(name, 2): Extraemos del segundo carácter en adelante
LOWER(): Garantizamos que todo el resto sea minúscula
CONCAT(): Pegamos ambas partes para formar el nombre corregido
ORDER BY: Requisito del problema

CONCEPTOS USADOS:

- SUBSTRING() (extraer parte de un texto) [NUEVO]
- UPPER() (convertir a mayúsculas) [NUEVO]
- LOWER() (convertir a minúsculas) [NUEVO]
- CONCAT() (unir textos) [NUEVO]
- ORDER BY
*/
