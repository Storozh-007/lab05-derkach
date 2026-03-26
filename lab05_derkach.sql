-- База даних: financial_database_derkach
-- Деркач Павло Романович, група 491
-- Лабораторна робота #5 - PostgreSQL

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    account_number VARCHAR(20) UNIQUE NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    account_type VARCHAR(20) CHECK (account_type IN ('checking', 'savings', 'credit'))
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES accounts(id),
    amount DECIMAL(10,2) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('debit', 'credit')),
    description VARCHAR(200),
    transaction_date DATE DEFAULT CURRENT_DATE,
    category_id INTEGER
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category_id INTEGER REFERENCES categories(id);

INSERT INTO users (name, email, registration_date, is_active) VALUES
('Іван Петренко','ivan.petrenko@email.com','2024-01-15',TRUE),
('Марія Коваленко','maria.kovalenko@email.com','2024-02-20',TRUE),
('Олег Сидоренко','oleg.sydorenko@email.com','2024-03-10',TRUE),
('Анна Шевченко','anna.shevchenko@email.com','2024-04-05',TRUE),
('Віктор Бондаренко','viktor.bondarenko@email.com','2024-05-12',TRUE),
('Ольга Гриценко','olga.gritsenko@email.com','2024-06-18',TRUE),
('Дмитро Кравченко','dmytro.kravchenko@email.com','2024-07-22',TRUE),
('Софія Литвиненко','sofia.lytvynenko@email.com','2024-08-14',TRUE),
('Андрій Мороз','andriy.moroz@email.com','2024-09-08',FALSE),
('Павло Деркач','pavlo.derkach@email.com','2024-10-01',TRUE);

INSERT INTO accounts (user_id, account_number, balance, account_type) VALUES
(1,'ACC001',1850.75,'checking'),(1,'ACC002',5200.00,'savings'),(1,'ACC003',2700.50,'credit'),
(2,'ACC004',950.25,'checking'),(2,'ACC005',1350.00,'savings'),
(3,'ACC006',3650.75,'checking'),(3,'ACC007',2950.00,'credit'),
(4,'ACC008',1050.50,'savings'),
(5,'ACC009',2350.00,'credit'),(5,'ACC010',4650.25,'savings'),(5,'ACC011',750.00,'checking'),
(6,'ACC012',1550.75,'savings'),(6,'ACC013',1100.50,'checking'),
(7,'ACC014',3250.00,'credit'),(7,'ACC015',850.25,'savings'),(7,'ACC016',1750.00,'checking'),
(8,'ACC017',3150.50,'credit'),(8,'ACC018',1200.75,'savings'),
(9,'ACC019',5400.00,'checking'),
(10,'ACC020',6350.50,'savings'),(10,'ACC021',950.00,'checking'),
(1,'ACC022',2050.25,'savings'),(2,'ACC023',3450.00,'credit'),
(3,'ACC024',1300.50,'checking'),(4,'ACC025',5850.75,'savings'),
(5,'ACC026',500.00,'credit'),(6,'ACC027',2250.00,'checking'),
(7,'ACC028',3750.25,'savings'),(8,'ACC029',1400.00,'credit'),
(9,'ACC030',6300.50,'checking');

INSERT INTO categories (name) VALUES
('Покупки'),('Зарплата'),('Оплата рахунків'),('Транспорт'),('Розваги'),
('Їжа'),('Іпотека'),('Бонус'),('Інвестиція'),('Повернення');

