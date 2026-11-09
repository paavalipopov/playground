-- 1. Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- 2. Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- 3. Create Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity_sold INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Categories (category_id, category_name) VALUES 
(1, 'Electronics'),
(2, 'Home Decor'),
(3, 'Stationery');

-- Populating Products
INSERT INTO Products (product_id, product_name, category_id, price, stock_quantity) VALUES 
(101, 'Mechanical Keyboard', 1, 89.99, 15),
(102, 'Desk Lamp', 2, 25.50, 30),
(103, 'Fountain Pen', 3, 45.00, 10),
(104, 'Noise Cancelling Headphones', 1, 199.00, 5);

-- Populating Sales
INSERT INTO Sales (sale_id, product_id, sale_date, quantity_sold, total_price) VALUES 
(5001, 101, '2026-02-01', 1, 89.99),
(5002, 102, '2026-02-02', 2, 51.00),
(5003, 101, '2026-02-03', 1, 89.99);

-- Describe Sales
DESCRIBE Sales;

-- Query to find products with quantity_sold greater than 1
SELECT product_id, quantity_sold 
FROM Sales 
WHERE quantity_sold > 1;

-- Join Products and Sales to get product names with their sales details
SELECT Products.product_name, Sales.sale_date, Sales.total_price
FROM Sales
JOIN Products ON Sales.product_id = Products.product_id;

-- select all from sales
SELECT * FROM Sales;

-- select all from products
SELECT * FROM Products;

-- select all from categories
SELECT * FROM Categories;

-- Describe Products
DESCRIBE Products;

-- Practice Challenges
-- Simple Filter: Find all products that cost more than $50.
-- inspect the Products table to see the data
select * from Products limit 2;
DESCRIBE Products;

select * from Products;

select * from Products where price > 50;


-- Basic Join: List all product names alongside their category names.
select * from Categories limit 2;

select Products.product_name, Categories.category_name
from Products
join Categories 
on Products.category_id = Categories.category_id;

-- Aggregation: Calculate the total revenue (sum of total_price) from the Sales table.
select sum(total_price) as total_revenue
from Sales;

select sales.quantity_sold, sales.total_price, products.product_name, products.price 
from sales join products 
on sales.product_id = products.product_id;

-- The "Boss" Query: Find which category has generated the most sales revenue.

select c.category_name, sum(s.quantity_sold * p.price) as category_revenue
from Categories c 
join Products p on c.category_id = p.category_id
join Sales s on s.product_id = p.product_id
group by c.category_name
order by category_revenue desc
limit 1;