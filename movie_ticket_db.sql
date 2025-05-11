-- movie ticket SELLING dAtabase

-- Table :    Movies
CREATE TABLE  Movies (
    movie_id INTEGER PRIMARY key,
    title     TEXT  Not Null,
    genre TEXT,
    duration  INTEGER ,
    release_date DATE
);

-- Table:   theaters
Create table Theaters (
    theater_id INTEGER  primary KEY,
    name Text   not null,
    location text
);

-- table:   Showtimes
create TABLE Showtimes (
    showtime_id int PRIMARY KEY,
    movie_id int,
    theater_id int,
    show_time   datetime,
    screen_number Text,
    foreign key (movie_id)  references Movies(movie_id),
    FOREIGN KEY(theater_id) REFERENCES Theaters(theater_id)
);

--table: tickets
CREATE table Tickets(
    ticket_id INT PRIMARY key,
    showtime_id INT,
    seat_number  TEXT,
    price   real,
    is_sold boolean,
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id)
);

--sales
CREATE TABLE Sales (
    sale_id int PRIMARY KEY,
    ticket_id INT,
    sale_time    DATETIME,
    payment_method text,
    FOREIGN KEY(ticket_id) REFERENCES Tickets(ticket_id)
);

-- USers
create TABLE Users(
    user_id INT primary key,
    full_name   TEXT,
    email TEXT Unique,
    phone text
);

-- STAFF
CREATE table Staff (
    staff_id integer PRIMARY KEY,
    name TEXT,
    role text,
    theater_id INTEGER,
    FOREIGN KEY(theater_id) REFERENCES Theaters(theater_id)
);

--BOOKINGS
create table Bookings (
    booking_id INTEGER primary KEY,
    user_id INT,
    ticket_id INT,
    booking_time  datetime,
    foreign key (user_id) REFERENCES Users(user_id),
    FOREIGN key (ticket_id) REFERENCES Tickets(ticket_id)
);

--ratings
CREATE table Ratings (
    rating_id int PRIMARY KEY,
    user_id int,
    movie_id int,
    rating INT check(rating BETWEEN 1 AND 5),
    review text,
    FOREIGN key (user_id) references Users(user_id),
    FOREIGN key(movie_id) REFERENCES Movies(movie_id)
);

--discounts
create TABLE Discounts (
    discount_id INT PRIMARY key,
    name TEXT,
    description  text,
    percentage real,
    valid_until date
);

-- Sample data Inserts

-- Movies
insert into Movies values
(1, 'Inception', 'Sci-Fi', 148, '2010-07-16'),
(2, 'Avengers: Endgame', 'Action', 181, '2019-04-26');

-- Theaters
insert INTO Theaters VALUES
(1,'Cineplex A','Downtown'),
(2, 'Cinema B' , 'Uptown');

--Showtimes
INSERT into Showtimes VALUES
(1,1,1,'2025-05-12 18:00:00','1A'),
(2,2,2,'2025-05-12 20:00:00','2B');

--tickets
INSERT INTO Tickets VALUES
(1,1,'A1',12.50,1),
(2,1,'A2',12.50,0),
(3,2,'B1',15.00,1);

--sales
insert into Sales VALUES
(1,1,'2025-05-10 12:34:00','Credit Card'),
(2,3,'2025-05-10 13:00:00','Cash');

--USERS
Insert into Users VALUES
(1,'Alice Johnson','alice@example.com','1234567890'),
(2,'Bob Smith','bob@example.com','0987654321');

--staff
insert into Staff VALUES
(1,'Carol Lee','Manager',1),
(2,'David Kim','Cashier',2);

--bookings
INSERT INTO Bookings values
(1,1,1,'2025-05-10 12:35:00'),
(2,2,3,'2025-05-10 13:01:00');

--ratings
Insert INTO Ratings values
(1,1,1,5,'Mind-blowing movie!'),
(2,2,2,4,'Great action and story.');

--discounts
insert INTO Discounts VALUES
(1,'Student Discount','10% off for students',10.0,'2025-06-01'),
(2,'Early Bird','15% off for tickets before 4pm',15.0,'2025-07-01');
