create database LMS_DB;
use LMS_DB;

-- 1. Students
create table Students(
student_id int auto_increment primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(100),
registration_date date,
country varchar(50)
);

insert into Students(first_name,last_name,email,registration_date,country) values
('Rohan','Budha','rohan@gmail.com','2025-01-10','Nepal'),
('Aarav','Sharma','aarav@gmail.com','2025-01-12','India'),
('Sita','Karki','sita@gmail.com','2025-01-15','Nepal'),
('John','Doe','john@gmail.com','2025-01-18','USA'),
('Emma','Watson','emma@gmail.com','2025-01-20','UK'),
('Liam','Wilson','liam@gmail.com','2025-01-22','Australia'),
('Noah','Smith','noah@gmail.com','2025-01-25','Canada'),
('Olivia','Brown','olivia@gmail.com','2025-01-27','USA'),
('Sophia','Davis','sophia@gmail.com','2025-02-01','Germany'),
('Mason','Taylor','mason@gmail.com','2025-02-05','France');

select * from Students;

-- 2. Instructors
create table Instructors(
instructor_id int auto_increment primary key,
instructor_name varchar(100),
specialization varchar(100),
joining_date date
);

insert into Instructors(instructor_name,specialization,joining_date) values
('John Smith','Web Development','2020-01-15'),
('Sarah Johnson','Database Systems','2019-03-20'),
('Michael Brown','Data Science','2021-07-10'),
('Emily Davis','Cyber Security','2018-09-12'),
('David Wilson','Cloud Computing','2022-02-01'),
('Sophia Miller','AI & ML','2020-11-25'),
('James Taylor','Networking','2019-06-18'),
('Olivia Anderson','Software Engineering','2021-01-08'),
('Daniel Thomas','Mobile Development','2023-04-14'),
('Emma Martinez','DevOps','2022-08-22');

select * from Instructors;

-- 3. Courses
create table Courses(
course_id int auto_increment primary key,
course_name varchar(100),
category varchar(50),
course_fee decimal(10,2),
instructor_id int,
foreign key(instructor_id) references Instructors(instructor_id)
);

insert into Courses(course_name,category,course_fee,instructor_id) values
('Java Programming','Programming',5000,1),
('SQL Database','Database',4500,2),
('Python for Data Science','Data Science',7000,3),
('Cyber Security Basics','Security',6500,4),
('AWS Cloud Fundamentals','Cloud',8000,5),
('Machine Learning','AI',9000,6),
('Computer Networks','Networking',5500,7),
('Software Engineering','Engineering',6000,8),
('Android Development','Mobile',7500,9),
('DevOps Essentials','DevOps',8500,10);

select * from Courses;

-- 4. Enrollments
create table Enrollments(
enrollment_id int auto_increment primary key,
student_id int,
course_id int,
enrollment_date date,
completion_status varchar(20),
foreign key(student_id) references Students(student_id),
foreign key(course_id) references Courses(course_id)
);

insert into Enrollments(student_id,course_id,enrollment_date,completion_status) values
(1,1,'2025-03-01','Completed'),
(2,2,'2025-03-02','In Progress'),
(3,3,'2025-03-03','Completed'),
(4,4,'2025-03-04','In Progress'),
(5,5,'2025-03-05','Completed'),
(6,6,'2025-03-06','In Progress'),
(7,7,'2025-03-07','Completed'),
(8,8,'2025-03-08','In Progress'),
(9,9,'2025-03-09','Completed'),
(10,10,'2025-03-10','In Progress');

select * from Enrollments;

-- 5. Assigments
create table Assignments(
assignment_id int auto_increment primary key,
course_id int,
assignment_title varchar(100),
max_marks int,
due_date date,
foreign key(course_id) references Courses(course_id)
);

