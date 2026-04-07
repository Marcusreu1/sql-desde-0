-- 197. Rising Temperature
-- Dificultad: Fácil
-- https://leetcode.com/problems/rising-temperature/

/*
PROBLEMA:
Escribir una consulta que encuentre los ids de los días en los que
la temperatura fue más alta que la del día anterior.

TABLA:
- Weather (id, recordDate, temperature)
  - id: identificador único del registro
  - recordDate: fecha del registro
  - temperature: temperatura registrada ese día

RESULTADO ESPERADO:
| id |
|----|
| 2  |
| 4  |
*/

-- PASO 1: FROM con Self JOIN para comparar filas de la misma tabla
-- today representa el día "actual" que estamos evaluando
-- yesterday representa el día "anterior" con el que vamos a comparar
-- Usamos alias descriptivos para que el código sea más legible

-- PASO 2: INNER JOIN porque solo nos interesan días que tengan un día anterior registrado
-- ON con DATE_ADD para conectar cada día con su día anterior
-- Si le sumamos 1 día a yesterday, debería ser igual a today

-- PASO 3: WHERE para filtrar los días con temperatura en aumento
-- La temperatura de today debe ser MAYOR que la de yesterday

-- PASO 4: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos el id del día con temperatura en aumento (today)

SELECT today.id                                                  -- Id del día con temperatura en aumento
FROM Weather AS today                                            -- Tabla principal: día actual
INNER JOIN Weather AS yesterday                                  -- Self JOIN: día anterior
    ON today.recordDate = DATE_ADD(yesterday.recordDate,         -- Fecha de hoy = fecha de ayer
                                   INTERVAL 1 DAY)              -- + 1 día
WHERE today.temperature > yesterday.temperature;                 -- Temperatura de hoy > ayer

/*
POR QUÉ CADA PARTE:
- FROM Weather AS today: Representa el día que estamos evaluando
- INNER JOIN Weather AS yesterday: Empareja cada día con su día anterior
  (INNER JOIN porque solo queremos días que tengan un día anterior registrado)
- ON today.recordDate = DATE_ADD(yesterday.recordDate, INTERVAL 1 DAY):
  Conecta cada día con su día anterior (ayer + 1 día = hoy)
- WHERE today.temperature > yesterday.temperature: Solo días donde subió la temperatura
- SELECT today.id: Solo necesitamos el id del día con temperatura en aumento

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- Self JOIN (unir una tabla consigo misma)
- INNER JOIN (solo registros con coincidencia en ambos lados)
- AS (alias descriptivos para tablas: today, yesterday)
- DATE_ADD() (función para sumar un intervalo de tiempo a una fecha)
- INTERVAL (especificar el intervalo de tiempo)
- WHERE (filtrar filas con condiciones)
- > (operador estrictamente mayor que)
*/
