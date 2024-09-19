USE mi_bd;
SELECT * FROM empleados;
SELECT * FROM departamentos;
SELECT * FROM ventas;
UPDATE empleados SET departamento_id = 2 WHERE departamento_id IS NULL;
UPDATE ventas 
SET cantidad = 6 
WHERE ventas.empleado_id IN (
SELECT empleados.id 
FROM empleados 
WHERE empleados.departamento_id = 2);
/*-- Muestra el nombre y apellido de los empleados que pertenecen al departamento de "Recursos Humanos" y han realizado más de 5 ventas.*/
SELECT emp.nombre, emp.apellido FROM empleados `emp` 
JOIN ventas `vent` ON vent.empleado_id = emp.id
WHERE emp.departamento_id = 2 AND vent.cantidad > 5;
/*-- Muestra el nombre y apellido de todos los empleados junto con la cantidad total de ventas que han realizado, incluso si no han realizado ventas.*/
SELECT emp.nombre, emp.apellido, vent.cantidad `Cantidad de ventas` 
FROM empleados `emp`
LEFT JOIN ventas `vent` ON vent.empleado_id = emp.id;
/*-- Encuentra el empleado más joven de cada departamento y muestra el nombre del departamento junto con el nombre y la edad del empleado más joven.*/
SELECT dep.nombre `Nombre del departamento`,
       emp.nombre `Nombre del empleado mas joven`,
       emp.edad `Edad del empleado mas joven`
FROM empleados emp
LEFT JOIN departamentos dep ON dep.id = emp.departamento_id
WHERE emp.edad = (
  SELECT MIN(e.edad)
  FROM empleados e
  WHERE e.departamento_id = emp.departamento_id
);
/*-- Calcula el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 como "bajo", entre 5 y 10 como "medio", y más de 10 como "alto") y muestra la categoría de volumen junto con la cantidad y el nombre del producto.*/
SELECT prod.nombre, vent.cantidad,
CASE
	WHEN vent.cantidad < 5 THEN 'BAJO'
    WHEN vent.cantidad BETWEEN 5 AND 10 THEN 'MEDIO'
    ELSE 'ALTO'
END AS `Volumen`
FROM ventas `vent`
RIGHT JOIN productos `prod` ON vent.producto_id = prod.id;