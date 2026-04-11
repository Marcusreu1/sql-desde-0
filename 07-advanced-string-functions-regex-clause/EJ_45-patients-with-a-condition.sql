-- 1527. Patients With a Condition
-- Dificultad: Easy
-- https://leetcode.com/problems/patients-with-a-condition/

/*
PROBLEMA:
Encontrar los pacientes que tienen Diabetes Tipo I.
El código de Diabetes Tipo I siempre empieza con el prefijo "DIAB1".

TABLA:

Patients (patient_id, patient_name, conditions, time_of_diagnosis)

RESULTADO ESPERADO (ejemplo):

patient_id  patient_name  conditions   time_of_diagnosis
3           Bob           DIAB1050     2023-02-15
4           George        ACNE DIAB1   2023-05-20
*/

-- PASO 1: FROM Patients
-- Solo tenemos una tabla, la seleccionamos directamente

-- PASO 2: WHERE con LIKE para buscar el patrón DIAB1
-- Escenario 1: DIAB1 está al INICIO del texto → 'DIAB1%'
-- Escenario 2: DIAB1 está después de un espacio → '% DIAB1%'
-- Usamos OR porque puede ser cualquiera de los dos casos

-- PASO 3: SELECT * para devolver toda la información del paciente

SELECT *                                  -- Todas las columnas del paciente
FROM Patients                             -- Tabla de pacientes
WHERE conditions LIKE 'DIAB1%'            -- DIAB1 al inicio del texto
   OR conditions LIKE '% DIAB1%';         -- DIAB1 al inicio de una palabra (con espacio antes)

/*
POR QUÉ CADA PARTE:

LIKE 'DIAB1%': Cubre el caso donde Diabetes Tipo I es la primera condición
LIKE '% DIAB1%': Cubre el caso donde hay otras condiciones antes de DIAB1
El espacio antes de DIAB1 es CLAVE: evita falsos positivos como "XDIAB1"
    donde DIAB1 aparece pero no es inicio de palabra
OR: Porque el paciente puede caer en cualquiera de los dos escenarios

CONCEPTOS USADOS:

- LIKE (buscar patrones en texto) [NUEVO]
- % comodín (representa cualquier cantidad de caracteres) [NUEVO]
- OR
- SELECT *
*/
