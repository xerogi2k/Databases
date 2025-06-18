-- Вставка данных в таблицу supplier
INSERT INTO supplier (name, address, contact_name, phone)
VALUES
('Индустрия Металлов', 'Улица Первомайская, 10', 'Андрей Иванов', '123-456-7890'),
('ЭлектроТех', 'Проспект Ленина, 25', 'Елена Сидорова', '987-654-3210'),
('ТекстильМаркет', 'Улица Гагарина, 5', 'Дмитрий Петров', '456-789-0123');

-- Вставка данных в таблицу recipient
INSERT INTO recipient (name, address, contact_name, phone)
VALUES
('Магазин "Дом Товаров"', 'Улица Кирова, 15', 'Ольга Николаева', '321-654-9870'),
('Технический Магазин "Энерго"', 'Улица Советская, 20', 'Александр Васильев', '012-345-6789'),
('Супермаркет "Успех"', 'Проспект Мира, 30', 'Мария Федорова', '789-012-3456');

-- Вставка данных в таблицу product
INSERT INTO product (name, release_date, price, id_supplier)
VALUES
('Стальные Гайки', '2023-01-01', 100.00, 1),
('Электродвигатель', '2023-02-01', 200.00, 2),
('Ткань Хлопковая', '2023-03-01', 300.00, 3);

-- Вставка данных в таблицу invoice
INSERT INTO invoice (invoice_number, total_amount, manufacturer, id_recipient, id_supplier)
VALUES
('0000001', 500.00, 'Металлургия Групп', 1, 1),
('0000002', 700.00, 'Энерго Техника', 2, 2),
('0000003', 900.00, 'Текстиль Пром', 3, 3);

-- Вставка данных в таблицу invoice_product
INSERT INTO invoice_product (quantity, price, id_invoice, id_product)
VALUES
(2, 100.00, 1, 1),
(3, 200.00, 2, 2),
(4, 300.00, 3, 3);

-- 3.1 INSERT
-- a. Без указания списка полей
INSERT INTO supplier VALUES
(DEFAULT, 'ООО Рога и копыта', 'ул. Первомайская, 10', 'Иванов Иван', '+7 123 456-78-90');

-- b. С указанием списка полей
INSERT INTO recipient (name, address, contact_name, phone) VALUES
('ИП Иванов', 'пр. Ленина, 5', 'Петров Петр', '+7 987 654-32-10');

-- c. С чтением значения из другой таблицы
INSERT INTO product (name, release_date, price, id_supplier)
SELECT 'Ноутбук', '2024-05-15', 45000.00, id_supplier FROM supplier WHERE name = 'ООО Рога и копыта';

-- 3.2 DELETE
-- a. Всех записей
DELETE FROM invoice_product;

-- b. По условию
DELETE FROM product WHERE price > 50000.00;

-- 3.3 UPDATE
-- a. Всех записей
UPDATE supplier SET phone = '+7 987 654-32-10';

-- b. По условию обновляя один атрибут
UPDATE recipient SET address = 'ул. Советская, 20' WHERE name = 'ИП Иванов';

-- c. По условию обновляя несколько атрибутов
UPDATE invoice SET manufacturer = 'ООО Техника' WHERE id_supplier = (SELECT id_supplier FROM supplier WHERE name = 'ООО Рога и копыта');

-- 3.4 SELECT
-- a. С набором извлекаемых атрибутов
SELECT name, release_date FROM product;

-- b. Со всеми атрибутами
SELECT * FROM invoice;

-- c. С условием по атрибуту
SELECT * FROM recipient WHERE phone = '+7 987 654-32-10';

-- 3.5 SELECT ORDER BY + TOP (LIMIT)
-- a. С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM product ORDER BY price ASC LIMIT 5;

-- b. С сортировкой по убыванию DESC
SELECT * FROM invoice ORDER BY total_amount DESC;

-- c. С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT * FROM invoice_product ORDER BY quantity DESC, price ASC LIMIT 10;

