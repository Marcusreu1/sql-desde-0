-- 584. Find Customer Referee
-- Dificultad: Fácil
-- https://leetcode.com/problems/find-customer-referee/

/*
PROBLEMA:
Escribir una consulta que devuelva los nombres de los clientes
que NO fueron referidos por el cliente con id = 2.

TABLA:
- Customer (id, name, referee_id)
  - id: identificador único del cliente
  - name: nombre del cliente
  - referee_id: id del cliente que lo refirió (puede ser NULL)

RESULTADO ESPERADO:
| name |
|------|
| Will |
| Jane |
| Bill |
| Zack |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: Customer

-- PASO 2: WHERE para filtrar los datos con dos condiciones
-- Condición 1: referee_id != 2 (que NO fueron referidos por el cliente 2)
-- Condición 2: referee_id IS NULL (que NO tienen referido)
-- Usamos OR porque basta con que una de las dos se cumpla
-- Sin la condición IS NULL, los clientes sin referido se excluirían

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- Solo necesitamos name, que es lo que nos pide el problema

SELECT name                              -- Nombre del cliente
FROM Customer                            -- Tabla de donde tomamos los datos
WHERE referee_id != 2                    -- Condición 1: no referido por cliente 2
   OR referee_id IS NULL;                -- Condición 2: sin referido (NULL)

/*
POR QUÉ CADA PARTE:
- FROM Customer: Es la única tabla disponible
- WHERE referee_id != 2: Excluye a los referidos por el cliente 2
- OR referee_id IS NULL: Incluye a los que no tienen referido
  (sin esto, los NULL se excluyen porque NULL != 2 no es verdadero)
- SELECT name: El problema solo pide devolver los nombres

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- != (operador de desigualdad)
- IS NULL (verificar valores nulos)
- OR (operador lógico: al menos una condición debe cumplirse)
*/
