#Project 6

CREATE TABLE projects6 (adid INT,VIEWS INT,clicks INT,COST DECIMAL)
INSERT INTO projects6(adid,VIEWS,clicks,COST) VALUES('1','1000','50','20.5'),('2','800','30','15.2'),('3','1200','80','25.7'),('4','600','20','10.9'),('5','1500','120','40.3')

SELECT * FROM projects6
SELECT *,to_char((CAST(clicks AS DECIMAL)/CAST(VIEWS AS DECIMAL))*100.0,'fm90.0')||'%' AS CTR FROM projects6 ORDER BY CTR 

#Project 7

CREATE TABLE emails(ID INT, NAME VARCHAR(100), email VARCHAR(100), phone_number VARCHAR(100))
INSERT INTO emails(ID, NAME, email, phone_number) VALUES('1','Rahul','rahul@example.com','9839473902'),('2','rohit','rohit@example.com','9883782971'),('3','suresh','rahul@example.com','7654321098'),('4','manish','manish@exmaple.com','8927394619'),('5','amit','amit@example.com','9399303840'),('6','rahul','rahul@example.com','9737466147')

SELECT * FROM emails

SELECT * FROM emails GROUP BY ID,NAME,email,phone_number

CREATE TABLE ranked AS 
SELECT id, email,phone_number, ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rn FROM emails

DELETE FROM Emails WHERE id IN (SELECT id FROM ranked WHERE rn > 1);
    
 SELECT * FROM emails
 
 #Project 8

CREATE TABLE project8(NAME VARCHAR(100))
INSERT INTO project8(NAME) VALUES ('rAVI KUMAR'),('priya sharma'),('amit PATEL'),('NEHA gupta')

CREATE TABLE Corrected1 AS
SELECT INITCAP(NAME) AS NAME FROM project8 ORDER BY NAME

SELECT * FROM Corrected1
 
 #Project 9

CREATE TABLE post(post_id INT, post_content VARCHAR(100), post_date date)

INSERT INTO post(post_id,post_content,post_date) VALUES('1','Lorem ipsum dolor sit amet','2023-08-25 10:00:00'),('2','Exploring the beauty of nature','2023-08-26 15:30:00'),('3','Unveiling the latest tech trends','2023-08-27 12:00:00'),('4','Journey into the world of literature','2023-08-28 09:45:00'),('5','Capturing the essence of city life','2023-08-29 16:20:00')

SELECT * FROM post

CREATE TABLE reaction(reaction_id INT,user_id INT,post_id INT, reaction_type VARCHAR(100), reaction_date date)

INSERT INTO reaction(reaction_id,user_id,post_id,reaction_type,reaction_date) VALUES('1','101','1','like','2023-08-25 10:15:00'),('2','102','1','comment','2023-08-25 11:30:00'),('3','103','1','share','2023-08-26 12:45:00'),('4','101','2','like','2023-08-26 15:45:00'),('5','102','2','comment','2023-08-27 09:20:00'),('6','104','2','like','2023-08-27 10:00:00'),('7','105','3','comment','2023-08-27 14:30:00'),('8','101','3','like','2023-08-28 08:15:00'),('9','103','4','like','2023-08-28 10:30:00'),('10','105','4','share','2023-08-29 11:15:00'),('11','104','5','like','2023-08-29 16:30:00 '),('12','101','5','comment','2023-08-30 09:45:00')

SELECT * FROM reaction
CREATE TABLE C1 AS
SELECT post_id, count( * ) AS numl_likes FROM reaction WHERE reaction_type = 'like' AND post_id=2 GROUP BY post_id

CREATE TABLE C2 AS
SELECT post_id,count( * ) AS numl_comment FROM reaction WHERE reaction_type = 'comment' AND post_id=2 GROUP BY post_id

SELECT post_id, COALESCE(COUNT(*), 0) AS numl_share
FROM reaction WHERE reaction_type='share' AND post_id=2
GROUP BY post_id;

CREATE TABLE C3 AS
 SELECT * FROM post NATURAL JOIN reaction
 
 #output1
 SELECT post_id,post_content, count(CASE WHEN reaction_type='like' THEN 1 END) AS numl_like, 
 count(CASE WHEN reaction_type='comment' THEN 1 END) AS numl_comments,
 count(CASE WHEN reaction_type='share' THEN 1 END) AS numl_share 
 FROM  C3 WHERE post_id=2 GROUP BY post_id,post_content

##output2
SELECT reaction_date, count(DISTINCT user_id),count(reaction_type) AS total_reactions,COUNT(*) / CAST(COUNT(DISTINCT user_id) AS DECIMAL) AS avg_reactions_per_user FROM C3 GROUP BY reaction_date ORDER BY reaction_date

#output3
SELECT post_id,post_content, count(reaction_type) AS total_reactions FROM C3 WHERE post_id IN (1,2,3) GROUP BY post_id,post_content

SELECT post_id,post_content, COUNT(reaction_type) AS total_reactions 
FROM C3
GROUP BY post_id,post_content
ORDER BY total_reactions DESC
LIMIT 3;

#Project 10

CREATE TABLE trips(id INT, client_id INT, driver_id INT, city_id INT,status VARCHAR(100), requested_at date)

INSERT INTO trips(id, client_id, driver_id,city_id,status,requested_at) VALUES('1','1','10','1','completed','2023-07-12'),('2','2','11','1','cancelled_by_driver','2023-07-12'),('3','3','12','6','completed','2023-07-12'),('4','4','13','6','cancelled_by_client','2023-07-12'),('5','1','10','1','completed','2023-07-13'),('6','2','11','6','completed','2023-07-13'),('7','3','12','6','completed','2023-07-13'),('8','2','12','12','completed','2023-07-14'),('9','3','10','12','completed','2023-07-14'),('10','4','13','12','cancelled_by_driver','2023-07-14')

CREATE TABLE users(user_id INT,banned VARCHAR(100),roles VARCHAR(100))

INSERT INTO users(user_id,banned,roles) VALUES('1','no','client'),('2','yes','client'),('3','no','client'),('4','no','client'),('10','no','driver'),('11','no','driver'),('12','no','driver'),('13','no','driver')

SELECT post_id,post_content, count(CASE WHEN reaction_type='like' THEN 1 END) AS numl_like, 
 count(CASE WHEN reaction_type='comment' THEN 1 END) AS numl_comments,
 count(CASE WHEN reaction_type='share' THEN 1 END) AS numl_share 
 FROM  C3 WHERE post_id=2 GROUP BY post_id,post_content


SELECT * FROM trips 
SELECT * FROM users

SELECT requested_at,COUNT(CASE WHEN status IN ('cancelled_by_driver', 'cancelled_by_customer') THEN 1 END) * 1.0 / COUNT(*) AS cancellation_rate FROM trips GROUP BY requested_at ORDER BY requested_at

SELECT requested_at AS DAY,round(sum(CASE WHEN status IN('cancelled_by_driver','cancelled_by_client') THEN 1 ELSE 0 END)*1.0/count(status),2)
AS  cancellation_rate FROM trips JOIN users ON trips.client_id=users.user_id GROUP BY requested_at ORDER BY requested_at
