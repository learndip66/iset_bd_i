-- Subconsultas con ALL y ANY

-- 1. Nombre del cliente con mayor límite de crédito
SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);

-- 2. Nombre del producto con el precio de venta más caro
SELECT nombre
FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);

-- 3. Producto que menos unidades tiene en stock
SELECT nombre
FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);

-- Subconsultas con IN y NOT IN

-- 1. Nombre, apellido1 y cargo de los empleados que no representen a ningún cliente
SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas FROM cliente
);

-- 2. Clientes que no han realizado ningún pago
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (
    SELECT codigo_cliente FROM pago
);

-- 3. Clientes que sí han realizado algún pago
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
    SELECT codigo_cliente FROM pago
);

-- 4. Productos que nunca han aparecido en un pedido
SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (
    SELECT codigo_producto FROM detalle_pedido
);

-- 5. Nombre, apellidos, puesto y teléfono de la oficina de empleados que no sean representante de ventas de ningún cliente
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas FROM cliente
);

-- 6. Oficinas donde no trabajan empleados que hayan sido representantes de clientes que compraron productos de la categoría Frutales
SELECT o.*
FROM oficina o
WHERE o.codigo_oficina NOT IN (
    SELECT e.codigo_oficina
    FROM empleado e
    JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
    JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
    JOIN detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
    JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
    WHERE pr.categoria = 'Frutales'
);

-- 7. Clientes que han realizado algún pedido pero no han realizado ningún pago
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
    SELECT codigo_cliente FROM pedido
)
AND codigo_cliente NOT IN (
    SELECT codigo_cliente FROM pago
);

-- Subconsultas con EXISTS y NOT EXISTS

-- 1. Clientes que no han realizado ningún pago
SELECT nombre_cliente
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente
);

-- 2. Clientes que sí han realizado algún pago
SELECT nombre_cliente
FROM cliente c
WHERE EXISTS (
    SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente
);

-- 3. Productos que nunca han aparecido en un pedido
SELECT nombre
FROM producto pr
WHERE NOT EXISTS (
    SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = pr.codigo_producto
);

-- 4. Productos que han aparecido en un pedido alguna vez
SELECT nombre
FROM producto pr
WHERE EXISTS (
    SELECT 1 FROM detalle_pedido dp WHERE dp.codigo_producto = pr.codigo_producto
);
