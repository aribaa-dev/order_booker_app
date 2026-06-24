class MockDataStore {
  //Local Whole sale product catalog for inventory lookups:
  static final List<Map<String, dynamic>> wholeSaleInventory = [
    {
      "id": "proud_1",
      "name": "Tapal danedar tea 250g",
      "price": "450",
      "unit": "Carton",
      "category": "Beverages",
    },
    {
      "id": "proud_2",
      "name": "Olpers milk",
      "price": "1550",
      "unit": "Crate",
      "category": "Dairy",
    },

    {
      "id": "proud_3",
      "name": "Lux Soap Original Large",
      "price": "550",
      "unit": "Box",
      "category": "Personal Care",
    },

    {
      "id": "proud_4",
      "name": "Lays Masala Chips",
      "price": "100",
      "unit": "Box",
      "category": "Snacks",
    },

    {
      "id": "proud_5",
      "name": "Surf excel",
      "price": "600",
      "unit": "Packet",
      "category": "Household",
    },
  ];

  //Regional retail store:
  static final List<Map<String, dynamic>> assignedRetailers = [
    {
      "id": "ret_101",
      "name": "Bismillah General Store",
      "owner": "Muhammad Asif",
      "area": "Barket Market , Lahore",
      "blance": "4500",
    },

    {
      "id": "ret_102",
      "name": "Bilal Kiryani Market",
      "owner": "Tariq Mahmood",
      "area": "Ghalib Market , Lahore",
      "blance": "0",
    },

    {
      "id": "ret_101",
      "name": "Al-Madina Super Store",
      "owner": "Haji Khurshid",
      "area": "Samna bad , Lahore",
      "blance": "1500",
    },
  ];

  //
  static final List<Map<String, dynamic>> aiResponseSample = [
    {"shop_name": "Bismillah General Store"},
  ];
}
