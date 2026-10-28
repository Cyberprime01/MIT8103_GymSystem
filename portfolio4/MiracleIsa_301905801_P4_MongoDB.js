// ============================================================
// MIT 8103 Advanced Database Systems
// Student: MiracleIsa_301905801
// Case Study: Gym Membership & Fitness Tracking System
// File: MiracleIsa_301905801_P4_MongoDB.js
// Portfolio 4: NoSQL Database Modelling with MongoDB
// ============================================================

// ============================================================
// WHY NoSQL / MongoDB?
// Unlike PostgreSQL which stores data in separate tables,
// MongoDB stores data as documents (like JSON objects).
// Related data can be embedded inside one document instead
// of being split across multiple tables.
// This makes reading a full member profile very fast
// because everything is in one place.
// ============================================================

// ============================================================
// STEP 1: CREATE AND SELECT THE DATABASE
// ============================================================
use fitlife_gym_mongo

// ============================================================
// STEP 2: DROP EXISTING COLLECTIONS (clean start)
// ============================================================
db.members.drop()
db.trainers.drop()
db.equipment.drop()
db.fitness_classes.drop()

// ============================================================
// STEP 3: INSERT MEMBERSHIP PLANS AS EMBEDDED DOCUMENTS
// In MongoDB we embed the plan INSIDE the member document
// instead of having a separate membership_plan table
// ============================================================

// ============================================================
// STEP 4: INSERT MEMBERS WITH EMBEDDED DATA
// Notice how bookings, workout logs and payments are all
// embedded inside each member document
// ============================================================
db.members.insertMany([
  {
    member_id: 1,
    first_name: "Miracle",
    last_name: "Isa",
    email: "miracle.isa@email.com",
    phone: "08051234567",
    date_of_birth: new Date("1998-05-12"),
    join_date: new Date("2024-01-05"),
    membership_plan: {
      plan_name: "Premium",
      duration_months: 12,
      price: 40000.00
    },
    class_bookings: [
      { class_name: "Morning Yoga", schedule_day: "Monday",
        booking_date: new Date("2024-04-01"), status: "Confirmed" },
      { class_name: "HIIT Blast", schedule_day: "Tuesday",
        booking_date: new Date("2024-04-02"), status: "Confirmed" }
    ],
    workout_logs: [
      { log_date: new Date("2024-04-01"), exercise_name: "Bench Press",
        sets: 4, reps: 10, weight_kg: 80.00, notes: "Felt strong today" },
      { log_date: new Date("2024-04-02"), exercise_name: "Squat",
        sets: 4, reps: 12, weight_kg: 100.00, notes: "Personal best!" },
      { log_date: new Date("2024-04-03"), exercise_name: "Pull Up",
        sets: 3, reps: 8, weight_kg: 0, notes: "Bodyweight only" }
    ],
    payments: [
      { amount: 40000.00, payment_date: new Date("2024-01-05"),
        payment_method: "Bank Transfer", payment_type: "Membership Fee" },
      { amount: 15000.00, payment_date: new Date("2024-04-08"),
        payment_method: "Card", payment_type: "Personal Training" }
    ]
  },
  {
    member_id: 2,
    first_name: "Belema",
    last_name: "Benstowe",
    email: "belema.benstowe@email.com",
    phone: "08067654321",
    date_of_birth: new Date("2000-03-22"),
    join_date: new Date("2024-02-10"),
    membership_plan: {
      plan_name: "Standard",
      duration_months: 3,
      price: 12000.00
    },
    class_bookings: [
      { class_name: "Morning Yoga", schedule_day: "Monday",
        booking_date: new Date("2024-04-01"), status: "Confirmed" },
      { class_name: "Cycling Express", schedule_day: "Wednesday",
        booking_date: new Date("2024-04-03"), status: "Confirmed" }
    ],
    workout_logs: [
      { log_date: new Date("2024-04-01"), exercise_name: "Treadmill Run",
        sets: 1, reps: 30, weight_kg: 0, notes: "30 mins at 8km/h" },
      { log_date: new Date("2024-04-03"), exercise_name: "Plank",
        sets: 3, reps: 1, weight_kg: 0, notes: "60 seconds each" }
    ],
    payments: [
      { amount: 12000.00, payment_date: new Date("2024-02-10"),
        payment_method: "Card", payment_type: "Membership Fee" }
    ]
  },
  {
    member_id: 3,
    first_name: "Tunde",
    last_name: "Adeyemi",
    email: "tunde.adeyemi@email.com",
    phone: "08079876543",
    date_of_birth: new Date("1995-11-08"),
    join_date: new Date("2024-01-20"),
    membership_plan: {
      plan_name: "Basic",
      duration_months: 1,
      price: 5000.00
    },
    class_bookings: [
      { class_name: "Strength Basics", schedule_day: "Thursday",
        booking_date: new Date("2024-04-04"), status: "Confirmed" }
    ],
    workout_logs: [
      { log_date: new Date("2024-04-02"), exercise_name: "Deadlift",
        sets: 3, reps: 8, weight_kg: 120.00, notes: "Working on form" }
    ],
    payments: [
      { amount: 5000.00, payment_date: new Date("2024-01-20"),
        payment_method: "Cash", payment_type: "Membership Fee" }
    ]
  }
])

