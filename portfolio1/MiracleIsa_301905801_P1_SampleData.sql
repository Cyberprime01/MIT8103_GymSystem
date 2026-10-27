-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Student: MiracleIsa_301905801
-- Case Study: Gym Membership & Fitness Tracking System
-- File: MiracleIsa_301905801_P1_SampleData.sql
-- Step 9: Insert Sample Data & Test
-- ============================================================

-- ============================================================
-- INSERT MEMBERSHIP PLANS
-- ============================================================
INSERT INTO membership_plan (plan_name, duration_months, price, description) VALUES
('Basic',    1,  5000.00, 'Access to gym floor and basic equipment only'),
('Standard', 3,  12000.00, 'Access to gym floor, equipment and group classes'),
('Premium',  12, 40000.00, 'Full access including personal training sessions');

-- ============================================================
-- INSERT TRAINERS
-- ============================================================
INSERT INTO trainer (first_name, last_name, email, phone, specialisation, hire_date) VALUES
('Chidi',    'Okonkwo',  'chidi.okonkwo@fitlifegym.com',  '08031234567', 'Strength & Conditioning', '2021-03-15'),
('Amara',    'Nwosu',    'amara.nwosu@fitlifegym.com',    '08097654321', 'Yoga & Flexibility',      '2022-01-10'),
('Emeka',    'Eze',      'emeka.eze@fitlifegym.com',      '08112345678', 'HIIT & Cardio',           '2020-06-20'),
('Fatima',   'Aliyu',    'fatima.aliyu@fitlifegym.com',   '08023456789', 'Cycling & Endurance',     '2023-02-01');

-- ============================================================
-- INSERT MEMBERS
-- ============================================================
INSERT INTO member (first_name, last_name, email, phone, date_of_birth, join_date, plan_id) VALUES
('Miracle',  'Isa',       'miracle.isa@email.com',       '08051234567', '1998-05-12', '2024-01-05', 3),
('Belema',   'Benstowe',  'belema.benstowe@email.com',   '08067654321', '2000-03-22', '2024-02-10', 2),
('Tunde',    'Adeyemi',   'tunde.adeyemi@email.com',     '08079876543', '1995-11-08', '2024-01-20', 1),
('Ngozi',    'Okafor',    'ngozi.okafor@email.com',      '08034567890', '1997-07-15', '2024-03-01', 2),
('Hassan',   'Musa',      'hassan.musa@email.com',       '08045678901', '1992-09-30', '2024-01-15', 3),
('Chioma',   'Obi',       'chioma.obi@email.com',        '08056789012', '2001-04-18', '2024-02-28', 1);

-- ============================================================
-- INSERT FITNESS CLASSES
-- ============================================================
INSERT INTO fitness_class (class_name, trainer_id, schedule_day, schedule_time, max_capacity) VALUES
('Morning Yoga',      2, 'Monday',    '07:00:00', 15),
('HIIT Blast',        3, 'Tuesday',   '18:00:00', 20),
('Cycling Express',   4, 'Wednesday', '06:30:00', 12),
('Strength Basics',   1, 'Thursday',  '17:00:00', 20),
('Evening Yoga',      2, 'Friday',    '19:00:00', 15),
('Weekend HIIT',      3, 'Saturday',  '09:00:00', 25);

-- ============================================================
-- INSERT CLASS BOOKINGS
-- ============================================================
INSERT INTO class_booking (member_id, class_id, booking_date, status) VALUES
(1, 1, '2024-04-01', 'Confirmed'),
(1, 2, '2024-04-02', 'Confirmed'),
(2, 1, '2024-04-01', 'Confirmed'),
(2, 3, '2024-04-03', 'Confirmed'),
(3, 4, '2024-04-04', 'Confirmed'),
(4, 5, '2024-04-05', 'Confirmed'),
(5, 2, '2024-04-02', 'Cancelled'),
(5, 6, '2024-04-06', 'Confirmed'),
(6, 1, '2024-04-01', 'Confirmed'),
(6, 4, '2024-04-04', 'Confirmed');

