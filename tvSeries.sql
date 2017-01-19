CREATE TABLE series(
  series_id INT NOT NULL PRIMARY KEY,
  title VARCHAR(30) NOT NULL,
  year INT NOT NULL,
  language VARCHAR(30) NOT NULL,
  budget DECIMAL(11, 2) NOT NULL
);

CREATE TABLE actor(
  actor_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  nationality VARCHAR(30) NOT NULL
);

CREATE TABLE network(
  network_id INT NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  location TEXT NOT NULL
);

CREATE TABLE award(
  award_id int NOT NULL PRIMARY KEY,
  category VARCHAR(30) NOT NULL,
  organizer VARCHAR(30) NOT NULL
);

CREATE TABLE series_actor(
  series_id INT NOT NULL,
  actor_id INT NOT NULL,
  FOREIGN KEY (series_id) REFERENCES series(series_id),
  FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);

CREATE TABLE series_network(
  series_id INT NOT NULL,
  network_id INT NOT NULL,
  FOREIGN KEY (series_id) REFERENCES series(series_id),
  FOREIGN KEY (network_id) REFERENCES network(network_id)
);

CREATE TABLE actor_award(
  actor_id INT NOT NULL,
  award_id INT NOT NULL,
  FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
  FOREIGN KEY (award_id) REFERENCES award(award_id)
);

CREATE TABLE series_award(
  series_id INT NOT NULL,
  award_id INT NOT NULL,
  FOREIGN KEY (series_id) REFERENCES series(series_id),
  FOREIGN KEY (award_id) REFERENCES award(award_id)
);

SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';
