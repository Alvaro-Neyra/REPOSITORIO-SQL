CREATE DATABASE mi_bd;
USE mi_bd;
CREATE TABLE empleados (
id INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50), apellido VARCHAR(50), edad INT, salario DECIMAL(10, 2), fecha_contratacion DATE
);
DESCRIBE empleados;
INSERT INTO empleados (nombre, apellido, edad, salario, fecha_contratacion) VALUES ('Juan', 'Perez', 30, 1000.00, '2019-01-01');
SELECT * from empleados limit 10;
ALTER TABLE empleados MODIFY COLUMN edad INT NOT NULL;
ALTER TABLE empleados MODIFY COLUMN salario DECIMAL(10, 2) DEFAULT 0;
ALTER TABLE empleados ADD COLUMN correo_electronico VARCHAR(100);
ALTER TABLE empleados DROP COLUMN fecha_contratacion;
ALTER TABLE empleados ADD COLUMN fecha_contratacion DATETIME DEFAULT NOW();

CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50)
);

-- DESCRIBE departamentos;

ALTER TABLE empleados ADD COLUMN departamento_id INT;
ALTER TABLE empleados ADD FOREIGN KEY (departamento_id) REFERENCES departamentos(id);
DESCRIBE empleados;
ALTER TABLE empleados DROP COLUMN departamento;
INSERT INTO empleados VALUES (NULL, 'daoijsdajwdawdja', 'Pérez', 30, 1000.00, 'juanperez@gmail.com', NOW() , NULL);
SELECT * FROM empleados limit 20;
UPDATE empleados SET nombre = 'Jose', apellido = 'Gomez', edad = 40, salario = 1000000.00, correo_electronico = 'josegomez@gmail.com' WHERE id = 2;

DELETE FROM empleados WHERE nombre = 'Juan';
ALTER TABLE empleados DROP COLUMN id;
ALTER TABLE empleados ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;
SELECT nombre, correo_electronico FROM empleados WHERE edad > 35;
INSERT INTO departamentos (nombre) VALUES ('Ventas');
INSERT INTO departamentos (nombre) VALUES ('RECURSOS HUMANOS');
select * from departamentos limit 10;
INSERT INTO empleados VALUES (NULL, 'Ana', 'Rodriguez', 28, 3000.00, 'anarodriguez@mail.com', NOW(), 1);
INSERT INTO empleados VALUES (NULL, 'Carlos', 'Lopez', 32, 3200.00, 'carloslopez@mail.com', NOW(), 2);
insert into empleados VALUES (NULL, 'Laura', 'Perez', 26, 2800.75, 'lauraperez@mail.com', NOW(), 1);
INSERT INTO empleados VALUES (NULL, 'Martin', 'Gonzalez', 30, 3100.25, 'martingomez@mail.com', NOW(), 2);

-- Actualizar el salario del empleado con nombre "Ana" para aumentarlo a un 10%
UPDATE empleados SET salario = salario * 1.10 WHERE nombre = 'Ana';

-- Crea un departamento llamado 'Contabilidad'
INSERT INTO departamentos (nombre) VALUES ('Contabilidad');

-- Cambia el departamento del empleado con nombre 'Carlos' de 'Recursos humanos' a 'Contabilidad'
UPDATE empleados SET departamento_id = 3 WHERE nombre = 'Carlos';

-- Elimina el empleado con nombre 'Laura'
DELETE FROM empleados WHERE nombre = 'Laura';

SELECT id, nombre, apellido, edad, salario, correo_electronico FROM empleados;

SELECT fecha_contratacion, departamento_id FROM empleados;

SELECT id, nombre FROM departamentos;

-- DML: REPASO

-- CREA UNA TABLA LLAMADAS 'CLIENTES' CON COLUMNAS PARA EL 'ID' (ENTERO AUTOINCREMENTAL), 'NOMBRE' (CADENA HASTA 50 CARACTERES) Y DIRECCION (CADENA HASTA 100 CARACTERES)
create table clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

-- Crea una tabla llamada "productos" con columnas para el "id" (entero autoincremental), "nombre" (cadena de hasta 50 caracteres), y "precio" (decimal con 10 dígitos, 2 decimales).
CREATE TABLE productos(
    id int AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(50),
    precio DECIMAL(10, 2)
);

