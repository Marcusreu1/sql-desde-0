-- 1661. Average Time of Process per Machine
-- Dificultad: Fácil
-- https://leetcode.com/problems/average-time-of-process-per-machine/

/*
PROBLEMA:
Escribir una consulta que calcule el tiempo promedio que le toma
a cada máquina completar un proceso. Redondear a 3 decimales.
El tiempo de un proceso = timestamp de 'end' - timestamp de 'start'.

TABLA:
- Activity (machine_id, process_id, activity_type, timestamp)
  - machine_id: id de la máquina
  - process_id: id del proceso
  - activity_type: 'start' o 'end'
  - timestamp: momento en segundos de la actividad
  - (machine_id, process_id, activity_type) es la clave única

RESULTADO ESPERADO:
| machine_id | processing_time |
|------------|-----------------|
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
*/

-- PASO 1: FROM con Self JOIN para emparejar inicio y fin de cada proceso
-- start_process representa las actividades de INICIO ('start')
-- end_process representa las actividades de FIN ('end')
-- Usamos alias descriptivos para que el código sea más legible

-- PASO 2: INNER JOIN porque solo nos interesan procesos con inicio Y fin
-- Si usáramos LEFT JOIN, incluiríamos procesos incompletos

-- PASO 3: ON con múltiples condiciones para conectar correctamente
-- Misma máquina (machine_id), mismo proceso (process_id)
-- y que uno sea 'start' y el otro sea 'end'

-- PASO 4: GROUP BY para agrupar por máquina
-- Necesitamos el promedio POR CADA máquina

-- PASO 5: SELECT con ROUND(AVG(...), 3) para calcular el promedio
-- end_process.timestamp - start_process.timestamp = tiempo de cada proceso
-- AVG() promedia esos tiempos por máquina
-- ROUND(..., 3) redondea a 3 decimales

SELECT start_process.machine_id,                        -- Id de la máquina
       ROUND(                                           -- Redondear a 3 decimales
           AVG(end_process.timestamp                    -- Promedio de: timestamp de fin
               - start_process.timestamp),              -- menos timestamp de inicio
           3
       ) AS processing_time                             -- Alias que pide el problema
FROM Activity AS start_process                          -- Tabla: actividades de inicio
INNER JOIN Activity AS end_process                      -- Self JOIN: actividades de fin
    ON start_process.machine_id = end_process.machine_id    -- Misma máquina
    AND start_process.process_id = end_process.process_id   -- Mismo proceso
    AND start_process.activity_type = 'start'               -- Inicio del proceso
    AND end_process.activity_type = 'end'                   -- Fin del proceso
GROUP BY start_process.machine_id;                      -- Agrupar por máquina

/*
POR QUÉ CADA PARTE:
- FROM Activity AS start_process: Representa los registros de inicio de cada proceso
- INNER JOIN Activity AS end_process: Empareja cada inicio con su fin
  (INNER JOIN porque solo queremos procesos completos con inicio Y fin)
- ON con 4 condiciones: Asegura que emparejamos el inicio y fin
  del mismo proceso en la misma máquina
- GROUP BY start_process.machine_id: Agrupa por máquina para un promedio por cada una
- AVG(end_process.timestamp - start_process.timestamp): Promedio de los tiempos
- ROUND(..., 3): El problema pide redondear a 3 decimales

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- Self JOIN (unir una tabla consigo misma)
- INNER JOIN (solo registros con coincidencia en ambos lados)
- AS (alias descriptivos para tablas)
- ON con múltiples condiciones (AND)
- GROUP BY (agrupar filas por una columna)
- AVG() (función de agregación para calcular promedios)
- ROUND() (redondear a cierta cantidad de decimales)
*/
