CREATE OR REPLACE FUNCTION findoutlier(VARIADIC input NUMERIC[])
  RETURNS SETOF NUMERIC AS $$
  DECLARE
    firstq NUMERIC;
    thridq NUMERIC;
    IQR NUMERIC;
    n NUMERIC;
    num NUMERIC := 0;
    arr NUMERIC[];
  BEGIN
    FOR n IN SELECT unnest(input) AS x ORDER BY x  LOOP
      arr[num] := n;
      num := num + 1;
    END LOOP;

    IF num%2 = 0 THEN
      IF (num/2)%2 = 0 THEN
        firstq := (arr[num/4 +1] + arr[num/4])/2.0;
        thridq := (arr[num*3/4 - 1] + arr[num*3/4])/2.0;
      ELSE
        firstq := arr[(num/2 - 1)/2];
        thridq := arr[(num/2 - 1)/2 + num/2];
      END IF;
    ELSE
      IF ((num - 1)/2)%2 = 0 THEN
        firstq := (arr[(num - 1)/4 - 1] + arr[(num -1)/4])/2.0;
        thridq := (arr[(num - 1)*3/4] + arr[(num -1)*3/4 + 1])/2.0;
      ELSE
        firstq := arr[((num - 1)/2 - 1)/2];
        thridq := arr[((num - 1)/2 - 1)/2 + (num-1)/2 +1];
      END IF;
    END IF;


    IQR := thridq - firstq;
    FOR n IN SELECT unnest(arr) LOOP
      IF n < firstq - 1.5*IQR OR n > thridq + 1.5*IQR THEN
        RETURN NEXT n;
      END IF;
    END LOOP;
  END;
  $$