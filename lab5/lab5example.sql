use [pharmacy]
--1. Добавить внешние ключи.
ALTER TABLE [dbo].[dealer]
ADD CONSTRAINT FK_dealer_company
FOREIGN KEY (id_company)
REFERENCES company(id_company);

ALTER TABLE [dbo].[order]
ADD CONSTRAINT FK_order_production
FOREIGN KEY (id_production)
REFERENCES production(id_production);

ALTER TABLE [dbo].[order]
ADD CONSTRAINT FK_order_dealer
FOREIGN KEY (id_dealer)
REFERENCES dealer(id_dealer);

ALTER TABLE [dbo].[order]
ADD CONSTRAINT FK_order_pharmacy
FOREIGN KEY (id_pharmacy)
REFERENCES pharmacy(id_pharmacy);

ALTER TABLE [dbo].[production]
ADD CONSTRAINT FK_production_company
FOREIGN KEY (id_company)
REFERENCES company(id_company);

ALTER TABLE [dbo].[production]
ADD CONSTRAINT FK_production_medicine
FOREIGN KEY (id_medicine)
REFERENCES medicine(id_medicine);

--2. Выдать информацию по всем заказам лекарствам “Кордерон” компании “Аргус” с указанием названий аптек, дат, объема заказов.
SELECT ph.name AS pharmacy_name, o.date, o.quantity
FROM [order] o
JOIN [production] pr ON o.id_production = pr.id_production
JOIN [medicine] m ON pr.id_medicine = m.id_medicine
JOIN [pharmacy] ph ON o.id_pharmacy = ph.id_pharmacy
JOIN [company] c ON pr.id_company = c.id_company
WHERE m.name = '��������' AND c.name = '�����';

--3. Дать список лекарств компании “Фарма”, на которые не были сделаны заказы до 25 января.
SELECT m.name
FROM [medicine] m
JOIN [production] pr ON m.id_medicine = pr.id_medicine
JOIN [company] c ON pr.id_company = c.id_company
LEFT JOIN [order] o ON pr.id_production = o.id_production
    AND o.date >= '2019-01-25'
WHERE c.name = N'�����'
    AND o.id_order IS NULL;


--4. Дать минимальный и максимальный баллы лекарств каждой фирмы, которая оформила не менее 120 заказов.
SELECT c.name AS company_name, MIN(pr.rating) AS min_rating, MAX(pr.rating) AS max_rating
FROM production pr
JOIN company c ON pr.id_company = c.id_company
JOIN [order] o ON pr.id_production = o.id_production
GROUP BY c.name
HAVING COUNT(o.id_order) >= 120;

--5. Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”. Если у дилера нет заказов, в названии аптеки проставить NULL.
SELECT d.name AS dealer_name, p.name AS pharmacy_name
FROM dealer d
JOIN company c ON d.id_company = c.id_company
LEFT JOIN [order] o ON d.id_dealer = o.id_dealer
LEFT JOIN pharmacy p ON o.id_pharmacy = p.id_pharmacy
WHERE c.name = 'AstraZeneca';

--6. Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а длительность лечения не более 7 дней.
UPDATE production
SET price = price * 0.8
WHERE price > 3000 AND id_medicine IN (
    SELECT id_medicine
    FROM medicine
    WHERE cure_duration <= 7
);

--7. Добавить необходимые индексы.
CREATE INDEX IX_company_name ON company (name);
CREATE INDEX IX_medicine_name ON medicine (name);
CREATE INDEX IX_medicine_cure_duration ON medicine (cure_duration);
CREATE INDEX IX_prodution_id_medicine ON production (id_medicine);
CREATE INDEX IX_order_date ON [order] ([date]);
CREATE INDEX IX_order_id_production ON [order](id_production);