-- Crea una tabla llamada "ventas" con columnas para "id" (entero autoincremental), "producto_id" (entero), "cliente_id" (entero), "cantidad" (entero), “precio_unitario” (decimal con 10 dígitos, 2 decimales), "monto_total" (decimal con 10 dígitos, 2 decimales), y "empleado_id" (entero).
create table ventas(
    id INT auto_increment PRIMARY KEY,
    producto_id int, 
    cliente_id int,
    cantidad int,
    precio_unitario decimal(10, 2),
    monto_total decimal(10, 2),
    empleado_id int
);

-- En la tabla creada Ventas, establece restricciones de clave foránea en las columnas "producto_id," "cliente_id," y "empleado_id" para hacer referencia a las tablas correspondientes. 
ALTER TABLE ventas
ADD FOREIGN KEY (producto_id) REFERENCES productos(id),
ADD FOREIGN KEY (cliente_id) REFERENCES clientes(id),
ADD FOREIGN KEY (empleado_id) REFERENCES empleados(id);

-- Inserta un nuevo cliente en la tabla "clientes" con el nombre "Juan Pérez" y la dirección "Libertad 3215, Mar del Plata"
insert into clientes (nombre, direccion) values ('Juan Pérez', 'Libertad 3215, Mar del Plata');

-- Inserta un nuevo producto en la tabla "productos" con el nombre "Laptop" y un precio de 1200.00 .
insert into productos (nombre, precio) VALUES ("Laptop", 1200.00);

ALTER TABLE ventas DROP COLUMN monto_total;
-- Modifica la columna monto_total de la tabla ventas para que por defecto sea el resultado de multiplicar la cantidad por el precio del producto_id
ALTER TABLE ventas
ADD COLUMN monto_total DECIMAL(10, 2) AS (cantidad * precio_unitario) STORED;

