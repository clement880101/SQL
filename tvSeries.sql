CREATE TABLE series(
  series_id INT NOT NULL PRIMARY KEY,
  title VARCHAR(50) NOT NULL,
  year INT NOT NULL,
  language VARCHAR(50) NOT NULL,
  budget DECIMAL(15, 2) NOT NULL
);

CREATE TABLE actor(
  actor_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  nationality VARCHAR(50) NOT NULL
);

CREATE TABLE network(
  network_id INT NOT NULL PRIMARY KEY,
  network_name VARCHAR(50) NOT NULL,
  location TEXT NOT NULL
);

CREATE TABLE award(
  award_id INT NOT NULL PRIMARY KEY,
  award_name VARCHAR(50) NOT NULL,
  category VARCHAR(50) NOT NULL,
  organizer VARCHAR(50) NOT NULL
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

CREATE TEMPORARY TABLE entry(
  series_id INT,
  title VARCHAR(50),
  year INT,
  language VARCHAR(50),
  budget DECIMAL(15, 2),
  actor_id INT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  nationality VARCHAR(50),
  network_id INT,
  network_name VARCHAR(50),
  location TEXT,
  award_id INT,
  award_name VARCHAR(50),
  category VARCHAR(50),
  organizer VARCHAR(50)
);

CREATE OR REPLACE FUNCTION charlie()
RETURNS TRIGGER AS $emp_trigger$
DECLARE id_series INT;
DECLARE id_actor INT;
DECLARE id_network INT;
DECLARE id_award INT;
  BEGIN
    IF NOT EXISTS(SELECT series.series_id FROM series WHERE series.title = new.title)THEN
        IF (new.title) IS NOT NULL THEN
          INSERT INTO series VALUES (new.series_id,new.title,new.year,new.language,new.budget);
        END IF;
    END IF;

    IF NOT EXISTS(SELECT actor.actor_id FROM actor
      WHERE concat(actor.first_name, actor.last_name) = concat(new.first_name, new.last_name))THEN
        IF (new.last_name) IS NOT NULL THEN
          INSERT INTO actor VALUES (new.actor_id, new.first_name, new.last_name, new.nationality);
        END IF;
    END IF;

    IF NOT EXISTS(SELECT network.network_id FROM network WHERE network.network_name = new.network_name)THEN
      IF (new.network_name) IS NOT NULL THEN
        INSERT INTO network VALUES (new.network_id,new.network_name,new.location);
      END IF;
    END IF;

   IF NOT EXISTS(SELECT award.award_id FROM award WHERE award.award_name = new.award_name)THEN
     IF (new.award_name) IS NOT NULL THEN
        INSERT INTO award VALUES (new.award_id,new.award_name,new.category,new.organizer);
    END IF;
  END IF;

  id_series := 0;
  id_actor := 0;
  id_network := 0;
  id_award := 0;

  SELECT series.series_id INTO id_series FROM series
    WHERE series.title = new.title;

  SELECT actor.actor_id INTO id_actor FROM actor
    WHERE actor.first_name = new.first_name AND actor.last_name = new.last_name;

  SELECT network.network_id INTO id_network FROM network
    WHERE network.network_name = new.network_name;

  SELECT award.award_id INTO id_award FROM award
    WHERE award.award_name = new.award_name;

  IF (id_series, id_actor) IS NOT NULL THEN
    INSERT INTO series_actor VALUES (id_series, id_actor);
  END IF;
  IF (id_series, id_award) IS NOT NULL THEN
    INSERT INTO series_award VALUES (id_series, id_award);
  END IF;
  IF (id_series, id_network) IS NOT NULL THEN
    INSERT INTO series_network VALUES (id_series, id_network);
  END IF;
  IF (id_actor, id_award) IS NOT NULL THEN
    INSERT INTO actor_award VALUES (id_actor, id_award);
  END IF;

  RETURN new;
  END;
$emp_trigger$ LANGUAGE plpgsql;


CREATE TRIGGER updateentry
  BEFORE INSERT ON entry
  FOR EACH ROW EXECUTE PROCEDURE charlie();



INSERT INTO entry VALUES (
    1, 'Rome', 2005, 'English', 110000000, 1, 'Kevin', 'McKidd', 'British', 1, 'HBO', 'New York', 1,
  'Emmy', 'Excellence in Production Design', 'Academy of Television Arts & Sciences'
);

INSERT INTO entry (series_id, title, year ,language, budget)
VALUES (2, 'Game of Thrones', 2003, 'English', 12000000);


SELECT * FROM actor;
SELECT * FROM series_actor;
SELECT * FROM series;