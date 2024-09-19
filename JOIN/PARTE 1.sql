USE mi_bd;
DESCRIBE ventas;
SELECT * FROM ventas LIMIT 10;
SELECT * FROM ventas;
/*-- Encuentra el nombre y apellido de los empleados junto con la cantidad total de ventas que han realizado.*/
SELECT emp.nombre, emp.apellido, vent.cantidad
FROM empleados `emp`
INNER JOIN ventas `vent` ON emp.id = vent.empleado_id;
/*-- Calcula el monto total vendido a cada cliente y muestra el nombre del cliente, su dirección y el monto total.*/
SELECT cli.nombre, cli.direccion, vent.monto_total 
FROM clientes `cli`
INNER JOIN ventas `vent` ON cli.id = vent.cliente_id;
/*-- Encuentra los productos vendidos por cada empleado en el departamento de "Ventas" y muestra el nombre del empleado junto con el nombre de los productos que han vendido.*/
SELECT emp.nombre `empleado nombre` , prod.nombre `producto nombre`
FROM empleados `emp`
INNER JOIN ventas `vent` ON vent.empleado_id = emp.id
INNER JOIN productos `prod` ON vent.producto_id = prod.id;
/*Encuentra el nombre del cliente, el nombre del producto y la cantidad comprada de productos con un precio superior a $500.*/
SELECT cli.nombre, prod.nombre, vent.cantidad
FROM ventas `vent`
INNER JOIN productos `prod` ON vent.producto_id = prod.id
INNER JOIN clientes `cli` ON vent.cliente_id = cli.id
WHERE prod.precio > 500;

