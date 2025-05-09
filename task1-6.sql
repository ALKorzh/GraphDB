IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'GraphSocialNetwork')
BEGIN
    CREATE DATABASE GraphSocialNetwork;
END
GO

-- Переключение на созданную базу данных
USE GraphSocialNetwork;
GO

-- Удаление таблиц рёбер (Edges)
PRINT N'Dropping edge tables if they exist...';
IF OBJECT_ID('dbo.FriendOf', 'ET') IS NOT NULL
    DROP TABLE dbo.FriendOf;
GO
IF OBJECT_ID('dbo.LivesIn', 'ET') IS NOT NULL
    DROP TABLE dbo.LivesIn;
GO
IF OBJECT_ID('dbo.HasInterest', 'ET') IS NOT NULL
    DROP TABLE dbo.HasInterest;
GO

-- Удаление таблиц узлов (Nodes)
PRINT N'Dropping node tables if they exist...';
IF OBJECT_ID('dbo.Person', 'NT') IS NOT NULL
    DROP TABLE dbo.Person;
GO
IF OBJECT_ID('dbo.City', 'NT') IS NOT NULL
    DROP TABLE dbo.City;
GO
IF OBJECT_ID('dbo.Interest', 'NT') IS NOT NULL
    DROP TABLE dbo.Interest;
GO

PRINT N'Edge and node tables dropped (if they existed).';

-- Создание таблиц узлов (Nodes)
PRINT N'Creating node tables...';
-- Узел: Человек
CREATE TABLE Person
(
    PersonID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE 
) AS NODE;
GO

-- Узел: Город
CREATE TABLE City
(
    CityID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE 
) AS NODE;
GO

-- Узел: Интерес/Хобби
CREATE TABLE Interest
(
    InterestID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE 
) AS NODE;
GO
PRINT N'Node tables created.';

-- Создание таблиц рёбер (Edges)
PRINT N'Creating edge tables...';
-- Ребро: Дружба
CREATE TABLE FriendOf
AS EDGE;
GO

-- Ребро: Проживание (Человек -> Город)
CREATE TABLE LivesIn
AS EDGE;
GO

-- Ребро: Имеет интерес (Человек -> Интерес)
CREATE TABLE HasInterest
AS EDGE;
GO
PRINT N'Edge tables created.';


PRINT N'Inserting data into node tables...';
-- Person (Люди)
INSERT INTO Person (Name) VALUES
(N'Иван'), (N'Мария'), (N'Петр'), (N'Елена'), (N'Алексей'),
(N'Ольга'), (N'Сергей'), (N'Анна'), (N'Дмитрий'), (N'Екатерина'),
(N'Николай'), (N'Татьяна'); -- 12 человек
PRINT N'Person data inserted.';
GO

-- City (Города)
INSERT INTO City (Name) VALUES
(N'Москва'), (N'Санкт-Петербург'), (N'Новосибирск'), (N'Екатеринбург'),
(N'Казань'), (N'Нижний Новгород'), (N'Самара'), (N'Омск'),
(N'Челябинск'), (N'Ростов-на-Дону'); -- 10 городов
PRINT N'City data inserted.';
GO

-- Interest (Интересы)
INSERT INTO Interest (Name) VALUES
(N'Чтение'), (N'Спорт'), (N'Музыка'), (N'Путешествия'),
(N'Программирование'), (N'Готовка'), (N'Искусство'), (N'Фотография'),
(N'История'), (N'Наука'); -- 10 интересов
PRINT N'Interest data inserted.';
GO


PRINT N'Inserting data into edge tables...';
-- FriendOf (Дружба)
INSERT INTO FriendOf ($from_id, $to_id) VALUES
((SELECT $node_id FROM Person WHERE Name = N'Иван'), (SELECT $node_id FROM Person WHERE Name = N'Мария')),
((SELECT $node_id FROM Person WHERE Name = N'Иван'), (SELECT $node_id FROM Person WHERE Name = N'Петр')),
((SELECT $node_id FROM Person WHERE Name = N'Мария'), (SELECT $node_id FROM Person WHERE Name = N'Елена')),
((SELECT $node_id FROM Person WHERE Name = N'Мария'), (SELECT $node_id FROM Person WHERE Name = N'Алексей')),
((SELECT $node_id FROM Person WHERE Name = N'Петр'), (SELECT $node_id FROM Person WHERE Name = N'Сергей')),
((SELECT $node_id FROM Person WHERE Name = N'Петр'), (SELECT $node_id FROM Person WHERE Name = N'Анна')),
((SELECT $node_id FROM Person WHERE Name = N'Алексей'), (SELECT $node_id FROM Person WHERE Name = N'Дмитрий')),
((SELECT $node_id FROM Person WHERE Name = N'Сергей'), (SELECT $node_id FROM Person WHERE Name = N'Екатерина')),
((SELECT $node_id FROM Person WHERE Name = N'Елена'), (SELECT $node_id FROM Person WHERE Name = N'Ольга')),
((SELECT $node_id FROM Person WHERE Name = N'Ольга'), (SELECT $node_id FROM Person WHERE Name = N'Николай')),
((SELECT $node_id FROM Person WHERE Name = N'Дмитрий'), (SELECT $node_id FROM Person WHERE Name = N'Татьяна')),
((SELECT $node_id FROM Person WHERE Name = N'Екатерина'), (SELECT $node_id FROM Person WHERE Name = N'Татьяна'));
PRINT N'FriendOf data inserted.';
GO

