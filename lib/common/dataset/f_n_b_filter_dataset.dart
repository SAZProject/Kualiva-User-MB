class FNBFilterDataset {
  static List<String> get fnbFoodFilter => ["Executive Merchant", ...fnbFilter];
  static List<String> get fnbBVGFilter =>
      ["Executive Merchant", ...fnbSubCategBvg];

  static List<String> get fnbFilter => [
        "24 Hour",
        "Vegetarian",
        "Seafood",
        "Halal",
        "Shabu",
        "Grill",
        "All You Can Eat",
        "Michelin",
        "Vegan",
        "Drive Thru",
      ];

  static List<String> get fnbSubCategFoods => [
        "Indonesian",
        "Korean",
        "Italian",
        "Japanese",
        "Indian",
        "Chinese",
        "Malaysian",
        "Thailand",
        "Philipines",
        "Western",
        "Middle Eastern",
        "Healthy & Dietary",
        "Martabak",
        "Fast Food",
        "Bakery & Pastry",
        "Street Food",
        "Snack",
        "Dessert",
        "Fusion",
        "Beverages",
      ];

  static List<String> get fnbSubCategBvg => [
        "Coffee & Tea",
        "Dairy",
        "Juice & Smoothie",
        "Soft Drink",
        "Herbal",
        "Alcohol",
        "Blend",
      ];
}
