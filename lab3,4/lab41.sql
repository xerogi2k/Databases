-- Вставка данных в таблицу movie
INSERT INTO movie (name, description, director, genre, release_date) VALUES
('Начало', 'Человек, который крадёт корпоративные секреты с помощью технологии попадания в сон', 'Кристофер Нолан', 'Фантастика', '2010-07-16'),
('Матрица', 'Днём он самый обычный офисный работник,получающий от начальства, а ночью хакер Нео.', 'Лана Вачовски, Лилли Вачовски', 'Боевик', '1999-03-31'),
('Интерстеллар', 'Коллектив исследователей и учёных отправляется сквозь червоточину в путешествие....', 'Кристофер Нолан', 'Фантастика', '2014-10-26');

-- Вставка данных в таблицу customer
INSERT INTO customer (full_name, birth_date, email, seat) VALUES
('Иван Иванов', '1985-05-15', 'ivan.inanov@example.com', 'А12'),
('Василий Васильев', '1993-04-13', 'vasya1993@mail.ru', 'Б11'),
('Мария Шапкина', '1995-03-11', 'masha11@gmail.com', 'Б12');

-- Вставка данных в таблицу film_rental
INSERT INTO film_rental (provider, start_date, end_date, id_movie) VALUES
('Warner Bros', '2024-05-01', '2024-05-31', 1),
('Universal Pictures', '2024-06-01', '2024-06-30', 2),
('Paramount Pictures', '2024-07-01', '2024-07-31', 3);

-- Вставка данных в таблицу cinema
INSERT INTO cinema (name, cinema_number, phone, address, id_film_rental)
VALUES
('Кинолента', '0000000001', '89272346252', 'Театральная 14', 1),
('Союз', '0002340245', '86452344512', 'Достоевского 27Б', 2),
('Взлёт', '0013456023', '89871431415', 'Пушкина 29А', 3);

-- Вставка данных в таблицу cinema_customer
INSERT INTO cinema_customer (id_cinema, id_customer) VALUES
(1, 1),
(1, 2),
(2, 3);

-- Вставка данных в таблицу ticket
INSERT INTO ticket (ticket_number, purchase_date, price, id_cinema, id_movie, id_customer) VALUES
('T12345', '2024-05-20', 15.50, 1, 1, 1),
('T12346', '2024-05-21', 12.00, 1, 2, 2),
('T12347', '2024-05-22', 10.00, 2, 3, 3);

-- 3.1 INSERT

-- a. Без указания списка полей
INSERT INTO movie
VALUES (DEFAULT, 'Побег из Шоушенка', 'Каждый, кто попадает в эти стены, становится их рабом до конца жизни, но Энди находит выход...', 'Фрэнк Дарабонт', 'Драма', '1994-10-09');

-- b. С указанием списка полей
INSERT INTO customer (full_name, birth_date, email, seat)
VALUES ('Николай Наумов', '1987-04-19', 'naumov@yandex.ru', 'В11');

-- c. С чтением значения из другой таблицы
INSERT INTO ticket (ticket_number, purchase_date, price, id_cinema, id_movie, id_customer)
SELECT 'T12345', '2024-05-20', 15.50, c.id_cinema, m.id_movie, cust.id_customer
FROM cinema c, movie m, customer cust
WHERE c.name = 'Кинолента' AND m.name = 'Начало' AND cust.full_name = 'Иван Иванов';

-- 3.2 DELETE

-- a. Удаление всех записей
DELETE FROM ticket WHERE TRUE;

-- b. Удаление по условию
DELETE FROM customer WHERE email = 'naumov@yandex.ru';

-- 3.3 UPDATE

-- a. Обновление всех записей
UPDATE cinema SET phone = '89658887343' WHERE TRUE;

-- b. Обновление по условию одного атрибута
UPDATE movie SET genre = 'Комедия' WHERE name = 'Побег из Шоушенка';

-- c. Обновление по условию нескольких атрибутов
UPDATE customer SET email = 'new.email@example.com', seat = 'B15' WHERE full_name = 'Василий Васильев';

-- 3.4 SELECT

-- a. С набором извлекаемых атрибутов
SELECT name, genre FROM movie;

-- b. Со всеми атрибутами
SELECT * FROM cinema;

-- c. С условием по атрибуту
SELECT * FROM movie WHERE genre = 'Фантастика';

-- 3.5 SELECT ORDER BY + TOP (LIMIT)

