-- 196. Delete Duplicate Emails
-- Dificultad: Easy
-- https://leetcode.com/problems/delete-duplicate-emails/

/*
PROBLEMA:
Eliminar los emails duplicados de la tabla Person,
manteniendo solo el registro con el id más pequeño de cada email.

TABLA:

Person (id, email)

RESULTADO ESPERADO (ejemplo):

Antes:                     Después:
id  email                  id  email
1   john@example.com       1   john@example.com
2   bob@example.com        2   bob@example.com
3   john@example.com       (eliminado)
*/

-- PASO 1: Self JOIN para comparar la tabla consigo misma
-- Conectamos registros que tengan el MISMO email
-- ON p1.email = p2.email

-- PASO 2: WHERE p1.id > p2.id
-- De los pares con mismo email, identificamos al que tiene id MAYOR
-- Ese es el duplicado que queremos eliminar

-- PASO 3: DELETE p1
-- Especificamos que solo borramos las filas de p1 (las de id mayor)
-- Sin el "p1", SQL no sabría de cuál tabla borrar

DELETE p1                                  -- Borrar solo las filas de p1 (id mayor)
FROM Person p1                             -- Primera referencia a la tabla
INNER JOIN Person p2                       -- Segunda referencia (Self JOIN)
    ON p1.email = p2.email                 -- Condición: mismo email
WHERE p1.id > p2.id;                       -- Filtro: p1 tiene id mayor (es el duplicado)

/*
POR QUÉ CADA PARTE:

DELETE p1: Especificamos de cuál referencia borrar (la del id mayor)
Self JOIN: Necesitamos comparar la tabla consigo misma para encontrar duplicados
ON p1.email = p2.email: Emparejamos registros con el mismo email
WHERE p1.id > p2.id: De cada par, marcamos como "a borrar" el de id mayor

CONCEPTOS USADOS:

- DELETE (eliminar filas de una tabla) [NUEVO]
- DELETE con JOIN (especificar de cuál tabla borrar) [NUEVO]
- Self JOIN
- INNER JOIN
*/
