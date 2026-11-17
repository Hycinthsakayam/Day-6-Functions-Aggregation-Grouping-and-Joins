// Day 6 - Set 1 : Retail Sales Reporting
// reports.js : same three reports with MongoDB aggregation (run: mongosh reports.js)
// each order is one document with its items embedded

db = db.getSiblingDB("retail_sales");
db.orders.drop();
db.orders.insertMany([
  { order_id: 1, customer: { id: 1, name: "Arun Prakash", city: "Chennai" }, order_date: new Date("2026-08-03"), status: "Delivered", discount: 100,
    items: [ { product: "Bluetooth Speaker", category: "Electronics", qty: 1, price: 1499 }, { product: "Wireless Mouse", category: "Electronics", qty: 1, price: 649 } ] },
  { order_id: 2, customer: { id: 3, name: "Karthik Raja", city: "Bengaluru" }, order_date: new Date("2026-08-07"), status: "Delivered", discount: null,
    items: [ { product: "Basmati Rice 5kg", category: "Groceries", qty: 2, price: 645 }, { product: "Cold Pressed Oil 1L", category: "Groceries", qty: 3, price: 320 } ] },
  { order_id: 3, customer: { id: 5, name: "Rahul Sharma", city: "Hyderabad" }, order_date: new Date("2026-08-12"), status: "Delivered", discount: 200,
    items: [ { product: "Mixer Grinder 750W", category: "Home & Kitchen", qty: 1, price: 3299 } ] },
  { order_id: 4, customer: { id: 1, name: "Arun Prakash", city: "Chennai" }, order_date: new Date("2026-08-18"), status: "Delivered", discount: null,
    items: [ { product: "Cotton Kurta", category: "Clothing", qty: 2, price: 799 } ] },
  { order_id: 5, customer: { id: 2, name: "Divya Menon", city: "Chennai" }, order_date: new Date("2026-08-25"), status: "Delivered", discount: 50,
    items: [ { product: "USB-C Charger 25W", category: "Electronics", qty: 1, price: 899 }, { product: "Cold Pressed Oil 1L", category: "Groceries", qty: 2, price: 320 } ] },
  { order_id: 6, customer: { id: 7, name: "Vikram Singh", city: "Mumbai" }, order_date: new Date("2026-09-02"), status: "Delivered", discount: null,
    items: [ { product: "Running Shoes", category: "Footwear", qty: 1, price: 2199 } ] },
  { order_id: 7, customer: { id: 3, name: "Karthik Raja", city: "Bengaluru" }, order_date: new Date("2026-09-06"), status: "Delivered", discount: 150,
    items: [ { product: "Smart Watch", category: "Electronics", qty: 1, price: 3499 } ] },
  { order_id: 8, customer: { id: 5, name: "Rahul Sharma", city: "Hyderabad" }, order_date: new Date("2026-09-10"), status: "Delivered", discount: null,
    items: [ { product: "Basmati Rice 5kg", category: "Groceries", qty: 3, price: 645 } ] },
  { order_id: 9, customer: { id: 1, name: "Arun Prakash", city: "Chennai" }, order_date: new Date("2026-09-15"), status: "Delivered", discount: null,
    items: [ { product: "Non-stick Tawa", category: "Home & Kitchen", qty: 1, price: 799 }, { product: "Cold Pressed Oil 1L", category: "Groceries", qty: 1, price: 320 } ] },
  { order_id: 10, customer: { id: 4, name: "Meena Iyer", city: "Bengaluru" }, order_date: new Date("2026-09-21"), status: "Delivered", discount: 100,
    items: [ { product: "Bluetooth Speaker", category: "Electronics", qty: 1, price: 1499 }, { product: "USB-C Charger 25W", category: "Electronics", qty: 1, price: 899 } ] },
  { order_id: 11, customer: { id: 6, name: "Sneha Patil", city: "Hyderabad" }, order_date: new Date("2026-09-27"), status: "Cancelled", discount: null,
    items: [ { product: "Running Shoes", category: "Footwear", qty: 1, price: 2199 } ] },
  { order_id: 12, customer: { id: 8, name: "Priya Nair", city: "Mumbai" }, order_date: new Date("2026-10-04"), status: "Delivered", discount: null,
    items: [ { product: "Cotton Kurta", category: "Clothing", qty: 3, price: 799 } ] },
  { order_id: 13, customer: { id: 3, name: "Karthik Raja", city: "Bengaluru" }, order_date: new Date("2026-10-09"), status: "Delivered", discount: 0,
    items: [ { product: "Wireless Mouse", category: "Electronics", qty: 2, price: 649 }, { product: "Basmati Rice 5kg", category: "Groceries", qty: 1, price: 645 } ] },
  { order_id: 14, customer: { id: 5, name: "Rahul Sharma", city: "Hyderabad" }, order_date: new Date("2026-10-14"), status: "Delivered", discount: 300,
    items: [ { product: "Smart Watch", category: "Electronics", qty: 1, price: 3499 }, { product: "Bluetooth Speaker", category: "Electronics", qty: 1, price: 1499 } ] },
  { order_id: 15, customer: { id: 1, name: "Arun Prakash", city: "Chennai" }, order_date: new Date("2026-10-20"), status: "Delivered", discount: 500,
    items: [ { product: "Mixer Grinder 750W", category: "Home & Kitchen", qty: 1, price: 3299 }, { product: "Smart Watch", category: "Electronics", qty: 1, price: 3499 } ] },
  { order_id: 16, customer: { id: 9, name: "Lakshmi Devi", city: "Chennai" }, order_date: new Date("2026-10-20"), status: "Delivered", discount: 250,
    items: [ { product: "Running Shoes", category: "Footwear", qty: 2, price: 2199 }, { product: "Bluetooth Speaker", category: "Electronics", qty: 1, price: 1499 } ] },
  { order_id: 17, customer: { id: 7, name: "Vikram Singh", city: "Mumbai" }, order_date: new Date("2026-10-20"), status: "Delivered", discount: null,
    items: [ { product: "Basmati Rice 5kg", category: "Groceries", qty: 2, price: 645 } ] },
  { order_id: 18, customer: { id: 2, name: "Divya Menon", city: "Chennai" }, order_date: new Date("2026-10-26"), status: "Delivered", discount: null,
    items: [ { product: "Non-stick Tawa", category: "Home & Kitchen", qty: 2, price: 799 } ] },
  { order_id: 19, customer: { id: 4, name: "Meena Iyer", city: "Bengaluru" }, order_date: new Date("2026-11-02"), status: "Delivered", discount: 100,
    items: [ { product: "Smart Watch", category: "Electronics", qty: 1, price: 3499 } ] },
  { order_id: 20, customer: { id: 3, name: "Karthik Raja", city: "Bengaluru" }, order_date: new Date("2026-11-05"), status: "Delivered", discount: null,
    items: [ { product: "Cold Pressed Oil 1L", category: "Groceries", qty: 4, price: 320 }, { product: "Basmati Rice 5kg", category: "Groceries", qty: 2, price: 645 } ] },
  { order_id: 21, customer: { id: 5, name: "Rahul Sharma", city: "Hyderabad" }, order_date: new Date("2026-11-08"), status: "Delivered", discount: null,
    items: [ { product: "USB-C Charger 25W", category: "Electronics", qty: 2, price: 899 } ] },
  { order_id: 22, customer: { id: 1, name: "Arun Prakash", city: "Chennai" }, order_date: new Date("2026-11-11"), status: "Delivered", discount: 0,
    items: [ { product: "Running Shoes", category: "Footwear", qty: 1, price: 2199 }, { product: "Cotton Kurta", category: "Clothing", qty: 1, price: 799 } ] },
  { order_id: 23, customer: { id: 6, name: "Sneha Patil", city: "Hyderabad" }, order_date: new Date("2026-11-13"), status: "Delivered", discount: null,
    items: [ { product: "Wireless Mouse", category: "Electronics", qty: 1, price: 649 } ] },
  { order_id: 24, customer: { id: 8, name: "Priya Nair", city: "Mumbai" }, order_date: new Date("2026-11-15"), status: "Delivered", discount: 200,
    items: [ { product: "Mixer Grinder 750W", category: "Home & Kitchen", qty: 1, price: 3299 } ] }
]);
print("orders loaded: " + db.orders.countDocuments());

