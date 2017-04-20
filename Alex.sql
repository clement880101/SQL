  CREATE OR REPLACE FUNCTION popstdey(VARIADIC inputs NUMERIC[])
    RETURNS TABLE(
      std DECIMAL,
      popMean DECIMAL
    )AS $$
    DECLARE
      sum DECIMAL :=0;
      sum2 DECIMAL :=0;
      cnt DECIMAL :=0;
      diffsqrd DECIMAL;
      num DECIMAL;
    BEGIN
      FOR num IN SELECT unnest(inputs)
        LOOP
        sum := sum + num;
        cnt := cnt + 1;
      END LOOP;

      popMean := sum/cnt;

      FOR num IN SELECT unnest(inputs)
        LOOP
          diffsqrd := (num - popMean) ^ 2;
          sum2 := sum2 + diffsqrd;
      END LOOP;

      std := |/(sum2/cnt);

      RAISE NOTICE 'Sum: %, Counter: %, Population Mean: %', sum, cnt, popMean;
      RETURN NEXT;

    END;
    $$ LANGUAGE plpgsql;

  SELECT * FROM popstdey(70, 80, 90, 60, 50);