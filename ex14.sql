


--ALTER table table_name--
--add column_name data_type--
--BEGIN;--

ALTER TABLE person ADD phone INTEGER;
ALTER TABLE person ADD salary FLOAT;
ALTER TABLE person ADD dob DATETIME;
ALTER TABLE person_pet ADD purchased_on DATETIME;
ALTER TABLE pet ADD parent INTEGER;

UPDATE person SET phone = 0468671669 WHERE id = 0;
UPDATE person SET phone = 9909233423 WHERE id = 1;
UPDATE person SET phone = 8823423423 WHERE id = 2;

UPDATE person SET salary = 1000 WHERE id = 0;
UPDATE person SET salary = 100.0 WHERE id = 1;
UPDATE person SET salary = 999.0 WHERE id = 2;

UPDATE person SET dob = '19841708' WHERE id = 0;
UPDATE person SET dob = '20131201' WHERE id = 1;
UPDATE person SET dob = '20131201' WHERE id = 2;

UPDATE person_pet SET purchased_on = '20061027' WHERE pet_id = 0;
UPDATE person_pet SET purchased_on = '20041027' WHERE pet_id = 1;
UPDATE person_pet SET purchased_on = '20021027' WHERE pet_id = 2;
UPDATE person_pet SET purchased_on = '20011027' WHERE pet_id = 3;
UPDATE person_pet SET purchased_on = '20061127' WHERE pet_id = 4;

INSERT INTO person VALUES (3, 'X', 'Y', 44, 1234, 1500.0, '19900103');
INSERT INTO pet VALUES (5, 'Violeta', 'Dog', 4, 0, '20120101', (SELECT id FROM pet WHERE name = 'MAR'));

INSERT INTO person_pet VALUES(0, 5, '20120501');

--Write a query that can find all the names of pets and their owners bought after 2004. Key to this is to map the person_pet based on the purchased_on column to the pet and parent.--

select name from pet where id in (select pet_id from person_pet where purchased_on > 20040000);
select first_name from person where id in (select person_id from person_pet where purchased_on > 20040000);
select name from pet where parent in (select id from pet where name = 'MAR');


--ROLLBACK;--
