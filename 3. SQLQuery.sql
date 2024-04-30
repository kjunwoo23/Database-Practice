--SQL_DDL&Query

select name
from instructor

select distinct dept_name
from instructor

select all dept_name
from instructor

select *
from instructor

select '437' as FOO

select 'A'
from instructor

select ID, name, salary/12 as monthly_salary
from instructor

select name
from instructor
where dept_name = 'CS'

select name
from instructor
where dept_name = 'CS' and salary > 80000

select *
from instructor, teaches

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID

select name, course_id
from instructor, teaches
where instructor.ID = teaches.ID and instructor.dept_name = 'Art'

select distinct T.name
from instructor as T, instructor as S
where t.salary > s.salary and s.dept_name = 'CS'



--SQL_Functions&Operators
select name
from instructor
where name like '%lil%'

select *
from student
where name like 'Manb%'

select *
from student
where name like 'Manbe_'

select name, ASCII(name) as ASCII_firstCharacter
from student

select CHAR(65) as NumberCodeToCharacter

select CHARINDEX('t', 'teacher') as MatchPosition

select 'Sejong' + ' ' + 'University'

select convert(int, 13.12)

select UPPER('student')

select lower('STUdent')

select len('student')

select distinct name
from instructor
order by name

select distinct dept_name, name
from instructor
order by dept_name, name desc

select name
from instructor
where salary between 90000 and 100000

select course_id
from section
where semester = 'Fall' and year = 2009
union
	(select course_id
	from section
	where semester = 'Spring' and year = 2010)

select course_id
from section
where semester = 'Fall' and year = 2009
intersect
	(select course_id
	from section
	where semester = 'Spring' and year = 2010)

select course_id
from section
where semester = 'Fall' and year = 2009
except
	(select course_id
	from section
	where semester = 'Spring' and year = 2010)

select distinct T.salary
from instructor as T, instructor as S
where T.salary < S.salary

select salary
from instructor

select salary
from instructor
except
	(select distinct T.salary
	from instructor as T, instructor as S
	where T.salary < S.salary)

select name
from instructor
where salary is null



--SQL_Funcs & Subqrys
select avg(salary)
from instructor
where dept_name = 'comp.sci.'

select count(distinct ID)
from teaches
where semester = 'spring' and year = 2010

select count(*)
from course

select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name

/*
select dept_name, ID, avg(salary)
from instructor
group by dept_name
*/

select dept_name, avg(salary)
from instructor
group by dept_name
having avg(salary) > 42000

select sum(salary)
from instructor

select distinct course_id
from section
where semester = 'fall' and year = 2009
and
course_id in (
	select course_id
	from section
	where semester = 'spring' and year = 2010)

select distinct course_id
from section
where semester = 'fall' and year = 2009
and
course_id not in (
	select course_id
	from section
	where semester = 'spring' and year = 2010)

select count(distinct t1.id)
	from takes as t1 inner join teaches as t2 on t1.course_id = t2.course_id
		and t1.sec_id = t2.sec_id
		and t1.semester = t2.semester
		and t1.year = t2.year
where t2.id = 14365;

select distinct t.name
from instructor as t, instructor as s
where t.salary > s.salary and s.dept_name = 'comp.sci.'
order by name desc

select name
from instructor
where salary > some (select salary
					from instructor
					where dept_name = 'comp.sci.')
					order by name desc

select name
from instructor
where salary > all(
					select salary
					from instructor
					where dept_name = 'comp.sci')

select course_id
from section as s
where semester = 'fall' and year = 2009
and
exists(
	select *
	from section as t
	where semester = 'spring' and year = 2010 and s.course_id = t.course_id)

select distinct S.id, S.name
from student as S
where not exists(
			(select course_id
			from course
			where dept_name = 'comp.sci.')
			except(select T.course_id
				from takes as T
				where S.id = T.ID))

select dept_name, avg_salary
from(
	select dept_name, avg(salary)
	from instructor
	group by dept_name) as dept_avg(dept_name, avg_salary)
where avg_salary > 42000

with max_budget(value) as
	(select max(budget)
	from department)
select department.dept_name
from max_budget, department
where department.budget = max_budget.value

with dept_total(dept_name, value) as
	(select dept_name, sum(salary)
	from instructor
	group by dept_name),
dept_total_avg(value) as
	(select avg(value)
	from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value > dept_total_avg.value

select dept_name,
	(select count(*)
	from instructor
	where department.dept_name = instructor.dept_name)
	as num_instructors
from department



--SQL_DB Modification
select *
from INFORMATION_SCHEMA.TABLES

delete from instructor

delete from instructor
where dept_name = 'Comp.Sci'

delete from instructor
where dept_name in (
	select dept_name
	from department
	where building = 'Watson')

delete from instructor
where salary < (
	select avg(salary)
	from instructor)

with avg_salary(value) as
	(select avg(salary)
	from instructor)
delete from instructor
from avg_salary, instructor
where instructor.salary > avg_salary.value

insert into course
	values('CS-437', 'DB', 'Comp.Sci', 4)
--or
insert into course(course_id, title, dept_name, credits)
	values('CS-437', 'DB', 'Comp.Sci', 4)

update instructor
	set salary = salary * 1.03
	where salary > 100000
update instructor
	set salary = salary * 1.05
	where salary <= 100000

update instructor
	set salary = case
		when salary <= 100000 then salary * 1.05
		else salary * 1.03
		end

update student
	set tot_cred = (select sum(credits)
					from takes, course
					where takes.course_id = course.course_id
					and student.ID = takes.ID
					and takes.grade <> 'F'
					and takes.grade is not null)

select *
from course
left join prereq on course.course_id = prereq.course_id

select *
from course
right join prereq on course.course_id = prereq.course_id

select *
from course
full join prereq on course.course_id = prereq.course_id

select ID, name, dept_name
from instructor

select *
from faculty

select *
from departments_total_salary

select *
from Comp_Sci_fall_2009

select *
from student with(index(studentid_index))
where ID = '10481'