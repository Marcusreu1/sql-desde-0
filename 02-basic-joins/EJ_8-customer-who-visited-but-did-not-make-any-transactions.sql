-- 1581. Customer Who Visited but Did Not Make Any Transaction
-- Dificultad: Fácil
-- https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transaction/

/*
PROBLEMA:
Escribir una consulta que encuentre los ids de los clientes que visitaron
sin hacer ninguna transacción y cuántas veces hicieron ese tipo de visitas.

TABLAS:
- Visits (visit_id, customer_id)
  - visit_id: identificador único de la visita
  - customer_id: id del cliente que hizo la visita
- Transactions (transaction_id, visit_id, amount)
  - transaction_id: identificador único de la transacción
  - visit_id: id de la visita en la que se hizo la transacción
  - amount: monto de la transacción
  - No todas las visitas tienen una transacción

RESULTADO ESPERADO:
| customer_id | count_no_trans |
|-------------|----------------|
| 30          | 1              |
| 96          | 1              |
| 54          | 2              |
*/

-- PASO 1: FROM para seleccionar la tabla principal
-- Visits es la tabla principal porque necesitamos TODAS las visitas

-- PASO 2: LEFT JOIN para traer la información de transacciones
-- LEFT JOIN porque queremos todas las visitas, incluso las que no tienen transacción
-- ON para conectar ambas tablas por visit_id

-- PASO 3: WHERE para filtrar las visitas SIN transacción
-- Después del LEFT JOIN, las visitas sin transacción tienen NULL en transaction_id
-- Filtramos con IS NULL para quedarnos solo con esas

-- PASO 4: GROUP BY para agrupar por cliente
-- Necesitamos agrupar porque queremos contar visitas POR CADA cliente

-- PASO 5: SELECT con COUNT() para contar las visitas sin transacción
-- COUNT(v.visit_id) cuenta cuántas visitas sin transacción tiene cada cliente

SELECT v.customer_id,                    -- Id del cliente
       COUNT(v.visit_id)                 -- Cantidad de visitas sin transacción
       AS count_no_trans                 -- Alias que pide el problema
FROM Visits v                            -- Tabla principal: visitas
LEFT JOIN Transactions t                 -- Traer info de transacciones
    ON v.visit_id = t.visit_id           -- Condición de unión: misma visita
WHERE t.transaction_id IS NULL           -- Filtrar: solo visitas SIN transacción
GROUP BY v.customer_id;                  -- Agrupar por cliente

/*
POR QUÉ CADA PARTE:
- FROM Visits: Es la tabla que contiene todas las visitas
- LEFT JOIN Transactions: Trae las transacciones sin perder visitas sin transacción
- ON v.visit_id = t.visit_id: Conecta ambas tablas por el id de la visita
- WHERE t.transaction_id IS NULL: Filtra solo las visitas que NO tuvieron transacción
  (patrón común: LEFT JOIN + IS NULL = encontrar registros sin coincidencia)
- GROUP BY v.customer_id: Agrupa por cliente para contar por separado
- COUNT(v.visit_id): Cuenta cuántas visitas sin transacción tiene cada cliente

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla principal)
- LEFT JOIN (unir tablas manteniendo todos los registros de la izquierda)
- ON (condición de unión entre tablas)
- WHERE (filtrar filas con condiciones)
- IS NULL (verificar valores nulos tras el LEFT JOIN)
- GROUP BY (agrupar filas por una columna)
- COUNT() (función de agregación para contar filas)
- Alias de tablas (v, t) para simplificar la escritura
*/
