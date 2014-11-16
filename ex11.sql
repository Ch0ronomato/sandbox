--*/ Run these from the command line */--

INSERT INTO person (id, first_name, last_name, age)
       VALUES (0, 'Frank', 'Smith', 100);

INSERT OR REPLACE INTO person (id, first_name, last_name, age)
       VALUES (0, 'Frank', 'Smith', 100);

SELECT * FROM person;

REPLACE INTO person (id, first_name, last_name, age)
	VALUES (0, 'Sebastian', 'Duchene', 30);

SELECT * FROM person;

