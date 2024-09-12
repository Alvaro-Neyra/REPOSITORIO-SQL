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
