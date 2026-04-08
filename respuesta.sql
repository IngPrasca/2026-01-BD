--Sofhia Prasca Teheran
--pregunta 1
SELECT p.productname
FROM products p
JOIN OrderDetails od ON p.productid = od.productid
JOIN orders o ON od.orderid = o.orderid
GROUP BY p.productid, p.productname
HAVING COUNT(DISTINCT o.employeeid) = (SELECT COUNT(*) FROM employees);
--pregunta 2
SELECT DISTINCT c.companyname
FROM customers c
WHERE c.customerid NOT IN (
    SELECT DISTINCT o.customerid
    FROM orders o
    JOIN OrderDetails od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid
    WHERE p.unitprice > 50);
--pregunta 3
SELECT e.title, e.firstname || ' ' || e.lastname AS nombre
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM orders o
    JOIN OrderDetails od ON o.orderid = od.orderid
    JOIN products p ON od.productid = p.productid
    WHERE o.employeeid = e.employeeid
    AND p.productname IN ('Gravad Lax', 'Mishi Kobe Niku')
)
ORDER BY nombre;
--pregunta 4
  SELECT 
    e.firstname || ' ' || e.lastname AS empleado,
    c.companyname AS cliente
FROM orders o
JOIN employees e ON o.employeeid = e.employeeid
JOIN customers c ON o.customerid = c.customerid
JOIN shippers s ON o.shipvia = s.shipperid
WHERE s.companyname = 'Speedy Express'
AND c.city = 'Bruxelles';
--pregunta 5
 SELECT DISTINCT 
    e.firstname || ' ' || e.lastname AS nombre,
    e.address,
    e.city,
    e.region
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
WHERE o.shipcountry = 'Belgium';