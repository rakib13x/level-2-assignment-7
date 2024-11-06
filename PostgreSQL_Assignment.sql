

CREATE DATABASE university_db;



-- Creating the "students" table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,         -- Primary key, unique identifier for students
    student_name VARCHAR(100),             -- Name of the student
    age INT,                               -- Age of the student
    email VARCHAR(100),                    -- Email address of the student
    frontend_mark INT,                     -- Frontend assignment mark
    backend_mark INT,                      -- Backend assignment mark
    status VARCHAR(50)                     -- Result status of the student
);

-- Creating the "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,          -- Primary key, unique identifier for courses
    course_name VARCHAR(100),              -- Name of the course
    credits INT                            -- Number of credits for the course
);

-- Creating the "enrollment" table  
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,                -- Primary key, unique identifier for enrollments
    student_id INT REFERENCES students(student_id),  -- Foreign key referencing student_id in "students" table
    course_id INT REFERENCES courses(course_id)      -- Foreign key referencing course_id in "courses" table
);


-- Inserting sample data into "students" table
-- Corrected Insert Statement for the "students" table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);


-- Inserting sample data into "courses" table
-- Corrected Insert Statement for the "courses" table
INSERT INTO courses (course_name, credits) VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);


-- Inserting sample data into "enrollment" table
INSERT INTO enrollment (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);



-- Query 1: Insert a new student record with specified details
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) VALUES
('Rakib Islam', 25, 'rakib@gmail.com', 27, 29, NULL);

-- Query 2: Retrieve the names of all students enrolled in the course titled 'Next.js'
SELECT student_name
FROM students
JOIN enrollment ON students.student_id = enrollment.student_id
JOIN courses ON enrollment.course_id = courses.course_id
WHERE course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);

-- Query 4: Delete all courses that have no students enrolled
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollment
);

-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course
SELECT course_name, COUNT(enrollment.student_id) AS students_enrolled
FROM courses
LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY course_name;

-- Query 7: Calculate and display the average age of all students
SELECT AVG(age) AS average_age
FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'
SELECT student_name
FROM students
WHERE email LIKE '%gmail.com%';


-- Display all data from the "students" table
SELECT * FROM students;

-- Display all data from the "courses" table
SELECT * FROM courses;

-- Display all data from the "enrollment" table
SELECT * FROM enrollment;





--answer to the question:
--1.What is PostgreSQL?

--ans:PostgreSQL is a powerful, open-source relational database management system (RDBMS). It allows us to store, organize, and manage data in a structured way. PostgreSQL is known for its stability, advanced features, and ability to handle large datasets, making it popular for web applications and data storage.
--2.What is the purpose of a database schema in PostgreSQL?

--ans: In PostgreSQL, a schema organizes and groups related tables, views, functions, and other database objects. It helps structure the database and avoid conflicts by allowing similar tables in different schemas (like having separate departments). Schemas are helpful for managing large databases.
--3.Explain the primary key and foreign key concepts in PostgreSQL.

--ans:A primary key uniquely identifies each record in a table. It ensures there are no duplicate values in that column. A foreign key links two tables by referring to the primary key in another table. It helps maintain relationships between tables, like connecting students to the courses they’re enrolled in.
--4.What is the difference between the VARCHAR and CHAR data types?

--ans:VARCHAR and CHAR are both used to store text, but they work a bit differently. VARCHAR is a variable-length text field, so it only takes up as much space as the text needs. CHAR is a fixed-length text field, which means it pads shorter texts to the specified length. VARCHAR is more flexible, while CHAR is often used when all entries are the same length, like country codes.
--5.Explain the purpose of the WHERE clause in a SELECT statement.

--ans:The WHERE clause filters records in a SELECT statement, so we only get the rows that meet specific conditions. For example, if we want to see students aged 20 or older, we’d use a WHERE age >= 20 condition in our query.
--6.What are the LIMIT and OFFSET clauses used for?

--ans:LIMIT and OFFSET are used to control the number of records returned by a query. LIMIT sets the maximum number of rows, and OFFSET skips a specified number of rows before starting to return results. Together, they’re useful for pagination, like showing 10 results per page.
--7.How can you perform data modification using UPDATE statements?

--ans: To modify data in a table, we use the UPDATE statement. We specify the table, set new values for certain columns, and use a WHERE clause to target specific rows. For example, to update a student’s email, we’d use UPDATE students SET email = 'newemail@example.com' WHERE student_id = 1;.
--8.What is the significance of the JOIN operation, and how does it work in PostgreSQL?

--ans:JOIN combines rows from two or more tables based on a related column. This is important for retrieving connected information, like showing which students are in which courses. There are different types of joins, like INNER JOIN, LEFT JOIN, and RIGHT JOIN, each serving a slightly different purpose in how data from tables is combined.
--9.Explain the GROUP BY clause and its role in aggregation operations.

--ans:The GROUP BY clause groups rows that have the same values in specific columns, letting us perform aggregate calculations on each group. For example, we could group students by age and then count how many students are in each age group. It’s helpful when calculating totals, averages, or counts for each group.
--10.How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?

--ans:Aggregate functions summarize data. COUNT counts rows, SUM adds up values in a column, and AVG calculates the average value. To use them, we write queries like SELECT COUNT(*) FROM students;, SELECT SUM(credits) FROM courses;, and SELECT AVG(age) FROM students;.
--11.What is the purpose of an index in PostgreSQL, and how does it optimize query performance?

--ans:An index speeds up data retrieval by creating a quick lookup table for certain columns. It’s like a shortcut, helping the database find data faster, especially in large tables. Indexes are crucial for optimizing query performance but do slightly increase storage requirements.
--12.Explain the concept of a PostgreSQL view and how it differs from a table.

--ans:A view is a saved query that acts like a virtual table. It displays data from one or more tables but doesn’t store data itself. Views are helpful for presenting data in a specific format or for simplifying complex queries. Unlike a table, which holds actual data, a view just shows a result set based on a query.
