-- Consultas multitabla (Composición externa)
-- Todas las consultas usan LEFT JOIN y RIGHT JOIN

-- 1. Clientes que no han realizado ningún pago
SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- 2. Clientes que no han realizado ningún pedido
SELECT c.*
FROM cliente c
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE pd.codigo_cliente IS NULL;

-- 3. Clientes que no han realizado ningún pago y los que no han realizado ningún pedido
SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE p.codigo_cliente IS NULL OR pd.codigo_cliente IS NULL;

-- 4. Empleados que no tienen una oficina asociada
SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

-- 5. Empleados que no tienen un cliente asociado
SELECT e.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 6. Empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan
SELECT e.*, o.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_empleado_rep_ventas IS NULL;

-- 7. Empleados que no tienen una oficina asociada y los que no tienen un cliente asociado
SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL OR c.codigo_empleado_rep_ventas IS NULL;

-- 8. Productos que nunca han aparecido en un pedido
SELECT pr.*
FROM producto pr
LEFT JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

-- 9. Productos que nunca han aparecido en un pedido (nombre, descripción, imagen)
SELECT pr.nombre, pr.descripcion, pr.imagen
FROM producto pr
LEFT JOIN detalle_pedido dp ON pr.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

-- 10. Oficinas donde no trabajan empleados que hayan sido representantes de clientes que compraron productos de la categoría Frutales
SELECT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
LEFT JOIN detalle_pedido dp ON pd.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto AND pr.categoria = 'Frutales'
WHERE pr.codigo_producto IS NULL;

-- 11. Clientes que han realizado algún pedido pero no han realizado ningún pago
SELECT DISTINCT c.*
FROM cliente c
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE pd.codigo_cliente IS NOT NULL AND p.codigo_cliente IS NULL;

-- 12. Empleados que no tienen clientes asociados y el nombre de su jefe asociado
SELECT e.*, j.nombre AS jefe_nombre
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;
