SELECT Country, COUNT(CustomerId) AS CustomerCount
FROM customers
GROUP BY Country
