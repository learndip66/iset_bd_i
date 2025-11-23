
-- a. Código de oficina y ciudad
SELECT codigo_oficina, ciudad FROM oficina;

-- b. Ciudad y teléfono de oficinas en España
SELECT ciudad, telefono FROM oficina WHERE pais = 'España';

-- c. Nombre, apellidos y email de empleados cuyo jefe tiene código 7
SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;

-- d. Puesto, nombre, apellidos y email del jefe de la empresa
SELECT puesto, nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_empleado = (
    SELECT codigo_jefe FROM empleado WHERE codigo_jefe IS NULL LIMIT 1
);

-- e. Nombre, apellidos y puesto de empleados que no sean representantes de ventas
SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto <> 'Representante Ventas';

-- f. Nombre de todos los clientes españoles
SELECT nombre_cliente
FROM cliente
WHERE pais = 'España';

-- g. Distintos estados de pedido
SELECT DISTINCT estado
FROM pedido;

-- h. Código de cliente con pagos en 2008 (sin repetidos)
-- Usando YEAR
SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;
-- Usando DATE_FORMAT
SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';
-- Sin funciones
SELECT DISTINCT codigo_cliente
FROM pago
WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

-- i. Pedidos no entregados a tiempo
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

-- j. Pedidos entregados al menos dos días antes de la fecha esperada
-- Usando ADDDATE
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);
-- Usando DATEDIFF
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;
-- ¿Con suma/resta? Sí, con DATEDIFF

-- k. Pedidos rechazados en 2009
SELECT *
FROM pedido
WHERE estado = 'Rechazado'
  AND YEAR(fecha_pedido) = 2009;

-- l. Pedidos entregados en enero de cualquier año
SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;

-- m. Pagos en 2008 mediante Paypal, ordenados de mayor a menor
SELECT *
FROM pago
WHERE forma_pago = 'Paypal'
  AND YEAR(fecha_pago) = 2008
ORDER BY total DESC;

-- n. Todas las formas de pago (sin repetidos)
SELECT DISTINCT forma_pago
FROM pago;

-- o. Productos de categoría Ornamentales con más de 100 unidades en stock, ordenados por precio de venta descendente
SELECT *
FROM producto
WHERE categoria = 'Ornamentales'
  AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

-- p. Clientes de Madrid cuyo representante de ventas tiene código de empleado 11 o 30
SELECT *
FROM cliente
WHERE ciudad = 'Madrid'
  AND codigo_empleado_rep_ventas IN (11, 30);
