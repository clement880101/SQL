CREATE OR REPLACE FUNCTION curve (VARIADIC inputs NUMERIC[])
  RETURNS FLOAT AS
  $$
  DECLARE
    sum FLOAT := 0;
    count INTEGER := 0;
    num INTEGER;
  BEGIN

    FOR num IN SELECT unnest(inputs)
      LOOP
      IF (num >= 60) THEN
        count := count + 1;
        sum := sum + num;
      END IF;
    END LOOP;

    IF(85-(sum/count) < 0) THEN
      RAISE NOTICE 'The average of the class is % and it is higher than 85 so there is no need for a curve', (sum/count);
      RETURN 0;
      FOR num IN SELECT unnest(inputs)
        LOOP
        changed = num;
        RETURN NEXT;
      END LOOP;
    ELSE
      FOR num IN SELECT unnest(inputs)
        LOOP
        changed = num + (85-(sum/count));
        RETURN NEXT;
      END LOOP;
    END IF;
  END;


  END;
$$ LANGUAGE plpgsql;


SELECT * FROM curveTable(50, 50, 50, 75, 90);