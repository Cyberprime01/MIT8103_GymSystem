# Step 7: Normalisation
# Gym Membership & Fitness Tracking System

**Student:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## What is Normalisation?

Normalisation is the process of organising a database to reduce
data duplication and improve data integrity. It involves breaking
down large tables into smaller, well-structured tables and defining
relationships between them.

This database follows the first three normal forms (1NF, 2NF, 3NF).

---

## First Normal Form (1NF)

**Rule:** Every column must contain only one value per cell.
No repeating groups or arrays allowed.

**How our database satisfies 1NF:**

Before normalisation, a single member record might have looked
like this (UNNORMALISED):

| member_id | name          | classes_booked              | payments        |
|-----------|---------------|-----------------------------|-----------------|
| 1         | Miracle Isa   | Yoga, HIIT, Cycling         | 5000, 3000      |
| 2         | Belema Benstowe | Yoga                      | 5000            |

This violates 1NF because classes_booked and payments contain
multiple values in one cell.

**After applying 1NF:**
- Each member has one row per booking in the CLASS_BOOKING table
- Each payment is stored as a separate row in the PAYMENT table
- All columns now contain only one value per cell
- Every table has a primary key (member_id, booking_id, payment_id)

---

## Second Normal Form (2NF)

**Rule:** Must already be in 1NF. Every non-key column must depend
on the WHOLE primary key, not just part of it.

**How our database satisfies 2NF:**

In the CLASS_BOOKING table, the primary key is booking_id.
All other columns (member_id, class_id, booking_date, status)
depend fully on booking_id — not on just part of it.

If we had stored the class_name inside CLASS_BOOKING, it would
only depend on class_id and not on the full booking — that would
violate 2NF. Instead, class_name is stored in the FITNESS_CLASS
table where it belongs.

**Example of what we avoided:**

| booking_id | member_id | class_id | class_name | booking_date |
|------------|-----------|----------|------------|--------------|
| 1          | 1         | 2        | Yoga       | 2025-01-10   |

class_name only depends on class_id, not on the full primary key.
So we removed it and kept it in the FITNESS_CLASS table only.

---

## Third Normal Form (3NF)

**Rule:** Must already be in 2NF. No non-key column should depend
on another non-key column (no transitive dependencies).

**How our database satisfies 3NF:**

In the MEMBER table, we store plan_id as a foreign key.
We do NOT store plan_name or plan_price directly in MEMBER
because those values depend on the plan, not on the member.

If we stored plan_name in the MEMBER table, it would create a
transitive dependency: member_id → plan_id → plan_name.

**What we avoided:**

| member_id | first_name | plan_id | plan_name | plan_price |
|-----------|------------|---------|-----------|------------|
| 1         | Miracle    | 2       | Premium   | 15000      |

plan_name and plan_price depend on plan_id, not on member_id.
So they are stored only in the MEMBERSHIP_PLAN table.

---

## Summary of Normalisation Achieved

| Normal Form | Rule                              | Status in Our Database |
|-------------|-----------------------------------|------------------------|
| 1NF         | No repeating groups, atomic values| ✅ Achieved            |
| 2NF         | Full dependency on primary key    | ✅ Achieved            |
| 3NF         | No transitive dependencies        | ✅ Achieved            |

---

## Benefits of Normalisation in This System

- **No data duplication:** Member details are stored once in
  the MEMBER table and referenced elsewhere using member_id
- **Easy to update:** Changing a membership plan price only
  requires updating one row in MEMBERSHIP_PLAN
- **Data integrity:** Foreign keys ensure that bookings and
  payments always link to a valid member
- **Efficient storage:** Smaller, focused tables use less
  storage space than one large table

---

*File: MiracleIsa_301905801_P1_Normalisation.md*
*Saved in: portfolio1/ folder*