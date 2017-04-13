DROP TABLE IF EXISTS domain, category, student, grades;
DROP FUNCTION IF EXISTS setEmail(first_name VARCHAR(30), last_name VARCHAR(30), category_id INT);
DROP FUNCTION IF EXISTS getLetter(grades INT);
DROP FUNCTION IF EXISTS newPerson(first_name VARCHAR(30), last_name VARCHAR(30), role VARCHAR(30));

CREATE TABLE IF NOT EXISTS domain(
  domain_id SERIAL PRIMARY KEY,
  domain_suffix VARCHAR(30) NOT NULL
);


CREATE TABLE IF NOT EXISTS category(
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(30) NOT NULL,
  domain_id INT NOT NULL,
  FOREIGN KEY (domain_id) REFERENCES domain(domain_id)
);

CREATE TABLE IF NOT EXISTS student(
  student_id SERIAL PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  category_id INT NOT NULL,
  email VARCHAR(90) NOT NULL,
  created TIMESTAMP NOT NULL,
  FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE IF NOT EXISTS grades(
  grade_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL,
  score INT NOT NULL,
  scoreLetter VARCHAR(2) NOT NULL,
  date TIMESTAMP NOT NULL,
  FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE FUNCTION setEmail(first_name VARCHAR(30), last_name VARCHAR(30), category_id INT)
  RETURNS VARCHAR(60) AS
  $$
    DECLARE
    domain_name VARCHAR(30);
    BEGIN
      SELECT domain_suffix INTO domain_name FROM domain INNER JOIN category USING (domain_id)
      WHERE category.category_id = setEmail.category_id LIMIT 1;

       RETURN concat(concat(concat(concat(substr(first_name, 1, 1), '.'), last_name), '@'), domain_name);
    END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION getLetter(grades INT)
  RETURNS VARCHAR(2) AS
  $$
    BEGIN
      IF grades >= 90 THEN
        RETURN 'A';
      ELSEIF grades >= 80 THEN
        RETURN 'B';
      ELSEIF grades >= 70 THEN
        RETURN 'C';
      ELSEIF grades >= 60 THEN
        RETURN 'D';
      ELSE
        RETURN 'F';
      END IF;
    END;
  $$ LANGUAGE plpgsql;


CREATE FUNCTION newPerson(first_name VARCHAR(30), last_name VARCHAR(30), role VARCHAR(30))
  RETURNS TABLE(
    id INT,
    FirstName VARCHAR(30),
    LastName VARCHAR(30),
    Categoryid INT,
    Email VARCHAR(90),
    Created TIMESTAMP
  )
  AS $$
  DECLARE
    email VARCHAR(90);
    cat_id INT;
  BEGIN
    SELECT category.category_id INTO cat_id FROM category WHERE category_name = role;
    email := setEmail(lower(first_name), lower(last_name), cat_id);

    INSERT INTO student (first_name, last_name, category_id, email, created) VALUES
      (first_name, last_name, cat_id, email, now());

    RETURN QUERY SELECT student_id, student.first_name, student.last_name, category_id, student.email, student.created
      FROM student WHERE newPerson.first_name = student.first_name;
  END;
  $$ LANGUAGE plpgsql;

INSERT INTO domain(domain_suffix) VALUES ('student.pas.org');
INSERT INTO domain(domain_suffix) VALUES ('teacher.pas.org');
INSERT INTO category(category_name, domain_id) VALUES ('students', 1);
INSERT INTO category(category_name, domain_id) VALUES ('teachers', 2);

SELECT * FROM newPerson('Clement', 'Chang', 'students');