SELECT * FROM pet;

UPDATE pet SET name = 'Sebs pet' WHERE id IN (
SELECT id FROM pet WHERE id in (
SELECT pet_id FROM person_pet WHERE person_id in (
SELECT id FROM person WHERE first_name = 'Sebastian')));

SELECT * FROM pet;
