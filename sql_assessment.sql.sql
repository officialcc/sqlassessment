-- Active: 1715669263304@@127.0.0.1@3306
-- 1. Analyse the data
-- ****************************************************************
-- How are the two tables related? The two tables are related based on user_id
SELECT u.*, p.*
FROM users u
JOIN progress p
ON u.user_id = p.user_id;

-- 2. What are the Top 25 schools (.edu domains)?
-- ****************************************************************
SELECT COUNT(u.email_domain) AS "Number of students", u.email_domain
FROM users u
GROUP BY email_domain
ORDER BY COUNT(u.email_domain) DESC
LIMIT 25;

-- How many .edu learners are located in New York? 
-- ****************************************************************
SELECT COUNT(u.city) AS "Number of students", u.city
FROM users u
WHERE u.city = "New York"
-- GROUP BY city
-- ORDER BY COUNT(u.city) DESC;

-- The mobile_app column contains either mobile-user or NULL. 
-- How many of these Codecademy learners are using the mobile app?
-- ****************************************************************
SELECT COUNT(u.mobile_app) AS "Number of Mobile Users", u.mobile_app
FROM users u
WHERE u.mobile_app = "mobile-user";

-- 3. Query for the sign up counts for each hour.
-- Refer to CodeAcademy to solve this question
-- Hint: https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
-- ****************************************************************
SELECT COUNT(sign_up_at),
  strftime('%H', sign_up_at) AS "Hour"
FROM users
GROUP BY "Hour";

-- 4. Do different schools (.edu domains) prefer different courses?
-- Calculate the users from each email domain that have non-empty entries learning C++, SQL, HTML, JavaScript, Java
-- Count the total number of users per email domain, sorted by the email domain in descending order
-- ****************************************************************

-- Original attempt - Also produces 617 results but categorised as "started" and "completed":
-- SELECT u.email_domain, p.learn_cpp, p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql
-- FROM users u
-- JOIN progress p
-- ON u.user_id = p.user_id
-- GROUP BY email_domain
-- ORDER BY COUNT(u.email_domain) DESC;

-- Second version:
SELECT email_domain, 
SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
COUNT(email_domain) AS "NUMBER OF LEARNERS"
FROM progress
JOIN users ON progress.user_id = users.user_id
GROUP BY email_domain
ORDER BY email_domain ASC;

-- What courses are the New Yorker Students taking?
-- ****************************************************************
-- Original attempt - Also produces 50 results but categorised by individual user_id and as "started" and "completed":
-- SELECT u.user_id, u.city, p.learn_cpp, p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql
-- FROM users u
-- JOIN progress p
-- ON u.user_id = p.user_id
-- WHERE u.city = "New York";

-- 2nd version:
SELECT city AS "CITY",
SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
COUNT(city) AS "NUMBER OF LEARNERS"
FROM progress
JOIN users ON progress.user_id = users.user_id
WHERE users.city = "New York";

-- What courses are the Chicago Students taking?
-- ****************************************************************
-- Original attempt - Also produces 92 results but categorised by individual user_id and as "started" and "completed":
-- SELECT u.user_id, u.city, p.learn_cpp, p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql
-- FROM users u
-- JOIN progress p
-- ON u.user_id = p.user_id
-- WHERE u.city = "Chicago";

-- 2nd version:
SELECT city AS "CITY",
SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
COUNT(city) AS "NUMBER OF LEARNERS"
FROM progress
JOIN users ON progress.user_id = users.user_id
WHERE users.city = "Chicago";