-- 1174. Immediate Food Delivery II
-- Dificultad: Media
-- https://leetcode.com/problems/immediate-food-delivery-ii/

/*
PROBLEMA:
Calcular el porcentaje de pedidos inmediatos entre los PRIMEROS pedidos de cada cliente.
Un pedido es "inmediato" si order_date = customer_pref_delivery_date.
El primer pedido es el que tiene la order_date más antigua.
Redondear a 2 decimales.

TABLAS:

Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)

RESULTADO ESPERADO:

immediate_percentage
33.33
*/

-- PASO 1: Subconsulta para obtener el primer pedido de cada cliente
-- GROUP BY customer_id para agrupar por cliente
-- MIN(order_date) para obtener la fecha más antigua (primer pedido)

-- PASO 2: WHERE (customer_id, order_date) IN (subconsulta)
-- Filtramos la tabla principal para quedarnos SOLO con los primeros pedidos
-- Usamos dos columnas porque necesitamos que coincida tanto el cliente como su fecha mínima

-- PASO 3: SUM(CASE WHEN...) para contar pedidos inmediatos
-- Si order_date = customer_pref_delivery_date → 1 (inmediato)
-- Si no → 0 (programado)

-- PASO 4: Multiplicar por 100.0 y dividir entre COUNT(*) para el porcentaje
-- 100.0 (no 100) para forzar división decimal

-- PASO 5: ROUND(..., 2) para redondear a 2 decimales

SELECT
    ROUND(                                              -- Redondear a 2 decimales
        SUM(CASE
            WHEN order_date = customer_pref_delivery_date
            THEN 1 ELSE 0
        END) * 100.0                                    -- Total inmediatos * 100
        / COUNT(*),                                     -- Dividido entre total de primeros pedidos
    2) AS immediate_percentage                          -- Alias del resultado
FROM Delivery                                           -- Tabla principal
WHERE (customer_id, order_date) IN (                    -- Filtrar solo primeros pedidos
    SELECT customer_id, MIN(order_date)                 -- Cliente + su fecha más antigua
    FROM Delivery                                       -- Misma tabla (subconsulta)
    GROUP BY customer_id                                -- Agrupar por cliente
);

/*
POR QUÉ CADA PARTE:

- Subconsulta con MIN(): Necesitamos identificar el primer pedido de cada cliente
- WHERE (col1, col2) IN: Filtramos con dos columnas porque solo customer_id no garantiza que sea el primer pedido
- SUM(CASE WHEN...): Cuenta los inmediatos (1 si cumple, 0 si no)
- * 100.0 / COUNT(*): Convierte a porcentaje con división decimal
- ROUND(..., 2): Formato requerido por el problema

CONCEPTOS NUEVOS USADOS:
- MIN() (función de agregación: valor mínimo)
- WHERE (col1, col2) IN (subconsulta) (filtrar con múltiples columnas)
*/
