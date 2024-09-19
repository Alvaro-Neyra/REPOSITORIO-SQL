use mi_bd;
-- Une las tablas de empleados con departamentos y solo muestra las columnas nombre, apellido, edad, salario de empleados y la columna nombre de departamentos.
SELECT *
FROM empleados;
SELECT emp.nombre, emp.apellido, emp.edad, emp.salario, dep.nombre `departamento` 
FROM empleados emp, departamentos dep 
WHERE emp.departamento_id = dep.id 
ORDER BY emp.nombre
ASC, emp.apellido ASC;
-- Une las tablas ventas con la tabla empleados donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados.
SELECT vent.id, vent.producto_id, vent.cliente_id, vent.cantidad, vent.precio_unitario, vent.monto_total, emp.nombre, emp.apellido
FROM empleados emp, ventas vent WHERE vent.empleado_id = emp.id;
-- Une las tablas ventas con la tabla productos donde se muestren todas las columnas de ventas exceptuando la columna producto_id y en su lugar muestres la columna nombre de la tabla productos.
SELECT vent.id, vent.cliente_id, vent.cantidad, vent.precio_unitario, vent.empleado_id, vent.monto_total, prod.nombre
FROM ventas vent, productos prod
WHERE vent.producto_id = prod.id;
-- Une las tablas ventas con la tabla clientes donde se muestren todas las columnas de ventas exceptuando la columna cliente_id y en su lugar muestres la columna nombre de la tabla clientes.
SELECT vent.id, vent.producto_id, vent.cantidad, vent.precio_unitario, vent.empleado_id, vent.monto_total, cl.nombre
FROM ventas `vent`, clientes `cl`
WHERE vent.cliente_id = cl.id;
-- Une las tablas ventas con la tablas empleados y departamentos donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados y además muestres la columna nombre de la tabla departamentos.
SELECT vent.id, vent.producto_id, vent.cliente_id, vent.cantidad, vent.precio_unitario, vent.monto_total, emp.nombre, emp.apellido, dep.nombre
FROM ventas `vent`, empleados `emp`, departamentos `dep`
WHERE vent.empleado_id = emp.id
AND emp.departamento_id = dep.id;
-- Une las tablas ventas, empleados, productos y clientes donde se muestren las columnas de la tabla ventas reemplazando sus columnas de FOREIGN KEYs con las respectivas columnas de “nombre” de las otras tablas.
SELECT vent.id, prod.nombre `nombre_producto`, cli.nombre `nombre_cliente`, vent.cantidad, vent.precio_unitario, vent.monto_total, emp.nombre `nombre_apellido`, emp.apellido `apellido_empleado`
FROM ventas `vent`, empleados `emp`, productos `prod`, clientes `cli`
WHERE vent.producto_id = prod.id 
AND vent.cliente_id = cli.id 
AND vent.empleado_id = emp.id;
-- Calcular el salario máximo de los empleados en cada departamento y mostrar el nombre del departamento junto con el salario máximo.
SELECT dep.nombre, MAX(emp.salario) `maximo_salario` 
FROM empleados `emp`, departamentos `dep` WHERE emp.departamento_id = dep.id
GROUP BY emp.departamento_id;

-- PARTE 2
-- Calcular el monto total de ventas por departamento y mostrar el nombre del departamento junto con el monto total de ventas.
SELECT SUM(vent.monto_total), dep.nombre
FROM ventas `vent`, departamentos `dep`, empleados `emp`
WHERE emp.departamento_id = dep.id AND vent.empleado_id = emp.id GROUP BY dep.nombre;
-- Encontrar el empleado más joven de cada departamento y mostrar el nombre del departamento junto con la edad del empleado más joven.
SELECT dep.nombre, MIN(emp.edad) `edad minima`
FROM empleados `emp`, departamentos `dep`
WHERE emp.departamento_id = dep.id GROUP BY dep.id;

-- Calcular el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 “bajo”, menos 8 “medio” y mayor o igual a 8 “alto”) y mostrar la categoría de volumen junto con la cantidad y el nombre del producto.
SELECT prod.nombre, SUM(vent.cantidad) AS total_cantidad,
CASE
	WHEN SUM(vent.cantidad) < 5 THEN 'BAJO'
    WHEN SUM(vent.cantidad) < 8 THEN 'MEDIO'
    ELSE 'ALTO'
END AS volumen
FROM ventas `vent`, productos `prod`
WHERE vent.producto_id = prod.id
GROUP BY prod.nombre;

--  Encontrar el cliente que ha realizado el mayor monto total de compras y mostrar su nombre y el monto total.
SELECT SUM(vent.monto_total), cli.nombre
FROM ventas `vent`, clientes `cli`
WHERE vent.cliente_id = cli.id 
GROUP BY cli.id 
ORDER BY SUM(vent.monto_total) 
DESC LIMIT 1;

/*
-- 5. Calcular el precio promedio de los productos vendidos por cada
empleado y mostrar el nombre del empleado junto con el precio promedio
de los productos que ha vendido.
*/
SELECT emp.nombre 'nombre_empleado', emp.apellido 'apellido_empleado',
round(AVG(vent.precio_unitario), 2) 'precio_promedio_productos'
FROM empleados `emp`, ventas `vent`
WHERE vent.empleado_id = emp.id
GROUP BY vent.empleado_id
ORDER BY precio_promedio_productos DESC;

/*
-- 6. Encontrar el departamento con el salario mínimo más bajo entre
los empleados y mostrar el nombre del departamento junto con el salario
mínimo más bajo.
*/
SELECT dep.nombre 'nombre_departamento', MIN(emp.salario) 'salario_minimo'
FROM empleados `emp`, departamentos `dep`
WHERE emp.departamento_id = dep.id
GROUP BY emp.departamento_id
ORDER BY salario_minimo ASC
LIMIT 1;

/*
-- 7. Encuentra el departamento con el salario promedio más alto entre
los empleados mayores de 30 años y muestra el nombre del departamento
junto con el salario promedio. Limita los resultados a mostrar solo los
departamentos con el salario promedio mayor a 3320.
*/
SELECT dep.nombre 'nombre_departamento',
round(AVG(emp.salario), 2) 'salario_promedio'
FROM empleados `emp`, departamentos `dep`
WHERE emp.departamento_id = dep.id AND emp.edad > 30
GROUP BY emp.departamento_id
HAVING salario_promedio > 3320
ORDER BY salario_promedio DESC;



