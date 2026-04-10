-- 585. Investments in 2016
-- Dificultad: Media
-- https://leetcode.com/problems/investments-in-2016/

/*
PROBLEMA:
Calcular la suma de tiv_2016 de las pólizas que cumplan DOS condiciones:
1. Su tiv_2015 sea igual al de al menos otra póliza (valor repetido)
2. Su ubicación (lat, lon) sea única (no compartida con otra póliza)
Redondear a 2 decimales.

TABLAS:

Insurance (pid, tiv_2015, tiv_2016, lat, lon)

RESULTADO ESPERADO:

tiv_2016
45.00
*/

-- PASO 1: Primera subconsulta - valores de tiv_2015 que se repiten
-- GROUP BY tiv_2015 + HAVING COUNT(*) > 1: solo valores que aparecen más de una vez
-- JOIN para quedarnos solo con pólizas que tengan un tiv_2015 repetido

-- PASO 2: Segunda subconsulta - ubicaciones únicas
-- GROUP BY lat, lon + HAVING COUNT(*) = 1: solo ubicaciones que aparecen exactamente una vez
-- JOIN para quedarnos solo con pólizas en ubicaciones únicas

-- PASO 3: Ambos JOIN filtran al mismo tiempo
-- Solo sobreviven las pólizas que cumplen AMBAS condiciones

-- PASO 4: ROUND(SUM(tiv_2016), 2) para sumar y redondear

SELECT
    ROUND(SUM(i.tiv_2016), 2) AS tiv_2016                  -- Suma de inversiones 2016 redondeada
FROM Insurance i                                            -- Tabla principal de pólizas
JOIN (
    SELECT tiv_2015                                         -- Valores de tiv_2015 que se repiten
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1                                     -- Más de una póliza con ese valor
) AS repeated_tiv
    ON i.tiv_2015 = repeated_tiv.tiv_2015                   -- Filtro: tiv_2015 debe ser repetido
JOIN (
    SELECT lat, lon                                         -- Ubicaciones únicas
    FROM Insurance
    GROUP BY lat, lon
    HAVING COUNT(*) = 1                                     -- Exactamente una póliza en esa ubicación
) AS unique_loc
    ON i.lat = unique_loc.lat AND i.lon = unique_loc.lon;   -- Filtro: ubicación debe ser única

/*
POR QUÉ CADA PARTE:

- Subconsulta repeated_tiv: Encontrar qué valores de tiv_2015 aparecen más de una vez
  - HAVING COUNT(*) > 1: "más de una póliza" = valor repetido
- Subconsulta unique_loc: Encontrar qué ubicaciones son únicas
  - HAVING COUNT(*) = 1: "exactamente una póliza" = ubicación única
  - GROUP BY lat, lon: La ubicación se define por AMBAS coordenadas
- Doble INNER JOIN: Solo sobreviven las pólizas que pasan ambos filtros
  - Si no cumple el primer JOIN: tiv_2015 es único → se descarta
  - Si no cumple el segundo JOIN: ubicación es compartida → se descarta
- ROUND(SUM(), 2): Formato requerido por el problema

CONCEPTOS NUEVOS:
- Ninguno (combinación de INNER JOIN con subconsultas, GROUP BY, HAVING, SUM y ROUND ya vistos)
*/
