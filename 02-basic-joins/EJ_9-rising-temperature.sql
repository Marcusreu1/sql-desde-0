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
-- w1 representa el día "actual" que estamos evaluando
-- w2 representa el día "anterior" con el que vamos a comparar

-- PASO 2: ON con DATEDIFF para conectar cada día con su día anterior
-- DATEDIFF(w1.recordDate, w2.recordDate) = 1 significa que w1 es
-- exactamente 1 día después de w2

-- PASO 3: WHERE para filtrar los días con temperatura en aumento
-- La temperatura de w1 (hoy) debe ser MAYOR que la de w2 (ayer)

-- PASO 4: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos el id del día con temperatura en aumento (w1)

SELECT w1.id                             -- Id del día con temperatura en aumento
FROM Weather w1                          -- Tabla principal: día actual
JOIN Weather w2                          -- Self JOIN: día anterior
    ON DATEDIFF(w1.recordDate,           -- Diferencia entre fecha actual
                w2.recordDate) = 1       -- y fecha anterior = 1 día
WHERE w1.temperature > w2.temperature;   -- Temperatura de hoy > temperatura de ayer

/*
POR QUÉ CADA PARTE:
- FROM Weather w1: Representa el día que estamos evaluando
- JOIN Weather w2: Necesitamos comparar con el día anterior (misma tabla)
- ON DATEDIFF(...) = 1: Conecta cada día con su día anterior exacto
  (DATEDIFF calcula la diferencia en días entre dos fechas)
- WHERE w1.temperature > w2.temperature: Filtra solo los días donde subió la temperatura
- SELECT w1.id: Solo necesitamos el id del día con temperatura en aumento

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- Self JOIN (unir una tabla consigo misma)
- ON (condición de unión entre tablas)
- DATEDIFF() (función para calcular diferencia en días entre fechas)
- WHERE (filtrar filas con condiciones)
- > (operador estrictamente mayor que)
- Alias de tablas (w1, w2) para diferenciar la misma tabla
*/
