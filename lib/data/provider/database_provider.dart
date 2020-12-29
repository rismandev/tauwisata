import 'package:flutter/material.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/data/helper/database_helper.dart';
import 'package:tauwisata/data/model/destination.dart';
import 'package:tauwisata/data/model/favorite.dart';
import 'package:tauwisata/data/model/food.dart';
import 'package:tauwisata/data/model/hotel.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper});

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<DestinationModel> _destinations = [];
  List<DestinationModel> get destinations => _destinations;
  List<FoodModel> _foods = [];
  List<FoodModel> get foods => _foods;
  List<HotelModel> _hotels = [];
  List<HotelModel> get hotels => _hotels;
  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  Future<List<FavoriteModel>> getFavorites() async {
    _destinations = new List<DestinationModel>();
    _foods = new List<FoodModel>();
    _hotels = new List<HotelModel>();
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.length > 0) {
      _favorites.forEach((item) {
        if (item.subMenu == 'destination') {
          _destinations.add(DestinationModel(
            id: item.id,
            category: item.category,
            description: item.description,
            location: item.location,
            name: item.name,
            photoURL: item.photoURL,
            price: item.price,
            totalFavorite: item.totalFavorite,
          ));
        } else if (item.subMenu == 'food') {
          _foods.add(FoodModel(
            id: item.id,
            category: item.category,
            description: item.description,
            location: item.location,
            name: item.name,
            photoURL: item.photoURL,
            price: item.price,
            totalFavorite: item.totalFavorite,
          ));
        } else {
          _hotels.add(HotelModel(
            id: item.id,
            category: item.category,
            description: item.description,
            location: item.location,
            name: item.name,
            photoURL: item.photoURL,
            price: item.price,
            totalFavorite: item.totalFavorite,
          ));
        }
      });
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
    return _favorites;
  }

  Future<bool> addFavorite(FavoriteModel favorite) async {
    try {
      databaseHelper.addToFavorite(favorite);
      getFavorites();
      return true;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> isFavorite(String id) async {
    final _favorite = await databaseHelper.getFavoriteByPhotoUrl(id);
    return _favorite.isNotEmpty;
  }

  Future<bool> removeFavorite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      getFavorites();
      return true;
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
      return false;
    }
  }
}
