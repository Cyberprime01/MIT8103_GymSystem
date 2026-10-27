# Step 6: Entity Relationship Diagram (ERD)
# Gym Membership & Fitness Tracking System

**Student:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## ER Diagram

The diagram below shows all entities in the Gym Membership &
Fitness Tracking System and how they relate to each other.
It was created using Mermaid diagram syntax.

```mermaid
erDiagram

    MEMBERSHIP_PLAN {
        int plan_id PK
        varchar plan_name
        int duration_months
        decimal price
        text description
    }

    MEMBER {
        int member_id PK
        varchar first_name
        varchar last_name
        varchar email
        varchar phone
        date date_of_birth
        date join_date
        int plan_id FK
    }

    TRAINER {
        int trainer_id PK
        varchar first_name
        varchar last_name
        varchar email
        varchar phone
        varchar specialisation
        date hire_date
    }

    FITNESS_CLASS {
        int class_id PK
        varchar class_name
        int trainer_id FK
        varchar schedule_day
        time schedule_time
        int max_capacity
    }

    CLASS_BOOKING {
        int booking_id PK
        int member_id FK
        int class_id FK
        date booking_date
        varchar status
    }

    PERSONAL_TRAINING_SESSION {
        int session_id PK
        int member_id FK
        int trainer_id FK
        date session_date
        time session_time
        int duration_mins
        text notes
    }

    WORKOUT_LOG {
        int log_id PK
        int member_id FK
        date log_date
        varchar exercise_name
        int sets
        int reps
        decimal weight_kg
        text notes
    }

    EQUIPMENT {
        int equipment_id PK
        varchar equipment_name
        date purchase_date
        date last_maintenance
        varchar condition
    }

    PAYMENT {
        int payment_id PK
        int member_id FK
        decimal amount
        date payment_date
        varchar payment_method
        varchar payment_type
    }

    MEMBERSHIP_PLAN ||--o{ MEMBER : "has"
    MEMBER ||--o{ CLASS_BOOKING : "makes"
    FITNESS_CLASS ||--o{ CLASS_BOOKING : "receives"
    TRAINER ||--o{ FITNESS_CLASS : "leads"
    MEMBER ||--o{ PERSONAL_TRAINING_SESSION : "attends"
    TRAINER ||--o{ PERSONAL_TRAINING_SESSION : "conducts"
    MEMBER ||--o{ WORKOUT_LOG : "logs"
    MEMBER ||--o{ PAYMENT : "makes"
```

---

## Explanation of Relationships

- **MEMBERSHIP_PLAN to MEMBER:** One membership plan can be assigned
  to many members but each member has only one plan at a time.

- **MEMBER to CLASS_BOOKING:** One member can make many class bookings
  over time across different fitness classes.

- **FITNESS_CLASS to CLASS_BOOKING:** One fitness class can receive
  many bookings from different members.

- **TRAINER to FITNESS_CLASS:** One trainer can lead many fitness
  classes but each class is led by one trainer.

- **MEMBER to PERSONAL_TRAINING_SESSION:** One member can attend
  many personal training sessions over time.

- **TRAINER to PERSONAL_TRAINING_SESSION:** One trainer can conduct
  many personal training sessions with different members.

- **MEMBER to WORKOUT_LOG:** One member can log many workouts
  over time to track their fitness progress.

- **MEMBER to PAYMENT:** One member can make many payments for
  membership renewals and personal training sessions.

---

## Diagram Key

- **PK** = Primary Key (unique identifier for each record)
- **FK** = Foreign Key (links to another table)
- **||--o{** = One to Many relationship
- **}o--o{** = Many to Many relationship

---

*File: MiracleIsa_301905801_P1_ERDiagram.md*
*Saved in: portfolio1/ folder*