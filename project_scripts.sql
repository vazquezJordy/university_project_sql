USE university_project; 

-- the way my data was inseted
INSERT INTO students(firstName, lastName, student_year, student_id)
VALUES ( 'Santa', 'Clause', 'Senior', 11);

INSERT INTO professors(professor_id, professor_name)
VALUES (11, "MRS. Larson");

INSERT INTO courses(course_id, course_name, course_professor_id)
VALUES(11, "English", 11);

INSERT INTO grades(grade_student_id, grade_value, grade_id, grade_course_id)
VALUES (11, 88, 11, 11);

-- Scrip that brings back everything. 
SELECT *
FROM students s
LEFT JOIN grades g
ON s.student_id = g.grade_student_id
JOIN courses c
ON c.course_id = g.grade_course_id
JOIN professors p
ON p.professor_id = c.course_professor_id;

-- Average grade give by each teacher
SELECT professor_name AS 'Professor', AVG(grade_value) AS 'Grade Given'
FROM courses
JOIN professors
ON course_professor_id = professor_id
JOIN grades
ON course_id = grade_course_id
GROUP BY professor_name;

-- The top grades for each student
SELECT firstName AS 'name',MAX(grade_value) AS 'Grade'
FROM grades
JOIN students
ON student_id = grade_student_id
GROUP BY firstName
ORDER BY  MAX(grade_value);

--  Students grouped by each course
SELECT firstName AS 'Name', lastName AS 'Last name', course_name AS 'Course enrolled'
FROM students s
LEFT JOIN grades g
ON s.student_id = g.grade_student_id
JOIN courses c
ON c.course_id = g.grade_course_id
JOIN professors p
ON p.professor_id = c.course_professor_id
ORDER BY c.course_name, firstName;

-- Average give grade by course from least challenging class to hardest class
SELECT AVG(g.grade_value) AS 'grade', c.course_name AS 'course' 
FROM grades g
JOIN courses c
ON g.grade_course_id = c.course_id 
GROUP BY c.course_name
ORDER BY AVG(g.grade_value) ASC;

-- Courses the student and professor have in common
SELECT firstName, professor_name, course_name
FROM students s
RIGHT JOIN grades g
ON s.student_id = g.grade_student_id
JOIN courses c
ON c.course_id = g.grade_course_id
JOIN professors p
ON p.professor_id = c.course_professor_id
WHERE student_id = grade_student_id 
AND
professor_id = course_professor_id
ORDER BY course_name, firstName;