-- Usando GENERATED ALWAYS AS Y STORED PARA CALCULAR el monto total
ALTER TABLE ventas MODIFY monto_total decimal(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED;

--Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra "Laptop" por una cantidad de 2 unidades y el vendedor tenga el nombre “Ana" y apellido "Rodriguez”. Ten en cuenta que debes “tener” los ID y valores correspondientes previamente, luego aprenderemos a recuperarlos con subconsultas
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES (1, 1, 2, 1200.00, 1);

-- Haz una consulta simple de los datos de la tabla ventas y verifica que se presente de la siguiente manera:

SELECT * FROM ventas;

SELECT 
    ventas.id, 
    productos.nombre AS producto_nombre, 
    clientes.nombre AS cliente_nombre, 
    ventas.cantidad, 
    ventas.precio_unitario, 
    ventas.monto_total, 
    empleados.nombre AS empleado_nombre, 
    empleados.apellido AS empleado_apellido
FROM 
    ventas
JOIN 
    productos ON ventas.producto_id = productos.id
JOIN 
    clientes ON ventas.cliente_id = clientes.id
JOIN 
    empleados ON ventas.empleado_id = empleados.id;

-- SUBCONSULTAS

UPDATE empleados SET salario = salario * 1.07 WHERE departamento_id =
(SELECT id FROM departamentos WHERE nombre = 'Ventas');

-- Continuando con la practica

-- Inserta un nuevo producto en la tabla "productos" con el nombre "Teléfono móvil" y un precio de 450.00.
INSERT INTO productos (nombre, precio) VALUES ('Teléfono móvil', 450.00);

-- Inserta un nuevo cliente en la tabla "clientes" con el nombre "María García" y la dirección "Constitución 456, Luján".
INSERT INTO clientes (nombre, direccion) VALUES ('María García', 'Constitución 456, Luján');

ALTER TABLE empleados
DROP COLUMN correo_electronico;


ALTER TABLE empleados
ADD correo_electronico VARCHAR(255) GENERATED ALWAYS AS (
    CONCAT(nombre, '.', apellido, '@mail.com')
) STORED;

-- Inserta un nuevo empleado en la tabla "empleados" con el nombre "Luis” y apellido “Fernández", edad 28, salario 2800.00 y que pertenezca al departamento “ventas”.
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Luis', 'Fernández', 28, 2800.00, 1);

-- Actualiza el precio del producto "Laptop" a 1350.00 en la tabla "productos".
UPDATE productos SET precio = "1350.00" WHERE nombre = "Laptop";

-- Modifica la dirección del cliente "Juan Pérez" a "Alberti 1789, Mar del Plata" en la tabla "clientes".
UPDATE clientes SET direccion = "Alberti 1789, Mar del Plata" WHERE nombre = "Juan Pérez";

-- Incrementa el salario de todos los empleados en un 5% en la tabla "empleados".
UPDATE empleados SET salario = salario * 1.05;

-- Inserta un nuevo producto en la tabla " productos" con el nombre "Tablet" y un precio de 350.00.
INSERT INTO productos (nombre, precio) VALUES ('Tablet', 350.00);

-- Inserta un nuevo cliente en la tabla "clientes" con el nombre "Ana López" y la dirección "Beltrán 1452, Godoy Cruz".
INSERT INTO clientes (nombre, direccion) VALUES ('Ana López', 'Beltrán 1452, Godoy Cruz');

-- Inserta un nuevo empleado en la tabla "empleados" con el nombre "Marta", apellido "Ramírez", edad 32, salario 3100.00 y que pertenezca al departamento “ventas”.
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Marta', 'Ramírez', 32, 3100.00, 1);

-- Actualiza el precio del producto "Teléfono móvil" a 480.00 en la tabla "productos".
UPDATE PRODUCTOS SET precio = 480.00 WHERE nombre = "Teléfono móvil";

-- Modifica la dirección del cliente "María García" a "Avenida 789, Ciudad del Este" en la tabla "clientes".
UPDATE clientes SET direccion = "Avenida 789, Ciudad del Este" WHERE nombre = "María García";

-- Incrementa el salario de todos los empleados en el departamento de "Ventas" en un 7% en la tabla "empleados".
UPDATE empleados SET salario = salario * 1.07 WHERE departamento_id = (SELECT id FROM departamentos WHERE nombre = 'Ventas');

-- Inserta un nuevo producto en la tabla "productos" con el nombre "IMPRESORA" y un precio de 280.00.
INSERT INTO productos (nombre, precio) VALUES ('IMPRESORA', 280.00);

-- Inserta un nuevo cliente en la tabla "clientes" con el nombre "Carlos Sánchez" y la dirección "Saavedra 206, Las Heras".

INSERT INTO clientes (nombre, direccion) VALUES ('Carlos Sánchez', 'Saavedra 206, Las Heras');

-- Inserta un nuevo empleado en la tabla "empleados" con el nombre "Lorena", apellido "Guzmán", edad 26, salario 2600.00 y que pertenezca al departamento “ventas”.
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Lorena', 'Guzmán', 26, 2600.00, 1);

-- Haz una consulta simple de los datos de la tabla empleados y verifica que se presente de la siguiente manera:
SELECT * FROM empleados;

-- 18. Haz una consulta simple de los datos de la tabla clientes y verifica que se presente de la siguiente manera:
SELECT * FROM clientes;

-- 19. Haz una consulta simple de los datos de la tabla productos y verifica que se presente de la siguiente manera:
SELECT * FROM productos;

-- EJERCICIOS COMPLEMENTARIOS
--  Inserta una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Laptop" con una cantidad de 2 y el vendedor tiene el nombre "Ana" y apellido "Rodríguez".
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES (1, 1, 2, 1350.00, (SELECT id FROM empleados WHERE nombre = 'Ana' AND apellido = 'Rodríguez'));

-- Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil" con una cantidad de 3 y el vendedor tiene el nombre "Carlos" y apellido "López".
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES (2, (SELECT id FROM clientes WHERE nombre = 'María García' LIMIT 1), 3, 480.00, (SELECT id FROM empleados WHERE nombre = 'Carlos' AND apellido = 'López' LIMIT 1));

-- Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Tablet" con una cantidad de 2 y el vendedor tiene el nombre "Luis" y apellido "Fernández".
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES (3, (SELECT id FROM clientes WHERE nombre = 'Juan Pérez' LIMIT 1), 2, (SELECT precio FROM productos WHERE nombre = 'Tablet' LIMIT 1), (SELECT id FROM empleados WHERE nombre = 'Luis' AND apellido = 'Fernández' LIMIT 1));

-- Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil" con una cantidad de 1 y el vendedor tiene el nombre "Marta" y apellido "Ramírez".
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES (2, (SELECT id FROM clientes WHERE nombre = 'María García' LIMIT 1), 1, (SELECT precio FROM productos WHERE nombre = 'Teléfono móvil' LIMIT 1), (SELECT id FROM empleados WHERE nombre = 'Marta' AND apellido = 'Ramírez' LIMIT 1));

-- Crea una venta en la tabla "ventas" donde el cliente "Carlos Sánchez" compra una "Impresora" con una cantidad de 2 y el vendedor tiene el nombre "Lorena" y apellido "Guzmán".
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES ((SELECT id FROM productos WHERE nombre = 'IMPRESORA' LIMIT 1), (SELECT id FROM clientes WHERE nombre = 'Carlos Sánchez' LIMIT 1), 2, (SELECT precio FROM productos WHERE nombre = 'IMPRESORA' LIMIT 1), (SELECT id FROM empleados WHERE nombre = 'Lorena' AND apellido = 'Guzmán' LIMIT 1));

-- Haz una consulta simple de los datos de la tabla ventas y verifica que se presente de la siguiente manera:
SELECT * FROM ventas;

-- SELECT AVANZADO
-- FALTA COMPLETAR

INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id)
VALUES
  ('Laura', 'Sánchez', 27, 3300.00, 1),
  ('Javier', 'Pérez', 29, 3100.00, 1),
  ('Camila', 'Gómez', 26, 3000.00, 1),
  ('Lucas', 'Fernández', 28, 3200.00, 1),
  ('Valentina', 'Rodríguez', 30, 3500.00, 1);