-- LivesIn (Проживание)
INSERT INTO LivesIn ($from_id, $to_id) VALUES
((SELECT $node_id FROM Person WHERE Name = N'Иван'), (SELECT $node_id FROM City WHERE Name = N'Москва')),
((SELECT $node_id FROM Person WHERE Name = N'Мария'), (SELECT $node_id FROM City WHERE Name = N'Москва')),
((SELECT $node_id FROM Person WHERE Name = N'Петр'), (SELECT $node_id FROM City WHERE Name = N'Санкт-Петербург')),
((SELECT $node_id FROM Person WHERE Name = N'Елена'), (SELECT $node_id FROM City WHERE Name = N'Москва')),
((SELECT $node_id FROM Person WHERE Name = N'Алексей'), (SELECT $node_id FROM City WHERE Name = N'Новосибирск')),
((SELECT $node_id FROM Person WHERE Name = N'Ольга'), (SELECT $node_id FROM City WHERE Name = N'Москва')),
((SELECT $node_id FROM Person WHERE Name = N'Сергей'), (SELECT $node_id FROM City WHERE Name = N'Санкт-Петербург')),
((SELECT $node_id FROM Person WHERE Name = N'Анна'), (SELECT $node_id FROM City WHERE Name = N'Екатеринбург')),
((SELECT $node_id FROM Person WHERE Name = N'Дмитрий'), (SELECT $node_id FROM City WHERE Name = N'Новосибирск')),
((SELECT $node_id FROM Person WHERE Name = N'Екатерина'), (SELECT $node_id FROM City WHERE Name = N'Казань')),
((SELECT $node_id FROM Person WHERE Name = N'Николай'), (SELECT $node_id FROM City WHERE Name = N'Москва')),
((SELECT $node_id FROM Person WHERE Name = N'Татьяна'), (SELECT $node_id FROM City WHERE Name = N'Новосибирск'));
PRINT N'LivesIn data inserted.';
GO

-- HasInterest (Имеет интерес)
INSERT INTO HasInterest ($from_id, $to_id) VALUES
((SELECT $node_id FROM Person WHERE Name = N'Иван'), (SELECT $node_id FROM Interest WHERE Name = N'Чтение')),
((SELECT $node_id FROM Person WHERE Name = N'Иван'), (SELECT $node_id FROM Interest WHERE Name = N'Спорт')),
((SELECT $node_id FROM Person WHERE Name = N'Мария'), (SELECT $node_id FROM Interest WHERE Name = N'Чтение')),
((SELECT $node_id FROM Person WHERE Name = N'Мария'), (SELECT $node_id FROM Interest WHERE Name = N'Путешествия')),
((SELECT $node_id FROM Person WHERE Name = N'Петр'), (SELECT $node_id FROM Interest WHERE Name = N'Спорт')),
((SELECT $node_id FROM Person WHERE Name = N'Петр'), (SELECT $node_id FROM Interest WHERE Name = N'Музыка')),
((SELECT $node_id FROM Person WHERE Name = N'Елена'), (SELECT $node_id FROM Interest WHERE Name = N'Путешествия')),
((SELECT $node_id FROM Person WHERE Name = N'Алексей'), (SELECT $node_id FROM Interest WHERE Name = N'Программирование')),
((SELECT $node_id FROM Person WHERE Name = N'Сергей'), (SELECT $node_id FROM Interest WHERE Name = N'Спорт')),
((SELECT $node_id FROM Person WHERE Name = N'Анна'), (SELECT $node_id FROM Interest WHERE Name = N'Искусство')),
((SELECT $node_id FROM Person WHERE Name = N'Дмитрий'), (SELECT $node_id FROM Interest WHERE Name = N'Программирование')),
((SELECT $node_id FROM Person WHERE Name = N'Екатерина'), (SELECT $node_id FROM Interest WHERE Name = N'Готовка')),
((SELECT $node_id FROM Person WHERE Name = N'Николай'), (SELECT $node_id FROM Interest WHERE Name = N'Чтение')),
((SELECT $node_id FROM Person WHERE Name = N'Татьяна'), (SELECT $node_id FROM Interest WHERE Name = N'Программирование')),
((SELECT $node_id FROM Person WHERE Name = N'Татьяна'), (SELECT $node_id FROM Interest WHERE Name = N'Путешествия'));
PRINT N'HasInterest data inserted.';
GO


