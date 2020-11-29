import 'dart:convert';

class DestinationModel {
  String photoURL;
  String name;
  String location;
  String description;
  String price;
  String category;
  int totalFavorite;

  DestinationModel({
    this.photoURL,
    this.name,
    this.location,
    this.description,
    this.price,
    this.category,
    this.totalFavorite,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      DestinationModel(
        photoURL: json["photo"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        totalFavorite: json["total_favorite"],
      );
}

List<DestinationModel> parseDestinationFromJson(
  String json, {
  String filter,
}) {
  if (json == null) {
    return [];
  }

  final _parsed = jsonDecode(json);

  List<DestinationModel> _data = List<DestinationModel>();

  _parsed["destinations"].forEach((item) {
    if (filter != null && filter.isNotEmpty) {
      if (item["category"] == filter) {
        _data.add(DestinationModel.fromJson(item));
      }
    } else {
      _data.add(DestinationModel.fromJson(item));
    }
  });

  return _data;
}
