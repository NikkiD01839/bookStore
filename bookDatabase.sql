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
    cardNumber varchar(255) NOT NULL,
    type varchar(25) NOT NULL,
    exp_date varchar(25) NOT NULL,
    bill_add varchar(255) NOT NULL,
    name_on_card varchar(255) NOT NULL,
    ccv varchar(25) NOT NULL,
    userId int NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id),
    lastFour varchar(255) NOT NULL
);

create table promotions (
	promo_code varchar(50) PRIMARY KEY NOT NULL,
    discount double NOT NULL
);

INSERT INTO promotions (promo_code, discount)
VALUES ("123CODE", 0.25);

create table cart(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    userId int NOT NULL,
	FOREIGN KEY (userId) REFERENCES users(id),
    bookId int NOT NULL,
    FOREIGN KEY (bookId) REFERENCES books(id)
);

create table books(
	id int PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    title varchar(255) NOT NULL,
    author varchar(255) NOT NULL,
    price double NOT NULL,
    rating double NOT NULL,
    genre varchar(255) NOT NULL,
    ISBN varchar(255) NOT NULL,
    synopsis varchar(8000),
    pic_location varchar(255),
    edition varchar(255),
    publisher varchar(255),
    pubYear int,
    salePrice double,
    quantity int
);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location, edition, publisher, pubYear, salePrice, quantity)
VALUES ("1984", "George Orwell", 13.99, 5, "Dystopian Political Fiction", 9752262935, 
"A story about a dystopian future where a totalitarian super-state watches your every move.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/1984.jpg", "5th", "Publisher1", 1999, 12.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Animal Farm", "George Orwell", 9.99, 5, "Animal Fable/Political Satire", 9751002177,
"A story about an animal revolution and how some animals are more equal than others.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/animalfarm.jpg","5th", "Publisher2", 1999, 12.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Brave New World", "Aldous Huxley", 17.99, 4, "Science/Dystopian Fiction", 978062696120, 
"A story about what life would be like if it were pain-free, and thus, meaningless.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/bravenewworld.jpg","5th", "Publisher3", 1999, 12.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Catch-22", "Joseph Heller", 12.99, 4, "Satire", 9786125722, 
"A story about the paradoxical reality of war.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/catch22.jpg","5th", "Publisher4", 1999, 12.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Fahrenheit 451", "Ray Bradbury", 21.99, 4.5, "Dystopian", 978-1451673265,
"A story about burning books.", "https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/fahrenheit451.jpg","4th", "Publisher5", 2006, 18.99, 49);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity) 
VALUES ("Uncle Tom's Cabin","Harriet Beecher Stowe", 19.99, 3.5, "Novel", 24158, 
"The narrative drive of Stowe's classic novel is often overlooked in the heat of the controversies surrounding 
its anti-slavery sentiments. In fact, it is a compelling adventure story with richly drawn characters and has 
earned a place in both literary and American history. Stowe's puritanical religious beliefs show up in the novel's 
final, overarching theme—the exploration of the nature of Christianity and how Christian theology is fundamentally 
incompatible with slavery.", "https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/cabin.jpg","6th", "Publisher6", 2006, 15.99, 50);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity) 
VALUES ("Where the Wild Things Are","Maurice Sendak", 15.99, 4, "Fiction", 12356, 
"Max, a wild and naughty boy, is sent to bed without his supper by his exhausted mother. In his room, he imagines 
sailing far away to a land of Wild Things. Instead of eating him, the Wild Things make Max their king.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/wild.jpg","5th", "Publisher7", 1996, 15.99, 50);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity) 
VALUES ("A Wrinkle in Time (Time Quintet)","Madeleine L'Engle", 21.99, 4, "Fiction", 25689, 
"It was a dark and stormy night; Meg Murry, her small brother Charles Wallace, and her 
mother had come down to the kitchen for a midnight snack when they were upset by the 
arrival of a most disturbing stranger.", "https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/time.jpg","5th", "Publisher8", 1979, 9.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity) 
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
 Mrs O’Leary’s husband. ", "https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/adolf.jpg","5th", "Publisher9", 2005, 17.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity) 
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
Diego de la Vega, a.k.a. Zorro, returns to America to reclaim the hacienda on which 
he was raised and to seek justice for all who cannot fight for it themselves.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/zorro.jpg","1st", "Publisher10", 2009, 20.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Pride and Prejudice", "Jane Austen", 7.99, 5, "Romantic Novel", 486284736,
"Elizabeth Bennett is quick to dislike Mr.Darcy who has an acerbic wit. The two butt heads and eventually fall in love.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/prideprejudice.jpg","2nd", "Publisher11", 2003, 14.99, 26);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("The Odyssey", "Homer", 10.00, 4.3, "Epic Poetry", 40268867,
"Odysseus endures many trials on his journey back to Ithaca.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/lookingglass.jpg","3rd", "Publisher12", 1989, 16.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Pygmalion", "George Bernard Shaw", 4.99, 4.5, "Romantic Comedy", 978-0486282220,
"Eliza Doolittle learns how to be a cultured gentlewoman.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/pygmalion.jpg","6th", "Publisher13", 2002, 15.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Twilight", "Stephanie Meyer", 1.99, 4, "Young Adult Fiction", 316015844,
"Bella Swan is your average girl who doesn't know she's actually beautiful. Edward Cullen 
is an immortal being who sparkles in the sunlight, and this makes him a monster. 
Romance ensues.", "https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/twilight.jpg","4th", "Publisher14", 1997, 10.99, 30);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Through the Looking Glass", "Lewis Carroll", 8.50, 5, "Childrens", 50593267,
"Alice has another fantastical adventure.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/lookingglass.jpg","5th", "Publisher15", 1999, 19.99, 20);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("The Hunger Games", "Suzanne Collins", 12.99, 4.7, "Adventure", 939023481,
"12 districts are forced to send young adults to compete in a survival game. The one who wins gets fame and glory. Those who don’t die.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/hungergames.jpg","1st", "Publisher16", 2001, 22.99, 40);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Insurgent", "Veronica Roth", 12.99, 4.5, "Science Fiction", 594138539,
"Sequel to Divergent, it continues the story of Tris Prior, who must now save those that she loves as war has broken out between the factions.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/insurgent.jpg","2nd", "Publisher17", 2000, 12.99, 8);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Jurassic Park", "Michael Crichton", 17.98, 4.7, "Science Fiction", 45538987,
"Newly cloned dinosaurs now roam around Jurassic Park! People from around the world come to see them until something goes wrong", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/jurassicpark.jpg","5th", "Publisher18", 1989, 11.99, 10);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("Horton Hears a Who!", "Dr. Seuss", 9.99, 5, "Childrens", 394800783,
"Horton, the lovable elephant, tries to protect tiny creatures on a speck of dust.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/Horton.jpg","3rd", "Publisher19", 1998, 12.99, 100);

INSERT INTO books (title, author, price, rating, genre, ISBN, synopsis, pic_location,edition, publisher, pubYear, salePrice, quantity)
VALUES("The Lorax", "Dr. Seuss", 11.89, 5, "Childrens", 94823379,
"I am the Lorax. I speak for the trees.", 
"https://raw.githubusercontent.com/NikkiD01839/bookStore/master/images/thelorax.jpg","4th", "Publisher20", 2001, 13.99, 50);










