import 'package:flutter/material.dart';
import 'package:kualiva/places/fnb/model/fnb_filter_toggle_model.dart';

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

  static List<FnbFilterToggleModel> get facilitiesDataset => [
        FnbFilterToggleModel(
            id: 0,
            useIcon: true,
            icon: Icons.local_convenience_store_outlined,
            label: "24 Hour\nOpen"),
        FnbFilterToggleModel(
            id: 1,
            useIcon: true,
            icon: Icons.sensor_door_outlined,
            label: "Open Now"),
        FnbFilterToggleModel(
            id: 2,
            useIcon: true,
            icon: Icons.brightness_4_outlined,
            label: "Any"),
        FnbFilterToggleModel(
            id: 3, useIcon: true, icon: Icons.ac_unit, label: "Indoor"),
        FnbFilterToggleModel(
            id: 4, useIcon: true, icon: Icons.smoking_rooms, label: "Outdoor"),
        FnbFilterToggleModel(
            id: 5,
            useIcon: true,
            icon: Icons.sports_esports_outlined,
            label: "Kids\nPlayground"),
        FnbFilterToggleModel(
            id: 6, useIcon: true, icon: Icons.wifi, label: "Wi-Fi"),
        FnbFilterToggleModel(
            id: 7,
            useIcon: true,
            icon: Icons.electrical_services_sharp,
            label: "Electric\nOutlet"),
        FnbFilterToggleModel(
            id: 8, useIcon: true, icon: Icons.wc, label: "Toilet"),
        FnbFilterToggleModel(
            id: 9,
            useIcon: true,
            icon: Icons.dining_outlined,
            label: "Dine In"),
        FnbFilterToggleModel(
            id: 10,
            useIcon: true,
            icon: Icons.directions_car,
            label: "Drive Thru"),
        FnbFilterToggleModel(
            id: 11,
            useIcon: true,
            icon: Icons.fastfood_outlined,
            label: "Both"),
      ];

  static List<FnbFilterToggleModel> get categoriesDataset => [
        FnbFilterToggleModel(id: 0, useIcon: false, label: "Halal"),
        FnbFilterToggleModel(id: 1, useIcon: false, label: "Non-Halal"),
        FnbFilterToggleModel(id: 2, useIcon: false, label: "All"),
        FnbFilterToggleModel(id: 3, useIcon: false, label: "Vegan"),
        FnbFilterToggleModel(id: 4, useIcon: false, label: "Vegetarian"),
        FnbFilterToggleModel(id: 5, useIcon: false, label: "Western"),
        FnbFilterToggleModel(id: 6, useIcon: false, label: "Eastern"),
        FnbFilterToggleModel(id: 7, useIcon: false, label: "Middle East"),
        FnbFilterToggleModel(id: 8, useIcon: false, label: "Traditional"),
        FnbFilterToggleModel(id: 9, useIcon: false, label: "Fast Food"),
        FnbFilterToggleModel(id: 10, useIcon: false, label: "Beverage"),
        FnbFilterToggleModel(id: 11, useIcon: false, label: "Snack"),
        FnbFilterToggleModel(id: 12, useIcon: false, label: "Dessert"),
        FnbFilterToggleModel(id: 13, useIcon: false, label: "Bakery & Pastry"),
      ];
}
