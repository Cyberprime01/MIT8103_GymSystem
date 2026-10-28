# MIT 8103 Advanced Database Systems
# Final Summary Document

**Student Name:** Miracle Isa
**Student ID:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems
**Case Study:** Gym Membership & Fitness Tracking System
**GitHub Repository:** https://github.com/Cyberprime01/MIT8103_GymSystem
**Submission Date:** October 2026

---

## 1. Overview

This document provides a comprehensive summary of the work
completed across all five portfolios for the MIT 8103 Advanced
Database Systems continuous assessment. The case study chosen
is the FitLife Gym — a Gym Membership and Fitness Tracking
System designed to manage members, trainers, fitness classes,
workout logs, equipment, and payments for a gym business
operating in Nigeria.

The project was implemented entirely using GitHub Codespaces,
PostgreSQL 16, and MongoDB (7.0), with all work version-
controlled and documented on GitHub.

---

## 2. Portfolio Summaries

### Portfolio 1 — Database Design & PostgreSQL Implementation
**Marks available: 7**

This portfolio covered the complete design and implementation
of a relational database for FitLife Gym. The work included:

- A detailed case study description identifying the business
  problem and scope of the database system
- Identification of 9 entities with all attributes, primary
  keys, foreign keys, and unique constraints clearly defined
- A fully rendered ER Diagram created using Mermaid syntax,
  showing all entities and their relationships
- Application of First, Second, and Third Normal Form (1NF,
  2NF, 3NF) to ensure the database is free from data
  duplication and transitive dependencies
- Full SQL schema implementation in PostgreSQL 16 creating
  all 9 tables with appropriate constraints
- Realistic sample data inserted across all 9 tables covering
  members, trainers, classes, bookings, workout logs,
  equipment, and payments

**Files:**
- `portfolio1/MiracleIsa_301905801_P1_CaseStudy.md`
- `portfolio1/MiracleIsa_301905801_P1_Entities.md`
- `portfolio1/MiracleIsa_301905801_P1_ERDiagram.md`
- `portfolio1/MiracleIsa_301905801_P1_Normalisation.md`
- `portfolio1/MiracleIsa_301905801_P1_Schema.sql`
- `portfolio1/MiracleIsa_301905801_P1_SampleData.sql`

---

### Portfolio 2 — SQL Queries & Optimisation
**Marks available: 7**

This portfolio demonstrated proficiency in writing and
optimising SQL queries against the fitlife_gym database.
The work included:

- 12 SQL queries covering basic SELECT, JOIN, aggregate
  functions (COUNT, SUM, AVG), filtering, sorting, subqueries,
  and advanced multi-table queries
- Execution plan analysis using EXPLAIN ANALYZE to identify
  a sequential scan bottleneck on the member email column
- Creation of 3 indexes (on member email, class booking
  member_id, and payment member_id) to optimise query
  performance
- Before and after comparison of execution plans showing
  improvement from Sequential Scan to Index Scan after
  adding the index

**Key finding:** Adding an index on the member email column
reduced query cost significantly as demonstrated by the
EXPLAIN ANALYZE output switching from Seq Scan to Index Scan.

**File:**
- `portfolio2/MiracleIsa_301905801_P2_Queries.sql`

---

### Portfolio 3 — Transactions & Concurrency Control
**Marks available: 7**

This portfolio demonstrated understanding of database
transaction management and concurrency control. The work
included:

- A successful transaction using BEGIN and COMMIT that
  atomically inserted a new member and their first payment
  together, ensuring both records are saved or neither is
- A failed transaction using ROLLBACK that demonstrated
  how PostgreSQL automatically rejects operations that
  violate foreign key constraints
- A SAVEPOINT transaction demonstrating how to partially
  roll back within a transaction without cancelling the
  entire operation
- Row-level locking using SELECT FOR UPDATE to demonstrate
  concurrency control when multiple sessions access the
  same record
- Transaction isolation level set to SERIALIZABLE to
  demonstrate protection against dirty reads and phantom
  reads

**File:**
- `portfolio3/MiracleIsa_301905801_P3_Transactions.sql`

---

### Portfolio 4 — NoSQL Database Modelling with MongoDB
**Marks available: 7**

This portfolio demonstrated the ability to model the same
gym system using a NoSQL document database approach with
MongoDB. The work included:

- Full document model design embedding related data (bookings,
  workout logs, payments) inside member documents rather than
  spreading them across separate tables
- 4 collections created: members, trainers, equipment, and
  fitness_classes
- 10 MongoDB queries covering find, findOne, aggregate
  pipeline (grouping, projecting, sorting), updateOne,
  and $push operations
- Index creation on email and membership plan name fields
- A detailed comparison of the relational PostgreSQL approach
  versus the document-based MongoDB approach, explaining
  when each is more appropriate

