-- Consultas multitabla (Composición interna)
-- Todas las consultas usan INNER JOIN y NATURAL JOIN

-- 1. Listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas
SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 3. Nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE p.codigo_cliente IS NULL;

-- 4. Clientes que han hecho pagos, nombre de sus representantes y ciudad de la oficina del representante
SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 5. Clientes que no han hecho pagos, nombre de sus representantes y ciudad de la oficina del representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

-- 6. Dirección de las oficinas que tengan clientes en Fuenlabrada
SELECT DISTINCT o.direccion
FROM oficina o
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

-- 7. Nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina del representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8. Nombre de los empleados junto con el nombre de sus jefes
SELECT e.nombre AS empleado, j.nombre AS jefe
FROM empleado e
INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado;

-- 9. Nombre de cada empleado, el nombre de su jefe y el nombre del jefe de su jefe
SELECT e.nombre AS empleado, j.nombre AS jefe, jj.nombre AS jefe_de_jefe
FROM empleado e
INNER JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
LEFT JOIN empleado jj ON j.codigo_jefe = jj.codigo_empleado;

-- 10. Nombre de los clientes a los que no se les ha entregado a tiempo un pedido
SELECT DISTINCT c.nombre_cliente
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

-- 11. Diferentes categorías de producto que ha comprado cada cliente
SELECT DISTINCT c.nombre_cliente, pr.categoria
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
INNER JOIN producto pr ON dp.codigo_producto = pr.codigo_producto;