INSERT INTO transactions (account_id, amount, type, description, transaction_date) VALUES
(1,120.00,'debit','Покупка продуктів','2024-11-01'),(1,550.00,'credit','Зарплата листопад','2024-11-05'),
(2,250.00,'debit','Оплата комунальних послуг','2024-11-10'),
(3,180.00,'debit','Метро та автобус','2024-11-20'),
(5,300.00,'debit','Кіно та ігри','2024-11-25'),(5,350.00,'credit','Відсотки по депозиту','2024-11-28'),
(9,450.00,'debit','Іпотека за листопад','2024-11-10'),(9,650.00,'credit','Премія','2024-11-15'),
(9,95.00,'debit','Продукти','2024-11-20'),(9,175.00,'credit','Кешбек','2024-11-25'),
(9,225.00,'debit','Навчальна література','2024-11-30'),
(10,85.00,'debit','Кава вранці','2024-11-02'),(10,400.00,'credit','Дивіденди','2024-11-16'),
(10,120.00,'debit','Стрічка новин','2024-11-21'),
(11,140.00,'debit','Новий смартфон','2024-11-21'),
(14,100.00,'debit','Зимовий одяг','2024-11-01'),(14,320.00,'credit','Повернення коштів','2024-11-06'),
(15,125.00,'debit','Фітнес зал','2024-11-11'),(15,380.00,'credit','Фріланс проект','2024-11-16'),
(15,80.00,'debit','Музичний концерт','2024-11-21'),
(17,150.00,'debit','Відпочинок за кордоном','2024-11-01'),(17,500.00,'credit','Інвестиції в акції','2024-11-06'),
(17,105.00,'debit','Аудіокниги','2024-11-11'),(17,350.00,'credit','Продаж товару','2024-11-16'),
(20,155.00,'debit','Розваги','2024-11-21'),(20,520.00,'credit','Відсотки','2024-11-26'),
(22,115.00,'debit','Таксі','2024-11-01'),(22,370.00,'credit','Додатковий заробіток','2024-11-06'),
(22,175.00,'debit','Обід в ресторані','2024-11-11'),
(25,95.00,'debit','Кава та десерт','2024-11-21'),(25,300.00,'credit','Повернення покупки','2024-11-26'),
(27,135.00,'debit','Одяг онлайн','2024-11-01'),(27,480.00,'credit','Зарплата','2024-11-06'),
(27,155.00,'debit','Спортмарафон','2024-11-11'),
(29,175.00,'debit','Кіносеанс','2024-11-21'),(29,620.00,'credit','Криптовалюта','2024-11-26'),
(30,195.00,'debit','Мандрівка вихідного дня','2024-11-01'),(30,640.00,'credit','Продаж на маркетплейсі','2024-11-06'),
(30,215.00,'debit','Ігри та розваги','2024-11-11'),
(1,235.00,'debit','Транспортні витрати','2024-11-21'),
(2,255.00,'debit','Продукти харчування','2024-11-01'),
(3,275.00,'debit','Книги та журнали','2024-11-11'),
(5,295.00,'debit','Кава та випічка','2024-11-21'),
(7,315.00,'debit','Одяг та взуття','2024-11-01'),
(10,335.00,'debit','Спортивні товари','2024-11-11'),
(14,355.00,'debit','Кіно та серіали','2024-11-21'),
(15,375.00,'debit','Туризм','2024-11-01'),
(17,395.00,'debit','Концерти','2024-11-11'),
(20,415.00,'debit','Розваги','2024-11-21'),
(22,435.00,'credit','Подарунок','2024-11-26');

UPDATE transactions SET category_id = CASE
    WHEN description ILIKE '%зарплат%' THEN (SELECT id FROM categories WHERE name='Зарплата')
    WHEN description ILIKE '%іпотек%' THEN (SELECT id FROM categories WHERE name='Іпотека')
    WHEN description ILIKE '%бонус%' OR description ILIKE '%кешбек%' THEN (SELECT id FROM categories WHERE name='Бонус')
    WHEN description ILIKE '%інвест%' OR description ILIKE '%акці%' OR description ILIKE '%крипт%' THEN (SELECT id FROM categories WHERE name='Інвестиція')
    WHEN description ILIKE '%повернен%' THEN (SELECT id FROM categories WHERE name='Повернення')
    WHEN description ILIKE '%їж%' OR description ILIKE '%кава%' OR description ILIKE '%продукт%' OR description ILIKE '%обід%' THEN (SELECT id FROM categories WHERE name='Їжа')
    WHEN description ILIKE '%транспорт%' OR description ILIKE '%метро%' OR description ILIKE '%таксі%' THEN (SELECT id FROM categories WHERE name='Транспорт')
    WHEN description ILIKE '%оплата%' OR description ILIKE '%комунальн%' THEN (SELECT id FROM categories WHERE name='Оплата рахунків')
    WHEN description ILIKE '%покуп%' THEN (SELECT id FROM categories WHERE name='Покупки')
    ELSE (SELECT id FROM categories WHERE name='Розваги')
END;

