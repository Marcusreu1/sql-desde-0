-- 1321. Restaurant Growth
-- Dificultad: Medium
-- https://leetcode.com/problems/restaurant-growth/

/*
PROBLEMA:
Calcular para cada día la suma y el promedio del monto gastado
en una ventana de 7 días (día actual + 6 anteriores).
Solo mostrar resultados a partir del séptimo día.
Promedio redondeado a 2 decimales.

TABLA:

Customer (customer_id, name, visited_on, amount)

RESULTADO ESPERADO (ejemplo):

visited_on   amount  average_amount
2019-01-07   860     122.86
2019-01-08   840     120.00
2019-01-09   840     120.00
2019-01-10   1000    142.86
*/

-- PASO 1: Subconsulta interna (daily)
-- Consolidar múltiples visitas del mismo día en una sola fila
-- GROUP BY visited_on + SUM(amount)

-- PASO 2: Subconsulta intermedia (windowed)
-- Aplicar funciones de ventana sobre TODAS las filas
-- SUM() y AVG() con ventana deslizante de 7 días
-- Es clave que aquí NO filtremos, para que la ventana tenga todos los datos

-- PASO 3: Consulta externa con WHERE
-- AHORA sí filtramos para mostrar solo a partir del 7mo día
-- El filtro va DESPUÉS de las funciones de ventana

SELECT
    visited_on,                                -- Fecha de visita
    amount,                                    -- Suma de 7 días
    average_amount                             -- Promedio de 7 días
FROM (
    SELECT
        visited_on,
        SUM(amount) OVER (
            ORDER BY visited_on
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW  -- Ventana: 7 días
        ) AS amount,
        ROUND(
            AVG(amount) OVER (
                ORDER BY visited_on
                ROWS BETWEEN 6 PRECEDING AND CURRENT ROW  -- Misma ventana
            ), 2
        ) AS average_amount
    FROM (
        SELECT
            visited_on,                        -- Fecha
            SUM(amount) AS amount              -- Total del día
        FROM Customer
        GROUP BY visited_on                    -- Una fila por día
    ) AS daily
) AS windowed                                  -- Alias para la capa con ventanas
WHERE visited_on >= (
    SELECT MIN(visited_on)                     -- Fecha más antigua
    FROM Customer
) + INTERVAL 6 DAY;                           -- +6 días = a partir del 7mo día

/*
POR QUÉ CADA PARTE:

Subconsulta daily: Un mismo día puede tener múltiples visitas, necesitamos
    consolidar en una fila por día antes de aplicar la ventana
Subconsulta windowed: Las funciones de ventana necesitan TODAS las filas
    para calcular correctamente, por eso el filtro NO puede ir aquí
WHERE en consulta externa: Filtramos DESPUÉS de que la ventana ya calculó,
    así los primeros 6 días sí fueron usados en los cálculos pero no se muestran
ROWS BETWEEN 6 PRECEDING AND CURRENT ROW: Ventana deslizante de exactamente
    7 filas (6 anteriores + la actual)
INTERVAL 6 DAY: Asegura que solo mostremos resultados con ventana completa

CONCEPTOS USADOS:

- ROWS BETWEEN n PRECEDING AND CURRENT ROW (ventana deslizante) [NUEVO]
- SUM() OVER / AVG() OVER (funciones de ventana)
- Subconsultas anidadas en el FROM
- GROUP BY
- ROUND()
- MIN()
- INTERVAL
*/
