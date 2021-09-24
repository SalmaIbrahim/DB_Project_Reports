--use SystemExamination
--1
create proc StuInfo @deptId int
as
select * 
from Student
where Dept_Id = @deptId

StuInfo 10

select * from student

--2
create proc StuGrades @stId int
as
select St_Id, Crs_Name, Grade, dateOfExm
from Stu_Course stcrs 
inner join Courses crs
on crs.Crs_Id = stcrs.Crs_Id 
and St_Id = @stId

StuGrades 3


--3
alter proc InsStuNCrs @insId int
as

if exists (select Ins_Id from Ins_Course where Ins_Id = @insId)
begin
	select Crs_Name, count(St_Fname + ' ' + St_Lname) as 'NoOfStudents'
	from Ins_Course ins
	inner join Courses crs
	on crs.Crs_Id = ins.Crs_Id
	and Ins_Id = @insId
	inner join Stu_Course stcrs
	on crs.Crs_Id = stcrs.Crs_Id
	inner join Student st
	on st.St_Id = stcrs.St_Id
	group by Crs_Name
end
else
	print 'Not Exists!'

	InsStuNCrs 1
	InsStuNCrs 6


--4
create proc CrsTopics @crsId int
as
if exists(select Crs_Id from Courses where Crs_Id = @crsId)
begin
	select crsTpc.Crs_Topic
	from Courses crs 
	inner join Course_Topics crsTpc
	on crs.Crs_Id = crsTpc.Crs_Id
	and crs.Crs_Id = @crsId
end
else
	select 'Not Exists!'

CrsTopics 600
CrsTopics 500
CrsTopics 300


--5

create proc GetExam @exmId int
as
select q.Q, q.Options
from exam exm 
inner join Exams exms
on exm.Exm_Id = exms.Exam_Id
inner join Questions q
on q.Q_Id = exms.Q_Id
and exm.Exm_Id = @exmId


getExam 1
getExam 2



--6
create proc StuExmAns @exmId int, @stuId int
as
select q.Q as Question, ans.St_Ans as StuAns
from Exams exms
inner join Questions q
on q.Q_Id = exms.Q_Id
and exms.Exam_Id = @exmId
inner join Answers ans
on q.Q_Id = ans.Q_Id
and ans.St_Id = @stuId


StuExmAns 1, 1




