set FOREIGN_KEY_CHECKS = 0;

DROP TABLE STUDENT;
DROP TABLE COURSE;
DROP TABLE SECTION;
DROP TABLE GRADE_REPORT;
DROP TABLE PREQUISITE;

CREATE TABLE STUDENT(
    name VARCHAR(15),
    StudentNumber INT(9) PRIMARY KEY,
    Class INT(2),
    Major CHAR(9) NOT NULL
    );

CREATE TABLE COURSE(
    CourseName VARCHAR(50),
    CourseNumber VARCHAR(20) PRIMARY KEY,
    CreditHours INT(3),
    Department VARCHAR(10)
);

CREATE TABLE SECTION(
    SectionIdentifier INT(3) PRIMARY KEY,
    CourseNumber VARCHAR(20),
    FOREIGN KEY (CourseNumber) REFERENCES COURSE (CourseNumber),
    Semester VARCHAR(10),
    Year INT(3),
    Instructor VARCHAR(20)
);

CREATE TABLE GRADE_REPORT(
    StudentNumber INT(9),
    SectionIdentifier INT(9),
    PRIMARY KEY (StudentNumber, SectionIdentifier),
    FOREIGN KEY (StudentNumber) REFERENCES STUDENT(StudentNumber),
    FOREIGN KEY (SectionIdentifier) REFERENCES SECTION(SectionIdentifier),
    Grade VARCHAR(1)
);

CREATE TABLE PREQUISITE(
    CourseNumber VARCHAR(20),
    PrequisiteNumber VARCHAR(20),
    PRIMARY KEY (CourseNumber, PrequisiteNumber),
    FOREIGN KEY (CourseNumber) REFERENCES COURSE(CourseNumber),
    FOREIGN KEY (PrequisiteNumber) REFERENCES COURSE(CourseNumber)
);
-- INSERT DATA

--INSERT INTO STUDENT
--values ('Smith', 17, 1, 'CS');

INSERT INTO STUDENT values ('Smith', '17', '1', 'CS'), ('Brown', '8', '2', 'CS');  
INSERT INTO COURSE values ('Intro to Computer Science', 'CS1310', 4, 'CS'), ('Data Structures', 'CS3320', 4, 'CS'), ('Discrete Mathematics', 'MATH2410', 3, 'MATH'), ('Database', 'CS3380', 3, 'CS');  
INSERT INTO SECTION values (85, 'MATH2410', 'Fall', 98, 'King'), (92, 'CS1310', 'Fall', 98, 'Anderson'), (102, 'CS3320', 'Spring', 99, 'Knuth'), (112, 'MATH2410', 'Fall', 99, 'Chang'), (119, 'CS1310', 'Fall', 99, 'Anderson'), (135, 'CS3380', 'Fall', 99, 'Stone');  
INSERT INTO GRADE_REPORT values (17, 112, 'B'),(17, 119, 'C'),(8, 85, 'A'),(8, 92, 'A'),(8, 102, 'B'),(8, 135, 'A');
INSERT INTO PREQUISITE values ('CS3380', 'CS3320'), ('CS3380', 'MATH2410'), ('CS3320', 'CS1310');

--INSERT INTO enrolled
--VALUES ('12524', '790123456', 'B');

-- try violating referential integrity

--DELETE * FROM students
--WHERE sid = '790123456';


-- SHOW TABLE DATA
SELECT * FROM STUDENT;
SELECT * from COURSE;
SELECT * FROM SECTION;
SELECT * from GRADE_REPORT;
SELECT * from PREQUISITE;

set FOREIGN_KEY_CHECKS = 1;