**Note on execution:** MongoDB 7.0 was successfully installed
in the Codespaces environment however the mongod service
could not be started due to Docker container restrictions
in GitHub Codespaces. All code and expected outputs are
fully documented in the portfolio files.

**Files:**
- `portfolio4/MiracleIsa_301905801_P4_MongoDB.js`
- `portfolio4/MiracleIsa_301905801_P4_MongoDB_Output.md`

---

### Portfolio 5 — Distributed & Cloud Databases
**Marks available: 6**

This portfolio discussed how the FitLife Gym database could
be scaled and distributed as the business grows. The work
included:

- Explanation of core distributed database concepts including
  replication, sharding, CAP theorem, and ACID vs BASE
- Analysis of CAP theorem trade-offs for the gym use case,
  concluding that Availability and Partition Tolerance (AP)
  should be prioritised over strict consistency
- Evaluation of cloud database platforms including AWS RDS,
  Google Cloud SQL, Microsoft Azure Cosmos DB, and MongoDB
  Atlas, with specific recommendations for FitLife Gym
- A proposed distributed architecture showing primary and
  replica servers across Port Harcourt, Lagos, and Abuja
- Discussion of benefits including high availability,
  scalability, disaster recovery, and performance
- Discussion of challenges including network latency,
  complexity, cost, and security risks
- A practical 5-step migration plan for moving the existing
  PostgreSQL database to a distributed cloud architecture

**File:**
- `portfolio5/MiracleIsa_301905801_P5_Distributed.md`

---

## 3. Technologies Used

| Technology | Version | Purpose |
|---|---|---|
| PostgreSQL | 16 | Primary relational database |
| MongoDB | 7.0 | NoSQL document database |
| GitHub Codespaces | Latest | Development environment |
| Git & GitHub | Latest | Version control & submission |
| Mermaid | Built-in | ER Diagram rendering |
| SQL | Standard | Schema, queries, transactions |
| JavaScript | ES6 | MongoDB query scripting |
| Markdown | Standard | Documentation |

---

## 4. Key Learnings & Reflection

This assessment provided a comprehensive and practical
understanding of advanced database systems concepts that
go well beyond basic SQL knowledge.

**Most valuable learning:** Understanding the difference
between relational and NoSQL databases is not about one
being better than the other — it is about choosing the
right tool for the right job. PostgreSQL is ideal for
structured financial and membership data where accuracy
and consistency are critical. MongoDB is ideal for
flexible, fast-growing data like workout logs where the
schema may change over time.

**Most challenging aspect:** Setting up and configuring
PostgreSQL in GitHub Codespaces required troubleshooting
authentication issues and configuration file changes.
This real-world problem-solving experience was arguably
more valuable than the database concepts themselves, as
it reflects the kind of issues a database administrator
would face in a professional environment.

**How AI was used:** Claude AI (claude.ai) was used as
a learning and guidance tool throughout this assessment.
It helped explain concepts, debug errors, suggest SQL
syntax, and guide the setup of the development environment.
All code was understood, reviewed, and adapted by the
student before implementation. AI was used as a tool
to enhance learning, not to replace it.

---

## 5. GitHub Repository Structure

```
MIT8103_GymSystem/
│
├── portfolio1/
│   ├── MiracleIsa_301905801_P1_CaseStudy.md
│   ├── MiracleIsa_301905801_P1_Entities.md
│   ├── MiracleIsa_301905801_P1_ERDiagram.md
│   ├── MiracleIsa_301905801_P1_Normalisation.md
│   ├── MiracleIsa_301905801_P1_Schema.sql
│   └── MiracleIsa_301905801_P1_SampleData.sql
│
├── portfolio2/
│   └── MiracleIsa_301905801_P2_Queries.sql
│
├── portfolio3/
│   └── MiracleIsa_301905801_P3_Transactions.sql
│
├── portfolio4/
│   ├── MiracleIsa_301905801_P4_MongoDB.js
│   └── MiracleIsa_301905801_P4_MongoDB_Output.md
│
├── portfolio5/
│   └── MiracleIsa_301905801_P5_Distributed.md
│
├── docs/
│   └── MiracleIsa_301905801_FinalSummary.md
│
└── README.md
```

---

## 6. AI Usage Declaration

In accordance with the MIT 8103 assessment guidelines,
I declare that artificial intelligence tools were used
during this assessment as follows:

- **Tool used:** Claude AI (claude.ai) by Anthropic
- **Purpose:** Concept explanation, syntax guidance,
  error debugging, and environment setup assistance
- **Extent:** AI was used as a learning aid and tutor.
  All code was reviewed, understood, and verified by
  the student before being implemented
- **Academic integrity:** All work submitted represents
  my own understanding of the concepts. AI was used
  to support learning, not to replace independent
  thinking or understanding

---

*MIT 8103 Advanced Database Systems*
*Student: MiracleIsa_301905801*
*GitHub: https://github.com/Cyberprime01/MIT8103_GymSystem*
*October 2026*