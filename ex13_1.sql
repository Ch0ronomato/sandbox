
SELECT pet.name FROM pet WHERE pet.id IN (SELECT pet_id FROM person_pet WHERE purchased_on > 20040101) ;

SELECT person.first_name FROM person WHERE id IN (SELECT person_id FROM person_pet WHERE purchased_on > 20040101);



--SELECT person.first_name FROM person WHERE id IN (SELECT person_id FROM person_pet WHERE purchased_on > 20040101);--

SELECT name FROM pet WHERE parent IN (SELECT id FROM pet WHERE name = "MAR");






select pet.name, person.first_name from pet, person, person_pet
        where person_pet.person_id = person.id and pet.id = person_pet.pet_id 
	and pet.id in (select pet_id from person_pet where purchased_on > 20040101);
