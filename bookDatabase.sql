create database bookstore;
use bookstore;

create table users(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL unique,
    pass varchar(255) NOT NULL,
    status varchar(25) NOT NULL Default "Inactive",
    usertype int NOT NULL DEFAULT 2
);

create table userTypes(
	type_id int PRIMARY KEY NOT NULL,
    type_name varchar(25) NOT NULL
);

INSERT INTO userTypes (type_id, type_name) VALUES (1, "Admin");
INSERT INTO userTypes (type_id, type_name) VALUES (2, "Customer");

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

create table books(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    title varchar(255) NOT NULL,
    author varchar(255) NOT NULL,
    price double NOT NULL,
    rating double NOT NULL,
    genre varchar(255) NOT NULL,
    ISBN int NOT NULL,
    synopsis varchar(8000),
    pic_location varchar(255)
);

INSERT INTO book (title, author, price, rating, genre, ISBN, synopsis, pic_location)
VALUES ("1984", "George Orwell", 13.99, 5, "Dystopian Political Fiction", 978-0452262935, 
"A story about a dystopian future where a totalitarian super-state watches your every move.", "1984.jpg")

INSERT INTO book (title, author, price, rating, genre, ISBN, synopsis, pic_location)
VALUES("Animal Farm", "George Orwell", 9.99, 5, "Animal Fable/Political Satire", 978-0151002177,
"A story about an animal revolution and how some animals are more equal than others.", "animalfarm.jpg")

INSERT INTO book (title, author, price, rating, genre, ISBN, synopsis, pic_location)
VALUES("Brave New World", "Aldous Huxley", 17.99, 4 stars, "Science/Dystopian Fiction", 978-0062696120, 
"A story about what life would be like if it were pain-free, and thus, meaningless.", "bravenewworld.jpg")

INSERT INTO book (title, author, price, rating, genre, ISBN, synopsis, pic_location)
VALUES("Catch-22", "Joseph Heller", 12.99, 4, "Satire", 978-3596125722, 
"A story about the paradoxical reality of war.", "catch22.jpg")

INSERT INTO book (title, author, price, rating, genre, ISBN, synopsis, pic_location)
VALUES("Fahrenheit 451", "Ray Bradbury", 21.99, 4.5, "Dystopian", 978-1,451673265,
"A story about burning books.", "fahrenheit451.jpg")

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location) 
VALUES ("Uncle Tom's Cabin","Harriet Beecher Stowe", 19.99, 3.5, "Novel", 24158, 
"The narrative drive of Stowe's classic novel is often overlooked in the heat of the controversies surrounding 
its anti-slavery sentiments. In fact, it is a compelling adventure story with richly drawn characters and has 
earned a place in both literary and American history. Stowe's puritanical religious beliefs show up in the novel's 
final, overarching theme—the exploration of the nature of Christianity and how Christian theology is fundamentally 
incompatible with slavery.", "cabin.jpg");

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location) 
VALUES ("Where the Wild Things Are","Maurice Sendak", 15.99, 4, "Fiction", 12356, 
"Max, a wild and naughty boy, is sent to bed without his supper by his exhausted mother. In his room, he imagines 
sailing far away to a land of Wild Things. Instead of eating him, the Wild Things make Max their king.", "wild.jpg");

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location) 
VALUES ("A Wrinkle in Time (Time Quintet)","Madeleine L'Engle", 21.99, 4, "Fiction", 25689, 
"It was a dark and stormy night; Meg Murry, her small brother Charles Wallace, and her 
mother had come down to the kitchen for a midnight snack when they were upset by the 
arrival of a most disturbing stranger.", "time.jpg");

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location) 
VALUES ("Young Adolf","Beryl Bainbridge", 17.99, 3.21, "Biography", 519556, 
"Young Adolf was published in 1978 and was Beryl Bainbridge’s first and 
only historical novel until the 1990s. Many its characters are inspired 
by real people: besides the protagonist Adolf Hitler, there is his 
half-brother Alois, Alois’ English wife Bridget and their baby Pat. 
Some other names mentioned in the novel - mainly those of relatives of 
the future dictator, such as his brother Edwin or his half-sister Angela 
- are also those of real historical people. Other important but fictional 
characters are Meyer, the Jewish landlord and future friend of Adolf, Mary O’Leary,
 another tenant, Dr Kephalus, a somewhat mysterious doctor and friend of Meyer’s, 
 Mr Dupont, a guest at the Adelphi Hotel, and the “bearded man”, who is in fact 
 Mrs O’Leary’s husband. ", "adolf.jpg");

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location) 
VALUES ("Zorro","Isabel Allende", 19.99, 3.76, "Fiction", 561651, 
"A swashbuckling adventure story that reveals for the first time how Diego de la 
Vega became the masked man we all know so well Born in southern California late in 
the eighteenth century, Diego de la Vega is a child of two worlds. His father is an 
aristocratic Spanish military man turned landowner; his mother, a Shoshone warrior. 
At the age of sixteen, Diego is sent to Spain, a country chafing under the corruption 
of Napoleonic rule. He soon joins La Justicia, a secret underground resistance movement 
devoted to helping the powerless and the poor. Between the New World and the Old, the
persona of Zorro is formed, a great hero is born, and the legend begins. After many
adventures -- duels at dawn, fierce battles with pirates at sea, and impossible rescues
-- Diego de la Vega, a.k.a. Zorro, returns to America to reclaim the hacienda on which 
he was raised and to seek justice for all who cannot fight for it themselves.", "zorro.jpg");














