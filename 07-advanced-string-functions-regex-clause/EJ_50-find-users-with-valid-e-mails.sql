-- 1517. Find Users With Valid Emails
-- Dificultad: Easy
-- https://leetcode.com/problems/find-users-with-valid-emails/

/*
PROBLEMA:
Encontrar los usuarios con emails válidos. Un email válido:
- El prefijo empieza con una letra (mayúscula o minúscula)
- El prefijo puede contener letras, números, guion bajo, punto y guion
- El dominio debe ser exactamente @leetcode.com

TABLA:

Users (user_id, name, mail)

RESULTADO ESPERADO (ejemplo):

user_id  name      mail
1        Winston   winston@leetcode.com
3        Annabel   annabel@leetcode.com
4        Sally     sally@leetcode.com
*/

-- PASO 1: FROM Users
-- Solo tenemos una tabla, la seleccionamos directamente

-- PASO 2: REGEXP para validar el patrón completo del email
-- ^ → inicio del texto
-- [a-zA-Z] → primera letra obligatoria
-- [a-zA-Z0-9_.-]* → cero o más caracteres permitidos
-- @leetcode\\.com → dominio exacto (\\. = punto literal)
-- $ → fin del texto

-- PASO 3: LIKE BINARY como capa extra de validación
-- Asegura que @leetcode.com sea exactamente en minúsculas

SELECT
    user_id,                                -- ID del usuario
    name,                                   -- Nombre del usuario
    mail                                    -- Email del usuario
FROM Users                                  -- Tabla de usuarios
WHERE mail REGEXP                           -- Validar patrón con expresión regular
    '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$'
  AND mail LIKE BINARY '%@leetcode.com';    -- Validar dominio exacto (case-sensitive)

/*
POR QUÉ CADA PARTE:

REGEXP: Permite validar un patrón complejo que LIKE no podría manejar
    (inicio con letra, caracteres específicos permitidos)
^ y $: Aseguran que TODO el email cumpla el patrón, no solo una parte
[a-zA-Z]: La primera posición DEBE ser una letra
[a-zA-Z0-9_.-]*: El resto del prefijo puede tener estos caracteres
\\.com: Punto literal antes de com (sin \\ el punto significaría 
    "cualquier carácter")
LIKE BINARY: Capa extra para garantizar que el dominio sea exactamente
    en minúsculas, ya que REGEXP puede no ser case-sensitive en algunos
    entornos

CONCEPTOS USADOS:

- REGEXP (expresiones regulares en SQL) [NUEVO]
- Sintaxis de expresiones regulares: ^, $, [], *, \\. [NUEVO]
- BINARY (comparación sensible a mayúsculas/minúsculas) [NUEVO]
- LIKE
- AND
*/
