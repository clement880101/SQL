DROP FUNCTION IF EXISTS product(a INTEGER, b INTEGER);
DROP FUNCTION IF EXISTS fib(num INTEGER);
DROP FUNCTION IF EXISTS text(a VARCHAR(30), b VARCHAR(30));
DROP FUNCTION IF EXISTS email(firstname VARCHAR(30), lastname VARCHAR(30), dmain VARCHAR(30));
DROP FUNCTION IF EXISTS oppemail(fname VARCHAR(30), email VARCHAR(90));
DROP FUNCTION IF EXISTS mymimo(a INT, b INT, c INT);
DROP FUNCTION IF EXISTS ave_total(VARIADIC inputs NUMERIC[]);

CREATE FUNCTION product(a INTEGER, b INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    RETURN a * b;
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION fib(num_terms INTEGER)
  RETURNS INTEGER AS
  $$
  BEGIN
    if num_terms < 2 THEN
      RETURN num_terms;
    ELSE
      RETURN fib(num_terms - 2) + fib(num_terms -1);
    END IF;
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION text(a VARCHAR(30), b VARCHAR(30))
  RETURNS VARCHAR(60) AS
  $$
  BEGIN
    RETURN concat(initcap(a), initcap(b));
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION email(firstname VARCHAR(30), lastname VARCHAR(30), dmain VARCHAR(30) DEFAULT 'pas.org')
  RETURNS VARCHAR(90) AS
  $$
  BEGIN
    RETURN concat(concat(concat(concat(substr(firstname, 1, 1), '.'), lastname), '@'), dmain);
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION mymimo(a INT, b INT, c INT,
                        OUT total INT, OUT maximum INT) AS
  $$
  BEGIN
    total := a + b + c;
    maximum := greatest(a, b, c);
  END;
  $$ LANGUAGE plpgsql;

CREATE FUNCTION oppemail(fname VARCHAR(30), email VARCHAR(90),
                          OUT dmain VARCHAR(30), OUT lastname VARCHAR(30), OUT firstname VARCHAR(30)) AS
  $$
  BEGIN
    firstname := initcap(fname);
    dmain := split_part(email, '@', 2);
    lastname := initcap(split_part(split_part(email,'.', 2),'@' ,1));
  END;
  $$ LANGUAGE plpgsql;


CREATE FUNCTION ave_total(VARIADIC inputs NUMERIC[], OUT total NUMERIC, OUT average NUMERIC)AS
  $$
  DECLARE
    val NUMERIC;
    count NUMERIC := 0;
    tot NUMERIC := 0;
  BEGIN
   FOR val IN SELECT unnest(inputs)
     LOOP
     count := count + 1;
     tot := tot + val;
   END LOOP;
  total = tot;
  average =  tot/count;
  END;
  $$LANGUAGE plpgsql;


-- Run
SELECT * FROM product(4,5);
SELECT fib(11);
SELECT text('car', 'boo');
SELECT email('clement', 'chang', 'gmail.com');
SELECT mymimo(1, 2, 43);
SELECT oppemail('clement' ,email('clement', 'chang'));
SELECT * FROM ave_total(1,2,2,1,1,1,2,2,2,3);
