select name from pet where id in (select pet_id from person_pet where purchased_on > 20040000);

select first_name from person where id in (select person_id from person_pet where purchased_on > 20040000);


select name from pet where parent in (select id from pet where name = 'MAR');

