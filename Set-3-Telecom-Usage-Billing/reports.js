// Day 6 - Set 3 : Telecom Usage and Billing Reporting
// reports.js : pipelines on the usage_events collection (run: mongosh reports.js)
// one document per network event on 16 Nov 2026; data sessions and voice calls have different fields

db = db.getSiblingDB("telecom_usage");
db.usage_events.drop();
db.usage_events.insertMany([
  { msisdn: "9840011004", event_type: "data_session", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T07:20:20+05:30"), end: ISODate("2026-11-16T07:44:58+05:30"), duration_sec: 1478, data_mb: 274.6, app: "Hotstar" },
  { msisdn: "9840011005", event_type: "data_session", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T07:27:41+05:30"), end: ISODate("2026-11-16T08:21:02+05:30"), duration_sec: 3201, data_mb: 510.7, app: "Chrome" },
  { msisdn: "9840011011", event_type: "voice_call", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T07:53:35+05:30"), end: ISODate("2026-11-16T07:59:13+05:30"), duration_sec: 338, called_number: "9874819866" },
  { msisdn: "9840011010", event_type: "data_session", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T09:03:05+05:30"), end: ISODate("2026-11-16T09:51:06+05:30"), duration_sec: 2881, data_mb: 276.1, app: "WhatsApp" },
  { msisdn: "9840011002", event_type: "voice_call", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T10:13:35+05:30"), end: ISODate("2026-11-16T10:21:22+05:30"), duration_sec: 467, called_number: "9857795467" },
  { msisdn: "9840011013", event_type: "voice_call", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T10:38:45+05:30"), end: ISODate("2026-11-16T10:42:43+05:30"), duration_sec: 238, called_number: "9892494128" },
  { msisdn: "9840011010", event_type: "data_session", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T12:03:39+05:30"), end: ISODate("2026-11-16T12:32:48+05:30"), duration_sec: 1749, data_mb: 200.1, app: "YouTube" },
  { msisdn: "9840011008", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T12:06:50+05:30"), end: ISODate("2026-11-16T12:44:58+05:30"), duration_sec: 2288, data_mb: 326.5, app: "Chrome" },
  { msisdn: "9840011006", event_type: "data_session", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T12:18:40+05:30"), end: ISODate("2026-11-16T13:17:48+05:30"), duration_sec: 3548, data_mb: 666.4, app: "Instagram" },
  { msisdn: "9840011009", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T12:36:50+05:30"), end: ISODate("2026-11-16T13:19:53+05:30"), duration_sec: 2583, data_mb: 221.8, app: "Instagram" },
  { msisdn: "9840011005", event_type: "voice_call", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T13:02:27+05:30"), end: ISODate("2026-11-16T13:04:43+05:30"), duration_sec: 136, called_number: "9887511173" },
  { msisdn: "9840011001", event_type: "data_session", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T13:08:29+05:30"), end: ISODate("2026-11-16T13:17:55+05:30"), duration_sec: 566, data_mb: 87.4, app: "Chrome" },
  { msisdn: "9840011001", event_type: "voice_call", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T13:10:02+05:30"), end: ISODate("2026-11-16T13:18:59+05:30"), duration_sec: 537, called_number: "9886791450" },
  { msisdn: "9840011009", event_type: "voice_call", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T13:18:05+05:30"), end: ISODate("2026-11-16T13:18:44+05:30"), duration_sec: 39, called_number: "9884985712" },
  { msisdn: "9840011010", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T13:29:33+05:30"), end: ISODate("2026-11-16T14:28:58+05:30"), duration_sec: 3565, data_mb: 686.9, app: "Instagram" },
  { msisdn: "9840011003", event_type: "data_session", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T13:48:27+05:30"), end: ISODate("2026-11-16T14:32:43+05:30"), duration_sec: 2656, data_mb: 358.7, app: "WhatsApp" },
  { msisdn: "9840011005", event_type: "voice_call", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T18:14:06+05:30"), end: ISODate("2026-11-16T18:24:05+05:30"), duration_sec: 599, called_number: "9896904514" },
  { msisdn: "9840011010", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T18:30:24+05:30"), end: ISODate("2026-11-16T19:24:19+05:30"), duration_sec: 3235, data_mb: 457.9, app: "Hotstar" },
  { msisdn: "9840011002", event_type: "voice_call", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T18:54:57+05:30"), end: ISODate("2026-11-16T19:04:26+05:30"), duration_sec: 569, called_number: "9812479861" },
  { msisdn: "9840011008", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T18:58:19+05:30"), end: ISODate("2026-11-16T19:02:42+05:30"), duration_sec: 263, data_mb: 23.1, app: "Hotstar" },
  { msisdn: "9840011003", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T19:13:15+05:30"), end: ISODate("2026-11-16T19:33:38+05:30"), duration_sec: 1223, data_mb: 174.7, app: "Hotstar" },
  { msisdn: "9840011003", event_type: "data_session", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T19:56:31+05:30"), end: ISODate("2026-11-16T20:30:58+05:30"), duration_sec: 2067, data_mb: 155.9, app: "WhatsApp" },
  { msisdn: "9840011010", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T20:04:52+05:30"), end: ISODate("2026-11-16T20:09:40+05:30"), duration_sec: 288, data_mb: 26.4, app: "Chrome" },
  { msisdn: "9840011012", event_type: "data_session", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T20:13:41+05:30"), end: ISODate("2026-11-16T21:12:29+05:30"), duration_sec: 3528, data_mb: 380.5, app: "YouTube" },
  { msisdn: "9840011013", event_type: "voice_call", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T20:15:27+05:30"), end: ISODate("2026-11-16T20:25:24+05:30"), duration_sec: 597, called_number: "9880991349" },
  { msisdn: "9840011006", event_type: "data_session", tower_id: "TWR-CHN-102", start: ISODate("2026-11-16T20:24:49+05:30"), end: ISODate("2026-11-16T20:59:43+05:30"), duration_sec: 2094, data_mb: 391.1, app: "Instagram" },
  { msisdn: "9840011012", event_type: "voice_call", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T20:30:14+05:30"), end: ISODate("2026-11-16T20:34:28+05:30"), duration_sec: 254, called_number: "9856004949" },
  { msisdn: "9840011005", event_type: "data_session", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T20:32:17+05:30"), end: ISODate("2026-11-16T21:18:40+05:30"), duration_sec: 2783, data_mb: 464.5, app: "Chrome" },
  { msisdn: "9840011006", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T21:03:03+05:30"), end: ISODate("2026-11-16T21:17:19+05:30"), duration_sec: 856, data_mb: 65.8, app: "WhatsApp" },
  { msisdn: "9840011001", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T21:03:15+05:30"), end: ISODate("2026-11-16T21:15:20+05:30"), duration_sec: 725, data_mb: 105.1, app: "Hotstar" },
  { msisdn: "9840011003", event_type: "voice_call", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T21:07:11+05:30"), end: ISODate("2026-11-16T21:17:34+05:30"), duration_sec: 623, called_number: "9813225096" },
  { msisdn: "9840011008", event_type: "data_session", tower_id: "TWR-CHN-102", start: ISODate("2026-11-16T21:08:18+05:30"), end: ISODate("2026-11-16T21:53:03+05:30"), duration_sec: 2685, data_mb: 406.0, app: "Chrome" },
  { msisdn: "9840011006", event_type: "voice_call", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T21:14:18+05:30"), end: ISODate("2026-11-16T21:23:28+05:30"), duration_sec: 550, called_number: "9829913229" },
  { msisdn: "9840011006", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T21:14:57+05:30"), end: ISODate("2026-11-16T21:43:12+05:30"), duration_sec: 1695, data_mb: 175.1, app: "Hotstar" },
  { msisdn: "9840011011", event_type: "data_session", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T21:27:17+05:30"), end: ISODate("2026-11-16T21:39:31+05:30"), duration_sec: 734, data_mb: 146.0, app: "Hotstar" },
  { msisdn: "9840011007", event_type: "data_session", tower_id: "TWR-MUM-401", start: ISODate("2026-11-16T21:36:27+05:30"), end: ISODate("2026-11-16T22:16:13+05:30"), duration_sec: 2386, data_mb: 371.4, app: "WhatsApp" },
  { msisdn: "9840011007", event_type: "data_session", tower_id: "TWR-BLR-201", start: ISODate("2026-11-16T21:56:49+05:30"), end: ISODate("2026-11-16T22:08:59+05:30"), duration_sec: 730, data_mb: 68.2, app: "Chrome" },
  { msisdn: "9840011002", event_type: "data_session", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T21:58:19+05:30"), end: ISODate("2026-11-16T22:40:45+05:30"), duration_sec: 2546, data_mb: 355.0, app: "Instagram" },
  { msisdn: "9840011005", event_type: "data_session", tower_id: "TWR-CHN-101", start: ISODate("2026-11-16T22:32:33+05:30"), end: ISODate("2026-11-16T22:45:37+05:30"), duration_sec: 784, data_mb: 114.9, app: "Chrome" },
  { msisdn: "9840011013", event_type: "voice_call", tower_id: "TWR-HYD-301", start: ISODate("2026-11-16T22:41:53+05:30"), end: ISODate("2026-11-16T22:44:49+05:30"), duration_sec: 176, called_number: "9810188728" }
]);
print("events loaded: " + db.usage_events.countDocuments());

const day = { $gte: ISODate("2026-11-16T00:00:00+05:30"), $lt: ISODate("2026-11-17T00:00:00+05:30") };

// 1. hourly usage (IST)
print("\n--- Pipeline 1 : hourly usage on 16 Nov 2026 ---");
db.usage_events.aggregate([
  { $match: { start: day } },
  { $group: { _id: { $hour: { date: "$start", timezone: "+05:30" } },
              events: { $sum: 1 },
              data_mb: { $sum: { $ifNull: ["$data_mb", 0] } },
              voice_sec: { $sum: { $cond: [{ $eq: ["$event_type", "voice_call"] }, "$duration_sec", 0] } } } },
  { $sort: { _id: 1 } },
  { $project: { _id: 0, hour: "$_id", events: "$events", data_mb: { $round: ["$data_mb", 1] },
                voice_min: { $round: [{ $divide: ["$voice_sec", 60] }, 1] } } }
]).forEach(doc => print(JSON.stringify(doc)));

// 2. average session length by event type
print("\n--- Pipeline 2 : average session length ---");
db.usage_events.aggregate([
  { $match: { start: day } },
  { $group: { _id: "$event_type", sessions: { $sum: 1 }, avg_sec: { $avg: "$duration_sec" },
              longest_sec: { $max: "$duration_sec" } } },
  { $sort: { avg_sec: -1 } },
  { $project: { _id: 0, event_type: "$_id", sessions: "$sessions",
                avg_minutes: { $round: [{ $divide: ["$avg_sec", 60] }, 2] },
                longest_minutes: { $round: [{ $divide: ["$longest_sec", 60] }, 2] } } }
]).forEach(doc => print(JSON.stringify(doc)));

// 3. busiest cell tower
print("\n--- Pipeline 3 : busiest cell tower ---");
db.usage_events.aggregate([
  { $match: { start: day } },
  { $group: { _id: "$tower_id", events: { $sum: 1 }, data_mb: { $sum: { $ifNull: ["$data_mb", 0] } } } },
  { $sort: { events: -1, data_mb: -1 } },
  { $project: { _id: 0, tower_id: "$_id", events: "$events", data_mb: { $round: ["$data_mb", 1] } } }
]).forEach(doc => print(JSON.stringify(doc)));
