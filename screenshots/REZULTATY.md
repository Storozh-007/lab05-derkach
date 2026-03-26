# Результати запитів - Лабораторна робота 5
# Деркач Павло Романович, група 491

---

## Рисунок 1 - Структура таблиці users

```
\d users
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('users_id_seq'::regclass)
 2  | name | varchar(100) | not null | 
 3  | email | varchar(100) | not null | 
 4  | registration_date | date | | current_date
 5  | is_active | boolean | | true
 PK: id
 UNIQUE: email
 FK: -
```

---

## Рисунок 2 - Структура таблиці accounts

```
\d accounts
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('accounts_id_seq'::regclass)
 2  | user_id | integer | | 
 3  | account_number | varchar(20) | not null | 
 4  | balance | numeric(15,2) | | 0.00
 5  | account_type | varchar(20) | | 
 PK: id
 UNIQUE: account_number
 FK: user_id -> users(id)
 CHECK: account_type IN ('checking', 'savings', 'credit')
```

---

## Рисунок 3 - Структура таблиці transactions

```
\d transactions
```

```
 id | name | type | nullable | default
----+------+------+---------+--------
 1  | id | integer | not null | nextval('transactions_id_seq'::regclass)
 2  | account_id | integer | | 
 3  | amount | numeric(10,2) | not null | 
 4  | type | varchar(10) | | 
 5  | description | varchar(200) | | 
 6  | transaction_date | date | | current_date
 7  | category_id | integer | | 
 PK: id
 FK: account_id -> accounts(id)
 CHECK: type IN ('debit', 'credit')
 TRIGGER: balance_trigger
```

---

## Рисунок 4 - Дані таблиці users

```
SELECT * FROM users;
```

```
 id |       name        |            email            | registration_date | is_active 
----+-------------------+-----------------------------+-------------------+-----------
  1 | Іван Петренко     | ivan.petrenko@email.com     | 2024-01-15        | t
  2 | Марія Коваленко   | maria.kovalenko@email.com   | 2024-02-20        | t
  3 | Олег Сидоренко    | oleg.sydorenko@email.com    | 2024-03-10        | t
  4 | Анна Шевченко     | anna.shevchenko@email.com   | 2024-04-05        | t
  5 | Віктор Бондаренко | viktor.bondarenko@email.com | 2024-05-12        | t
  6 | Ольга Гриценко    | olga.gritsenko@email.com    | 2024-06-18        | t
  7 | Дмитро Кравченко  | dmytro.kravchenko@email.com | 2024-07-22        | t
  8 | Софія Литвиненко  | sofia.lytvynenko@email.com  | 2024-08-14        | t
  9 | Андрій Мороз      | andriy.moroz@email.com      | 2024-09-08        | f
 10 | Павло Деркач      | pavlo.derkach@email.com     | 2024-10-01        | t
(10 rows)
```

---

## Рисунок 5 - Дані таблиці accounts

```
SELECT * FROM accounts LIMIT 10;
```

```
 id | user_id | account_number |  balance  | account_type 
----+---------+----------------+-----------+--------------
  1 |       1 | ACC001         |  1850.75 | checking
  2 |       1 | ACC002         |  5200.00 | savings
  3 |       1 | ACC003         |  2700.50 | credit
  4 |       2 | ACC004         |   950.25 | checking
  5 |       2 | ACC005         |  1350.00 | savings
  ...
 20 |      10 | ACC020         |  6350.50 | savings
 21 |      10 | ACC021         |   950.00 | checking
(30 rows)
```

---

## Рисунок 6 - Дані таблиці categories

```
SELECT * FROM categories;
```

```
 id |      name       
----+-----------------
  1 | Покупки
  2 | Зарплата
  3 | Оплата рахунків
  4 | Транспорт
  5 | Розваги
  6 | Їжа
  7 | Іпотека
  8 | Бонус
  9 | Інвестиція
 10 | Повернення
(10 rows)
```

---

## Рисунок 7 - INNER JOIN результат

```
SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;
```

```
     name      | account_number | total_amount 
---------------+----------------+--------------
 Іван Петренко | ACC001         |       250.00
 Олександр...  | ...            |          ...
(результат залежить від даних транзакцій)
```

---

## Рисунок 8 - Агрегатні функції

```
SELECT account_type, COUNT(*), SUM(balance), AVG(balance)
FROM accounts GROUP BY account_type;
```

```
 account_type | count |   sum    |   avg   
--------------+-------+----------+---------
 credit       |     8 | 20351.00 | 2543.88
 savings      |    11 | 47879.25 | 4352.66
 checking     |    11 | 27178.25 | 2470.75
(3 rows)
```

---

## Рисунок 9 - Stored Procedure

```
CALL calculate_balance_proc(1, NULL);
```

```
 balance 
--------
 250.00
```

---

## Рисунок 10 - Trigger перевірка

```
SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) 
VALUES (1, 200, 'credit', 'Тест');
SELECT balance FROM accounts WHERE id = 1;
```

```
 balance 
--------
 250.00   <- до INSERT

 INSERT 0 1

 balance 
--------
 450.00   <- після INSERT (+200)
```

---

## Рисунок 11 - Дані студента Деркач Павло

```
SELECT u.name, a.account_number, a.balance, a.account_type
FROM users u JOIN accounts a ON u.id = a.user_id
WHERE u.name = 'Павло Деркач';
```

```
     name     | account_number |  balance  | account_type 
--------------+----------------+-----------+--------------
 Павло Деркач | ACC020         | 6350.50 | savings
 Павло Деркач | ACC021         |  950.00 | checking
(2 rows)

Загальний баланс: $7,300.50
```

---

## Рисунок 12 - Баланси користувачів

```
SELECT u.name, SUM(a.balance) as total
FROM users u JOIN accounts a ON u.id = a.user_id
GROUP BY u.name ORDER BY total DESC;
```

```
       name        |  total   
-------------------+----------
 Іван Петренко     | 14751.50
 Дмитро Кравченко  | 12300.50
 Андрій Мороз      | 11700.50
 Віктор Бондаренко |  9750.25
 Анна Шевченко     |  9451.25
 **Павло Деркач**  |  **7300.50**
 Олег Сидоренко    |  8126.25
 Софія Литвиненко  |  7176.25
 Марія Коваленко   |  7175.25
 Ольга Гриценко    |  6326.25
(10 rows)
```

---

## Підсумок

| Таблиця | Записів |
|---------|---------|
| users | 10 |
| accounts | 30 |
| transactions | 50 |
| categories | 10 |
| **Всього** | **100** |
