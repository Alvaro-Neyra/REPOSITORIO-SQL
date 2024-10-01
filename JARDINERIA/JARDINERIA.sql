use jardineria;

/* Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.*/
SELECT cli.nombre_contacto, cli.apellido_contacto, 
MIN(pag.fecha_pago) `Primer pago`,
MAX(pag.fecha_pago) `Ultimo pago`
FROM cliente `cli`
INNER JOIN pago `pag` ON pag.codigo_cliente = cli.codigo_cliente
GROUP BY cli.nombre_contacto, cli.apellido_contacto;

/*Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).*/
SELECT 
    p.nombre,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unidad) AS total_facturado,
    SUM(dp.cantidad * dp.precio_unidad * 1.21) AS total_facturado_con_iva
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY 
    p.codigo_producto
HAVING 
    SUM(dp.cantidad * dp.precio_unidad) > 3000;
    
/* Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).*/
SELECT 
    c.nombre_cliente,
    c.limite_credito
FROM 
    cliente c
WHERE 
    c.limite_credito > (
        SELECT 
            SUM(p.total)
        FROM 
            pago p 
        WHERE 
            p.codigo_cliente = c.codigo_cliente
	);
/*Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.*/
SELECT 
    e.nombre,
    e.apellido1,
    e.apellido2,
    e.email
FROM 
    empleado e
WHERE 
    e.codigo_jefe = (
        SELECT 
            codigo_empleado 
        FROM 
            empleado 
        WHERE 
            nombre = 'Alberto' AND apellido1 = 'Soria'
    );
/*Devuelve un listado que muestre solamente los clientes que sí han realizado ningún pago. (Recomendamos resolver este ejercicio con Subconsultas del tipo IN y NOT IN).*/
SELECT 
    c.nombre_cliente,
    c.apellido_contacto
FROM 
    cliente c
WHERE 
    c.codigo_cliente NOT IN (
        SELECT 
            p.codigo_cliente 
        FROM 
            pago p
    );
/*Devuelve un listado de los productos (código y nombre)  que han aparecido en un pedido alguna vez.(Recomendamos resolver este ejercicio con Subconsultas del tipo EXISTS y NOT EXISTS).*/
SELECT 
    p.codigo_producto,
    p.nombre
FROM 
    producto p
WHERE 
    EXISTS (
        SELECT 
            1 
        FROM 
            detalle_pedido dp 
        WHERE 
            dp.codigo_producto = p.codigo_producto
    );
    
/*Devuelve el nombre del producto que tenga el precio de venta más caro. (Recomendamos resolver este ejercicio con Subconsultas del tipo ALL y ANY).*/
SELECT 
    nombre 
FROM 
    producto 
WHERE 
    precio_venta = (
        SELECT 
            MAX(precio_venta) 
        FROM 
            producto
    );
/*Devuelve el nombre del producto que tenga el precio de venta más caro (puedes realizarlo ordenando la tabla).*/
SELECT 
    nombre 
FROM 
    producto 
ORDER BY 
    precio_venta DESC 
LIMIT 1;

/*Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.*/
SELECT 
    dp.codigo_pedido,
    SUM(dp.cantidad) AS total_cantidad_productos
FROM 
    detalle_pedido dp
GROUP BY 
    dp.codigo_pedido;
    
/*Devuelve el nombre del cliente con mayor límite de crédito.*/
SELECT 
    nombre_cliente 
FROM 
    cliente 
ORDER BY 
    limite_credito DESC 
LIMIT 1;

/*Devuelve el producto que más unidades tiene en stock.*/
SELECT 
    nombre 
FROM 
    producto 
ORDER BY 
    cantidad_en_stock DESC 
LIMIT 1;

/*Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago. (Recomendamos resolver este ejercicio con Subconsultas del tipo ALL y ANY).*/
SELECT 
    c.nombre_cliente
FROM 
    cliente c
WHERE 
    c.codigo_cliente NOT IN (
        SELECT 
            p.codigo_cliente 
        FROM 
            pago p
    );
/*Devuelve un listado de los productos que nunca han aparecido en un pedido. (Recomendamos resolver este ejercicio con Subconsultas del tipo EXISTS y NOT EXISTS).*/
SELECT 
    p.codigo_producto,
    p.nombre
FROM 
    producto p
WHERE 
    NOT EXISTS (
        SELECT 
            1 
        FROM 
            detalle_pedido dp 
        WHERE 
            dp.codigo_producto = p.codigo_producto
    );
/*Calcula el número de productos diferentes que hay en cada uno de los pedidos. */
SELECT 
    dp.codigo_pedido,
    COUNT(DISTINCT dp.codigo_producto) AS productos_diferentes
FROM 
    detalle_pedido dp
GROUP BY 
    dp.codigo_pedido;
/*Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.*/
SELECT 
    e.nombre,
    e.apellido1,
    COUNT(c.codigo_cliente) AS numero_clientes
FROM 
    empleado e
LEFT JOIN 
    cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY 
    e.codigo_empleado;
    
/*Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M.*/
SELECT 
    ciudad,
    COUNT(*) AS numero_clientes
FROM 
    cliente
WHERE 
    ciudad LIKE 'M%'
GROUP BY 
    ciudad;

/*Calcula el número de clientes que no tiene asignado representante de ventas.*/
SELECT 
    COUNT(*) AS numero_clientes_sin_representante
FROM 
    cliente
WHERE 
    codigo_empleado_rep_ventas IS NULL;
    
/*Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas descendente.*/
SELECT 
    p.codigo_producto,
    p.nombre,
    SUM(dp.cantidad) AS total_unidades_vendidas
FROM 
    detalle_pedido dp
JOIN 
    producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY 
    p.codigo_producto
ORDER BY 
    total_unidades_vendidas DESC
LIMIT 20;