// ============================================================
// STEP 5: INSERT TRAINERS COLLECTION
// ============================================================
db.trainers.insertMany([
  {
    trainer_id: 1,
    first_name: "Chidi",
    last_name: "Okonkwo",
    email: "chidi.okonkwo@fitlifegym.com",
    phone: "08031234567",
    specialisation: "Strength & Conditioning",
    hire_date: new Date("2021-03-15"),
    classes: ["Strength Basics"],
    sessions_conducted: 3
  },
  {
    trainer_id: 2,
    first_name: "Amara",
    last_name: "Nwosu",
    email: "amara.nwosu@fitlifegym.com",
    phone: "08097654321",
    specialisation: "Yoga & Flexibility",
    hire_date: new Date("2022-01-10"),
    classes: ["Morning Yoga", "Evening Yoga"],
    sessions_conducted: 1
  },
  {
    trainer_id: 3,
    first_name: "Emeka",
    last_name: "Eze",
    email: "emeka.eze@fitlifegym.com",
    phone: "08112345678",
    specialisation: "HIIT & Cardio",
    hire_date: new Date("2020-06-20"),
    classes: ["HIIT Blast", "Weekend HIIT"],
    sessions_conducted: 2
  }
])

// ============================================================
// STEP 6: INSERT EQUIPMENT COLLECTION
// ============================================================
db.equipment.insertMany([
  { equipment_name: "Treadmill 1", purchase_date: new Date("2020-01-15"),
    last_maintenance: new Date("2024-03-01"), condition: "Good" },
  { equipment_name: "Bench Press Rack", purchase_date: new Date("2019-06-10"),
    last_maintenance: new Date("2024-02-15"), condition: "Excellent" },
  { equipment_name: "Squat Rack", purchase_date: new Date("2019-06-10"),
    last_maintenance: new Date("2024-02-15"), condition: "Excellent" },
  { equipment_name: "Cycling Bike 1", purchase_date: new Date("2021-03-20"),
    last_maintenance: new Date("2024-03-10"), condition: "Good" },
  { equipment_name: "Dumbbells Set", purchase_date: new Date("2019-01-01"),
    last_maintenance: new Date("2024-02-01"), condition: "Excellent" }
])

// ============================================================
// STEP 7: MONGODB QUERIES
// ============================================================

// Query 1: Find all members
db.members.find().pretty()

// Query 2: Find a specific member by email
db.members.findOne({ email: "miracle.isa@email.com" })

// Query 3: Find all Premium members
db.members.find(
  { "membership_plan.plan_name": "Premium" },
  { first_name: 1, last_name: 1, "membership_plan.plan_name": 1 }
)

// Query 4: Find members who have booked Morning Yoga
db.members.find(
  { "class_bookings.class_name": "Morning Yoga" },
  { first_name: 1, last_name: 1, class_bookings: 1 }
)

// Query 5: Count total members per plan
db.members.aggregate([
  { $group: {
      _id: "$membership_plan.plan_name",
      total_members: { $sum: 1 },
      plan_price: { $first: "$membership_plan.price" }
  }},
  { $sort: { total_members: -1 } }
])

// Query 6: Total payments per member
db.members.aggregate([
  { $project: {
      full_name: { $concat: ["$first_name", " ", "$last_name"] },
      total_paid: { $sum: "$payments.amount" },
      number_of_payments: { $size: "$payments" }
  }},
  { $sort: { total_paid: -1 } }
])

// Query 7: Find members with more than 2 workout logs
db.members.find(
  { $expr: { $gt: [{ $size: "$workout_logs" }, 2] } },
  { first_name: 1, last_name: 1, workout_logs: 1 }
)

// Query 8: Update a member's phone number
db.members.updateOne(
  { email: "miracle.isa@email.com" },
  { $set: { phone: "08011112222" } }
)

// Query 9: Add a new workout log to a member
db.members.updateOne(
  { email: "miracle.isa@email.com" },
  { $push: {
      workout_logs: {
        log_date: new Date("2024-04-10"),
        exercise_name: "Bicep Curl",
        sets: 3, reps: 12,
        weight_kg: 20.00,
        notes: "Good pump"
      }
  }}
)

// Query 10: Create an index on email for faster lookups
db.members.createIndex({ email: 1 })
db.members.createIndex({ "membership_plan.plan_name": 1 })

// Verify indexes
db.members.getIndexes()

// ============================================================
// STEP 8: RELATIONAL vs NoSQL COMPARISON
// ============================================================
// In PostgreSQL (Relational):
// - Member data spread across 9 separate tables
// - Need JOIN queries to get full member profile
// - Better for complex relationships and reporting
// - Strict schema - every row must follow same structure
//
// In MongoDB (NoSQL):
// - Full member profile in ONE document
// - No JOINs needed - just find() the member
// - Better for flexible, fast reads
// - Schema-less - each document can have different fields
//
// For FitLife Gym:
// - PostgreSQL is better for financial reporting & analytics
// - MongoDB is better for quickly loading a member's profile
// ============================================================