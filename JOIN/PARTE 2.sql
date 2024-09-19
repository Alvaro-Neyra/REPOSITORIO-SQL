USE mi_bd;
DESCRIBE ventas;
SELECT * FROM ventas LIMIT 10;
SELECT * FROM ventas;
SELECT * FROM productos;
SELECT * FROM departamentos;
SELECT * FROM empleados;
SELECT * FROM clientes;
/*-- Calcula la cantidad de ventas por departamento, incluso si el departamento no tiene ventas.*/
SELECT dep.nombre `Nombre departamento` , vent.cantidad `Cantidad ventas` FROM ventas `vent`
RIGHT JOIN empleados `emp` ON vent.empleado_id = emp.id
RIGHT JOIN departamentos `dep` ON emp.departamento_id = dep.id;
/*-- Encuentra el nombre y la dirección de los clientes que han comprado más de 3 productos y muestra la cantidad de productos comprados.*/
SELECT cli.nombre, cli.direccion, vent.cantidad `Cantidad de productos comprados`
FROM clientes `cli`
INNER JOIN ventas `vent` ON cli.id = vent.cliente_id
WHERE vent.cantidad > 3;
/*-- Calcula el monto total de ventas realizadas por cada departamento y muestra el nombre del departamento junto con el monto total de ventas. */
SELECT dep.nombre, vent.monto_total
FROM ventas `vent`
INNER JOIN empleados `emp` ON emp.id = vent.empleado_id
RIGHT JOIN departamentos `dep` ON dep.id = emp.departamento_id;
