
SELECT maxmin.account_number,
       MAX (maxmin.max_amt7) max_amt7,
       MAX (maxmin.dt_max_amt7) dt_max_amt7,
       MAX (maxmin.min_amt30) min_amt30,
       MAX (maxmin.dt_min_amt30) dt_min_amt30
FROM (SELECT CASE
                 WHEN     a.transaction_date > SYSDATE - 7
                      AND MAX (a.transaction_amt)
                              OVER (
                                  PARTITION BY (CASE
                                                    WHEN a.transaction_date >
                                                         SYSDATE - 7
                                                    THEN
                                                        a.account_number
                                                END)) =
                          a.transaction_amt
                 THEN
                     a.transaction_amt
             END AS max_amt7,
             CASE
                 WHEN     a.transaction_date > SYSDATE - 7
                      AND MAX (a.transaction_amt)
                              OVER (
                                  PARTITION BY (CASE
                                                    WHEN a.transaction_date >
                                                         SYSDATE - 7
                                                    THEN
                                                        a.account_number
                                                END)) =
                          a.transaction_amt
                 THEN
                     a.transaction_date
             END AS dt_max_amt7,
             CASE
                 WHEN     a.transaction_date > SYSDATE - 30
                      AND MIN (a.transaction_amt)
                              OVER (
                                  PARTITION BY (CASE
                                                    WHEN a.transaction_date >
                                                         SYSDATE - 30
                                                    THEN
                                                        a.account_number
                                                END)) =
                          a.transaction_amt
                 THEN
                     a.transaction_amt
             END AS min_amt30,
             CASE
                 WHEN     a.transaction_date > SYSDATE - 30
                      AND MIN (a.transaction_amt)
                              OVER (
                                  PARTITION BY (CASE
                                                    WHEN a.transaction_date >
                                                         SYSDATE - 30
                                                    THEN
                                                        a.account_number
                                                END)) =
                          a.transaction_amt
                 THEN
                     a.transaction_date
             END AS dt_min_amt30,
             a.transaction_amt,
             a.transaction_date,
             a.account_number
      FROM transaction_table a) maxmin
GROUP BY account_number