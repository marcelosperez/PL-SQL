-- Source:
-- Converted from standard SQL to Oracle PL/SQL
-- This PL/SQL block demonstrates an INNER JOIN between payment and customer tables
-- retrieving customer names and payment amounts where customer is active
-- Results are ordered by payment amount in descending order
-- Original SQL converted to Oracle PL/SQL format following repository conventions

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to retrieve customer payment information with INNER JOIN
    CURSOR payment_customer_cur IS
        SELECT c.first_name,
               c.last_name,
               p.amount
        FROM payment p
        INNER JOIN customer c
          ON p.customer_id = c.customer_id
        WHERE c.active IS NOT NULL
        ORDER BY p.amount DESC;
        
BEGIN
    -- Display results using cursor loop
    FOR rec IN payment_customer_cur LOOP
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.first_name || ' ' || rec.last_name || 
                            ', Payment Amount: ' || rec.amount);
    END LOOP;
END;
/