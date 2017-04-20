CREATE OR REPLACE FUNCTION improve(score INT)
  RETURNS BOOLEAN AS
$$
  DECLARE
    prevAvg DECIMAL;
    sum INTEGER := 0;
    cnt INTEGER := 0;
    num INTEGER;
  BEGIN
    FOR num IN SELECT * FROM randTable(5)
      LOOP
        cnt := cnt + 1;
        sum := sum + num;
    END LOOP;

    prevAvg := sum/cnt;
    IF score > prevAvg THEN
      RAISE NOTICE 'The student has improved';
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    END IF;
  END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION randTable(numValues INT)
  RETURNS TABLE(
  number INTEGER
  )AS $$
  BEGIN
  FOR x in 0..numValues LOOP
    number:= trunc(random()*100);
    RETURN NEXT;
  END LOOP;
  END;
  $$LANGUAGE plpgsql;