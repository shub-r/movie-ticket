const express = require('express');
const session = require('express-session');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');
const app = express();
const port = 3000;

// Middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(session({
    secret: 'secret-key',
    resave: false,
    saveUninitialized: true
}));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));

// Database Connection
const db = new sqlite3.Database('./database.db', (err) => {
    if (err) console.error('Database error:', err);
    else console.log('Connected to SQLite');
});

// Routes
app.get('/', (req, res) => {
    db.all('SELECT * FROM Movies', [], (err, movies) => {
        if (err) res.status(500).send('Error fetching movies');
        else res.render('index', { movies });
    });
});

app.get('/movies/:id', (req, res) => {
    const movieId = req.params.id;
    db.get('SELECT * FROM Movies WHERE movie_id = ?', [movieId], (err, movie) => {
        if (err || !movie) res.status(500).send('Error fetching movie');
        else {
            db.all('SELECT * FROM Showtimes WHERE movie_id = ?', [movieId], (err, showtimes) => {
                if (err) res.status(500).send('Error fetching showtimes');
                else res.render('movie', { movie, showtimes });
            });
        }
    });
});

// Add routes for booking, login, signup, admin, history, ratings...

app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
