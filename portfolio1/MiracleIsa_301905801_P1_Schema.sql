-- ============================================================
-- MIT 8103 Advanced Database Systems
-- Student: MiracleIsa_301905801
-- Case Study: Gym Membership & Fitness Tracking System
-- File: MiracleIsa_301905801_P1_Schema.sql
-- Step 8: Database Schema - Create All Tables
-- ============================================================

-- Create and connect to the database
-- Run this first in psql:
-- CREATE DATABASE fitlife_gym;
-- \c fitlife_gym

-- ============================================================
-- TABLE 1: MEMBERSHIP_PLAN
-- Created first because MEMBER references it
-- ============================================================
CREATE TABLE membership_plan (
    plan_id       SERIAL PRIMARY KEY,
    plan_name     VARCHAR(50)   NOT NULL,
    duration_months INT         NOT NULL,
    price         DECIMAL(8,2)  NOT NULL,
    description   TEXT
);

-- ============================================================
-- TABLE 2: MEMBER
-- ============================================================
CREATE TABLE member (
    member_id     SERIAL PRIMARY KEY,
    first_name    VARCHAR(50)   NOT NULL,
    last_name     VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    phone         VARCHAR(20)   NOT NULL,
    date_of_birth DATE          NOT NULL,
    join_date     DATE          NOT NULL DEFAULT CURRENT_DATE,
    plan_id       INT           REFERENCES membership_plan(plan_id)
);

-- ============================================================
-- TABLE 3: TRAINER
-- ============================================================
CREATE TABLE trainer (
    trainer_id    SERIAL PRIMARY KEY,
    first_name    VARCHAR(50)   NOT NULL,
    last_name     VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    phone         VARCHAR(20)   NOT NULL,
    specialisation VARCHAR(100) NOT NULL,
    hire_date     DATE          NOT NULL
);

-- ============================================================
-- TABLE 4: FITNESS_CLASS
-- ============================================================
CREATE TABLE fitness_class (
    class_id      SERIAL PRIMARY KEY,
    class_name    VARCHAR(100)  NOT NULL,
    trainer_id    INT           REFERENCES trainer(trainer_id),
    schedule_day  VARCHAR(20)   NOT NULL,
    schedule_time TIME          NOT NULL,
    max_capacity  INT           NOT NULL
);

-- ============================================================
-- TABLE 5: CLASS_BOOKING
-- Junction table for MEMBER and FITNESS_CLASS (many-to-many)
-- ============================================================
CREATE TABLE class_booking (
    booking_id    SERIAL PRIMARY KEY,
    member_id     INT           NOT NULL REFERENCES member(member_id),
    class_id      INT           NOT NULL REFERENCES fitness_class(class_id),
    booking_date  DATE          NOT NULL DEFAULT CURRENT_DATE,
    status        VARCHAR(20)   NOT NULL DEFAULT 'Confirmed'
);

-- ============================================================
-- TABLE 6: PERSONAL_TRAINING_SESSION
-- ============================================================
CREATE TABLE personal_training_session (
    session_id    SERIAL PRIMARY KEY,
    member_id     INT           NOT NULL REFERENCES member(member_id),
    trainer_id    INT           NOT NULL REFERENCES trainer(trainer_id),
    session_date  DATE          NOT NULL,
    session_time  TIME          NOT NULL,
    duration_mins INT           NOT NULL,
    notes         TEXT
);

-- ============================================================
-- TABLE 7: WORKOUT_LOG
-- ============================================================
CREATE TABLE workout_log (
    log_id        SERIAL PRIMARY KEY,
    member_id     INT           NOT NULL REFERENCES member(member_id),
    log_date      DATE          NOT NULL DEFAULT CURRENT_DATE,
    exercise_name VARCHAR(100)  NOT NULL,
    sets          INT,
    reps          INT,
    weight_kg     DECIMAL(5,2),
    notes         TEXT
);

-- ============================================================
-- TABLE 8: EQUIPMENT
-- ============================================================
CREATE TABLE equipment (
    equipment_id      SERIAL PRIMARY KEY,
    equipment_name    VARCHAR(100)  NOT NULL,
    purchase_date     DATE          NOT NULL,
    last_maintenance  DATE,
    condition         VARCHAR(50)   NOT NULL DEFAULT 'Good'
);

-- ============================================================
-- TABLE 9: PAYMENT
-- ============================================================
CREATE TABLE payment (
    payment_id      SERIAL PRIMARY KEY,
    member_id       INT           NOT NULL REFERENCES member(member_id),
    amount          DECIMAL(8,2)  NOT NULL,
    payment_date    DATE          NOT NULL DEFAULT CURRENT_DATE,
    payment_method  VARCHAR(50)   NOT NULL,
    payment_type    VARCHAR(50)   NOT NULL
);

-- ============================================================
-- VERIFY ALL TABLES WERE CREATED
-- ============================================================
\dt

-- ============================================================
-- CHECK STRUCTURE OF KEY TABLES
-- ============================================================
\d member
\d fitness_class
\d class_booking