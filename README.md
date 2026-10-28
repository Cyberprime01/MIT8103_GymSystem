# MIT8103_GymSystem
## MIT 8103 Advanced Database Systems
### Gym Membership & Fitness Tracking System

**Student:** Miracle Isa
**Student ID:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## Case Study Overview

This repository contains the complete database systems assessment
for the Gym Membership & Fitness Tracking System (FitLife Gym).
The project demonstrates database design, SQL implementation,
NoSQL modelling, and distributed database concepts using a
real-world gym management scenario.

---

## Repository Structure

```
MIT8103_GymSystem/
│
├── portfolio1/          # Database Design & PostgreSQL Implementation
│   ├── MiracleIsa_301905801_P1_CaseStudy.md
│   ├── MiracleIsa_301905801_P1_Entities.md
│   ├── MiracleIsa_301905801_P1_ERDiagram.md
│   ├── MiracleIsa_301905801_P1_Normalisation.md
│   ├── MiracleIsa_301905801_P1_Schema.sql
│   └── MiracleIsa_301905801_P1_SampleData.sql
│
├── portfolio2/          # SQL Queries & Optimisation
│
├── portfolio3/          # Transactions & Concurrency
│
├── portfolio4/          # NoSQL / MongoDB
│
├── portfolio5/          # Distributed & Cloud Databases
│
├── docs/                # Supporting documentation
├── images/              # Screenshots and diagrams
└── README.md            # This file
```

---

## Portfolio 1 — Database Design & Implementation ✅

### What Was Completed
- Designed a fully normalised relational database for FitLife Gym
- Created 9 entities with proper primary keys, foreign keys,
  and constraints
- Produced an ER Diagram using Mermaid syntax
- Applied 1NF, 2NF, and 3NF normalisation
- Implemented the schema in PostgreSQL using GitHub Codespaces
- Inserted realistic sample data across all 9 tables

### Database: fitlife_gym
### Tables Created

| Table | Description | Rows |
|---|---|---|
| membership_plan | Gym membership plans | 3 |
| member | Gym member profiles | 6 |
| trainer | Trainer profiles | 4 |
| fitness_class | Group fitness classes | 6 |
| class_booking | Member class bookings | 10 |
| personal_training_session | 1-on-1 trainer sessions | 5 |
| workout_log | Daily workout records | 8 |
| equipment | Gym equipment inventory | 8 |
| payment | Member payment records | 8 |

### Technologies Used
- PostgreSQL 16
- GitHub Codespaces
- Mermaid (ER Diagram)
- Git & GitHub

---

## Portfolio 2 — SQL Queries & Optimisation 🔄

*Coming soon*

---

## Portfolio 3 — Transactions & Concurrency 🔄

*Coming soon*

---

## Portfolio 4 — NoSQL / MongoDB 🔄

*Coming soon*

---

## Portfolio 5 — Distributed & Cloud Databases 🔄

*Coming soon*

---

## How to Run This Project

### Prerequisites
- GitHub Codespaces
- PostgreSQL 16

### Setup Instructions

1. Clone this repository
2. Open in GitHub Codespaces
3. Install PostgreSQL:
```bash
sudo apt-get install -y postgresql postgresql-contrib
sudo service postgresql start
```
4. Configure PostgreSQL access:
```bash
sudo sed -i 's/peer/trust/g' /etc/postgresql/16/main/pg_hba.conf
sudo sed -i 's/md5/trust/g' /etc/postgresql/16/main/pg_hba.conf
sudo service postgresql restart
```
5. Create and set up the database:
```bash
psql -U postgres -c "CREATE DATABASE fitlife_gym;"
psql -U postgres -d fitlife_gym -f portfolio1/MiracleIsa_301905801_P1_Schema.sql
psql -U postgres -d fitlife_gym -f portfolio1/MiracleIsa_301905801_P1_SampleData.sql
```

---

*MIT 8103 Advanced Database Systems | Miva Open University*
*Student: MiracleIsa_301905801*
