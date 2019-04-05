-- Start of DDL Script for Package Body SCOTT.TASK
-- Generated 05-Apr-2019 23:44:21 from SCOTT@ORCL

CREATE OR REPLACE 
PACKAGE BODY task

IS
    PROCEDURE CalculateAge (age IN INTEGER DEFAULT 1, text OUT VARCHAR2)
    IS
    BEGIN
        IF age > 0 AND age < 7
        THEN
            text := 'You are infant';
        ELSIF age >= 7 AND age < 18
        THEN
            text := 'You are schoolchild';
        ELSIF age >= 18 AND age < 40
        THEN
            text := 'You are adult';
        ELSIF age >= 40 AND age < 55
        THEN
            text := 'You are in middle-age';
        ELSIF age >= 55
        THEN
            text := 'You are aged';
        ELSE
            text := 'No such age!!';
        END IF;
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('Error in function: CalculateAge');
            DBMS_OUTPUT.put_line ('input params:' || age);
    END;

    FUNCTION CalculatePi (precision IN INTEGER)
        RETURN NUMBER
    IS
        res        NUMBER := 0;
        res_prev   NUMBER := -1;
        i          INTEGER := 0;
    BEGIN
        DELETE FROM LOG;

        WHILE ROUND(res_prev,precision)<>round(res,precision)
        LOOP
            res_prev:=res;
            res :=
                  res
                +   1
                  / POWER (16, i)
                  * (  4 / (8 * i + 1)
                     - 2 / (8 * i + 4)
                     - 1 / (8 * i + 5)
                     - 1 / (8 * i + 6));

            i := i + 1;

            INSERT INTO LOG (transaction_date, transaction_amt)
            VALUES (SYSDATE, res);

        END LOOP;

        RETURN res;
    EXCEPTION
        WHEN OTHERS
        THEN
            DBMS_OUTPUT.put_line ('Error in function: CalculatePi');
            DBMS_OUTPUT.put_line ('input params:' || precision);
            DBMS_OUTPUT.put_line (SQLERRM);
            DBMS_OUTPUT.put_line(DBMS_UTILITY.format_call_stack);
            RETURN -1;
    END;
END;
/



-- End of DDL Script for Package Body SCOTT.TASK