-- ============================================================
-- INSERT PERSONAL TRAINING SESSIONS
-- ============================================================
INSERT INTO personal_training_session (member_id, trainer_id, session_date, session_time, duration_mins, notes) VALUES
(1, 1, '2024-04-08', '10:00:00', 60, 'Focus on chest and shoulders'),
(1, 1, '2024-04-10', '10:00:00', 60, 'Leg day — squats and lunges'),
(5, 1, '2024-04-09', '11:00:00', 45, 'Core strengthening session'),
(5, 3, '2024-04-11', '16:00:00', 60, 'Cardio endurance training'),
(2, 2, '2024-04-08', '09:00:00', 60, 'Beginner yoga — flexibility focus');

-- ============================================================
-- INSERT WORKOUT LOGS
-- ============================================================
INSERT INTO workout_log (member_id, log_date, exercise_name, sets, reps, weight_kg, notes) VALUES
(1, '2024-04-01', 'Bench Press',    4, 10, 80.00, 'Felt strong today'),
(1, '2024-04-02', 'Squat',          4, 12, 100.00, 'Personal best!'),
(1, '2024-04-03', 'Pull Up',        3, 8,  0.00,  'Bodyweight only'),
(2, '2024-04-01', 'Treadmill Run',  1, 30, 0.00,  '30 minutes at 8km/h'),
(2, '2024-04-03', 'Plank',          3, 1,  0.00,  '60 seconds each set'),
(3, '2024-04-02', 'Deadlift',       3, 8,  120.00,'Working on form'),
(5, '2024-04-01', 'Shoulder Press', 4, 10, 60.00, 'Good session'),
(5, '2024-04-04', 'Barbell Row',    4, 10, 70.00, 'Back focused day');

-- ============================================================
-- INSERT EQUIPMENT
-- ============================================================
INSERT INTO equipment (equipment_name, purchase_date, last_maintenance, condition) VALUES
('Treadmill 1',      '2020-01-15', '2024-03-01', 'Good'),
('Treadmill 2',      '2020-01-15', '2024-03-01', 'Good'),
('Bench Press Rack', '2019-06-10', '2024-02-15', 'Excellent'),
('Squat Rack',       '2019-06-10', '2024-02-15', 'Excellent'),
('Cycling Bike 1',   '2021-03-20', '2024-03-10', 'Good'),
('Cycling Bike 2',   '2021-03-20', '2024-03-10', 'Fair'),
('Yoga Mat Set',     '2022-01-05', '2024-01-20', 'Good'),
('Dumbbells Set',    '2019-01-01', '2024-02-01', 'Excellent');

-- ============================================================
-- INSERT PAYMENTS
-- ============================================================
INSERT INTO payment (member_id, amount, payment_date, payment_method, payment_type) VALUES
(1, 40000.00, '2024-01-05', 'Bank Transfer', 'Membership Fee'),
(2, 12000.00, '2024-02-10', 'Card',          'Membership Fee'),
(3,  5000.00, '2024-01-20', 'Cash',          'Membership Fee'),
(4, 12000.00, '2024-03-01', 'Card',          'Membership Fee'),
(5, 40000.00, '2024-01-15', 'Bank Transfer', 'Membership Fee'),
(6,  5000.00, '2024-02-28', 'Cash',          'Membership Fee'),
(1, 15000.00, '2024-04-08', 'Card',          'Personal Training'),
(5, 15000.00, '2024-04-09', 'Bank Transfer', 'Personal Training');

-- ============================================================
-- VERIFY ALL DATA WAS INSERTED
-- ============================================================
SELECT 'membership_plan' AS table_name, COUNT(*) AS total_rows FROM membership_plan
UNION ALL
SELECT 'member',                    COUNT(*) FROM member
UNION ALL
SELECT 'trainer',                   COUNT(*) FROM trainer
UNION ALL
SELECT 'fitness_class',             COUNT(*) FROM fitness_class
UNION ALL
SELECT 'class_booking',             COUNT(*) FROM class_booking
UNION ALL
SELECT 'personal_training_session', COUNT(*) FROM personal_training_session
UNION ALL
SELECT 'workout_log',               COUNT(*) FROM workout_log
UNION ALL
SELECT 'equipment',                 COUNT(*) FROM equipment
UNION ALL
SELECT 'payment',                   COUNT(*) FROM payment;