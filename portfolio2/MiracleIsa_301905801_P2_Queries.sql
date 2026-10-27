-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Student: MiracleIsa_301905801
-- Case Study: Gym Membership & Fitness Tracking System
-- File: MiracleIsa_301905801_P2_Queries.sql
-- Portfolio 2: SQL Queries & Optimisation
-- ============================================================

-- ============================================================
-- SECTION 1: BASIC SELECT QUERIES
-- ============================================================

-- Query 1: List all members with their membership plan
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email,
    mp.plan_name,
    mp.price
FROM member m
JOIN membership_plan mp ON m.plan_id = mp.plan_id
ORDER BY m.member_id;

-- Query 2: List all fitness classes with trainer names
SELECT
    fc.class_id,
    fc.class_name,
    fc.schedule_day,
    fc.schedule_time,
    fc.max_capacity,
    t.first_name || ' ' || t.last_name AS trainer_name
FROM fitness_class fc
JOIN trainer t ON fc.trainer_id = t.trainer_id
ORDER BY fc.schedule_day;

-- Query 3: Show all bookings with member and class details
SELECT
    cb.booking_id,
    m.first_name || ' ' || m.last_name AS member_name,
    fc.class_name,
    fc.schedule_day,
    cb.booking_date,
    cb.status
FROM class_booking cb
JOIN member m ON cb.member_id = m.member_id
JOIN fitness_class fc ON cb.class_id = fc.class_id
ORDER BY cb.booking_date;

-- ============================================================
-- SECTION 2: AGGREGATE QUERIES
-- ============================================================

-- Query 4: Count how many members are on each plan
SELECT
    mp.plan_name,
    COUNT(m.member_id) AS total_members,
    mp.price
FROM membership_plan mp
LEFT JOIN member m ON mp.plan_id = m.plan_id
GROUP BY mp.plan_name, mp.price
ORDER BY total_members DESC;

-- Query 5: Total revenue collected per payment type
SELECT
    payment_type,
    payment_method,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_revenue
FROM payment
GROUP BY payment_type, payment_method
ORDER BY total_revenue DESC;

-- Query 6: Number of bookings per fitness class
SELECT
    fc.class_name,
    fc.schedule_day,
    COUNT(cb.booking_id) AS total_bookings,
    fc.max_capacity,
    (fc.max_capacity - COUNT(cb.booking_id)) AS spots_remaining
FROM fitness_class fc
LEFT JOIN class_booking cb ON fc.class_id = cb.class_id
    AND cb.status = 'Confirmed'
GROUP BY fc.class_id, fc.class_name, fc.schedule_day, fc.max_capacity
ORDER BY total_bookings DESC;

-- ============================================================
-- SECTION 3: FILTERING & SORTING QUERIES
-- ============================================================

-- Query 7: Find all Premium plan members
SELECT
    m.first_name,
    m.last_name,
    m.email,
    m.join_date,
    mp.plan_name
FROM member m
JOIN membership_plan mp ON m.plan_id = mp.plan_id
WHERE mp.plan_name = 'Premium'
ORDER BY m.join_date;

-- Query 8: Find all confirmed bookings for a specific member
SELECT
    m.first_name || ' ' || m.last_name AS member_name,
    fc.class_name,
    fc.schedule_day,
    fc.schedule_time,
    cb.booking_date,
    cb.status
FROM class_booking cb
JOIN member m ON cb.member_id = m.member_id
JOIN fitness_class fc ON cb.class_id = fc.class_id
WHERE m.first_name = 'Miracle'
AND cb.status = 'Confirmed';

-- Query 9: Equipment that needs maintenance
-- (last maintained more than 60 days ago)
SELECT
    equipment_name,
    purchase_date,
    last_maintenance,
    condition,
    CURRENT_DATE - last_maintenance AS days_since_maintenance
FROM equipment
WHERE CURRENT_DATE - last_maintenance > 60
ORDER BY days_since_maintenance DESC;

-- ============================================================
-- SECTION 4: SUBQUERY & ADVANCED QUERIES
-- ============================================================

-- Query 10: Members who have never booked a class
SELECT
    m.member_id,
    m.first_name,
    m.last_name,
    m.email
FROM member m
WHERE m.member_id NOT IN (
    SELECT DISTINCT member_id FROM class_booking
);

-- Query 11: Trainer with the most personal training sessions
SELECT
    t.first_name || ' ' || t.last_name AS trainer_name,
    t.specialisation,
    COUNT(pts.session_id) AS total_sessions
FROM trainer t
LEFT JOIN personal_training_session pts ON t.trainer_id = pts.trainer_id
GROUP BY t.trainer_id, t.first_name, t.last_name, t.specialisation
ORDER BY total_sessions DESC
LIMIT 1;

-- Query 12: Member workout summary
SELECT
    m.first_name || ' ' || m.last_name AS member_name,
    COUNT(wl.log_id) AS total_workouts,
    MAX(wl.log_date) AS last_workout_date,
    AVG(wl.weight_kg) AS avg_weight_lifted
FROM member m
LEFT JOIN workout_log wl ON m.member_id = wl.member_id
GROUP BY m.member_id, m.first_name, m.last_name
ORDER BY total_workouts DESC;

-- ============================================================
-- SECTION 5: EXECUTION PLAN & INDEX OPTIMISATION
-- ============================================================

-- Step 1: Check execution plan BEFORE adding index
EXPLAIN ANALYZE
SELECT * FROM member WHERE email = 'miracle.isa@email.com';

-- Step 2: Create an index on email column
CREATE INDEX idx_member_email ON member(email);

-- Step 3: Create index on class_booking for faster lookups
CREATE INDEX idx_booking_member ON class_booking(member_id);

-- Step 4: Create index on payment for member lookups
CREATE INDEX idx_payment_member ON payment(member_id);

-- Step 5: Check execution plan AFTER adding index
-- Notice it now uses "Index Scan" instead of "Seq Scan"
EXPLAIN ANALYZE
SELECT * FROM member WHERE email = 'miracle.isa@email.com';

-- Step 6: List all indexes created
SELECT
    indexname,
    tablename,
    indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename;