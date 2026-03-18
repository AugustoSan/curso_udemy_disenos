import 'package:flutter/material.dart';

class SliderModel with ChangeNotifier {
  double _currentPage = 0.0;
  Color _primaryColor = Colors.blue;
  Color _secondaryColor = Colors.grey;

  double get currentPage => _currentPage;
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

  set primaryColor(Color value) {
    _primaryColor = value;
    notifyListeners();
  }

  set secondaryColor(Color value) {
    _secondaryColor = value;
    notifyListeners();
  }
}