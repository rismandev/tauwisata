import 'dart:convert';

class HotelModel {
  String id;
  String photoURL;
  String name;
  String location;
  String description;
  String price;
  String category;
  int totalFavorite;

  HotelModel({
    this.id,
    this.photoURL,
    this.name,
    this.location,
    this.description,
    this.price,
    this.category,
    this.totalFavorite,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
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

List<HotelModel> parseHotelFromJson(
  String json, {
  String filter,
}) {
  if (json == null) {
    return [];
  }

  final _parsed = jsonDecode(json);

  List<HotelModel> _data = List<HotelModel>();

  _parsed["hotels"].forEach((item) {
    if (filter != null && filter.isNotEmpty) {
      if (item["category"] == filter) {
        _data.add(HotelModel.fromJson(item));
      }
    } else {
      _data.add(HotelModel.fromJson(item));
    }
  });

  return _data;
}
