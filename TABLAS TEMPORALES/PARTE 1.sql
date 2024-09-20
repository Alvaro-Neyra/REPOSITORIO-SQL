USE mi_bd;

/*-- Utiliza TABLE para consultar la tabla productos de manera simple, ordenando los productos de forma descendente por precio y solo 10 filas.*/
CREATE TEMPORARY TABLE productos_temporal
AS SELECT productos.precio 
FROM productos
ORDER BY productos.precio 
DESC LIMIT 10;

SELECT * FROM productos_temporal;

/*-- Crea una tabla temporal de los empleados donde unifiques su nombre y apellido en una sola columna.*/
CREATE TEMPORARY TABLE empleados_temporal 
AS SELECT CONCAT(empleados.nombre, " ", empleados.apellido) `nombre y apellido`
FROM empleados;
SELECT * FROM empleados_temporal;

/*Crea una tabla temporal de la tabla clientes donde solo tengas la columna nombre.*/
CREATE TEMPORARY TABLE nombres_temporal
AS SELECT clientes.nombre `NOMBRE DE LOS CLIENTES`
FROM clientes;
SELECT * FROM nombres_temporal;

/*-- Realiza la unión entre las tablas temporales de empleados y clientes usando TABLE.*/
-- Con todos los duplicados
SELECT * FROM nombres_temporal UNION ALL SELECT * FROM empleados_temporal;
-- Omitiendo duplicados
SELECT * FROM nombres_temporal UNION SELECT * FROM empleados_temporal;
TABLE nombres_temporal UNION TABLE empleados_temporal;

/* -- 
Crea una tabla temporal escuela primaria que tenga las siguientes columnas: id(int), nombre(varchar), apellido(varchar), edad(int) y grado(int). Y que tenga los siguientes valores:
ID: 1, Nombre: Alejandro, Apellido: González, Edad: 11, Grado: 5
ID: 2, Nombre: Isabella, Apellido: López, Edad: 10, Grado: 4
ID: 3, Nombre: Lucas, Apellido: Martínez, Edad: 11, Grado: 5 
ID: 4, Nombre: Sofía, Apellido: Rodríguez, Edad: 10, Grado: 4 
ID: 5, Nombre: Mateo, Apellido: Pérez, Edad: 12, Grado: 6 
ID: 6, Nombre: Valentina, Apellido: Fernández, Edad: 12, Grado: 6
ID: 7, Nombre: Diego, Apellido: Torres, Edad: 10, Grado: 4
ID: 8, Nombre: Martina, Apellido: Gómez, Edad: 11, Grado: 5
ID: 9, Nombre: Joaquín, Apellido: Hernández, Edad: 10, Grado: 4
ID: 10, Nombre: Valeria, Apellido: Díaz, Edad: 11, Grado: 5
*/

CREATE TEMPORARY TABLE escuela_primaria (
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad int,
    grado int
);

INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Alejandro', 'Gonzalez', 11, 5);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Isabella', 'Lopez', 10, 4);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Lucas', 'Martinez', 11, 5);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Sofia', 'Rodriguez', 10, 4);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Mateo', 'Perez', 12, 6);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Valentina', 'Fernandez', 12, 6);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Diego', 'Torres', 10, 4);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Martina', 'Gomez', 11, 5);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Joaquin', 'Hernandez', 10, 4);
INSERT INTO escuela_primaria (nombre, apellido, edad, grado) VALUES ('Valeria', 'Diaz', 11, 5);
