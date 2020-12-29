import 'package:flutter/material.dart';
import 'package:tauwisata/common/sizeconfig.dart';

class FoodProvider extends ChangeNotifier {
  double _detailSize = SizeConfig.heightMultiplier * 60;
  double get detailSize => _detailSize;
  double _detailMargin = SizeConfig.heightMultiplier * 40;
  double get detailMargin => _detailMargin;
  bool get isMinimum {
    if (_detailSize == SizeConfig.heightMultiplier * 60) {
      return true;
    }
    return false;
  }

  void onChangeDetailSize() {
    if (isMinimum) {
      _detailSize = SizeConfig.heightMultiplier * 85;
      _detailMargin = SizeConfig.heightMultiplier * 15;
      notifyListeners();
    } else {
      _detailSize = SizeConfig.heightMultiplier * 60;
      _detailMargin = SizeConfig.heightMultiplier * 40;
      notifyListeners();
    }
  }
}
