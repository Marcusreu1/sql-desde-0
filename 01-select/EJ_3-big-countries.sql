-- 595. Big Countries
-- Dificultad: Fácil
-- https://leetcode.com/problems/big-countries/

/*
PROBLEMA:
Escribir una consulta que devuelva el nombre, población y área
de los países considerados "grandes".
Un país es grande si:
  - Tiene un área de al menos 3,000,000 km²
  - O tiene una población de al menos 25,000,000

TABLA:
- World (name, continent, area, population, gdp)
  - name: nombre del país (valor único)
  - continent: continente al que pertenece
  - area: área en km²
  - population: población del país
  - gdp: producto interno bruto

RESULTADO ESPERADO:
| name        | population | area     |
|-------------|------------|----------|
| Afghanistan | 25500100   | 652230   |
| Algeria     | 37100000   | 2381741  |
*/

-- PASO 1: FROM para seleccionar la tabla de donde tomamos los datos
-- Solo tenemos una tabla: World

-- PASO 2: WHERE para filtrar los países "grandes"
-- Condición 1: area >= 3000000 (área de al menos 3 millones)
-- Condición 2: population >= 25000000 (población de al menos 25 millones)
-- Usamos OR porque basta con cumplir UNA de las dos condiciones

-- PASO 3: SELECT para indicar qué columnas queremos ver
-- El problema pide: name, population, area

SELECT name,                             -- Nombre del país
       population,                       -- Población del país
       area                              -- Área del país en km²
FROM World                               -- Tabla de donde tomamos los datos
WHERE area >= 3000000                    -- Condición 1: área mayor o igual a 3 millones
   OR population >= 25000000;            -- Condición 2: población mayor o igual a 25 millones

/*
POR QUÉ CADA PARTE:
- FROM World: Es la única tabla disponible
- WHERE area >= 3000000: Filtra países con área grande
- OR population >= 25000000: Filtra países con población grande
  (usamos OR porque con cumplir una condición basta)
- SELECT name, population, area: Son las tres columnas que pide el problema

CONCEPTOS UTILIZADOS:
- SELECT (seleccionar columnas)
- FROM (seleccionar tabla)
- WHERE (filtrar filas con condiciones)
- >= (operador mayor o igual que)
- OR (operador lógico: al menos una condición debe cumplirse)
*/
