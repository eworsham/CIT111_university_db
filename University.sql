-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `University` ;

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` DEFAULT CHARACTER SET utf8 ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`student` ;

CREATE TABLE IF NOT EXISTS `University`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`),
  UNIQUE INDEX `student_id_UNIQUE` (`student_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`college` ;

CREATE TABLE IF NOT EXISTS `University`.`college` (
  `college_id` INT NOT NULL,
  `college` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`),
  UNIQUE INDEX `college_id_UNIQUE` (`college_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`department` ;

CREATE TABLE IF NOT EXISTS `University`.`department` (
  `department_id` INT NOT NULL,
  `department` VARCHAR(45) NOT NULL,
  `department_code` VARCHAR(45) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE INDEX `department_id_UNIQUE` (`department_id` ASC) VISIBLE,
  INDEX `fk_department_college_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `University`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`course` ;

CREATE TABLE IF NOT EXISTS `University`.`course` (
  `course_id` INT NOT NULL,
  `course` VARCHAR(45) NOT NULL,
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC) VISIBLE,
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `University`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`term` ;

CREATE TABLE IF NOT EXISTS `University`.`term` (
  `term_id` INT NOT NULL,
  `term` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`term_id`),
  UNIQUE INDEX `term_id_UNIQUE` (`term_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`faculty` ;

CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_id` INT NOT NULL,
  `faculty_fname` VARCHAR(45) NOT NULL,
  `faculty_lname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`faculty_id`),
  UNIQUE INDEX `faculty_id_UNIQUE` (`faculty_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`section` ;

CREATE TABLE IF NOT EXISTS `University`.`section` (
  `section_id` INT NOT NULL,
  `section` INT NOT NULL,
  `capacity` INT NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  UNIQUE INDEX `section_id_UNIQUE` (`section_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `University`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `University`.`term` (`term_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `University`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `University`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `University`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- DATA ENTRY 
USE university;

INSERT INTO college VALUES
	(1, 'College of Physical Science and Engineering'),
    (2, 'College of Business and Communication'),
    (3, 'College of Language and Letters');
    
    
INSERT INTO department VALUES
	(1, 'Computer Information Technology', 'CIT', 1),
    (2, 'Economics', 'ECON', 2),
    (3, 'Humanities and Philosophy', 'HUM', 3);

INSERT INTO course VALUES
	(1, 'CIT 111', 111, 'Intro to Databases', 3, 1),
    (2, 'ECON 150', 150, 'Micro Economics', 3, 2),
    (3, 'ECON 388', 388, 'Econometrics', 4, 2),
    (4, 'HUM 376', 376, 'Classical Heritage', 2, 3);
    
INSERT INTO student VALUES
	(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
    (2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
    (3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-06-22'),
    (4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
    (5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
    (6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
    (7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
    (8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
    (9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
    (10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');
    
INSERT INTO faculty VALUES 
	(1, 'Marty', 'Morring'),
    (2, 'Nate', 'Norris'),
    (3, 'Ben', 'Barrus'),
    (4, 'John', 'Jensen'),
    (5, 'Bill', 'Barney');

INSERT INTO term VALUES
	(1, 'Fall', 2019),
    (2, 'Winter', 2018);
    
INSERT INTO section VALUES
	(1, 1, 30, 1, 1, 1),  -- SECTION: 1,   CAPACITY: 30,   COURSE: (1)-CIT  111,   TERM: (1)-Fall 2019,     FACULTY: (1)-Marty Morring
    (2, 1, 50, 2, 1, 2),  -- SECTION: 1,   CAPACITY: 50,   COURSE: (2)-ECON 150,   TERM: (1)-Fall 2019,     FACULTY: (2)-Nate Norris
    (3, 2, 50, 2, 1, 2),  -- SECTION: 2,   CAPACITY: 50,   COURSE: (2)-ECON 150,   TERM: (1)-Fall 2019,     FACULTY: (2)-Nate Norris
    (4, 1, 35, 3, 1, 3),  -- SECTION: 1,   CAPACITY: 35,   COURSE: (3)-ECON 388,   TERM: (1)-Fall 2019,     FACULTY: (3)-Ben Barrus
    (5, 1, 30, 4, 1, 4),  -- SECTION: 1,   CAPACITY: 30,   COURSE: (4)-HUM  376,   TERM: (1)-Fall 2019,     FACULTY: (4)-John Jensen
    (6, 2, 30, 1, 2, 1),  -- SECTION: 2,   CAPACITY: 30,   COURSE: (1)-CIT  111,   TERM: (2)-Winter 2018,   FACULTY: (1)-Marty Morring
    (7, 3, 35, 1, 2, 5),  -- SECTION: 3,   CAPACITY: 35,   COURSE: (1)-CIT  111,   TERM: (2)-Winter 2018,   FACULTY: (5)-Bill Barney
    (8, 1, 50, 2, 2, 2),  -- SECTION: 1,   CAPACITY: 50,   COURSE: (2)-ECON 150,   TERM: (2)-Winter 2018,   FACULTY: (2)-Nate Norris
    (9, 2, 50, 2, 2, 2),  -- SECTION: 2,   CAPACITY: 50,   COURSE: (2)-ECON 150,   TERM: (2)-Winter 2018,   FACULTY: (2)-Nate Norris
    (10, 1, 30, 4, 2, 4); -- SECTION: 1,   CAPACITY: 30,   COURSE: (4)-HUM  376,   TERM: (2)-Winter 2018,   FACULTY: (4)-John Jensen

INSERT INTO enrollment VALUES
	(6,7),  -- (6)-Alece     enrolling in   (7) -CIT  111 Winter 2018 Section 3
    (7,6),  -- (7)-Bryce     enrolling in   (6) -CIT  111 Winter 2018 Section 2
    (7,8),  -- (7)-Bryce     enrolling in   (8) -ECON 150 Winter 2018 Section 1
    (7,10), -- (7)-Bryce     enrolling in   (10)-HUM  376 Winter 2018 Section 1
    (4,5),  -- (4)-Devon     enrolling in   (5) -HUM  376 Fall 2019   Section 1
    (9,9),  -- (9)-Julia     enrolling in   (9) -ECON 150 Winter 2018 Section 2
    (2,4),  -- (2)-Katie     enrolling in   (4) -ECON 388 Fall 2019   Section 1
    (3,4),  -- (3)-Kelly     enrolling in   (4) -ECON 388 Fall 2019   Section 1
    (5,4),  -- (5)-Mandy     enrolling in   (4) -ECON 388 Fall 2019   Section 1
    (5,5),  -- (5)-Mandy     enrolling in   (5) -HUM  376 Fall 2019   Section 1
    (1,1),  -- (1)-Paul      enrolling in   (1) -CIT  111 Fall 2019   Section 1
    (1,3),  -- (1)-Paul      enrolling in   (3) -ECON 150 Fall 2019   Section 2
    (8,9),  -- (8)-Preston   enrolling in   (9) -ECON 150 Winter 2018 Section 2
    (10,6); -- (10)-Susan    enrolling in   (6) -CIT  111 Winter 2018 Section 2
    

-- SQL QUERIES

-- Query 1
SELECT first_name, last_name, DATE_FORMAT(birthdate, '%M %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE birthdate like '%-09-%'
ORDER BY last_name;

-- Query 2
SELECT 
	last_name, 
	first_name, 
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS 'Years', 
    DATEDIFF('2017-01-05', birthdate) % 365 AS 'Days', 
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' - Yrs, ', DATEDIFF('2017-01-05', birthdate) % 365, ' - Days') AS 'Years and Days'
FROM student
ORDER BY birthdate;

-- Query 3
SELECT st.first_name, st.last_name
FROM student st
	JOIN enrollment e
    ON st.student_id = e.student_id
	JOIN section se
    ON e.section_id = se.section_id
    JOIN faculty f
    ON se.faculty_id = f.faculty_id
WHERE f.faculty_id = 4
ORDER BY st.last_name;

-- Query 4
SELECT f.faculty_fname, f.faculty_lname
FROM student st
	JOIN enrollment e
    ON st.student_id = e.student_id
    JOIN section se
	ON e.section_id = se.section_id
    JOIN faculty f
    ON se.faculty_id = f.faculty_id
    JOIN term t
    ON t.term_id = se.term_id
WHERE st.student_id = 7 AND t.term_id = 2
ORDER BY f.faculty_lname;

-- Query 5
SELECT st.first_name, st.last_name
FROM student st
	JOIN enrollment e
    ON st.student_id = e.student_id
	JOIN section se
    ON e.section_id = se.section_id
    JOIN course c
    ON se.course_id = c.course_id
    JOIN term t
    ON se.term_id = t.term_id
WHERE c.course_id = 3 AND t.term_id = 1
ORDER BY st.last_name;

-- Query 6
SELECT d.department_code, c.course_num, c.course_title
FROM student st
	JOIN enrollment e
    ON st.student_id = e.student_id
    JOIN section se
    ON e.section_id = se.section_id
    JOIN course c
    ON se.course_id = c.course_id
    JOIN term t
    ON se.term_id = t.term_id
    JOIN department d
    ON c.department_id = d.department_id
WHERE st.student_id = 7 AND t.term_id = 2
ORDER BY c.course_title;

-- Query 7
SELECT t.term, t.year, COUNT(*) AS 'Enrollment'
FROM enrollment e
	JOIN section se
    ON se.section_id = e.section_id
    JOIN term t
    ON se.term_id = t.term_id
WHERE t.term_id = 1;

-- Query 8
SELECT co.college, COUNT(c.course) AS 'Courses'
FROM course c
	JOIN department d
    ON c.department_id = d.department_id
    JOIN college co
    ON d.college_id = co.college_id
GROUP BY co.college
ORDER BY co.college;

-- Query 9
SELECT f.faculty_fname, f.faculty_lname, SUM(se.capacity) AS TeachingCapacity
FROM section se
	JOIN faculty f
    ON se.faculty_id = f.faculty_id
    JOIN term t
    ON se.term_id = t.term_id
WHERE t.term_id = 2
GROUP BY f.faculty_id
ORDER BY TeachingCapacity;

-- Query 10
SELECT st.last_name, st.first_name, SUM(c.credits) AS Credits
FROM student st
	JOIN enrollment e
    ON st.student_id = e.student_id
    JOIN section se
    ON e.section_id = se.section_id
    JOIN term t
    ON se.term_id = t.term_id
    JOIN course c
    ON se.course_id = c.course_id
WHERE t.term_id = 1
GROUP BY st.student_id
HAVING Credits > 3
ORDER BY Credits DESC;