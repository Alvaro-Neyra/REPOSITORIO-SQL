USE mi_bd;
SELECT * FROM clientes;
/*-- Agrega un cliente nuevo con el nombre “Ana Rodríguez” y con dirección en “San Martín 2515, Mar del Plata”. Luego realiza la intersección entre la tabla temporal de empleados y clientes.*/
INSERT INTO clientes (nombre, direccion) VALUES ('Ana Rodriguez', 'San Martín 2515, Mar del Plata');
SELECT `NOMBRE DE LOS CLIENTES` FROM nombres_temporal INTERSECT SELECT `nombre y apellido` FROM empleados_temporal;
TABLE nombres_temporal INTERSECT TABLE empleados_temporal;
/*💡 Debes volver a crear la tabla temporal de clientes para actualizar esa tabla.*/
DROP TEMPORARY TABLE nombres_temporal;
CREATE TEMPORARY TABLE nombres_temporal
AS SELECT clientes.nombre `NOMBRE DE LOS CLIENTES`
FROM clientes;
/*-- Realiza la excepción entre la tabla temporal de clientes y la de empleados.*/
SELECT `NOMBRE DE LOS CLIENTES` 
FROM nombres_temporal 
EXCEPT 
SELECT `nombre y apellido` 
FROM empleados_temporal;
/*Crea una tabla temporal escuela secundaria que tenga las siguientes columnas: id(int), nombre(varchar), apellido(varchar), edad(int) y grado(int). Y que tenga los siguientes valores:
ID: 1, Nombre: Eduardo, Apellido: Sánchez, Edad: 16, Grado: 10
ID: 2, Nombre: Camila, Apellido: Martín, Edad: 17, Grado: 11
ID: 3, Nombre: Manuel, Apellido: Gutiérrez, Edad: 15, Grado: 9
ID: 4, Nombre: Laura, Apellido: García, Edad: 16, Grado: 10
ID: 11, Nombre: Pablo, Apellido: Ortega, Edad: 17, Grado: 11
ID: 12, Nombre: Carmen, Apellido: Ramírez, Edad: 15, Grado: 9
ID: 13, Nombre: Carlos, Apellido: Molina, Edad: 16, Grado: 10
ID: 14, Nombre: Ana, Apellido: Ruiz, Edad: 17, Grado: 11
ID: 15, Nombre: Luis, Apellido: Fernández, Edad: 15, Grado: 9
ID: 16, Nombre: María, Apellido: López, Edad: 16, Grado: 10
*/
CREATE TEMPORARY TABLE escuela_secundaria (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    grado INT
);

INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Eduardo', 'Sanchez', 16, 10);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Camila', 'Martin', 17, 11);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Manuel', 'Gutierrez', 15, 9);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Laura', 'Garcia', 16, 10);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Pablo', 'Ortega', 17, 11);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Carmen', 'Ramirez', 15, 9);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Carlos', 'Molina', 16, 10);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Ana', 'Ruiz', 17, 11);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Luis', 'Fernandez', 15, 9);
INSERT INTO escuela_secundaria (nombre, apellido, edad, grado) VALUES ('Maria', 'Lopez', 16, 10);

/*-- Realiza la intersección de la escuela primaria y escuela secundaria con el nombre y apellido de los alumnos para saber quienes fueron a ambas escuelas.*/
SELECT nombre, apellido FROM escuela_primaria INTERSECT SELECT nombre, apellido FROM escuela_secundaria;

/*Realiza la excepción de la escuela primaria con la secundaria para saber quienes no siguieron cursando en dicha escuela secundaria.*/
TABLE escuela_primaria EXCEPT TABLE escuela_secundaria;

/*Realiza la excepción de la escuela secundaria con la primaria para saber quienes no siguieron cursando en dicha escuela secundaria.*/
TABLE escuela_secundaria EXCEPT TABLE escuela_primaria;