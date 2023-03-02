DROP TABLE students;
DROP TABLE enrolled;

CREATE TABLE students
    (sid CHAR(9) PRIMARY KEY,
    name VARCHAR(15),
    email VARCHAR(30) NOT NULL UNIQUE, -- UNIQUE implies this is a candidate key
    age INT CHECK (age > 9 AND age < 21), -- domain constraint
    gpa REAL);

CREATE TABLE enrolled
    (CRN CHAR(5),
    studnum CHAR(9) NOT NULL,
    grade CHAR DEFAULT 'A', -- can set default value
    PRIMARY KEY (CRN, studnum),
    FOREIGN KEY (studnum) REFERENCES students(sid)
        ON DELETE CASCADE); -- referential trigger action
                            -- can also do SET NULL, CASCADE, SET DEFAULT
                            -- ON DELETE or ON UPDATE

-- INSERT DATA

INSERT INTO students
values ('790123456', 'Lucy Lu', 'lucylu@yahoo.com', 18, 3.97);

INSERT INTO enrolled
VALUES ('12524', '790123456', 'B');

-- try violating referential integrity

--DELETE * FROM students
--WHERE sid = '790123456';

-- SHOW TABLE DATA
SELECT * FROM students;
SELECT * from enrolled;