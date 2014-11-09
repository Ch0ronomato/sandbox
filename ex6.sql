SELECT pet.id, pet.name, pet.age, pet.dead FROM pet, person_pet, person
WHERE person.first_name='Sebastian' AND 
person_pet.person_id=person.id AND
pet.id=person_pet.pet_id;
