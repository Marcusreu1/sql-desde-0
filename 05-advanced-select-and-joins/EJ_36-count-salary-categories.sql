-- 1907. Count Salary Categories
-- Dificultad: Media
-- https://leetcode.com/problems/count-salary-categories/

/*
PROBLEMA:
Clasificar cada cuenta en tres categorías según su ingreso:
- "Low Salary": income < 20000
- "Average Salary": 20000 <= income <= 50000
- "High Salary": income > 50000
Devolver las tres categorías con su cantidad de cuentas,
incluso si alguna tiene 0.

TABLAS:

Accounts (account_id, income)

RESULTADO ESPERADO:

category        accounts_count
Low Salary      1
Average Salary  0
High Salary     3
*/

-- PASO 1: CTE "categories" para crear tabla de categorías manualmente
-- UNION apila tres SELECT para tener las tres categorías como filas
-- Esto garantiza que las tres siempre aparezcan en el resultado

-- PASO 2: CTE "classified" para clasificar cada cuenta
-- CASE WHEN evalúa el income y asigna la categoría correspondiente

-- PASO 3: LEFT JOIN entre categories y classified
-- LEFT JOIN para mantener las tres categorías aunque no tengan cuentas

-- PASO 4: GROUP BY category + COUNT(cl.category)
-- COUNT de la columna de classified no cuenta NULL → categorías vacías dan 0

WITH categories AS (                                        -- Tabla manual de categorías
    SELECT 'Low Salary' AS category                         -- Primera categoría
    UNION SELECT 'Average Salary'                           -- Segunda categoría
    UNION SELECT 'High Salary'                              -- Tercera categoría
),
classified AS (                                             -- Clasificación de cada cuenta
    SELECT CASE
        WHEN income < 20000 THEN 'Low Salary'               -- Ingreso bajo
        WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'  -- Ingreso promedio
        ELSE 'High Salary'                                  -- Ingreso alto
    END AS category
    FROM Accounts                                           -- Tabla de cuentas
)
SELECT
    c.category,                                             -- Nombre de la categoría
    COUNT(cl.category) AS accounts_count                    -- Cantidad de cuentas (0 si no hay)
FROM categories c                                           -- Tabla base de categorías
LEFT JOIN classified cl                                     -- Traer cuentas clasificadas
    ON c.category = cl.category                             -- Condición: misma categoría
GROUP BY c.category;                                        -- Agrupar por categoría

/*
POR QUÉ CADA PARTE:

- CTE categories con UNION: Crear tabla de referencia con las tres categorías
  - Sin esto: si una categoría no tiene cuentas, no aparecería en el resultado
- CTE classified con CASE WHEN: Clasificar cada cuenta según su ingreso
- LEFT JOIN: Mantener las tres categorías aunque classified no tenga filas para alguna
- COUNT(cl.category): Contar solo las filas que tienen match (NULL no se cuenta = 0)
  - COUNT(*) daría 1 en vez de 0 para categorías vacías

CONCEPTOS NUEVOS:
- WITH ... AS / CTE (Common Table Expression: tablas temporales al inicio de la consulta)
- UNION (combinar resultados de múltiples SELECT apilando filas)
*/
