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