# Step 5: Entities, Attributes, Keys and Relationships
# Gym Membership & Fitness Tracking System

**Student:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## Entities and Their Attributes

### 1. MEMBER
Stores information about gym members.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| member_id       | SERIAL       | PRIMARY KEY       |
| first_name      | VARCHAR(50)  | NOT NULL          |
| last_name       | VARCHAR(50)  | NOT NULL          |
| email           | VARCHAR(100) | UNIQUE, NOT NULL  |
| phone           | VARCHAR(20)  | NOT NULL          |
| date_of_birth   | DATE         | NOT NULL          |
| join_date       | DATE         | NOT NULL          |
| plan_id         | INT          | FOREIGN KEY       |

---

### 2. MEMBERSHIP_PLAN
Stores the different membership plans available.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| plan_id         | SERIAL       | PRIMARY KEY       |
| plan_name       | VARCHAR(50)  | NOT NULL          |
| duration_months | INT          | NOT NULL          |
| price           | DECIMAL(8,2) | NOT NULL          |
| description     | TEXT         |                   |

---

### 3. TRAINER
Stores information about gym trainers.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| trainer_id      | SERIAL       | PRIMARY KEY       |
| first_name      | VARCHAR(50)  | NOT NULL          |
| last_name       | VARCHAR(50)  | NOT NULL          |
| email           | VARCHAR(100) | UNIQUE, NOT NULL  |
| phone           | VARCHAR(20)  | NOT NULL          |
| specialisation  | VARCHAR(100) | NOT NULL          |
| hire_date       | DATE         | NOT NULL          |

---

### 4. FITNESS_CLASS
Stores group fitness classes offered by the gym.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| class_id        | SERIAL       | PRIMARY KEY       |
| class_name      | VARCHAR(100) | NOT NULL          |
| trainer_id      | INT          | FOREIGN KEY       |
| schedule_day    | VARCHAR(20)  | NOT NULL          |
| schedule_time   | TIME         | NOT NULL          |
| max_capacity    | INT          | NOT NULL          |

---

### 5. CLASS_BOOKING
Records which members have booked which fitness classes.
(This is a junction table for the many-to-many relationship
between MEMBER and FITNESS_CLASS)

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| booking_id      | SERIAL       | PRIMARY KEY       |
| member_id       | INT          | FOREIGN KEY       |
| class_id        | INT          | FOREIGN KEY       |
| booking_date    | DATE         | NOT NULL          |
| status          | VARCHAR(20)  | NOT NULL          |

---

### 6. PERSONAL_TRAINING_SESSION
Records personal training sessions between members and trainers.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| session_id      | SERIAL       | PRIMARY KEY       |
| member_id       | INT          | FOREIGN KEY       |
| trainer_id      | INT          | FOREIGN KEY       |
| session_date    | DATE         | NOT NULL          |
| session_time    | TIME         | NOT NULL          |
| duration_mins   | INT          | NOT NULL          |
| notes           | TEXT         |                   |

---

### 7. WORKOUT_LOG
Records daily workouts logged by members.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| log_id          | SERIAL       | PRIMARY KEY       |
| member_id       | INT          | FOREIGN KEY       |
| log_date        | DATE         | NOT NULL          |
| exercise_name   | VARCHAR(100) | NOT NULL          |
| sets            | INT          |                   |
| reps            | INT          |                   |
| weight_kg       | DECIMAL(5,2) |                   |
| notes           | TEXT         |                   |

---

### 8. EQUIPMENT
Stores gym equipment information for maintenance tracking.

| Attribute         | Data Type    | Constraint        |
|-------------------|--------------|-------------------|
| equipment_id      | SERIAL       | PRIMARY KEY       |
| equipment_name    | VARCHAR(100) | NOT NULL          |
| purchase_date     | DATE         | NOT NULL          |
| last_maintenance  | DATE         |                   |
| condition         | VARCHAR(50)  | NOT NULL          |

---

### 9. PAYMENT
Records all payments made by members.

| Attribute       | Data Type    | Constraint        |
|-----------------|--------------|-------------------|
| payment_id      | SERIAL       | PRIMARY KEY       |
| member_id       | INT          | FOREIGN KEY       |
| amount          | DECIMAL(8,2) | NOT NULL          |
| payment_date    | DATE         | NOT NULL          |
| payment_method  | VARCHAR(50)  | NOT NULL          |
| payment_type    | VARCHAR(50)  | NOT NULL          |

---

## Relationships Between Entities

| Relationship                              | Type         | Description                                              |
|-------------------------------------------|--------------|----------------------------------------------------------|
| MEMBER → MEMBERSHIP_PLAN                  | Many-to-One  | Many members can be on the same plan                     |
| TRAINER → FITNESS_CLASS                   | One-to-Many  | One trainer can run many classes                         |
| MEMBER ↔ FITNESS_CLASS (via CLASS_BOOKING)| Many-to-Many | Members can book many classes; classes have many members |
| MEMBER → PERSONAL_TRAINING_SESSION        | One-to-Many  | One member can have many training sessions               |
| TRAINER → PERSONAL_TRAINING_SESSION       | One-to-Many  | One trainer can conduct many training sessions           |
| MEMBER → WORKOUT_LOG                      | One-to-Many  | One member can log many workouts                         |
| MEMBER → PAYMENT                          | One-to-Many  | One member can make many payments                        |

---

## Key Types Summary

- **Primary Keys:** member_id, plan_id, trainer_id, class_id,
  booking_id, session_id, log_id, equipment_id, payment_id
- **Foreign Keys:** plan_id (in MEMBER), trainer_id (in FITNESS_CLASS),
  member_id and class_id (in CLASS_BOOKING), member_id and trainer_id
  (in PERSONAL_TRAINING_SESSION), member_id (in WORKOUT_LOG),
  member_id (in PAYMENT)
- **Unique Keys:** email (in MEMBER and TRAINER)

---

*File: MiracleIsa_301905801_P1_Entities.md*
*Saved in: portfolio1/ folder*