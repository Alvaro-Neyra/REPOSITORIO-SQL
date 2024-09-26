USE mi_bd;
/*Crea una tabla triangulos_rectangulos con dos columnas: longitud_lado_adyacente y longitud lado_opuesto, ambos de tipo INT.*/
CREATE TABLE triangulos_rectangulos (
	longitud_lado_adyacente INT,
    longitud_lado_opuesto INT
);
/*Rellena la tabla triangulos_rectangulos con 10 filas con enteros aleatorios entre 1 y 100*/
INSERT INTO triangulos_rectangulos (longitud_lado_adyacente, longitud_lado_opuesto) 
VALUES 
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
    (FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1),
    (FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1);
    
/*Crea una vista donde agregues la columna “hipotenusa” calculándola a partir de los otros dos lados. Utiliza el teorema de Pitágoras para realizar el cálculo: Siendo el lado adyacente “A” y el opuesto “B” y la hipotenusa “C” la fórmula quedaría de la siguiente forma:*/
CREATE OR REPLACE VIEW hipotenusa_vista AS 
SELECT longitud_lado_adyacente AS A, longitud_lado_opuesto AS B,
ROUND(SQRT(POW(longitud_lado_adyacente,2) + POW(longitud_lado_opuesto, 2)), 2) AS hipotenusa
FROM triangulos_rectangulos;

SELECT * FROM hipotenusa_vista;

/*Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo α en radianes y grados. Aquí tienes dos fórmulas:*/

CREATE OR REPLACE VIEW hipotenusa_vista_2 AS 
SELECT *,
ATAN(A / hipotenusa) AS angulo_beta_radianes,
DEGREES(ATAN(A / hipotenusa)) AS angulo_beta_grados
FROM hipotenusa_vista;

/*Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo β en radianes y grados. Aquí tienes dos fórmulas:*/
CREATE OR REPLACE VIEW hipotenusa_vista_4 AS 
SELECT *,
ATAN(B / hipotenusa) AS angulo_beta_radianes_B,
DEGREES(ATAN(B / hipotenusa)) AS angulo_beta_grados_B
FROM hipotenusa_vista_2;

SELECT * FROM hipotenusa_vista_4;

/*Reemplaza la vista y ahora agrégale dos columnas para calcular el ángulo γ en radianes y grados. Como se trata de triángulos rectángulos, el ángulo es de 90°, pero aplica una fórmula de igual manera, usa la regla de que la suma de los ángulos de un triángulo suma 180°.*/
CREATE OR REPLACE VIEW hipotenusa_vista_5 AS 
SELECT *,
ROUND(RADIANS(90), 2) AS angulo_gamma_radianes_C,
90 AS angulo_gamma_grados_C
FROM hipotenusa_vista_4;

SELECT * FROM hipotenusa_vista_5;

/*Crea una tabla triangulos_rectangulos_2 con dos columnas: angulo_alfa y una hipotenusa ambos de tipo INT.*/
CREATE TABLE triangulos_rectangulos_2 (
	angulo_alfa INT,
    hipotenusa INT
);

/*Rellena la tabla triangulos_rectangulos_2 con 10 filas con enteros aleatorios entre 1 y 89 para angulo_alfa y enteros aleatorios entre 1 y 100 para la columna hipotenusa.*/
INSERT INTO triangulos_rectangulos_2 (angulo_alfa, hipotenusa) VALUES (
	FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
    (FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
    (FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1),
	(FLOOR(RAND() * 89) + 1, FLOOR(RAND() * 100) + 1);

CREATE OR REPLACE VIEW triantulos_rectangulos2_vista_1 AS
SELECT angulo_alfa,
hipotenusa,
ROUND(hipotenusa * COS(RADIANS(angulo_alfa)), 2) AS lado_adyacente,
ROUND(hipotenusa * SIN(RADIANS(angulo_alfa)), 2) AS lado_opuesto
FROM triangulos_rectangulos_2;

CREATE OR REPLACE VIEW triangulos_rectangulos2_vista_2 AS
SELECT *,
ROUND(90 - angulo_alfa, 2) AS angulo_beta,
90 AS angulo_gamma
FROM triantulos_rectangulos2_vista_1;

/*Crea una tabla mensajes que tenga una columna “datos” de tipo varchar y una columna valor_crc de tipo int, con las siguientes filas: VALUES*/

DROP TABLE mensajes;

CREATE TABLE mensajes (
	datos VARCHAR(200),
    valor_crc INT
);

/* INSERT INTO mensajes (datos, valor_crc) VALUES (
	'Hola, ¿cómo estás? Espero que tengas un buen día.',3221685809),
    ('Ayer fui al cine a ver una película genial.', 951196167),
    ('Estoy emocionado por el próximo fin de semana.', 3275166159),
    ('Mi reunión se pospuso para el martes que viene.', 169741145),
    ('He estado trabajando en un proyecto importante.', 6480112535),
    ('Esta receta de pastel de manzana es deliciosa.', 2524836786),
    ('Planeo hacer un viaje a la playa este verano.', 5107635050),
    ('Mi gato se divierte jugando con su pelota.', 3578632817),
    ('Hoy es un día soleado y agradable.', 3675102258),
    ('El libro que estoy leyendo es muy interesante.', 854938277);

SELECT LENGTH('Hola, ¿cómo estás? Espero que tengas un buen día.');
SELECT crc32('Hola, ¿cómo estás? Espero que tengas un buen día.'); */

-- Crea una tabla mensajes que tenga una columna “datos” de tipo varchar y una
-- columna valor_crc de tipo int, con las siguientes filas: VALUES
-- ('Hola, ¿cómo estás? Espero que tengas un buen día.',3221685809),
-- ('Ayer fui al cine a ver una película genial.', 951196167),
-- ('Estoy emocionado por el próximo fin de semana.', 3275166159),
-- ('Mi reunión se pospuso para el martes que viene.', 169741145),
-- ('He estado trabajando en un proyecto importante.', 6480112535),
-- ('Esta receta de pastel de manzana es deliciosa.', 2524836786),
-- ('Planeo hacer un viaje a la playa este verano.', 5107635050),
-- ('Mi gato se divierte jugando con su pelota.', 3578632817),
-- ('Hoy es un día soleado y agradable.', 3675102258),
-- ('El libro que estoy leyendo es muy interesante.', 854938277);

CREATE TABLE mensajes (
datos VARCHAR(255),
valor_crc BIGINT
);

INSERT INTO mensajes (datos, valor_crc) VALUES (
	'Hola, ¿cómo estás? Espero que tengas un buen día.',3221685809),
    ('Ayer fui al cine a ver una película genial.', 951196167),
    ('Estoy emocionado por el próximo fin de semana.', 3275166159),
    ('Mi reunión se pospuso para el martes que viene.', 169741145),
    ('He estado trabajando en un proyecto importante.', 6480112535),
    ('Esta receta de pastel de manzana es deliciosa.', 2524836786),
    ('Planeo hacer un viaje a la playa este verano.', 5107635050),
    ('Mi gato se divierte jugando con su pelota.', 3578632817),
    ('Hoy es un día soleado y agradable.', 3675102258),
    ('El libro que estoy leyendo es muy interesante.', 854938277);
    
