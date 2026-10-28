# Portfolio 5: Distributed & Cloud Databases
# Gym Membership & Fitness Tracking System

**Student:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## 1. What is a Distributed Database?

A distributed database is a database that is stored and managed
across multiple physical locations or servers rather than in one
single place. These locations can be in the same building, in
different cities, or even in different countries. The key point
is that to the user, it still looks and feels like one single
database even though the data is spread across many machines.

For FitLife Gym, a distributed database would become important
if the business grows from one location to multiple gym branches
across Nigeria — for example Port Harcourt, Lagos, Abuja, and
Warri. Each branch would need fast access to member data, and
a single centralised database in one location would be too slow
and too risky if that one server goes down.

---

## 2. Key Concepts in Distributed Databases

### 2.1 Replication
Replication means keeping identical copies of the same data
on multiple servers at the same time. If one server goes down,
another copy is immediately available.

**Example for FitLife Gym:**
The member table could be replicated across a primary server
in Port Harcourt and a backup server in Lagos. If the Port
Harcourt server fails, the Lagos server immediately takes over
and members can still check in without any interruption to
the service.

---

### 2.2 Sharding (Partitioning)
Sharding means splitting a large database into smaller pieces
called shards and storing each shard on a different server.
No single server carries the full load.

**Example for FitLife Gym:**

| Shard | Server Location | Data Stored |
|---|---|---|
| Shard 1 | Port Harcourt | Members with IDs 1 – 1000 |
| Shard 2 | Lagos | Members with IDs 1001 – 2000 |
| Shard 3 | Abuja | Members with IDs 2001 – 3000 |

This way queries run faster because each server handles a
smaller and more manageable portion of the full dataset.

---

### 2.3 CAP Theorem
The CAP Theorem states that a distributed database system can
only guarantee two out of three of the following properties
at any given time:

| Property | Meaning |
|---|---|
| **C — Consistency** | All servers always show exactly the same data |
| **A — Availability** | The system always responds to every request |
| **P — Partition Tolerance** | System keeps working even if the network between servers fails |

**For FitLife Gym:**
We would prioritise **Availability and Partition Tolerance (AP)**.
It is more important that gym members can always check in and
access their workout data even during a brief network outage
between branches, than to have perfectly consistent data across
all branches at every single moment. Small delays in syncing
data across branches are acceptable.

---

### 2.4 ACID vs BASE

| | ACID (PostgreSQL) | BASE (Distributed NoSQL) |
|---|---|---|
| **Stands for** | Atomicity, Consistency, Isolation, Durability | Basically Available, Soft state, Eventually consistent |
| **Data guarantee** | Strict — data is always correct | Relaxed — data becomes correct eventually |
| **Best for** | Financial records, payments, bookings | Workout logs, check-in history, activity feeds |
| **Used in** | Our PostgreSQL fitlife_gym database | MongoDB Atlas distributed setup |

---

## 3. Cloud Database Options for FitLife Gym

If FitLife Gym wanted to move to the cloud, the following
platforms would be most suitable:

| Cloud Platform | Database Service | Best For |
|---|---|---|
| Amazon Web Services (AWS) | Amazon RDS (PostgreSQL) | Members, payments, bookings |
| Amazon Web Services (AWS) | Amazon DynamoDB | Fast check-in lookups |
| Google Cloud Platform | Cloud SQL | PostgreSQL with auto-backups |
| Microsoft Azure | Azure Cosmos DB | Global distributed NoSQL |
| MongoDB | MongoDB Atlas | Workout logs and fitness data |

**Recommended choice for FitLife Gym:** AWS RDS (PostgreSQL)
for relational data combined with MongoDB Atlas for flexible
fitness tracking data. AWS has a data centre in Cape Town which
is the closest to Nigeria, giving the best performance.

---

## 4. Recommended Distributed Architecture for FitLife Gym

```
[Port Harcourt Branch]   [Lagos Branch]   [Abuja Branch]
        |                      |                 |
        v                      v                 v
   [Gym App]             [Gym App]          [Gym App]
        |                      |                 |
        +----------------------+-----------------+
                               |
              [AWS RDS Primary - PostgreSQL]
              [Cape Town Region - Main Server]
                    /                    \
         [Read Replica]            [Read Replica]
         [Lagos]                   [Abuja]
                               |
                    [MongoDB Atlas]
                    [Workout & Fitness Logs]
                    [Multi-region distributed]
```

**How it works:**
- Each branch gym app connects to the nearest read replica
- All writes (new members, payments) go to the primary server
- Read replicas sync automatically with the primary
- MongoDB Atlas handles workout logs independently

---

## 5. Benefits of Moving to Cloud/Distributed Database

| Benefit | Description |
|---|---|
| **High Availability** | System stays online 99.9% of the time even if one server fails |
| **Scalability** | Easily add more capacity as number of members grows |
| **Disaster Recovery** | Data is automatically backed up across multiple regions |
| **Performance** | Members always connect to the nearest server for fast response |
| **Cost Efficiency** | Pay only for what is used — no expensive hardware to maintain |
| **Security** | Cloud providers offer built-in encryption and access controls |

---

## 6. Challenges of Distributed Databases

- **Network latency:** Data travelling between servers in
  different cities can cause slight delays in synchronisation
- **Complexity:** Managing and monitoring multiple servers
  is significantly harder than managing one database
- **Cost:** Monthly cloud hosting fees add up over time
- **Data consistency:** Ensuring all branches show the same
  member data at the same time requires very careful design
- **Security risks:** More entry points across multiple
  servers means more areas that need to be protected

---

## 7. How Our PostgreSQL Database Could Be Distributed

Our existing `fitlife_gym` PostgreSQL database could be
migrated to a distributed setup using these steps:

**Step 1 — Move to AWS RDS:**
Upload the existing schema and data to Amazon RDS PostgreSQL
in the Cape Town region.

**Step 2 — Enable Read Replicas:**
Create read replicas in Lagos and Abuja so local branches
get fast query responses.

**Step 3 — Set Up Connection Pooling:**
Use PgBouncer to manage thousands of simultaneous connections
from multiple gym branches without overloading the database.

**Step 4 — Move Workout Logs to MongoDB Atlas:**
Migrate the workout_log table to MongoDB Atlas for more
flexible schema and faster writes as the data grows.

**Step 5 — Enable Automated Backups:**
Configure daily automated backups with 30-day retention
to protect against data loss.

---

## 8. Conclusion

At its current single-location stage, FitLife Gym's existing
PostgreSQL database running locally in Codespaces is perfectly
sufficient for its needs. However, as the business grows to
multiple branches across Nigeria, migrating to a cloud-based
distributed architecture using AWS RDS for relational data
and MongoDB Atlas for fitness tracking data would provide the
scalability, reliability, and performance needed to serve
thousands of members across multiple locations efficiently
and without interruption.

The combination of a relational database for structured
financial and membership data with a distributed NoSQL
database for flexible fitness tracking represents the ideal
architecture for a modern, growing gym business.

---

*File: MiracleIsa_301905801_P5_Distributed.md*
*Saved in: portfolio5/ folder*