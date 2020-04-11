create database bookstore;
use bookstore;
create table users(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL unique,
    pass varchar(255) NOT NULL
);

show tables;

ALTER TABLE users
ADD usertype int NOT NULL 
DEFAULT 2;

create table userTypes(
	type_id int PRIMARY KEY NOT NULL,
    type_name varchar(25) NOT NULL
);

INSERT INTO userTypes (type_id, type_name) VALUES (1, "Admin");
INSERT INTO userTypes (type_id, type_name) VALUES (2, "Customer");

INSERT INTO users (first_name, last_name, email, pass, usertype) 
VALUES ("adminFirst","adminLast","admin@gmail.com","admin", 1);

create table paymentCard(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    cardNumber varchar(25) NOT NULL,
    type varchar(25) NOT NULL,
    exp_date varchar(25) NOT NULL,
    bill_add varchar(255) NOT NULL,
    name_on_card varchar(255) NOT NULL,
    ccv varchar(25) NOT NULL,
    userId int NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id)
);

UPDATE users
SET usertype = 1
WHERE id = 1;

SELECT * FROM bookstore.userTypes;
SELECT * FROM bookstore.users;
