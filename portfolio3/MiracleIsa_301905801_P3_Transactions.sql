-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Student: MiracleIsa_301905801
-- Case Study: Gym Membership & Fitness Tracking System
-- File: MiracleIsa_301905801_P3_Transactions.sql
-- Portfolio 3: Transactions & Concurrency Control
-- ============================================================

-- ============================================================
-- WHAT IS A TRANSACTION?
-- A transaction is a group of SQL operations that are treated
-- as one single unit. Either ALL operations succeed (COMMIT)
-- or ALL are cancelled (ROLLBACK). This ensures data integrity.
-- ============================================================

-- ============================================================
-- SECTION 1: SUCCESSFUL TRANSACTION WITH COMMIT
-- Scenario: A new member joins and makes their first payment.
-- Both the member record AND payment must be saved together.
-- ============================================================

BEGIN;

    -- Step 1: Add new member
    INSERT INTO member (first_name, last_name, email, phone,
        date_of_birth, join_date, plan_id)
    VALUES ('Chukwuemeka', 'Obi', 'chukwu.obi@email.com',
        '08099887766', '1994-08-25', CURRENT_DATE, 2);

    -- Step 2: Record their membership payment
    INSERT INTO payment (member_id, amount, payment_date,
        payment_method, payment_type)
    VALUES (
        (SELECT member_id FROM member WHERE email = 'chukwu.obi@email.com'),
        12000.00, CURRENT_DATE, 'Card', 'Membership Fee'
    );

    -- Step 3: Verify both records before committing
    SELECT member_id, first_name, last_name, email
    FROM member WHERE email = 'chukwu.obi@email.com';

    SELECT payment_id, member_id, amount, payment_type
    FROM payment WHERE member_id = (
        SELECT member_id FROM member
        WHERE email = 'chukwu.obi@email.com'
    );

-- Step 4: Commit - saves both records permanently
COMMIT;

-- Confirm commit was successful
SELECT 'Transaction 1 COMMITTED successfully' AS status;

-- ============================================================
-- SECTION 2: FAILED TRANSACTION WITH ROLLBACK
-- Scenario: Trying to book a class for a member that does
-- not exist. The booking should be rejected and rolled back.
-- ============================================================

BEGIN;

    -- Step 1: Try to insert a booking for member_id = 999
    -- (this member does not exist in the database)
    INSERT INTO class_booking (member_id, class_id,
        booking_date, status)
    VALUES (999, 1, CURRENT_DATE, 'Confirmed');

-- Step 2: Rollback because member_id 999 does not exist
-- In a real system this would be caught automatically
-- by the foreign key constraint
ROLLBACK;

-- Confirm rollback
SELECT 'Transaction 2 ROLLED BACK - member does not exist' AS status;

-- ============================================================
-- SECTION 3: SAVEPOINT TRANSACTION
-- Scenario: Processing multiple bookings. If one fails,
-- only roll back to the savepoint, not the whole transaction.
-- ============================================================

BEGIN;

    -- Book first class successfully
    INSERT INTO class_booking (member_id, class_id,
        booking_date, status)
    VALUES (3, 2, CURRENT_DATE, 'Confirmed');

    -- Create a savepoint after first successful booking
    SAVEPOINT after_first_booking;

    -- Book second class successfully
    INSERT INTO class_booking (member_id, class_id,
        booking_date, status)
    VALUES (4, 3, CURRENT_DATE, 'Confirmed');

    -- Create another savepoint
    SAVEPOINT after_second_booking;

    -- Try a third booking - intentional mistake for demo
    -- Rolling back to savepoint if needed
    ROLLBACK TO SAVEPOINT after_second_booking;

    -- Confirm what we are committing
    SELECT booking_id, member_id, class_id, status
    FROM class_booking
    WHERE booking_date = CURRENT_DATE;

COMMIT;

SELECT 'Transaction 3 with SAVEPOINT completed' AS status;

-- ============================================================
-- SECTION 4: CONCURRENCY CONTROL DEMONSTRATION
-- Scenario: Two sessions trying to update the same record.
-- We use FOR UPDATE to lock the row during a transaction.
-- ============================================================

-- SESSION 1 (Run this first in Terminal 1):
-- This locks the member record while updating plan

BEGIN;

    -- Lock the row to prevent other sessions changing it
    SELECT * FROM member
    WHERE member_id = 1
    FOR UPDATE;

    -- Update member to a new plan
    UPDATE member
    SET plan_id = 1
    WHERE member_id = 1;

    -- Simulate some processing delay
    -- In real life another session would be blocked here

COMMIT;

SELECT 'Concurrency test - row lock released' AS status;

-- ============================================================
-- SECTION 5: ISOLATION LEVEL DEMONSTRATION
-- Setting transaction isolation to prevent dirty reads
-- ============================================================

-- Set isolation level to SERIALIZABLE (highest level)
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    -- Read member data at this exact point in time
    -- Even if another session changes data, we see
    -- the consistent snapshot from when we started
    SELECT
        m.member_id,
        m.first_name || ' ' || m.last_name AS full_name,
        mp.plan_name,
        mp.price
    FROM member m
    JOIN membership_plan mp ON m.plan_id = mp.plan_id
    ORDER BY m.member_id;

COMMIT;

SELECT 'Isolation level SERIALIZABLE transaction complete' AS status;

-- ============================================================
-- SECTION 6: VERIFY FINAL STATE OF DATABASE
-- ============================================================

-- Check total records in key tables after all transactions
SELECT 'member' AS table_name, COUNT(*) AS total FROM member
UNION ALL
SELECT 'class_booking', COUNT(*) FROM class_booking
UNION ALL
SELECT 'payment', COUNT(*) FROM payment;