-- -- Create the Database
-- CREATE DATABASE EngineeringDepartmentDB;
--   -- USE EngineeringDepartmentDB;

-- -- Create the Students table
-- CREATE TABLE Students (
--     student_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     date_of_birth DATE,
--     email VARCHAR(100),
--     phone VARCHAR(15)
-- );

-- -- Create the Fees table
-- CREATE TABLE Fees (
--     fee_id SERIAL PRIMARY KEY,
--     student_id INT,
--     amount_paid DECIMAL(10, 2),
--     payment_date DATE,
--     FOREIGN KEY (student_id) REFERENCES Students(student_id)
-- );

-- -- Create the Courses table
-- CREATE TABLE Courses (
--     course_id SERIAL PRIMARY KEY,
--     course_name VARCHAR(100),
--     credit_hours INT
-- );

-- -- Create the Enrollments table
-- CREATE TABLE Enrollments (
--     enrollment_id SERIAL PRIMARY KEY,
--     student_id INT,
--     course_id INT,
--     enrollment_date DATE,
--     FOREIGN KEY (student_id) REFERENCES Students(student_id),
--     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
-- );

-- -- Create the Lecturers table
-- CREATE TABLE Lecturers (
--     lecturer_id SERIAL PRIMARY KEY,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     email VARCHAR(100),
--     phone VARCHAR(15)
-- );

-- -- Create the CourseAssignments table
-- CREATE TABLE CourseAssignments (
--     assignment_id SERIAL PRIMARY KEY,
--     lecturer_id INT,
--     course_id INT,
--     assignment_date DATE,
--     FOREIGN KEY (lecturer_id) REFERENCES Lecturers(lecturer_id),
--     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
-- );

-- -- Create the TAAssignments table
-- CREATE TABLE TAAssignments (
--     ta_assignment_id SERIAL PRIMARY KEY,
--     ta_id INT,  -- TA is also a lecturer
--     course_id INT,
--     lecturer_id INT,
--     assignment_date DATE,
--     FOREIGN KEY (ta_id) REFERENCES Lecturers(lecturer_id),
--     FOREIGN KEY (course_id) REFERENCES Courses(course_id),
--     FOREIGN KEY (lecturer_id) REFERENCES Lecturers(lecturer_id)
-- );

-- Insert sample data into Students table
-- INSERT INTO Students (first_name, last_name, date_of_birth, email, phone)
-- VALUES
-- ('Alice', 'Smith', '2000-01-15', 'alice.smith@example.com', '555-0101'),
-- ('Bob', 'Johnson', '1999-02-20', 'bob.johnson@example.com', '555-0202'),
-- ('Carol', 'Williams', '1998-03-15', 'carol.williams@example.com', '555-0505'),
-- ('David', 'Brown', '2001-04-22', 'david.brown@example.com', '555-0606'),
-- ('Eva', 'Miller', '2002-05-30', 'eva.miller@example.com', '555-0707'),
-- ('Frank', 'Wilson', '1997-06-10', 'frank.wilson@example.com', '555-0808');

-- -- Insert sample data into Fees table
-- INSERT INTO Fees (student_id, amount_paid, payment_date)
-- VALUES
-- (1, 1500.00, '2024-01-10'),
-- (2, 1800.00, '2024-01-12'),
-- (3, 1600.00, '2024-02-01'),
-- (4, 1750.00, '2024-02-05'),
-- (5, 1900.00, '2024-02-10'),
-- (6, 1850.00, '2024-02-15');


-- -- Insert sample data into Courses table
-- INSERT INTO Courses (course_name, credit_hours)
-- VALUES
-- ('Database Systems', 3),
-- ('Operating Systems', 4),
-- ('Algorithms', 3),
-- ('Data Communications', 4),
-- ('Data Structures', 3),
-- ('Software Engineering', 4);

-- -- Insert sample data into Enrollments table
-- INSERT INTO Enrollments (student_id, course_id, enrollment_date)
-- VALUES
-- (1, 1, '2024-01-15'),
-- (2, 2, '2024-01-16'),
-- (3, 3, '2024-02-20'),
-- (4, 4, '2024-02-21'),
-- (5, 1, '2024-02-22'),
-- (6, 2, '2024-02-23');


-- -- Insert sample data into Lecturers table
-- INSERT INTO Lecturers (first_name, last_name, email, phone)
-- VALUES
-- ('Dr. John', '', 'john.doe@example.com', '555-0303'),
-- ('Dr. Jane', 'Roe', 'jane.roe@example.com', '555-0404'),
-- ('Dr. Emma', 'White', 'emma.white@example.com', '555-0909'),
-- ('Dr. Isaac', 'Aboagye', 'chris.green@example.com', '555-1010'),
-- ('Dr. Margaret', 'Ansah', 'nancy.black@example.com', '555-1111'),
-- ('Dr. John', 'Assiamah', 'eric.king@example.com', '555-1212');

-- -- Insert sample data into CourseAssignments table
-- INSERT INTO CourseAssignments (lecturer_id, course_id, assignment_date)
-- VALUES
-- (1, 1, '2024-01-08'),
-- (2, 2, '2024-01-09'),
-- (3, 3, '2024-01-11'),
-- (4, 4, '2024-01-12'),
-- (1, 2, '2024-01-13'),
-- (2, 3, '2024-01-14');

-- -- Insert sample data into TAAssignments table
-- INSERT INTO TAAssignments (ta_id, course_id, lecturer_id, assignment_date)
-- VALUES
-- (2, 1, 1, '2024-01-10'),
-- (1, 2, 2, '2024-01-11'),
-- (3, 2, 3, '2024-01-15'),
-- (4, 4, 4, '2024-01-16'),
-- (1, 3, 2, '2024-01-17'),
-- (2, 1, 4, '2024-01-18');


-- Recreate the Fees table if needed
-- DROP TABLE IF EXISTS Fees;

-- CREATE TABLE Fees (
--     fee_id SERIAL PRIMARY KEY,
--     student_id INT REFERENCES Students(student_id) ON DELETE CASCADE,
--     amount DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),  -- Define the amount column
--     payment_date DATE NOT NULL,
--     paid BOOLEAN DEFAULT FALSE
-- );

-- -- Insert sample data into the Fees table
-- INSERT INTO Fees (student_id, amount, payment_date, paid) VALUES
-- (1, 500.00, '2024-01-10', TRUE),
-- (1, 200.00, '2024-05-15', FALSE),  -- Unpaid fee
-- (2, 500.00, '2024-01-12', TRUE),
-- (3, 700.00, '2024-02-01', FALSE);  -- Unpaid fee

-- CREATE OR REPLACE FUNCTION get_outstanding_fees() RETURNS JSON AS $$
-- DECLARE
--     result JSON;
-- BEGIN
--     SELECT JSON_AGG(
--         JSON_BUILD_OBJECT(
--             'student_id', s.student_id,
--             'student_name', s.first_name || ' ' || s.last_name,
--             'outstanding_fees', COALESCE(SUM(f.amount), 0)  -- Handle possible NULL sums
--         )
--     ) INTO result
--     FROM Students s
--     LEFT JOIN Fees f ON s.student_id = f.student_id AND f.paid = FALSE
--     GROUP BY s.student_id;

--     RETURN result;
-- END;
-- $$ LANGUAGE plpgsql;

SELECT get_outstanding_fees();