-- Базові SELECT запити
SELECT * FROM transactions WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 9 ORDER BY transaction_date DESC;
SELECT * FROM transactions WHERE account_id = 20 AND type = 'credit';

-- Сортування
SELECT * FROM transactions ORDER BY transaction_date DESC;
SELECT * FROM transactions ORDER BY amount DESC, transaction_date;

-- INNER JOIN - об'єднання таблиць
SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;

-- LEFT JOIN - користувачі без транзакцій
SELECT u.name, a.account_number
FROM users u
LEFT JOIN accounts a ON u.id = a.user_id
LEFT JOIN transactions t ON a.id = t.account_id
WHERE t.id IS NULL;

-- CROSS JOIN - декартовий добуток
SELECT u.name, t.description, t.amount
FROM users u
CROSS JOIN transactions t
LIMIT 15;

-- FULL OUTER JOIN
SELECT a.account_number, t.id AS transaction_id, t.amount
FROM accounts a
FULL OUTER JOIN transactions t ON a.id = t.account_id;

-- Агрегатні функції
SELECT account_type, SUM(balance) AS sum_balance FROM accounts GROUP BY account_type;
SELECT account_type, AVG(balance) AS avg_balance FROM accounts GROUP BY account_type;
SELECT type, COUNT(*) AS txn_count, SUM(amount) AS sum_amount FROM transactions GROUP BY type;

-- Оновлення балансу
UPDATE accounts SET balance = balance + 1200 WHERE account_type = 'savings';
SELECT account_number, balance FROM accounts WHERE account_type = 'savings';

UPDATE accounts a SET balance = a.balance + 75
FROM users u
WHERE a.user_id = u.id AND u.is_active = TRUE;
SELECT a.account_number, a.balance
FROM accounts a JOIN users u ON a.user_id = u.id
WHERE u.is_active = TRUE;

-- Видалення старих транзакцій
DELETE FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';
SELECT * FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';

DELETE FROM transactions USING accounts
WHERE transactions.account_id = accounts.id AND accounts.balance < 0;
SELECT a.account_number, a.balance FROM accounts a WHERE a.balance < 0;

-- Підзапити
SELECT a.account_number, SUM(t.amount) AS total_amount
FROM accounts a JOIN transactions t ON a.id = t.account_id
GROUP BY a.account_number
ORDER BY total_amount DESC
LIMIT 3;

SELECT u.name, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name
HAVING SUM(t.amount) > 250;

SELECT t.id, a.account_number, t.amount, t.type, c.name AS category, t.description, t.transaction_date
FROM transactions t
JOIN accounts a ON t.account_id = a.id
LEFT JOIN categories c ON t.category_id = c.id
ORDER BY t.id;

SELECT c.id, c.name
FROM categories c
WHERE (SELECT COALESCE(SUM(t.amount),0) FROM transactions t WHERE t.category_id = c.id) > 150;

-- Stored Procedure
CREATE OR REPLACE PROCEDURE calculate_balance_proc(p_account_id INT, OUT balance DECIMAL)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT COALESCE(SUM(CASE WHEN type='credit' THEN amount ELSE -amount END),0)
    INTO balance
    FROM transactions t
    WHERE t.account_id = p_account_id;
END;
$$;

CALL calculate_balance_proc(1, NULL);

-- Trigger для оновлення балансу
CREATE OR REPLACE FUNCTION update_balance() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE accounts
        SET balance = balance + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE accounts
        SET balance = balance
            - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
            + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE accounts
        SET balance = balance - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
        WHERE id = OLD.account_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS balance_trigger ON transactions;
CREATE TRIGGER balance_trigger
AFTER INSERT OR UPDATE OR DELETE ON transactions
FOR EACH ROW EXECUTE FUNCTION update_balance();

-- Тестування trigger
SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) VALUES (1, 250.00, 'credit', 'Тестовий дохід');
SELECT balance FROM accounts WHERE id = 1;

-- Додаткові запити для звіту
SELECT u.name, a.account_number, a.balance, a.account_type
FROM users u JOIN accounts a ON u.id = a.user_id
WHERE u.name = 'Павло Деркач';

SELECT u.name, SUM(a.balance) as total
FROM users u JOIN accounts a ON u.id = a.user_id
GROUP BY u.name ORDER BY total DESC;
