-- Start of DDL Script for Package SCOTT.TASK
-- Generated 05-Apr-2019 23:44:59 from SCOTT@ORCL

CREATE OR REPLACE 
PACKAGE task
  IS

   PROCEDURE CalculateAge
    ( age       IN integer DEFAULT 1,
      text      OUT varchar2);
   FUNCTION CalculatePi
    ( precision  IN integer) return number;
END; -- Package spec
/



-- End of DDL Script for Package SCOTT.TASK

