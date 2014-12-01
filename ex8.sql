
DELETE FROM pet WHERE id IN (
       SELECT pet.id
       FROM pet, person_pet, person
       WHERE
       person.id = person_pet AND
       pet.id = peson_pet.pet_id AND
       person.first_name = 'harry'
);

SELECT * FROM pet;
SELECT * FROM person_pet;

DELETE FROM person_pet
       WHERE pet_id NOT IN (
       	     SELECT id from pet
	     );

SELECT * FROM person_pet;