// 1. month-wise sales
print("\n--- Pipeline 1 : month-wise sales ---");
printjson(db.orders.aggregate([
  { $match: { status: "Delivered" } },
  { $unwind: "$items" },
  { $group: {
      _id: { $dateToString: { format: "%Y-%m", date: "$order_date" } },
      orders:  { $addToSet: "$order_id" },
      revenue: { $sum: { $multiply: ["$items.qty", "$items.price"] } } } },
  { $project: { _id: 0, month: "$_id", orders: { $size: "$orders" }, revenue: "$revenue" } },
  { $sort: { month: 1 } }
]).toArray());

// 2. top 5 products by revenue
print("\n--- Pipeline 2 : top 5 products by revenue ---");
printjson(db.orders.aggregate([
  { $match: { status: "Delivered" } },
  { $unwind: "$items" },
  { $group: {
      _id: "$items.product",
      units:   { $sum: "$items.qty" },
      revenue: { $sum: { $multiply: ["$items.qty", "$items.price"] } } } },
  { $sort: { revenue: -1 } },
  { $limit: 5 },
  { $project: { _id: 0, product: "$_id", units: "$units", revenue: "$revenue" } }
]).toArray());

// 3. average basket value per city
print("\n--- Pipeline 3 : average basket value per city ---");
printjson(db.orders.aggregate([
  { $match: { status: "Delivered" } },
  { $addFields: { basket: { $sum: { $map: { input: "$items", as: "i",
                                             in: { $multiply: ["$$i.qty", "$$i.price"] } } } } } },
  { $group: { _id: "$customer.city", orders: { $sum: 1 }, avg_basket: { $avg: "$basket" } } },
  { $project: { _id: 0, city: "$_id", orders: "$orders", avg_basket: { $round: ["$avg_basket", 2] } } },
  { $sort: { avg_basket: -1 } }
]).toArray());
