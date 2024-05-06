drop table timetable

create table timetable(
	a date,
	b time
)

insert into timetable
	values('20220526', '15:28:00')

select * from timetable

select convert(date, sysdatetime());

select convert(time, sysdatetime());

drop table student1

create table student1(
	id varchar(5),
	name varchar(20) not null,
	dept_name varchar(20),
	tot_cred numeric(3,0) default 0
	)

insert into student1(ID, name, dept_name)
	values('111', 'jones', 'CSE')

select * from student1


select * from student

drop index student.studentID_index

create index studentID_index on student(ID)

select *
from student with (index(studentID_index))
where ID = '98988'

drop table countries

create table countries(
	name varchar(90),
	notes varchar(max)
	)

insert into countries
	values('South Korea', 'South Korea is a beautiful country located at far east of Asia!.....')

select *
from countries

drop table myphoto

create table myphoto(
id int,
img varbinary(max)
)

insert into University_DB.myphoto
	values(1, (
			select * from openrowset(bulk N'C:\SQL.png', single_blob) as T1))

select * from myphoto

create type euros
from numeric(12,2) not null

create table building(
	id int,
	name varchar(10),
	budget euros
	)

insert into building
	values(1, 'Daeyang', '100000')

select * from building

grant select on department to jalil

grant update(budget) on department to jalil;

revoke select on department from jalil cascade;

revoke update(budget) on department to jalil cascade;

create role teacher
grant select on takes to teacher

grant select on department to jalil with grant option;

--ppt version
create table Persons
(
	P_Id int PRIMARY KEY IDENTITY,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Adddress varchar(255),
	City varchar(255)
)

insert into persons values ('kim', 'lee', 'seoul', 'korea')
insert into persons values ('park', 'cho', 'busan', 'korea')

select * from persons

create table Persons2
(
	P_Id int PRIMARY KEY IDENTITY (1000,5),
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Adddress varchar(255),
	City varchar(255)
)

insert into persons values ('kim', 'lee', 'seoul', 'korea')
insert into persons values ('park', 'cho', 'busan', 'korea')

select * from persons2

create function dept_count(@dept_name varchar(20))
	returns INT
		as
	begin
	declare @d_count INT;
		set @d_count = 0;
			select @d_count = (select count(*)
				from instructor
				where instructor.dept_name = @dept_name)
	return @d_count;
	end

select dept_name, budget
from department
where dbo.dept_count(dept_name) < 12

create function instperdepartment()
	returns table
	as
	return
		(select i.dept_name, count(i.dept_name) as [number of instructors]
		from [instructor]i
		group by i.dept_name);
select *
from instperdepartment()

create function CountInstPerDepartment(@dept_name varchar(20))
	returns int
	as
	begin
	declare @instCount int
		select @instCount = count(*)
		from [instructor]
		where [instructor].[dept_name] = @dept_name
	return @instCount
	end
select distinct [dept_name], dbo.countInstPerDepartment(dept_name) as [number of instructors]
from [instructor]

create function instructor_of(@dept_name char(20))
	returns table
	as
	return(
		select ID, name, dept_name
		from instructor
		where instructor.dept_name = @dept_name);
select *
from instructor_of('comp.sci.')

drop procedure allInstructors
create procedure allInstructors
as
	select *
	from instructor
exec allInstructors

create procedure inst_dept
	@dname varchar(20),
	@totalins int out
	as
		select *
		from [instructor]
		where [instructor].[dept_name] = @dname;
		set @totalins = @@ROWCOUNT
	go

declare @dept varchar(20), @inscount int
set @dept = 'Physics'
exec [inst_dept] @dept, @insCount output
select @inscount

if object_id('temp1') is not null
	drop table temp1;
go

create table temp1(
	[s_id] int primary key,
	[sname] varchar(15) not null,
	[dob] datetime,
	[age] tinyint);
insert into temp1 (s_id, sname, dob)
	values(2, 'Park', '10/04/1995')
select * from temp1

create trigger [dbo].[trg_TempStdAgeUpdate]
	on [dbo].[temp1]
	after insert, update
	as
		begin
			declare @age tinyint
			select @age
				= convert(tinyint, round(datediff(hour, dob, getdate()) / 8766.0, 0))
			from inserted
			update temp1
				set age = @age
				where s_id = (select s_id from inserted)
	end

insert into temp1 (s_id, sname, dob)
	values(1, 'LEE', '6/23/1994')
select * from temp1

update temp1
	set dob = '6/23/1999'
	where s_id = 1
select *
from temp1