-- Использование функции MATCH 

PRINT N'--- Запросы с использованием MATCH ---';

-- 1. Найти всех людей, которые напрямую дружат с Иваном.
SELECT
    ivan.Name AS IvanName,
    friend.Name AS DirectFriendName
FROM
    Person AS ivan,
    FriendOf AS fo,
    Person AS friend
WHERE MATCH(ivan-(fo)->friend)
  AND ivan.Name = N'Иван';
GO

-- 2. Найти всех людей, проживающих в Москве.
SELECT
    p.Name AS PersonName,
    c.Name AS CityName
FROM
    Person AS p,
    LivesIn AS li,
    City AS c
WHERE MATCH(p-(li)->c)
  AND c.Name = N'Москва';
GO

-- 3. Найти все интересы, которыми увлекается Иван.
SELECT
    p.Name AS PersonName,
    i.Name AS InterestName
FROM
    Person AS p,
    HasInterest AS hi,
    Interest AS i
WHERE MATCH(p-(hi)->i)
  AND p.Name = N'Иван';
GO

-- 4. Найти людей, которые дружат с друзьями Ивана (друзья друзей, 2 хопа), исключая самого Ивана.
SELECT DISTINCT
    ivan.Name AS IvanName,
    foaf.Name AS FriendOfAFriendName
FROM
    Person AS ivan,
    FriendOf AS fo1,
    Person AS friend,
    FriendOf AS fo2,
    Person AS foaf
WHERE MATCH(ivan-(fo1)->friend-(fo2)->foaf)
  AND ivan.Name = N'Иван'
  AND foaf.Name <> ivan.Name; -- Исключаем самого Ивана
GO

-- 5. Найти людей, которые разделяют хотя бы один интерес с Иваном (исключая самого Ивана).
SELECT DISTINCT
    ivan.Name AS IvanName,
    other.Name AS PersonWithSharedInterest
FROM
    Person AS ivan,
    HasInterest AS hi1,
    Interest AS interest,
    HasInterest AS hi2,
    Person AS other
WHERE MATCH(ivan-(hi1)->interest<-(hi2)-other) -- Путь: Иван -> Интерес <- Другой человек
  AND ivan.Name = N'Иван'
  AND other.Name <> ivan.Name; -- Исключаем самого Ивана
GO

-- Использование функции SHORTEST_PATH 

PRINT N'--- Запросы с использованием SHORTEST_PATH ---';

-- 6. Найти кратчайший путь дружбы от Ивана до любого другого человека в сети (используя шаблон "+").

SELECT
    ivan.Name AS StartPerson, 
    LAST_VALUE(other.Name) WITHIN GROUP (GRAPH PATH) AS EndPersonInPath, 
    STRING_AGG(other.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPathNames 
FROM
    Person AS ivan, 
    FriendOf FOR PATH AS fo, 
    Person FOR PATH AS other 
WHERE MATCH(SHORTEST_PATH(ivan(-(fo)->other)+)) 
  AND ivan.Name = N'Иван';
GO

-- 7. Найти кратчайший путь дружбы от Ивана до любого другого человека, ограниченный 3 хопами (используя шаблон "{1,n}").
SELECT
    ivan.Name AS StartPerson, 
    LAST_VALUE(other.Name) WITHIN GROUP (GRAPH PATH) AS EndPersonInPath, 
    STRING_AGG(other.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPathNames 
FROM
    Person AS ivan, 
    FriendOf FOR PATH AS fo, 
    Person FOR PATH AS other 
WHERE MATCH(SHORTEST_PATH(ivan(-(fo)->other){1,3})) 
  AND ivan.Name = N'Иван';
GO


-- 8. Найти кратчайший путь дружбы от Ивана и посчитать количество друзей на этом пути (исключая самого Ивана).
SELECT
    ivan.Name AS StartPerson, 
    LAST_VALUE(other.Name) WITHIN GROUP (GRAPH PATH) AS EndPersonInPath, 
    STRING_AGG(other.Name, ' -> ') WITHIN GROUP (GRAPH PATH) AS FriendshipPathNames, 
    COUNT(other.PersonID) WITHIN GROUP (GRAPH PATH) AS NumberOfFriendsInPath 
FROM
    Person AS ivan, 
    FriendOf FOR PATH AS fo, 
    Person FOR PATH AS other 
WHERE MATCH(SHORTEST_PATH(ivan(-(fo)->other)+)) 
  AND ivan.Name = N'Иван';
GO