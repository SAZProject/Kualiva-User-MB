import 'package:flutter/material.dart';
import 'package:kualiva/_data/model/util_model/filter_toggle_model.dart';

class FilterDataset {
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

  static List<FilterToggleModel> get facilitiesDataset => [
        FilterToggleModel(
            id: 0,
            useIcon: true,
            icon: Icons.local_convenience_store_outlined,
            label: "24 Hour\nOpen"),
        FilterToggleModel(
            id: 1,
            useIcon: true,
            icon: Icons.sensor_door_outlined,
            label: "Open Now"),
        FilterToggleModel(
            id: 2,
            useIcon: true,
            icon: Icons.brightness_4_outlined,
            label: "Any"),
        FilterToggleModel(
            id: 3, useIcon: true, icon: Icons.ac_unit, label: "Indoor"),
        FilterToggleModel(
            id: 4, useIcon: true, icon: Icons.smoking_rooms, label: "Outdoor"),
        FilterToggleModel(
            id: 5,
            useIcon: true,
            icon: Icons.sports_esports_outlined,
            label: "Kids\nPlayground"),
        FilterToggleModel(
            id: 6, useIcon: true, icon: Icons.wifi, label: "Wi-Fi"),
        FilterToggleModel(
            id: 7,
            useIcon: true,
            icon: Icons.electrical_services_sharp,
            label: "Electric\nOutlet"),
        FilterToggleModel(
            id: 8, useIcon: true, icon: Icons.wc, label: "Toilet"),
        FilterToggleModel(
            id: 9,
            useIcon: true,
            icon: Icons.dining_outlined,
            label: "Dine In"),
        FilterToggleModel(
            id: 10,
            useIcon: true,
            icon: Icons.directions_car,
            label: "Drive Thru"),
        FilterToggleModel(
            id: 11,
            useIcon: true,
            icon: Icons.fastfood_outlined,
            label: "Both"),
      ];

  static List<FilterToggleModel> get categoriesDataset => [
        FilterToggleModel(id: 0, useIcon: false, label: "Halal"),
        FilterToggleModel(id: 1, useIcon: false, label: "Non-Halal"),
        FilterToggleModel(id: 2, useIcon: false, label: "All"),
        FilterToggleModel(id: 3, useIcon: false, label: "Vegan"),
        FilterToggleModel(id: 4, useIcon: false, label: "Vegetarian"),
        FilterToggleModel(id: 5, useIcon: false, label: "Western"),
        FilterToggleModel(id: 6, useIcon: false, label: "Eastern"),
        FilterToggleModel(id: 7, useIcon: false, label: "Middle East"),
        FilterToggleModel(id: 8, useIcon: false, label: "Traditional"),
        FilterToggleModel(id: 9, useIcon: false, label: "Fast Food"),
        FilterToggleModel(id: 10, useIcon: false, label: "Beverage"),
        FilterToggleModel(id: 11, useIcon: false, label: "Snack"),
        FilterToggleModel(id: 12, useIcon: false, label: "Dessert"),
        FilterToggleModel(id: 13, useIcon: false, label: "Bakery & Pastry"),
      ];
}
