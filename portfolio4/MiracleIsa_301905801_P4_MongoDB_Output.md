# Portfolio 4: MongoDB — Expected Output & Notes
# Gym Membership & Fitness Tracking System

**Student:** MiracleIsa_301905801
**Module:** MIT 8103 Advanced Database Systems

---

## Note on MongoDB Execution Environment

MongoDB was successfully installed in GitHub Codespaces
(version 7.0.45) however the MongoDB service (mongod) could
not be started due to Docker container restrictions in the
Codespaces environment. GitHub Codespaces runs inside a
container that does not support background services like
mongod due to its overhead and permission limitations.

The complete MongoDB implementation is available in:
`portfolio4/MiracleIsa_301905801_P4_MongoDB.js`

This file documents the expected output that would be
produced when the script is run in a standard environment
such as a local machine or MongoDB Atlas.

---

## How to Run This on a Local Machine

```bash
# Start MongoDB service
sudo service mongod start

# Run the script
mongosh --file portfolio4/MiracleIsa_301905801_P4_MongoDB.js
```

---

## Expected Output — Step 4: insertMany Members

```javascript
// Command run:
db.members.insertMany([...])

// Expected output:
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('661a1b2c3d4e5f6a7b8c9d0e'),
    '1': ObjectId('661a1b2c3d4e5f6a7b8c9d0f'),
    '2': ObjectId('661a1b2c3d4e5f6a7b8c9d10')
  }
}
```

---

## Expected Output — Step 5: insertMany Trainers

```javascript
// Command run:
db.trainers.insertMany([...])

// Expected output:
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('661a1b2c3d4e5f6a7b8c9d11'),
    '1': ObjectId('661a1b2c3d4e5f6a7b8c9d12'),
    '2': ObjectId('661a1b2c3d4e5f6a7b8c9d13')
  }
}
```

---

## Expected Output — Query 1: Find All Members

```javascript
// Command run:
db.members.find().pretty()

// Expected output:
[
  {
    _id: ObjectId('661a1b2c3d4e5f6a7b8c9d0e'),
    member_id: 1,
    first_name: 'Miracle',
    last_name: 'Isa',
    email: 'miracle.isa@email.com',
    phone: '08051234567',
    date_of_birth: ISODate('1998-05-12T00:00:00.000Z'),
    join_date: ISODate('2024-01-05T00:00:00.000Z'),
    membership_plan: {
      plan_name: 'Premium',
      duration_months: 12,
      price: 40000
    },
    class_bookings: [
      {
        class_name: 'Morning Yoga',
        schedule_day: 'Monday',
        booking_date: ISODate('2024-04-01T00:00:00.000Z'),
        status: 'Confirmed'
      },
      {
        class_name: 'HIIT Blast',
        schedule_day: 'Tuesday',
        booking_date: ISODate('2024-04-02T00:00:00.000Z'),
        status: 'Confirmed'
      }
    ],
    workout_logs: [
      {
        log_date: ISODate('2024-04-01T00:00:00.000Z'),
        exercise_name: 'Bench Press',
        sets: 4, reps: 10,
        weight_kg: 80,
        notes: 'Felt strong today'
      }
    ],
    payments: [
      {
        amount: 40000,
        payment_date: ISODate('2024-01-05T00:00:00.000Z'),
        payment_method: 'Bank Transfer',
        payment_type: 'Membership Fee'
      }
    ]
  }
  // ... 2 more documents
]
```

---

## Expected Output — Query 3: Find Premium Members

```javascript
// Command run:
db.members.find(
  { "membership_plan.plan_name": "Premium" },
  { first_name: 1, last_name: 1, "membership_plan.plan_name": 1 }
)

// Expected output:
[
  {
    _id: ObjectId('661a1b2c3d4e5f6a7b8c9d0e'),
    first_name: 'Miracle',
    last_name: 'Isa',
    membership_plan: { plan_name: 'Premium' }
  }
]
```

---

## Expected Output — Query 5: Count Members Per Plan

```javascript
// Command run:
db.members.aggregate([
  { $group: {
      _id: "$membership_plan.plan_name",
      total_members: { $sum: 1 },
      plan_price: { $first: "$membership_plan.price" }
  }},
  { $sort: { total_members: -1 } }
])

// Expected output:
[
  { _id: 'Standard', total_members: 1, plan_price: 12000 },
  { _id: 'Premium',  total_members: 1, plan_price: 40000 },
  { _id: 'Basic',    total_members: 1, plan_price: 5000  }
]
```

---

## Expected Output — Query 6: Total Payments Per Member

```javascript
// Command run:
db.members.aggregate([
  { $project: {
      full_name: { $concat: ["$first_name", " ", "$last_name"] },
      total_paid: { $sum: "$payments.amount" },
      number_of_payments: { $size: "$payments" }
  }},
  { $sort: { total_paid: -1 } }
])

// Expected output:
[
  { full_name: 'Miracle Isa',     total_paid: 55000, number_of_payments: 2 },
  { full_name: 'Belema Benstowe', total_paid: 12000, number_of_payments: 1 },
  { full_name: 'Tunde Adeyemi',   total_paid: 5000,  number_of_payments: 1 }
]
```

---

## Expected Output — createIndex

```javascript
// Command run:
db.members.createIndex({ email: 1 })

// Expected output:
email_1

// Command run:
db.members.getIndexes()

// Expected output:
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { email: 1 }, name: 'email_1' },
  { v: 2, key: { 'membership_plan.plan_name': 1 },
    name: 'membership_plan.plan_name_1' }
]
```

---

## Why MongoDB Over PostgreSQL for Workout Tracking?

In PostgreSQL, to get a full member profile with all bookings,
workouts and payments, you would need to JOIN 5 tables:

```sql
SELECT m.*, cb.*, wl.*, p.*
FROM member m
JOIN class_booking cb ON m.member_id = cb.member_id
JOIN workout_log wl ON m.member_id = wl.member_id
JOIN payment p ON m.member_id = p.member_id
WHERE m.member_id = 1;
```

In MongoDB, one simple query gets everything:

```javascript
db.members.findOne({ member_id: 1 })
```

This makes MongoDB significantly faster for loading a
complete member profile, which is something a gym app
would need to do very frequently.

---

*File: MiracleIsa_301905801_P4_MongoDB_Output.md*
*Saved in: portfolio4/ folder*