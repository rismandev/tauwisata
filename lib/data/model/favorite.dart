import 'dart:convert';

class FavoriteModel {
  String id;
  String photoURL;
  String name;
  String location;
  String description;
  String price;
  String category;
  int totalFavorite;
  String subMenu;

  FavoriteModel({
    this.id,
    this.photoURL,
    this.name,
    this.location,
    this.description,
    this.price,
    this.category,
    this.totalFavorite,
    this.subMenu,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        id: json["id"],
        photoURL: json["photoUrl"],
        name: json["name"],
        location: json["location"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        totalFavorite: json["total_favorite"],
        subMenu: json["sub_menu"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['photoUrl'] = photoURL;
    data['name'] = name;
    data['location'] = location;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['total_favorite'] = totalFavorite;
    data['sub_menu'] = subMenu;
    return data;
  }
}

List<FavoriteModel> parseFavoriteFromJson(String json) {
  if (json == null) {
    return [];
  }

  final _parsed = jsonDecode(json);

  List<FavoriteModel> _data = List<FavoriteModel>();

  _parsed["destinations"].forEach((item) {
    _data.add(FavoriteModel.fromJson(item));
  });

  return _data;
}
