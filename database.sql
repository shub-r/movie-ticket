-- Create Tables
CREATE TABLE Movies (
    movie_id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    genre TEXT,
    duration INTEGER,
    release_date DATE
);

CREATE TABLE Theaters (
    theater_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    location TEXT
);

CREATE TABLE Showtimes (
    showtime_id INTEGER PRIMARY KEY,
    movie_id INTEGER,
    theater_id INTEGER,
    show_time DATETIME,
    screen_number TEXT,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id)
);

CREATE TABLE Tickets (
    ticket_id INTEGER PRIMARY KEY,
    showtime_id INTEGER,
    seat_number TEXT,
    price REAL,
    is_sold BOOLEAN,
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id)
);

CREATE TABLE Sales (
    sale_id INTEGER PRIMARY KEY,
    ticket_id INTEGER,
    sale_time DATETIME,
    payment_method TEXT,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    full_name TEXT,
    email TEXT UNIQUE,
    phone TEXT,
    password TEXT
);

CREATE TABLE Staff (
    staff_id INTEGER PRIMARY KEY,
    name TEXT,
    role TEXT,
    theater_id INTEGER,
    FOREIGN KEY (theater_id) REFERENCES Theaters(theater_id)
);

CREATE TABLE Bookings (
    booking_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    ticket_id INTEGER,
    booking_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
);

CREATE TABLE Ratings (
    rating_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    movie_id INTEGER,
    rating INTEGER CHECK(rating BETWEEN 1 AND 5),
    review TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Discounts (
    discount_id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    percentage REAL,
    valid_until DATE
);

-- Insert Sample Data
INSERT INTO Movies VALUES
(1, 'Inception', 'Sci-Fi', 148, '2010-07-16'),
(2, 'Avengers: Endgame', 'Action', 181, '2019-04-26');

INSERT INTO Theaters VALUES
(1, 'Cineplex A', 'Downtown'),
(2, 'Cinema B', 'Uptown');

INSERT INTO Showtimes VALUES
(1, 1, 1, '2025-05-12 18:00:00', '1A'),
(2, 2, 2, '2025-05-12 20:00:00', '2B');

INSERT INTO Tickets VALUES
(1, 1, 'A1', 12.50, 1),
(2, 1, 'A2', 12.50, 0),
(3, 2, 'B1', 15.00, 1);

INSERT INTO Sales VALUES
(1, 1, '2025-05-10 12:34:00', 'Credit Card'),
(2, 3, '2025-05-10 13:00:00', 'Cash');

INSERT INTO Users VALUES
(1, 'Alice Johnson', 'alice@example.com', '1234567890', 'password1'),
(2, 'Bob Smith', 'bob@example.com', '0987654321', 'password2');

INSERT INTO Staff VALUES
(1, 'Carol Lee', 'Manager', 1),
(2, 'David Kim', 'Cashier', 2);

INSERT INTO Bookings VALUES
(1, 1, 1, '2025-05-10 12:35:00'),
(2, 2, 3, '2025-05-10 13:01:00');

INSERT INTO Ratings VALUES
(1, 1, 1, 5, 'Mind-blowing movie!'),
(2, 2, 2, 4, 'Great action and story.');

INSERT INTO Discounts VALUES
(1, 'Student Discount', '10% off for students', 10.0, '2025-06-01'),
(2, 'Early Bird', '15% off for tickets before 4pm', 15.0, '2025-07-01');