INSERT INTO productos (nombre, precio)
VALUES
  ('Cámara Digital', 420.00),
  ('Smart TV 55 Pulgadas', 1200.00),
  ('Auriculares Bluetooth', 80.00),
  ('Reproductor de Blu-ray', 120.00),
  ('Lavadora de Ropa', 550.00),
  ('Refrigeradora Doble Puerta', 800.00),
  ('Horno de Microondas', 120.00),
  ('Licuadora de Alta Potencia', 70.00),
  ('Silla de Oficina Ergonómica', 150.00),
  ('Escritorio de Madera', 200.00),
  ('Mesa de Comedor', 250.00),
  ('Sofá de Tres Plazas', 350.00),
  ('Mochila para Portátil', 30.00),
  ('Reloj de Pulsera Inteligente', 100.00),
  ('Juego de Utensilios de Cocina', 40.00),
  ('Set de Toallas de Baño', 20.00),
  ('Cama King Size', 500.00),
  ('Lámpara de Pie Moderna', 70.00),
  ('Cafetera de Goteo', 40.00),
  ('Robot Aspirador', 180.00);
INSERT INTO clientes (nombre, direccion)
VALUES
  ('Alejandro López', 'Calle Rivadavia 123, Buenos Aires'),
  ('Sofía Rodríguez', 'Avenida San Martín 456, Rosario'),
  ('Joaquín Pérez', 'Calle Belgrano 789, Córdoba'),
  ('Valeria Gómez', 'Calle Mitre 101, Mendoza'),
  ('Diego Martínez', 'Avenida 9 de Julio 654, Buenos Aires');
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (1, 6, 3, 1350.00, 1),
  (5, 8, 5, 420.00, 9),
  (10, 2, 2, 800.00, 6),
  (14, 7, 1, 200.00, 5),
  (20, 4, 4, 20.00, 6),
  (4, 5, 5, 280.00, 1),
  (9, 5, 3, 550.00, 1),
  (13, 3, 4, 150.00, 5),
  (19, 6, 2, 40.00, 1),
  (2, 9, 5, 480.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (3, 9, 1, 350.00, 1),
  (6, 7, 4, 1200.00, 1),
  (7, 6, 3, 80.00, 1),
  (12, 9, 5, 70.00, 1),
  (16, 8, 2, 350.00, 6),
  (23, 9, 4, 180.00, 1),
  (18, 4, 3, 100.00, 7),
  (11, 3, 2, 120.00, 5),
  (15, 5, 4, 250.00, 6),
  (8, 8, 1, 120.00, 7);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (17, 3, 2, 30.00, 5),
  (21, 9, 5, 500.00, 6),
  (22, 2, 3, 70.00, 6),
  (24, 9, 2, 180.00, 1),
  (5, 1, 2, 1350.00, 1),
  (9, 6, 4, 550.00, 9),
  (13, 8, 3, 150.00, 7),
  (3, 1, 5, 350.00, 1),
  (18, 9, 1, 100.00, 6),
  (10, 5, 2, 800.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (7, 4, 3, 80.00, 6),
  (2, 5, 1, 480.00, 6),
  (8, 7, 4, 120.00, 7),
  (1, 3, 5, 1350.00, 5),
  (4, 6, 2, 280.00, 5),
  (12, 1, 1, 70.00, 1),
  (19, 4, 3, 40.00, 6),
  (15, 3, 4, 250.00, 5),
  (6, 8, 2, 1200.00, 7),
  (11, 2, 3, 120.00, 5);

-- EJECUTA LA CLAUSULA IN
SELECT * FROM empleados WHERE id IN (1, 3, 5);

SELECT * FROM productos WHERE id IN (2, 4, 6);

select * from clientes where id in (1, 3, 5);

-- EJECUTA LA CLAUSULA LIKE

SELECT * FROM empleados WHERE nombre LIKE 'L%';
select * from productos where nombre like '%Teléfono%';
SELECT * from clientes WHERE direccion LIKE '%CALLE%';

-- Ejecuta la clausula ORDER BY
SELECT * FROM empleados ORDER BY salario ASC;
SELECT * FROM empleados ORDER BY nombre DESC;
select * from ventas ORDER BY cantidad ASC, precio_unitario DESC;

-- Ejecuta la clausula LIMIT
SELECT * FROM productos ORDER BY precio DESC LIMIT 5;
select * from empleados ORDER BY apellido ASC LIMIT 10;
SELECT * FROM ventas ORDER BY monto_total DESC LIMIT 3;

-- Ejercicios AS
SELECT salario, (salario * 0.10) as 'Aumento del 10%' from empleados;
SELECT (precio_unitario * cantidad) as 'Monto Total Gastado' from ventas;
SELECT CONCAT(nombre,' ',apellido) AS 'Nombre y Apellido' from empleados;

-- Ejercicios CASE
SELECT nombre,
    CASE
        WHEN precio >= 500 THEN 'Caro'
        WHEN precio >= 200  THEN 'Medio'
        WHEN precio < 500 THEN 'Barato'
    END AS 'Categoria'
FROM productos;

SELECT nombre,
    CASE 
    when edad < 30 THEN 'Joven'
    WHEN edad >= 30 AND edad <= 40 THEN 'Adulto'
    when edad > 40 THEN 'Adulto Mayor'
    END AS 'Categoria'
FROM empleados;

SELECT id,
    CASE 
    WHEN cantidad < 3 THEN 'Poca cantidad'
    WHEN cantidad >= 3 AND cantidad < 6 THEN 'Cantidad moderada'
    WHEN cantidad >= 6 THEN 'Mucha cantidad'
    END AS 'Categoria'
from ventas;

SELECT nombre,
    CASE
    WHEN nombre LIKE 'A%' THEN 'Empieza con A'
    WHEN nombre LIKE 'M%' THEN 'Empieza con M'
    ELSE 'Otros'
    END AS 'Categoria'
    from clientes;

SELECT nombre,
    CASE
    WHEN salario >= 3500 THEN 'Salario Alto'
    WHEN salario >= 3500 AND salario <= 3500 THEN 'Salario Medio'
    ELSE 'Salario Bajo'
    END AS 'Categoria'
    FROM empleados;


SELECT MAX(salario) AS 'Salario Máximo' FROM empleados;

Select MAX(cantidad) AS 'Cantidad max vendida en una sola venta' FROM ventas;

SELECT MAX(edad) as 'Edad maxima' FROM empleados;

SELECT MIN(salario) as 'Salario minimo' FROM empleados;
Select MIN(cantidad) AS 'Cantidad max vendida en una sola venta' FROM ventas;
SELECT MIN(edad) as 'Edad maxima' FROM empleados;

SELECT COUNT(*) as 'Cantidad de empleados' from empleados;
SELECT COUNT(*) as 'Cantidad de ventas realizadas' from ventas;
SELECT COUNT(*) as 'Cantidad productos con precio mayor a 500' from productos WHERE precio > 500;

SELECT SUM(salario) as 'Suma salarios' from empleados;

SELECT SUM(monto_total) as 'Suma monto total de ventas' from ventas;

SELECT SUM(precio) as 'Suma de precios de productos con id par' from productos WHERE id % 2 = 0;

SELECT AVG(salario) as 'Promedio salarios' from empleados;

-- Calcula el precio unitario promedio de todos los productos.
SELECT AVG(precio) as 'Precio unitario promedio de todos los productos' from productos;

SELECT AVG(edad) as 'Edad de los promedios de los empleados' from empleados;



