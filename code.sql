CREATE TABLE person (
       id INTEGER PRIMARY KEY,
       first_name TEXT,
       last_name INTEGER,
       age INTEGER
);

INSERT INTO person VALUES (0, 'Sebastian', 'Duchene', 30);
INSERT INTO person VALUES (1, 'p', 'wow', 35);
INSERT INTO person VALUES (2, 'Harry', 'Bert', 13);


CREATE TABLE pet (
       id INTEGER PRIMARY KEY,
       name TEXT,
       breed TEXT,
       age INTEGER,
       dead INTEGER,
       dob DATETIME
);

INSERT INTO pet VALUES (0, 'fluffy', 'Unico', 0, 0, '20101010');
INSERT INTO pet VALUES (1, 'transist', 'robot', 1, 0, '20100101');
INSERT INTO pet VALUES (2, 'MAR', 'DOG', 12, 0, '20100202');
INSERT INTO pet VALUES (3, 'fins', 'fish', 14, 0, '20100707');
INSERT INTO pet VALUES (4, 'bert', 'cat', 1, 4, '20100303');

CREATE TABLE person_pet (
      person_id INTEGER,
      pet_id INTEGER
);


INSERT INTO person_pet VALUES (0 , 2);
INSERT INTO person_pet VALUES (0 , 1);
INSERT INTO person_pet VALUES (2 , 3);
INSERT INTO person_pet VALUES (1 , 4);
INSERT INTO person_pet VALUES (2 , 4);


