CREATE TABLE movie (
    id_movie SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    director VARCHAR(100),
    genre VARCHAR(50),
    release_date DATE
);

CREATE TABLE film_rental (
    id_film_rental SERIAL PRIMARY KEY,
    provider VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    id_movie INTEGER NOT NULL REFERENCES movie(id_movie)
);

CREATE TABLE cinema (
    id_cinema SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cinema_number VARCHAR(10) NOT NULL,
    phone VARCHAR(16),
    address VARCHAR(255) NOT NULL,
    id_film_rental INTEGER NOT NULL REFERENCES film_rental(id_film_rental)
);

CREATE TABLE customer (
    id_customer SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL,
    email VARCHAR(50),
    seat VARCHAR(30)
);

CREATE TABLE cinema_customer (
    id_cinema INTEGER NOT NULL REFERENCES cinema(id_cinema),
    id_customer INTEGER NOT NULL REFERENCES customer(id_customer),
    PRIMARY KEY (id_cinema, id_customer)
);

CREATE TABLE ticket (
    id_ticket SERIAL PRIMARY KEY,
    ticket_number VARCHAR(20) NOT NULL,
    purchase_date DATE NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    id_cinema INTEGER NOT NULL REFERENCES cinema(id_cinema),
    id_movie INTEGER NOT NULL REFERENCES movie(id_movie),
    id_customer INTEGER NOT NULL REFERENCES customer(id_customer)
);