-- a. Сортировка по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM customer ORDER BY birth_date ASC LIMIT 2;

-- b. Сортировка по убыванию DESC
SELECT * FROM movie ORDER BY release_date DESC;

-- c. Сортировка по двум атрибутам + ограничение вывода количества записей
SELECT * FROM ticket ORDER BY price DESC, purchase_date ASC LIMIT 10;

-- d. Сортировка по первому атрибуту, из списка извлекаемых
SELECT name, release_date FROM movie ORDER BY 1;

-- 3.6 Работа с датами

-- a. WHERE по дате
SELECT * FROM ticket WHERE purchase_date = '2024-05-20';

-- b. WHERE дата в диапазоне
SELECT * FROM movie WHERE release_date BETWEEN '2010-01-01' AND '2010-12-31';

-- c. Извлечь из таблицы не всю дату, а только год
SELECT name, EXTRACT(YEAR FROM release_date) AS release_year FROM movie;

-- 3.7 Функции агрегации

-- a. Посчитать количество записей в таблице
SELECT COUNT(*) FROM customer;

-- b. Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT genre) FROM movie;

-- c. Вывести уникальные значения столбца
SELECT DISTINCT genre FROM movie;

-- d. Найти максимальное значение столбца
SELECT MAX(price) FROM ticket;

-- e. Найти минимальное значение столбца
SELECT MIN(release_date) FROM movie;

-- f. Написать запрос COUNT() + GROUP BY
SELECT genre, COUNT(*) FROM movie GROUP BY genre;

-- 3.8 SELECT GROUP BY + HAVING

-- a. Найти количество фильмов каждого жанра, имеющих больше 1 фильма
SELECT genre, COUNT(*) AS movie_count
FROM movie
GROUP BY genre
HAVING COUNT(*) > 1;

-- b. Найти максимальную цену билета, проданного по каждому кинотеатру и каждому фильму, если продано более 5 билетов на этот фильм в данном кинотеатре
SELECT id_cinema, AVG(price) AS average_ticket_price
FROM ticket
GROUP BY id_cinema
HAVING AVG(price) > 12;

-- c. Найти общее количество проданных билетов в каждом кинотеатре на каждый фильм, если общая сумма продаж превышает 10000
SELECT id_cinema, id_movie, SUM(price) AS total_sales
FROM ticket
GROUP BY id_cinema, id_movie
HAVING SUM(price) > 5000;

-- 3.9 SELECT JOIN

-- a. LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT customer.full_name, ticket.ticket_number
FROM customer
LEFT JOIN ticket ON customer.id_customer = ticket.id_customer
WHERE ticket.price > 10;

-- b. RIGHT JOIN. Получить такую же выборку, как и в 3.9a
SELECT customer.full_name, ticket.ticket_number
FROM ticket
RIGHT JOIN customer ON customer.id_customer = ticket.id_customer
WHERE ticket.price > 10;

-- c. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT c.name AS cinema_name, m.name AS movie_name, cust.full_name AS customer_name
FROM cinema c
LEFT JOIN ticket t ON c.id_cinema = t.id_cinema
LEFT JOIN movie m ON t.id_movie = m.id_movie
LEFT JOIN customer cust ON t.id_customer = cust.id_customer
WHERE c.name = 'Кинолента' AND m.genre = 'Фантастика' AND cust.full_name LIKE 'Иван%';

-- d. INNER JOIN двух таблиц
SELECT m.name, f.provider
FROM movie m
INNER JOIN film_rental f ON m.id_movie = f.id_movie;

-- 3.10 Подзапросы

-- a. Написать запрос с условием WHERE IN (подзапрос)
SELECT * FROM movie WHERE id_movie IN (SELECT id_movie FROM ticket WHERE price > 10);

-- b. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT m.name, m.genre, (SELECT COUNT(*) FROM ticket t WHERE t.id_movie = m.id_movie) AS ticket_count
FROM movie m;

-- c. Написать запрос вида SELECT * FROM(подзапрос)
SELECT *
FROM (SELECT id_movie, name, release_date FROM movie WHERE genre = 'Фантастика') AS sci_fi_movies;

-- d. Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON ...
SELECT c.name, temp.movie_count
FROM cinema c
JOIN (SELECT id_cinema, COUNT(*) AS movie_count FROM ticket GROUP BY id_cinema) AS temp
ON c.id_cinema = temp.id_cinema;