with cte as (
	select prereq_id
	from prereq
	where course_id = 'BIO-301'
	union all
		select cp.prereq_id
		from cte join prereq as cp
			on cte.prereq_id = cp.course_id
	)
select *
from cte

--video version
if OBJECT_ID('persons') is not null
	drop table dbo.persons;
go

create table persons(
	ID int primary key identity(1000,5),
	lastname varchar(29) not null,
	firstname varchar(29),
	address varchar(max),
	city varchar(29)
	)

insert into persons
	values('Johnes', 'Jack', 'Neungdon-ro 29, Gwangjin-gu', 'Seoul')
insert into persons
	values('Smith', 'Andrson', 'Neungdon-ro 29, Gwangjin-gu', 'Seoul')

select *
from persons

if OBJECT_ID('p1') is not null
	drop procedure dbo.p1;
go

create procedure p1
as
	print 'Welcome to Database Course';
exec p1

if OBJECT_ID('AllInstructors') is not null
	drop procedure dbo.allInstructors;
go

create procedure allinstructors
as
	select *
	from instructor
go

exec allInstructors

if OBJECT_ID('inst_dept') is not null
	drop procedure dbo.inst_dept;
go

create procedure inst_dept
	@dname varchar(20),
	@totalins int out
as
	select *
	from [instructor]
	where [instructor].[dept_name] = @dname
	set @totalins = @@ROWCOUNT
go

declare @dept varchar(20), @insCount int
set @dept = 'Finance'
exec[inst_dept] @dept, @inscount output
select @insCount

declare  @i int;
set @i = 1
while (@i <= 10)
	begin
		print (@i);
		set @i = @i + 1
end

declare @x int;
declare @y int;
set @x = 10;
set @y = 20;
if (@x > @y)
	print 'x is greater than y.'
else if (@x < @y)
	print 'y is greater than x'
else
	print 'x is equal to y.'

if OBJECT_ID('F1') is not null
	drop function dbo.f1
go

create function f1()
returns varchar(20)
as
	begin
		return 'Welcome to Database Course'
	end

select dbo.f1() as function1

if OBJECT_ID('dept_count') is not null
	drop function dept_count
go

create function dept_count(@dept_name varchar(20))
returns int
as
	begin
		declare @d_count int;
		set @d_count = 0;
		select @d_count = (select count(*)
			from instructor
			where instructor.dept_name = @dept_name)
		return @d_count;
	end

select dept_name, budget
from department
where dbo.dept_count(dept_name) < 12

if object_id('instperdepartment') is not null
	drop function instperdepartment
go

create function instperdepartment()
returns table
as
	return(
		select i.dept_name, count(i.dept_name) as [Number of Instructors]
		from [instructor]i
		group by i.dept_name
		)

select *
from instperdepartment()

if object_id('countinstperdepartment') is not null
	drop function countinstperdepartment
go

create function countinstperdepartment(@dept_name varchar(20))
returns int
as
	begin
	declare @instCount int
		select @instCount = count(*)
		from [instructor]
		where [instructor].[dept_name] = @dept_name
	return @instCount
end

select distinct [dept_name], dbo.countinstperdepartment(dept_name) as [Number of Instructors]
from [instructor]

if object_id('instructor_of') is not null
	drop function instructor_of
go

create function instructor_of(@dept_name varchar(20))
returns table
as
	return(
		select ID, name, dept_name
		from instructor
		where instructor.dept_name = @dept_name
		)

select *
from instructor_of('comp.sci.')

if object_id('temp1') is not null
	drop table temp1;
go

create table temp1(
	s_id int primary key,
	sname varchar(15) not null,
	dob datetime,
	age tinyint
)

insert into temp1(s_id, sname, dob)
	values(2, 'Johens', '10/04/1995')
insert into temp1(s_id, sname, dob)
	values(3, 'Smith', '10/04/1999')

select *
from temp1

if OBJECT_ID('Tr_Temp1Update') is not null
	drop trigger dbo.tr_temp1update;
go

create trigger tr_temp1update
	on temp1
	after insert, update
	as
		begin
			declare @age tinyint
			select @age = convert(tinyint, round(datediff(hour, dob, getdate())/8766.0, 0))
			from inserted
			update temp1
			set age = @age
			where s_id = (select s_id from inserted)
	end

if OBJECT_ID('cte') is not null
	drop table dbo.cte;
go

select *
from prereq

with cte as(
	select prereq_id
	from prereq
	where course_id = 'Bio-301'
	union all
		select cp.prereq_id
		from cte join
			prereq as cp
			on cte.prereq_id = cp.course_id
	)

select *
from cte
