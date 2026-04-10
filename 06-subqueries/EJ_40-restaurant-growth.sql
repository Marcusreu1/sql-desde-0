-- 1321. Restaurant Growth
-- Dificultad: Media
-- https://leetcode.com/problems/restaurant-growth/

/*
PROBLEMA:
Calcular la suma y el promedio del monto gastado en una ventana
deslizante de 7 días (día actual + 6 anteriores).
Solo mostrar resultados a partir del séptimo día.
Promedio redondeado a 2 decimales.

TABLAS:

Customer (customer_id, name, visited_on, amount)

RESULTADO ESPERADO:

visited_on   amount  average_amount
2019-01-07   860     122.86
2019-01-08   840     120.00
2019-01-09   840     120.00
2019-01-10   1000    142.86
*/

-- PASO 1: Subconsulta para consolidar montos por día
-- GROUP BY visited_on + SUM(amount): un total por cada fecha
-- Necesario porque un mismo día puede tener múltiples visitas

-- PASO 2: SUM() y AVG() con ventana deslizante de 7 días
-- ROWS BETWEEN 6 PRECEDING AND CURRENT ROW: fila actual + 6 anteriores = 7 días
-- ORDER BY visited_on: define el orden cronológico de la ventana

-- PASO 3: WHERE para filtrar los primeros 6 días
-- MIN(visited_on) + INTERVAL 6 DAY: fecha a partir de la cual hay 7 días completos
-- Sin esto: los primeros días tendrían ventanas incompletas (menos de 7 días)

-- PASO 4: ROUND(..., 2) para redondear el promedio a 2 decimales

SELECT
    visited_on,                                                             -- Fecha de visita
    SUM(amount) OVER (                                                      -- Suma de la ventana de 7 días
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW                           -- 6 días atrás + día actual
    ) AS amount,                                                            -- Alias para la suma
    ROUND(AVG(amount) OVER (                                                -- Promedio de la ventana de 7 días
        ORDER BY visited_on
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW                           -- 6 días atrás + día actual
    ), 2) AS average_amount                                                 -- Alias redondeado a 2 decimales
FROM (
    SELECT visited_on, SUM(amount) AS amount                                -- Total gastado por día
    FROM Customer                                                           -- Tabla de clientes
    GROUP BY visited_on                                                     -- Agrupar por fecha
) AS daily                                                                  -- Alias de la tabla consolidada
WHERE visited_on >= (SELECT MIN(visited_on) FROM Customer) + INTERVAL 6 DAY; -- Solo desde el día 7

/*
POR QUÉ CADA PARTE:

- Subconsulta con GROUP BY: Consolidar múltiples visitas del mismo día en un solo monto
  - Sin esto: la ventana deslizante contaría filas individuales en vez de días
- ROWS BETWEEN 6 PRECEDING AND CURRENT ROW: Define exactamente la ventana de 7 días
  - Sin esto: SUM() OVER() haría una suma acumulativa desde el inicio (no una ventana fija)
- WHERE con MIN() + INTERVAL 6 DAY: Asegura que solo aparezcan días con ventana completa
  - Los primeros 6 días tendrían menos de 7 días para calcular → resultados incorrectos
- ROUND(AVG(), 2): Formato requerido por el problema

CONCEPTOS NUEVOS:
- ROWS BETWEEN n PRECEDING AND CURRENT ROW (ventana deslizante: define rango exacto de filas para el cálculo)
*/
