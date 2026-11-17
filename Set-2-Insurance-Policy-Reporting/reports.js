// Day 6 - Set 2 : Insurance Policy Reporting
// reports.js : pipelines on the claims_notes collection (run: mongosh reports.js)
// one document per claim; fields differ by claim type (hospital, garage, surveyor, fir_no ...)

db = db.getSiblingDB("insurance_claims");
db.claims_notes.drop();
db.claims_notes.insertMany([
  { claim_id: 1, policy_no: "HLT2025000101", product: "Health", status: "Settled",
    reported_on: new Date("2026-03-14"), settled_on: new Date("2026-03-29"), damage_category: "Hospitalisation",
    claimed: 32000, approved: 30000, notes: ["Admitted for dengue, 4 days"], hospital: "Apollo, Chennai", cashless: true },
  { claim_id: 2, policy_no: "MOT2026000102", product: "Motor", status: "Settled",
    reported_on: new Date("2026-06-02"), settled_on: new Date("2026-06-20"), damage_category: "Accident",
    claimed: 42000, approved: 38000, notes: ["Front bumper and headlamp damaged", "Survey done at garage"], garage: "Sri Ram Motors", fir_no: null },
  { claim_id: 3, policy_no: "HLT2026000104", product: "Health", status: "Settled",
    reported_on: new Date("2026-05-11"), settled_on: new Date("2026-05-30"), damage_category: "Surgery",
    claimed: 26000, approved: 24000, notes: ["Appendix surgery"], hospital: "Manipal, Bengaluru", cashless: true },
  { claim_id: 4, policy_no: "MOT2025000105", product: "Motor", status: "Rejected",
    reported_on: new Date("2026-02-08"), settled_on: null, damage_category: "Theft",
    claimed: 15000, approved: null, notes: ["Stereo stolen from car", "Accessories not covered"], fir_no: "BLR-2231/26" },
  { claim_id: 5, policy_no: "HLT2025000107", product: "Health", status: "Settled",
    reported_on: new Date("2026-01-22"), settled_on: new Date("2026-02-15"), damage_category: "Hospitalisation",
    claimed: 15000, approved: 13500, notes: ["Typhoid, 3 days"], hospital: "KIMS, Hyderabad", cashless: false },
  { claim_id: 6, policy_no: "HME2024000106", product: "Home", status: "In Review",
    reported_on: new Date("2026-08-15"), settled_on: null, damage_category: "Flood",
    claimed: 45000, approved: null, notes: ["Ground floor water entry", "Photos uploaded", "Surveyor visit pending"], surveyor: "R. Balaji" },
  { claim_id: 7, policy_no: "HLT2026000110", product: "Health", status: "Settled",
    reported_on: new Date("2026-09-03"), settled_on: new Date("2026-10-01"), damage_category: "Surgery",
    claimed: 72000, approved: 65000, notes: ["Knee replacement"], hospital: "Kokilaben, Mumbai", cashless: true },
  { claim_id: 8, policy_no: "MOT2026000111", product: "Motor", status: "In Review",
    reported_on: new Date("2026-10-28"), settled_on: null, damage_category: "Accident",
    claimed: 28000, approved: null, notes: ["Rear-end collision at signal"], garage: "Mumbai Auto Works", fir_no: "MUM-8812/26" },
  { claim_id: 9, policy_no: "HLT2026000112", product: "Health", status: "Settled",
    reported_on: new Date("2026-07-19"), settled_on: new Date("2026-08-05"), damage_category: "Hospitalisation",
    claimed: 34000, approved: 31000, notes: ["Pneumonia, 6 days"], hospital: "MIOT, Chennai", cashless: true },
  { claim_id: 10, policy_no: "MOT2025000114", product: "Motor", status: "Open",
    reported_on: new Date("2026-11-05"), settled_on: null, damage_category: "Glass Damage",
    claimed: 9000, approved: null, notes: ["Windshield crack"], garage: "Glass Point" },
  { claim_id: 11, policy_no: "HLT2026000116", product: "Health", status: "Settled",
    reported_on: new Date("2026-10-10"), settled_on: new Date("2026-10-30"), damage_category: "Daycare",
    claimed: 18000, approved: 16500, notes: ["Cataract procedure"], hospital: "Sankara Nethralaya", cashless: false },
  { claim_id: 12, policy_no: "HME2026000113", product: "Home", status: "Settled",
    reported_on: new Date("2026-09-25"), settled_on: new Date("2026-10-20"), damage_category: "Fire",
    claimed: 22000, approved: 20000, notes: ["Short circuit in kitchen"], surveyor: "K. Prasad" }
]);
print("claims loaded: " + db.claims_notes.countDocuments());

// 1. claims per status
print("\n--- Pipeline 1 : claims per status ---");
printjson(db.claims_notes.aggregate([
  { $match: { reported_on: { $gte: new Date("2026-01-01") } } },
  { $group: { _id: "$status", claims: { $sum: 1 }, amount_claimed: { $sum: "$claimed" } } },
  { $sort: { claims: -1, _id: 1 } },
  { $project: { _id: 0, status: "$_id", claims: "$claims", amount_claimed: "$amount_claimed" } }
]).toArray());

// 2. average settlement time (days from report to settlement)
print("\n--- Pipeline 2 : average settlement time ---");
printjson(db.claims_notes.aggregate([
  { $match: { status: "Settled" } },
  { $project: { product: 1,
                days: { $dateDiff: { startDate: "$reported_on", endDate: "$settled_on", unit: "day" } } } },
  { $group: { _id: "$product", settled_claims: { $sum: 1 }, avg_days: { $avg: "$days" },
              fastest: { $min: "$days" }, slowest: { $max: "$days" } } },
  { $sort: { avg_days: 1 } },
  { $project: { _id: 0, product: "$_id", settled_claims: "$settled_claims",
                avg_days: { $round: ["$avg_days", 1] }, fastest: { $toInt: "$fastest" }, slowest: { $toInt: "$slowest" } } }
]).toArray());

printjson(db.claims_notes.aggregate([
  { $match: { status: "Settled" } },
  { $group: { _id: null, settled_claims: { $sum: 1 },
              avg_days_overall: { $avg: { $dateDiff: { startDate: "$reported_on", endDate: "$settled_on", unit: "day" } } } } },
  { $project: { _id: 0, settled_claims: 1, avg_days_overall: { $round: ["$avg_days_overall", 2] } } }
]).toArray());

// 3. top three damage categories
print("\n--- Pipeline 3 : top three damage categories ---");
printjson(db.claims_notes.aggregate([
  { $match: { status: { $ne: "Rejected" } } },
  { $group: { _id: "$damage_category", claims: { $sum: 1 }, amount_claimed: { $sum: "$claimed" } } },
  { $sort: { claims: -1, amount_claimed: -1 } },
  { $limit: 3 },
  { $project: { _id: 0, damage_category: "$_id", claims: "$claims", amount_claimed: "$amount_claimed" } }
]).toArray());
