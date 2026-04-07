-- 1193. Monthly Transactions I
-- Dificultad: Medio
-- https://leetcode.com/problems/monthly-transactions-i/

/*
PROBLEMA:
Escribir una consulta que para cada mes y cada país devuelva:
- El número total de transacciones
- El número de transacciones aprobadas
- El monto total de todas las transacciones
- El monto total de las transacciones aprobadas

TABLA:
- Transactions (id, country, state, amount, trans_date)
  - id: identificador único de la transacción
  - country: país donde se realizó
  - state: 'approved' o 'declined'
  - amount: monto de la transacción
  - trans_date: fecha de la transacción

RESULTADO ESPERADO:
| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
|---------|---------|-------------|----------------|--------------------|-----------------------|
| 2018-12 | US      | 2           | 1              | 600                | 400                   |
| 2019-01 | US      | 1           | 1              | 300                | 300                   |
| 2019-01 | DE      | 1           | 1              | 800                | 800                   |
| 2019-05 | US      | 1           | 0              | 100                | 0                     |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Transactions

-- PASO 2: GROUP BY para agrupar por mes y país
-- DATE_FORMAT(trans_date, '%Y-%m') extrae año-mes de la fecha
-- Agrupamos por mes Y país porque queremos un resumen por cada combinación

-- PASO 3: SELECT con múltiples cálculos
-- DATE_FORMAT: Formato año-mes para mostrar el mes
-- COUNT(*): Total de transacciones por grupo
-- COUNT(CASE WHEN...): Solo cuenta las aprobadas (NULL no se cuenta)
-- SUM(amount): Monto total de todas las transacciones
-- SUM(CASE WHEN...): Monto total solo de las aprobadas

SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,                 -- Mes en formato año-mes
    country,                                                    -- País
    COUNT(*) AS trans_count,                                    -- Total de transacciones
    COUNT(                                                      -- Total de aprobadas
        CASE WHEN state = 'approved' THEN 1 END                -- 1 si aprobada, NULL si no
    ) AS approved_count,                                        -- (COUNT no cuenta NULL)
    SUM(amount) AS trans_total_amount,                          -- Monto total
    SUM(                                                        -- Monto total de aprobadas
        CASE WHEN state = 'approved' THEN amount ELSE 0 END    -- Monto si aprobada, 0 si no
    ) AS approved_total_amount                                  -- (SUM solo suma las aprobadas)
FROM Transactions                                               -- Tabla de transacciones
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;             -- Agrupar por mes y país

/*
POR QUÉ CADA PARTE:
- FROM Transactions: Es la única tabla disponible
- GROUP BY DATE_FORMAT(...), country: Agrupa por mes y país
  (DATE_FORMAT extrae solo año-mes de la fecha completa)
- COUNT(*): Cuenta todas las transacciones de cada grupo
- COUNT(CASE WHEN state = 'approved' THEN 1 END):
  Solo cuenta las aprobadas (sin ELSE devuelve NULL, y COUNT no cuenta NULL)
- SUM(amount): Suma todos los montos de cada grupo
- SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END):
  Solo suma los montos de las aprobadas (las rechazadas suman 0)

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- GROUP BY con múltiples columnas
- DATE_FORMAT() (formatear fechas: %Y = año, %m = mes)
- COUNT(*) (contar total de filas)
- COUNT(CASE WHEN...END) (contar filas que cumplen una condición)
- SUM() (sumar valores)
- SUM(CASE WHEN...END) (sumar valores que cumplen una condición)
- CASE WHEN...THEN...ELSE...END (condicional en SQL)
*/