INSERT INTO Assignments(course_id,assignment_title,max_marks,due_date) VALUES
(1,'Java OOP Project',100,'2025-04-01'),
(2,'SQL Queries Assignment',100,'2025-04-02'),
(3,'Data Analysis Project',100,'2025-04-03'),
(4,'Security Audit Report',100,'2025-04-04'),
(5,'AWS Deployment Task',100,'2025-04-05'),
(6,'ML Prediction Model',100,'2025-04-06'),
(7,'Network Design Task',100,'2025-04-07'),
(8,'SDLC Documentation',100,'2025-04-08'),
(9,'Android App Project',100,'2025-04-09'),
(10,'CI/CD Pipeline Setup',100,'2025-04-10');

select * from Assignments;


-- 6 Submissions
create table Submissions(
submission_id int auto_increment primary key,
assignment_id int,
student_id int,
marks_obtained int,
submission_date date,
foreign key(assignment_id) references Assignments(assignment_id),
foreign key(student_id) references Students(student_id)
);

INSERT INTO Submissions(assignment_id,student_id,marks_obtained,submission_date) VALUES
(1,1,88,'2025-03-30'),
(2,2,75,'2025-03-31'),
(3,3,92,'2025-04-01'),
(4,4,80,'2025-04-02'),
(5,5,95,'2025-04-03'),
(6,6,78,'2025-04-04'),
(7,7,85,'2025-04-05'),
(8,8,89,'2025-04-06'),
(9,9,91,'2025-04-07'),
(10,10,84,'2025-04-08');

select * from Submissions;

-- 7. Payments
create table Payments(
payment_id int auto_increment primary key,
student_id int,
amount_paid decimal(10,2),
payment_date date,
payment_method varchar(20),
foreign key(student_id) references Students(student_id)
);

INSERT INTO Payments(student_id,amount_paid,payment_date,payment_method) VALUES
(1,5000,'2025-02-15','eSewa'),
(2,4500,'2025-02-16','Khalti'),
(3,7000,'2025-02-17','Card'),
(4,6500,'2025-02-18','Cash'),
(5,8000,'2025-02-19','Card'),
(6,9000,'2025-02-20','eSewa'),
(7,5500,'2025-02-21','Khalti'),
(8,6000,'2025-02-22','Cash'),
(9,7500,'2025-02-23','Card'),
(10,8500,'2025-02-24','eSewa');

select * from Payments;

-- 1. Find students who paid more than the average payment amount.
select first_name, last_name from Students s join Payments p on s.student_id = p.student_id where p.amount_paid >
(select avg(amount_paid) from Payments);

-- 2. Find Courses fee whose fee is greater than average course fee.
select course_fee from Courses where course_fee > (select avg(course_fee) from Courses);

-- 3. Find instructors teaching the most expensive course.
select distinct i.instructor_id, i.instructor_name, i.specialization from Instructors i join 
Courses c on i.instructor_id = c.instructor_id where c.course_fee = (select MAX(course_fee) from Courses);

-- 4. Find students who enrolled in the course with the highest fee.
select s.student_id, s.first_name, s.last_name from Students s join Enrollments e on s.student_id = e.student_id
where e.course_id in (select course_id from Courses where course_fee = (select MAX(course_fee) from Courses));

-- 5. Find assignments whose maximum marks are greater than the average maximum marks.
select * from Assignments where max_marks > (select avg(max_marks) from Assignments);

-- 6. Find students who have submitted at least one assignment.
select * from Students where student_id in (select student_id from Submissions );

-- 7. Find students who have never submitted any assignment.
select * from Students where student_id  not in (select student_id from Submissions);

-- 8. Find courses that have enrollments.
select * from Courses where course_id in (select course_id from Enrollments);

-- 9. Find courses that have no enrollments.
select * from Courses where course_id not in (select course_id from Enrollments);

-- 10. Find instructors who are not assigned to any course.
select * from Instructors where instructor_id not in (select instructor_id from Courses);

-- 11. Find students whose total payment is higher than the average payment of all students.
select distinct p1.student_id from Payments p1 where (select SUM(p2.amount_paid) from Payments p2
where p2.student_id = p1.student_id) > (select avg(total_payment) from (select sum(amount_paid) as total_payment
from Payments group by student_id) t);