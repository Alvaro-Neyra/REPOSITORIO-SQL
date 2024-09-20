/*-- Encuentra los nombres de los clientes que han realizado compras de productos con un precio superior a la media de precios de todos los productos.*/
SELECT cli.nombre
FROM ventas vent
LEFT JOIN clientes cli ON cli.id = vent.cliente_id
WHERE vent.precio_unitario > (
    SELECT AVG(precio_unitario) FROM ventas
);

SELECT * FROM ventas;