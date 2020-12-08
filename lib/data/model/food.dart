import 'dart:convert';

class FoodModel {
  String id;
  String photoURL;
  String name;
  String location;
  String description;
  String price;
  String category;
  int totalFavorite;

  FoodModel({
    this.id,
    this.photoURL,
    this.name,
    this.location,
    this.description,
    this.price,
    this.category,
    this.totalFavorite,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        photoURL: json["photo"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        totalFavorite: json["total_favorite"],
      );
}

List<FoodModel> parseFoodFromJson(
  String json, {
  String filter,
}) {
  if (json == null) {
    return [];
  }

  final _parsed = jsonDecode(json);

  List<FoodModel> _data = List<FoodModel>();

  _parsed["foods"].forEach((item) {
    if (filter != null && filter.isNotEmpty) {
      if (item["category"] == filter) {
        _data.add(FoodModel.fromJson(item));
      }
    } else {
      _data.add(FoodModel.fromJson(item));
    }
  });

  return _data;
}
