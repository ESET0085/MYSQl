
use Employee;
create procedure retrieve_data
@id int
as
begin


select *from student
where id = @id
end



drop procedure retrieve_data

EXEC retrieve_data @id = 2


