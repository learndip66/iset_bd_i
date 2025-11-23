-- Consultas con operadores básicos de comparación

-- 1. Nombre del cliente con mayor límite de crédito
SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

-- 2. Nombre del producto con el precio de venta más caro
SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

-- 3. Nombre del producto del que se han vendido más unidades
SELECT pr.nombre
FROM producto pr
JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
GROUP BY pr.codigo_producto
ORDER BY SUM(dp.cantidad) DESC
LIMIT 1;

-- 4. Clientes cuyo límite de crédito es mayor que los pagos realizados (sin INNER JOIN)
SELECT nombre_cliente
FROM cliente
WHERE limite_credito > (
    SELECT IFNULL(SUM(total), 0)
    FROM pago
    WHERE pago.codigo_cliente = cliente.codigo_cliente
);

-- 5. Producto que más unidades tiene en stock
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

-- 6. Producto que menos unidades tiene en stock
SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

-- 7. Nombre, apellidos y email de los empleados que están a cargo de Alberto Soria
SELECT e.nombre, e.apellido1, e.apellido2, e.email
FROM empleado e
WHERE e.codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);
