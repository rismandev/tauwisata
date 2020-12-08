import 'package:flutter/material.dart';
import 'package:tauwisata/common/enum.dart';
import 'package:tauwisata/data/helper/database_helper.dart';
import 'package:tauwisata/data/model/favorite.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({@required this.databaseHelper});

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<FavoriteModel> _favorites = [];
  List<FavoriteModel> get favorites => _favorites;

  Future<List<FavoriteModel>> getFavorites() async {
    _favorites = await databaseHelper.getFavorites();
    if (_favorites.length > 0) {
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
