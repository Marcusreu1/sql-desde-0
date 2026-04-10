-- 1204. Last Person to Fit in the Bus
-- Dificultad: Media
-- https://leetcode.com/problems/last-person-to-fit-in-the-bus/

/*
PROBLEMA:
Encontrar el nombre de la última persona que puede subir al autobús
sin que el peso total acumulado supere los 1000 kilogramos.
Las personas suben en orden según su turno.

TABLAS:

Queue (person_id, person_name, weight, turn)

RESULTADO ESPERADO:

person_name
Thomas
*/

-- PASO 1: Subconsulta con SUM() OVER() para calcular el peso acumulativo
-- SUM(weight) OVER (ORDER BY turn): suma el peso de cada persona
-- más todos los anteriores según el orden de turno
-- Esto simula cómo se va llenando el autobús persona por persona

-- PASO 2: WHERE cumulative_weight <= 1000
-- Filtramos para quedarnos solo con las personas donde el peso
-- acumulado no supere el límite de 1000 kg

-- PASO 3: ORDER BY turn DESC + LIMIT 1
-- De las personas válidas, ordenamos por turno de mayor a menor
-- y tomamos solo la primera → la última persona en subir sin pasarse

SELECT
    person_name                                             -- Nombre de la última persona válida
FROM(
    SELECT
        person_name,                                        -- Nombre de la persona
        turn,                                               -- Turno de abordaje
        SUM(weight) OVER (ORDER BY turn) AS cumulative_weight   -- Peso acumulado hasta este turno
    FROM Queue                                              -- Tabla de la fila del autobús
) AS weighted                                               -- Alias de la tabla derivada
WHERE cumulative_weight <= 1000                             -- Solo donde no se pase de 1000 kg
ORDER BY turn DESC                                          -- Turno más alto primero
LIMIT 1;                                                    -- Tomar solo la última persona válida

/*
POR QUÉ CADA PARTE:

- SUM() OVER (ORDER BY turn): Calcula la suma acumulativa en orden de turno
  - Sin OVER: sumaría todo en un solo valor
  - Con OVER (ORDER BY turn): va sumando fila por fila según el turno
- Subconsulta en FROM: Necesitamos primero calcular el acumulado para luego filtrar
  - No se puede usar una window function directamente en el WHERE
- WHERE <= 1000: Eliminar personas cuyo turno haría que se pase del límite
- ORDER BY turn DESC + LIMIT 1: De las válidas, obtener la de turno más alto (última en subir)

CONCEPTOS NUEVOS:
- SUM() OVER (ORDER BY columna) / suma acumulativa (suma que se va acumulando fila por fila)
*/