-- d. С сортировкой по первому атрибуту, из списка извлекаемых
SELECT name, release_date FROM product ORDER BY name;

-- 3.6 Работа с датами
-- a. WHERE по дате
SELECT * FROM product WHERE release_date = '2024-05-15';

-- b. WHERE дата в диапазоне
SELECT * FROM invoice WHERE total_amount BETWEEN 10000.00 AND 50000.00;

-- c. Извлечь из таблицы не всю дату, а только год
SELECT name, EXTRACT(YEAR FROM release_date) AS release_year FROM product;

-- 3.7 Функции агрегации
-- a. Посчитать количество записей в таблице
SELECT COUNT(*) FROM supplier;

-- b. Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT manufacturer) FROM invoice;

-- c. Вывести уникальные значения столбца
SELECT DISTINCT address FROM recipient;

-- d. Найти максимальное значение столбца
SELECT MAX(price) FROM product;

-- e. Найти минимальное значение столбца
SELECT MIN(release_date) FROM product;

-- f. Написать запрос COUNT() + GROUP BY
SELECT id_supplier, COUNT(*) FROM product GROUP BY id_supplier;

-- 3.8 SELECT GROUP BY + HAVING
-- a. Найти количество товаров поставленных каждым поставщиком, если поставлено более 5 товаров
SELECT id_supplier, COUNT(*) AS product_count FROM product GROUP BY id_supplier HAVING COUNT(*) > 5;

-- b. Найти количество накладных с общей суммой свыше 10000, выставленных каждому получателю
SELECT id_recipient, COUNT(*) AS invoice_count FROM invoice GROUP BY id_recipient HAVING SUM(total_amount) > 10000;

-- c. Найти количество товаров в каждой накладной, если в накладной больше 3 товаров
SELECT id_invoice, COUNT(*) AS product_count FROM invoice_product GROUP BY id_invoice HAVING COUNT(*) > 3;

-- 3.9 SELECT JOIN
-- a. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT s.name, p.name FROM supplier s LEFT JOIN product p ON s.id_supplier = p.id_supplier WHERE p.price > 5000.00;

-- b. RIGHT JOIN. Получить такую же выборку, как и в 3.9a
SELECT s.name, p.name FROM product p RIGHT JOIN supplier s ON s.id_supplier = p.id_supplier WHERE p.price > 5000.00;

-- c. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT p.name AS product_name, i.invoice_number, r.name AS recipient_name
FROM product p
LEFT JOIN invoice_product ip ON p.id_product = ip.id_product
LEFT JOIN invoice i ON ip.id_invoice = i.id_invoice
LEFT JOIN recipient r ON i.id_recipient = r.id_recipient
WHERE p.price > 10000.00 AND i.total_amount > 5000.00 AND r.phone = '+7 987 654-32-10';

-- d. INNER JOIN двух таблиц
SELECT i.invoice_number, p.name AS product_name FROM invoice i INNER JOIN invoice_product ip ON i.id_invoice = ip.id_invoice INNER JOIN product p ON ip.id_product = p.id_product;

-- 3.10 Подзапросы
-- a. Написать запрос с условием WHERE IN (подзапрос)
SELECT * FROM product WHERE id_supplier IN (SELECT id_supplier FROM supplier WHERE name = 'ООО Рога и копыта');

-- b. Написать запрос SELECT atr1, atr2, (подзапрос)
SELECT name, release_date, (SELECT COUNT(*) FROM invoice_product WHERE id_product = p.id_product) AS product_count
FROM product p;

-- c. Написать запрос вида SELECT * FROM(подзапрос)
SELECT * FROM (SELECT * FROM invoice WHERE total_amount > 600.00) AS expensive_invoices;

-- d. Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON ...
SELECT s.name AS supplier_name, p.name AS product_name
FROM supplier s
JOIN (SELECT id_supplier, name FROM product WHERE price > 5000.00) AS p
ON s.id_supplier = p.id_supplier;